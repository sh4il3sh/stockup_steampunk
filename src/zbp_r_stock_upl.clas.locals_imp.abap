CLASS lhc_StockUpload DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR StockUpload RESULT result.

    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE StockUpload.

    METHODS uploadexcel FOR MODIFY
      IMPORTING keys FOR ACTION StockUpload~UploadExcel. " RESULT result.

    METHODS CheckData FOR MODIFY
      IMPORTING keys FOR ACTION StockUpload~CheckData RESULT result.

    METHODS ProcessMM FOR MODIFY
      IMPORTING keys FOR ACTION StockUpload~ProcessMM RESULT result.

    METHODS ProcessWM FOR MODIFY
      IMPORTING keys FOR ACTION StockUpload~ProcessWM RESULT result.

ENDCLASS.

CLASS lhc_StockUpload IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

*  METHOD earlynumbering_create.
*    DATA: max_recnr TYPE zwm_recnr. " Use your RecordCounter data element
*
*    SELECT SINGLE MAX( recnr ) FROM ztab_stock_upl INTO @max_recnr.
*
*    LOOP AT entities INTO DATA(entity) WHERE RecordCounter IS INITIAL.
*      max_recnr += 1.
*      APPEND VALUE #( %cid      = entity-%cid
*                      RecordCounter = max_recnr ) TO mapped-stockupload.
*    ENDLOOP.
*  ENDMETHOD.

  METHOD earlynumbering_create.
    "DATA: max_recnr TYPE zwm_recnr.
    SELECT SINGLE MAX( recnr ) FROM ztab_stock_upl INTO @data(max_recnr).

    LOOP AT entities INTO DATA(entity).
      " We must handle EVERY entity in this loop to avoid the crash
      IF entity-RecordCounter IS INITIAL.
        max_recnr += 1.
        " This is the 'Handshake' that stops the dump:
        " We map the frontend's temporary ID (%cid) to our new number
        APPEND VALUE #( %cid          = entity-%cid
                        %is_draft     = entity-%is_draft
                        RecordCounter = max_recnr ) TO mapped-stockupload.
      ELSE.
        " Even if it already has a number, map it back so RAP is happy
        APPEND VALUE #( %cid          = entity-%cid
                        %is_draft     = entity-%is_draft
                        RecordCounter = entity-RecordCounter ) TO mapped-stockupload.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD CheckData.
    " 1. Read the data from the screen (including Drafts)
    READ ENTITIES OF zr_stock_upl IN LOCAL MODE
      ENTITY StockUpload
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_stock_data).

    LOOP AT lt_stock_data ASSIGNING FIELD-SYMBOL(<fs_stock>).
      " 2. here my BAPI or Validation logic should go.

      MODIFY ENTITIES OF zr_stock_upl IN LOCAL MODE
        ENTITY StockUpload
          UPDATE FIELDS ( Status Message )
          WITH VALUE #( ( %tky    = <fs_stock>-%tky
                          Status  = 'S' " Success
                          Message = 'Data validated successfully' ) )
        REPORTED DATA(ls_reported).

      " Pass any errors back to the UI
      reported = CORRESPONDING #( DEEP ls_reported ).
    ENDLOOP.
    " 3. Tell the UI to refresh the row
    result = VALUE #( FOR stock IN lt_stock_data
                      ( %tky = stock-%tky %param = stock )
                    ).
  ENDMETHOD.

  METHOD UploadExcel.
    " Because it is a static action, there is no %tky in 'keys'.
    " We access the file content via the 'parameter' field.

    READ TABLE keys INDEX 1 INTO DATA(ls_upload_request).
    IF sy-subrc = 0.
      DATA(lv_file_content) = ls_upload_request-%param-StreamProperty.
      DATA(lv_mime_type)    = ls_upload_request-%param-mimetype.

      " --- YOUR PARSING LOGIC GOES HERE ---
      " e.g., CALL METHOD parse_excel( lv_file_content ).

      " After parsing, you use MODIFY ENTITIES to create the rows.

      " 1. 'parameter' contains the file content and mimetype
      DATA(lv_excel_raw) = lv_file_content.

      " 2. Parse the Excel (You will need a tool like XCO or abap2xlsx here)
      " For now, let's pretend we parsed it into a table called 'lt_new_rows'

      " 3. Create the rows in the Draft table automatically
      MODIFY ENTITIES OF zr_stock_upl IN LOCAL MODE
        ENTITY StockUpload
          CREATE FIELDS ( Material Quantity Plant StorageLocation )
          WITH VALUE #(
            ( %cid = 'excel_row_1' Material = 'MAT-01' Quantity = 100 )
            ( %cid = 'excel_row_2' Material = 'MAT-02' Quantity = 250 )
          )
        MAPPED DATA(ls_mapped)
        FAILED DATA(ls_failed)
        REPORTED DATA(ls_reported).

      " 4. Tell the UI to refresh the list
      reported = CORRESPONDING #( DEEP ls_reported ).

    ENDIF.




  ENDMETHOD.

  METHOD ProcessMM.
  ENDMETHOD.

  METHOD ProcessWM.
  ENDMETHOD.

ENDCLASS.
