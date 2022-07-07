// To parse this JSON data, do
//
//     final actionTakenMasterModel = actionTakenMasterModelFromJson(jsonString);

import 'dart:convert';

List<ActionTakenMasterModel> actionTakenMasterModelFromJson(String str) => List<ActionTakenMasterModel>.from(json.decode(str).map((x) => ActionTakenMasterModel.fromJson(x)));

String actionTakenMasterModelToJson(List<ActionTakenMasterModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ActionTakenMasterModel {
  ActionTakenMasterModel({
    this.key,
    this.value,
    this.description,
  });

  int? key;
  String? value;
  String? description;

  factory ActionTakenMasterModel.fromJson(Map<String, dynamic> json) => ActionTakenMasterModel(
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
