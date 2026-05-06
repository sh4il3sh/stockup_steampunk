@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock Upload Interface View'

define root view entity ZI_STOCK_UPL
  provider contract transactional_interface
  as projection on ZR_STOCK_UPL
{
    key RecordCounter,
    Status,
    Material,
    Quantity,
    QuantityC,
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
    
    /* Administrative Fields */
    LocalCreatedBy,
    LocalCreatedAt,
    LocalLastChangedBy,
    LocalLastChangedAt,
    LastChangedAt
}
