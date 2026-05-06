@EndUserText.label: 'Upload Excel'
define root abstract entity Z_S_ExcelUpload
{     
  @Semantics.largeObject.mimeType: 'mimetype'
  @Semantics.largeObject.fileName: 'filename'
  @Semantics.largeObject.contentDispositionPreference: #INLINE   
  StreamProperty : abap.rawstring(0);
  
  @UI.hidden: true
  @Semantics.mimeType: true
  mimetype   : abap.char(128);
  
  @UI.hidden: true
  FileName : abap.char(128);    
}
