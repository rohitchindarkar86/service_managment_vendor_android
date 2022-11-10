// To parse this JSON data, do
//
//     final actionTakenMasterModel = actionTakenMasterModelFromJson(jsonString);

import 'dart:convert';

List<SpareMasterModel> spareMasterModelFromJson(String str) => List<SpareMasterModel>.from(json.decode(str).map((x) => SpareMasterModel.fromJson(x)));

String spareMasterModelToJson(List<SpareMasterModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SpareMasterModel {
  SpareMasterModel({
    this.code,
    this.applianceType_Code,
    this.serviceCategory_Code,
    this.imagePath,
    this.partCode,
    this.partDescription,
    this.partPrice,
    this.priceWEF,
    this.isActive,
  });

  int? code;
  int? applianceType_Code;
  int? serviceCategory_Code;
  String? imagePath;
  String? partCode;
  String? partDescription;
  var partPrice;
  String? priceWEF;
  bool? isActive;

  factory SpareMasterModel.fromJson(Map<String, dynamic> json) => SpareMasterModel(
    code: json["code"],
    applianceType_Code: json["applianceType_Code"],
    serviceCategory_Code: json["serviceCategory_Code"],
    imagePath: json["imagePath"],
    partCode: json["partCode"],
    partDescription: json["partDescription"],
    partPrice: json["partPrice"],
    isActive: json["isActive"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "applianceType_Code": applianceType_Code,
    "serviceCategory_Code": serviceCategory_Code,
    "imagePath": imagePath,
    "partCode": partCode,
    "partDescription": partDescription,
    "priceWEF": priceWEF,
    "isActive": isActive,
  };
}
