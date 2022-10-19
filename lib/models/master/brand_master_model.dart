// To parse this JSON data, do
//
//     final brandMasterModel = brandMasterModelFromJson(jsonString);

import 'dart:convert';


List<BrandMasterModel> golbalBrandMasterModel = [];

List<BrandMasterModel> brandMasterModelFromJson(String str) => List<BrandMasterModel>.from(json.decode(str).map((x) => BrandMasterModel.fromJson(x)));

String brandMasterModelToJson(List<BrandMasterModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BrandMasterModel {
  BrandMasterModel({
    this.key,
    this.value,
    this.description,
  });

  int? key;
  String? value;
  String? description;

  factory BrandMasterModel.fromJson(Map<String, dynamic> json) => BrandMasterModel(
    key: json["key"],
    value: json["value"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
    "description": description,
  };
}




