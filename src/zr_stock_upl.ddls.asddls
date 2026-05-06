@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock Upload Base View'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZR_STOCK_UPL
  as select from ztab_stock_upl
{
  key recnr                               as RecordCounter,
      status                              as Status,
      matnr                               as Material,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      anfme                               as Quantity,
      bestq                               as StockCategory,
      cast( posid as abap.char( 24 ) )    as WBSDisplay,
      cast( pspnr as abap.char( 8 ) )     as WBSInternal,
      wm_rel_ind                          as WMRelativeInd,
      nltyp                               as StorageType,
      nlpla                               as StorageBin,
      nppos                               as StoragePosition,
      budat                               as PostingDate,
      mblnr                               as MaterialDoc,
      tanum                               as TransferOrder,
      message                             as Message,
      werks                               as Plant,
      lgort                               as StorageLocation,
      matnr_c                             as MaterialC,
      bismt                               as OldMaterialNum,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      anfme_c                             as QuantityC,
      altme                               as BaseUnit, // Used as the Unit for Quantity
      charg                               as Batch,
      letyp                               as StorageUnitType,
      cast( lenum as abap.char( 20 ) )    as StorageUnitNumber,
      verif                               as VerificationValue,
      sobkz                               as SpecialStockInd,
      cast( wbs_elem as abap.char( 24 ) ) as WBSElement,
      nr_colli_lab                        as LabColliNumber,
      bwart                               as MovementType,
      bwlvs                               as WMMovementType,
      bwtar                               as ValuationType,
      uplfile                             as UploadFileName,

      /* Administrative Fields */
      @Semantics.user.createdBy: true
      local_created_by                    as LocalCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      local_created_at                    as LocalCreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by               as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at               as LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at                     as LastChangedAt
}
