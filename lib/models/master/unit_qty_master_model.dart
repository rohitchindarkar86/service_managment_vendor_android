// To parse this JSON data, do
//
//     final brandMasterModel = brandMasterModelFromJson(jsonString);

import 'dart:convert';


List<UnitQtyMasterModel> golbalUnitQtyMasterModel = [];

List<UnitQtyMasterModel> UnitQtyMasterModelFromJson(String str) => List<UnitQtyMasterModel>.from(json.decode(str).map((x) => UnitQtyMasterModel.fromJson(x)));

String brandMasterModelToJson(List<UnitQtyMasterModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UnitQtyMasterModel {
  UnitQtyMasterModel({
    this.key,
    this.value,
    this.description,
  });

  int? key;
  String? value;
  String? description;

  factory UnitQtyMasterModel.fromJson(Map<String, dynamic> json) => UnitQtyMasterModel(
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




