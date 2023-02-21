// To parse this JSON data, do
//
//     final brandMasterModel = brandMasterModelFromJson(jsonString);

import 'dart:convert';


List<SubApplianceMasterModel> golbalSubApplianceMasterModel = [];

List<SubApplianceMasterModel> subApplianceMasterModelFromJson(String str) => List<SubApplianceMasterModel>.from(json.decode(str).map((x) => SubApplianceMasterModel.fromJson(x)));

String subApplianceMasterModelToJson(List<SubApplianceMasterModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubApplianceMasterModel {
  SubApplianceMasterModel({
    this.key,
    this.value,
    this.description,
  });

  int? key;
  String? value;
  String? description;

  factory SubApplianceMasterModel.fromJson(Map<String, dynamic> json) => SubApplianceMasterModel(
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




