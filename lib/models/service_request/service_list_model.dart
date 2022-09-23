// To parse this JSON data, do
//
//     final serviceListModel = serviceListModelFromJson(jsonString);

import 'dart:convert';

List<ServiceListModel> serviceListModelFromJson(String str) => List<ServiceListModel>.from(json.decode(str).map((x) => ServiceListModel.fromJson(x)));

String serviceListModelToJson(List<ServiceListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServiceListModel {
  ServiceListModel({
    this.serviceRequestCode,
    this.serviceRequestDetailCode,
    this.serviceRequestCreatedOn,
    this.serviceRequestDetailCreatedOn,
    this.serviceRequestSeriesCode,
    this.scheduledDate,
    this.scheduledTimeFrom,
    this.scheduledTimeTill,
    required this.vendorUserTechnicianCode,
    this.technicianName,
    this.technicianMobile,
    this.serviceLatitude,
    this.serviceLongitude,
    this.userApplianceCode,
    this.userApplianceType,
    this.userApplianceBrandCode,
    this.userApplianceBrandName,
    this.applianceLocationCode,
    this.userApplianceSerialNumber,
    this.userApplianceMfgDate,
    this.userApplianceInWarranty,
    this.userApplianceWarrantyBaseYears,
    this.userApplianceWarrantyExtendedYears,
    this.serviceCategoryCode,
    this.serviceCategory,
    this.serviceComplaintCode,
    this.serviceStatusSysCode,
    this.serviceStatusCode,
    this.serviceStatus,
    this.pinSysCode,
    this.pinCode,
    this.pinCodeLocation,
    this.addressDetails,
    this.pinCodeRegion,
    this.pinCodeLatitude,
    this.pinCodeLongitude,
    this.customerCode,
    this.customerEmail,
    this.customerMobile,
    this.customerFirstName,
    this.customerLastName,
    this.vendorCode,
    this.vendorEmail,
    this.vendorMobile,
    this.vendorName,
  });

  int? serviceRequestCode;
  int? serviceRequestDetailCode;
  dynamic serviceRequestCreatedOn;
  String? serviceRequestDetailCreatedOn;
  String? serviceRequestSeriesCode;
  String? scheduledDate;
  String? scheduledTimeFrom;
  String? scheduledTimeTill;
  int vendorUserTechnicianCode;
  String? technicianName;
  String? technicianMobile;
  double? serviceLatitude;
  double? serviceLongitude;
  int? userApplianceCode;
  String? userApplianceType;
  String? userApplianceBrandCode;
  String? userApplianceBrandName;
  int? applianceLocationCode;
  String? userApplianceSerialNumber;
  String? userApplianceMfgDate;
  bool? userApplianceInWarranty;
  int? userApplianceWarrantyBaseYears;
  int? userApplianceWarrantyExtendedYears;
  int? serviceCategoryCode;
  String? serviceCategory;
  List<ServiceComplaintCode>? serviceComplaintCode;
  int? serviceStatusSysCode;
  String? serviceStatusCode;
  String? serviceStatus;
  int? pinSysCode;
  String? pinCode;
  dynamic? pinCodeLocation;
  String? addressDetails;
  String? pinCodeRegion;
  double? pinCodeLatitude;
  double? pinCodeLongitude;
  int? customerCode;
  String? customerEmail;
  String? customerMobile;
  String? customerFirstName;
  String? customerLastName;
  int? vendorCode;
  String? vendorEmail;
  String? vendorMobile;
  String? vendorName;

  factory ServiceListModel.fromJson(Map<String, dynamic> json) => ServiceListModel(
    serviceRequestCode: json["serviceRequestCode"],
    serviceRequestDetailCode: json["serviceRequestDetailCode"],
    serviceRequestCreatedOn: json["serviceRequestCreatedOn"],
    serviceRequestDetailCreatedOn: json["serviceRequestDetailCreatedOn"],
    serviceRequestSeriesCode: json["serviceRequestSeriesCode"],
    scheduledDate: json["scheduledDate"],
    scheduledTimeFrom: json["scheduledTimeFrom"],
    scheduledTimeTill: json["scheduledTimeTill"],
    vendorUserTechnicianCode: json["vendorUserTechnicianCode"],
    technicianName: json["technicianName"],
    technicianMobile: json["technicianMobile"],
    serviceLatitude: json["serviceLatitude"],
    serviceLongitude: json["serviceLongitude"],
    userApplianceCode: json["userApplianceCode"],
    userApplianceType: json["userApplianceType"],
    userApplianceBrandCode: json["userApplianceBrandCode"],
    userApplianceBrandName: json["userApplianceBrandName"],
    applianceLocationCode: json["applianceLocationCode"],
    userApplianceSerialNumber: json["userApplianceSerialNumber"],
    userApplianceMfgDate: json["userApplianceMFGDate"],
    userApplianceInWarranty: json["userApplianceInWarranty"],
    userApplianceWarrantyBaseYears: json["userApplianceWarrantyBaseYears"],
    userApplianceWarrantyExtendedYears: json["userApplianceWarrantyExtendedYears"],
    serviceCategoryCode: json["serviceCategoryCode"],
    serviceCategory: json["serviceCategory"],
    serviceComplaintCode: List<ServiceComplaintCode>.from(json["serviceComplaintCode"].map((x) => ServiceComplaintCode.fromJson(x))),
    serviceStatusSysCode: json["serviceStatusSysCode"],
    serviceStatusCode: json["serviceStatusCode"],
    serviceStatus: json["serviceStatus"],
    pinSysCode: json["pinSysCode"],
    pinCode: json["pinCode"],
    pinCodeLocation: json["pinCodeLocation"],
    pinCodeRegion: json["pinCodeRegion"],
    addressDetails: json["addressDetails"],
    pinCodeLatitude: json["pinCodeLatitude"].toDouble(),
    pinCodeLongitude: json["pinCodeLongitude"].toDouble(),
    customerCode: json["customerCode"],
    customerEmail: json["customerEmail"],
    customerMobile: json["customerMobile"],
    customerFirstName: json["customerFirstName"],
    customerLastName: json["customerLastName"],
    vendorCode: json["vendorCode"],
    vendorEmail: json["vendorEmail"],
    vendorMobile: json["vendorMobile"],
    vendorName: json["vendorName"],
  );

  Map<String, dynamic> toJson() => {
    "serviceRequestCode": serviceRequestCode,
    "serviceRequestDetailCode": serviceRequestDetailCode,
    "serviceRequestCreatedOn": serviceRequestCreatedOn,
    "serviceRequestDetailCreatedOn": serviceRequestDetailCreatedOn,
    "serviceRequestSeriesCode": serviceRequestSeriesCode,
    "scheduledDate": scheduledDate,
    "scheduledTimeFrom": scheduledTimeFrom,
    "scheduledTimeTill": scheduledTimeTill,
    "vendorUserTechnicianCode": vendorUserTechnicianCode,
    "technicianName": technicianName,
    "technicianMobile": technicianMobile,
    "serviceLatitude": serviceLatitude,
    "serviceLongitude": serviceLongitude,
    "userApplianceCode": userApplianceCode,
    "userApplianceType": userApplianceType,
    "userApplianceBrandCode": userApplianceBrandCode,
    "userApplianceBrandName": userApplianceBrandName,
    "applianceLocationCode": applianceLocationCode,
    "userApplianceSerialNumber": userApplianceSerialNumber,
    "userApplianceMFGDate": userApplianceMfgDate,
    "userApplianceInWarranty": userApplianceInWarranty,
    "userApplianceWarrantyBaseYears": userApplianceWarrantyBaseYears,
    "userApplianceWarrantyExtendedYears": userApplianceWarrantyExtendedYears,
    "serviceCategoryCode": serviceCategoryCode,
    "serviceCategory": serviceCategory,
    "serviceComplaintCode": List<dynamic>.from(serviceComplaintCode!.map((x) => x)),
    "serviceStatusSysCode": serviceStatusSysCode,
    "serviceStatusCode": serviceStatusCode,
    "serviceStatus": serviceStatus,
    "pinSysCode": pinSysCode,
    "pinCode": pinCode,
    "pinCodeLocation": pinCodeLocation,
    "addressDetails": addressDetails,
    "pinCodeRegion": pinCodeRegion,
    "pinCodeLatitude": pinCodeLatitude,
    "pinCodeLongitude": pinCodeLongitude,
    "customerCode": customerCode,
    "customerEmail": customerEmail,
    "customerMobile": customerMobile,
    "customerFirstName": customerFirstName,
    "customerLastName": customerLastName,
    "vendorCode": vendorCode,
    "vendorEmail": vendorEmail,
    "vendorMobile": vendorMobile,
    "vendorName": vendorName,
  };
}

class ServiceComplaintCode {
  ServiceComplaintCode({
    this.key,
    this.value,
    this.description,
    this.active,
    this.selected,
  });

  int? key;
  String? value;
  String? description;
  bool? active;
  bool? selected;

  factory ServiceComplaintCode.fromJson(Map<String, dynamic> json) => ServiceComplaintCode(
    key: json["key"],
    value: json["value"],
    description: json["description"],
    active: json["active"],
    selected: json["selected"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
    "description": description,
    "active": active,
    "selected": selected,
  };
}
