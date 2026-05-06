@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock Upload Projection/Consumption View'
@Metadata.allowExtensions: true
@Search.searchable: true
define root view entity ZC_STOCK_UPL 
provider contract transactional_query
as projection on ZI_STOCK_UPL
{
    @Search.defaultSearchElement: true
    key RecordCounter,
   // @Consumption.valueHelpDefinition: [{ entity: { name: 'FIXME_STATUS_VH', element: 'Status' } }] // We can add a VH later
    Status,
    @Search.defaultSearchElement: true
    Material,
    Quantity,
    QuantityC,
    @Semantics.unitOfMeasure: true
    BaseUnit,
    StockCategory,
    WBSInternal,
    WBSDisplay,
    WMRelativeInd,
    StorageType,
    StorageBin,
    StoragePosition,
    PostingDate,
    MaterialDoc,
    TransferOrder,
    Message,
    @Search.defaultSearchElement: true
    Plant,
    StorageLocation,
    MaterialC,
    OldMaterialNum,
    Batch,
    StorageUnitType,
    StorageUnitNumber,
    VerificationValue,
    SpecialStockInd,
    WBSElement,
    LabColliNumber,
    MovementType,
    WMMovementType,
    ValuationType,
    UploadFileName,
    LocalCreatedBy,
    LocalCreatedAt,
    LocalLastChangedBy,
    LocalLastChangedAt,
    @UI.hidden: true
    LastChangedAt
}
 
