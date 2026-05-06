@EndUserText.label: 'Abstract Entity 2 for Excel PopUp'
define root abstract entity Z_S_ExcelUpload_comp
{
@UI.hidden: true
dummy : abap_boolean;
     _StreamProperties : association [1] to Z_S_ExcelUpload on 1 = 1;
    
}
