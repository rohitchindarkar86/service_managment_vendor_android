// To parse this JSON data, do
//
//     final brandMasterModel = brandMasterModelFromJson(jsonString);

import 'dart:convert';


List<RefrigerantMasterModel> golbalRefrigerantMasterModel = [];

List<RefrigerantMasterModel> refrigerantMasterModelFromJson(String str) => List<RefrigerantMasterModel>.from(json.decode(str).map((x) => RefrigerantMasterModel.fromJson(x)));

String refrigerantMasterModelToJson(List<RefrigerantMasterModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RefrigerantMasterModel {
  RefrigerantMasterModel({
    this.key,
    this.value,
    this.description,
  });

  int? key;
  String? value;
  String? description;

  factory RefrigerantMasterModel.fromJson(Map<String, dynamic> json) => RefrigerantMasterModel(
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




