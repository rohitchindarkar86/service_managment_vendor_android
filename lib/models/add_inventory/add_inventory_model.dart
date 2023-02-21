class AddInventoryModel{

  int? customerCode =  0;
  int? applianceTypeCode= 0;
  int? applianceSubTypeCode= 0;
  int? unitQuantityCode= 0;
  int? refrigerantCode= 0;
  int? brandCode = 0;
  int? baseWarrantyYears = 0;
  int? extendedWarrantyYears = 0;
  bool? applianceinWarranty = true;
  String? serialNumber = "";
  String? manufacturingDate = "2022-10-05T15:20:54.078Z";
  String? userApplianceUniqueCode = "";
  String? modelNumber = "";

  int? serviceRequestCode = 0;


  AddInventoryModel({this.customerCode,this.applianceTypeCode,this.applianceSubTypeCode,this.unitQuantityCode,this.refrigerantCode,this.brandCode,this.baseWarrantyYears,this.extendedWarrantyYears,this.applianceinWarranty,this.serialNumber,this.manufacturingDate,this.userApplianceUniqueCode,this.serviceRequestCode,this.modelNumber});

  Map<String, dynamic> toJson() => {
    'customerCode': customerCode,
    'applianceTypeCode': applianceTypeCode,
    'applianceSubTypeCode': applianceSubTypeCode,
    'unitQuantityCode': unitQuantityCode,
    'refrigerantCode': refrigerantCode,
    'brandCode': brandCode,
    'baseWarrantyYears': baseWarrantyYears,
    'extendedWarrantyYears': extendedWarrantyYears,
    'applianceinWarranty': applianceinWarranty,
    'serialNumber': serialNumber,
    'manufacturingDate': manufacturingDate,
    'userApplianceUniqueCode': userApplianceUniqueCode,
    'modelNumber': modelNumber,
  };
}