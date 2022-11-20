// To parse this JSON data, do
//
//     final orderBookListModel = orderBookListModelFromJson(jsonString);

import 'dart:convert';

List<OrderBookListModel> orderBookListModelFromJson(String str) => List<OrderBookListModel>.from(json.decode(str).map((x) => OrderBookListModel.fromJson(x)));

String orderBookListModelToJson(List<OrderBookListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderBookListModel {
  OrderBookListModel({
    this.serviceRequestCode,
    this.serviceRequestSeriesCode,
    this.latitude,
    this.longitude,
    this.userCode,
    this.userMobile,
    this.userFirstName,
    this.userLastName,
    this.pinCode,
    this.pinCodeLatitude,
    this.pinCodeLongitude,
    this.pinCodeLocation,
    this.pinCodeRegion,
    this.serviceCategoryCode,
    this.serviceCategory,
    this.statusCode,
    this.serviceStatusCode,
    this.serviceStatus,
    this.createdDate,
    this.serviceRequestDetails,
  });

  int? serviceRequestCode;
  String? serviceRequestSeriesCode;
  double? latitude;
  int? longitude;
  int? userCode;
  String? userMobile;
  String? userFirstName;
  String? userLastName;
  String? pinCode;
  double? pinCodeLatitude;
  double? pinCodeLongitude;
  String? pinCodeLocation;
  String? pinCodeRegion;
  int? serviceCategoryCode;
  String? serviceCategory;
  int? statusCode;
  String? serviceStatusCode;
  String? serviceStatus;
  String? createdDate;
  List<ServiceRequestDetail>? serviceRequestDetails;

  factory OrderBookListModel.fromJson(Map<String, dynamic> json) => OrderBookListModel(
    serviceRequestCode: json["serviceRequestCode"],
    serviceRequestSeriesCode: json["serviceRequestSeriesCode"],
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"],
    userCode: json["userCode"],
    userMobile: json["userMobile"],
    userFirstName: json["userFirstName"],
    userLastName: json["userLastName"],
    pinCode: json["pinCode"],
    pinCodeLatitude: json["pinCodeLatitude"].toDouble(),
    pinCodeLongitude: json["pinCodeLongitude"].toDouble(),
    pinCodeLocation:json["pinCodeLocation"],
    pinCodeRegion: json["pinCodeRegion"],
    serviceCategoryCode: json["serviceCategoryCode"],
    serviceCategory: json["serviceCategory"],
    statusCode: json["statusCode"],
    serviceStatusCode: json["serviceStatusCode"],
    serviceStatus: json["serviceStatus"],
    createdDate: json["created_Date"],
    serviceRequestDetails: List<ServiceRequestDetail>.from(json["serviceRequestDetails"].map((x) => ServiceRequestDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "serviceRequestCode": serviceRequestCode,
    "serviceRequestSeriesCode": serviceRequestSeriesCode,
    "latitude": latitude,
    "longitude": longitude,
    "userCode": userCode,
    "userMobile": userMobile,
    "userFirstName":userFirstName,
    "userLastName": userLastName,
    "pinCode": pinCode,
    "pinCodeLatitude": pinCodeLatitude,
    "pinCodeLongitude": pinCodeLongitude,
    "pinCodeLocation": pinCodeLocation,
    "pinCodeRegion": pinCodeRegion,
    "serviceCategoryCode": serviceCategoryCode,
    "serviceCategory": serviceCategory,
    "statusCode": statusCode,
    "serviceStatusCode": serviceStatusCode,
    "serviceStatus": serviceStatus,
    "created_Date": createdDate,
    "serviceRequestDetails": List<dynamic>.from(serviceRequestDetails!.map((x) => x.toJson())),
  };
}


class ServiceRequestDetail {
  ServiceRequestDetail({
    this.serviceRequestDetailCode,
    this.scheduledDate,
    this.scheduledTimeFrom,
    this.scheduledTimeTill,
    this.applianceCode,
    this.applianceSerialNumber,
    this.applianceMfgDate,
    this.applianceName,
    this.applianceBrandCode,
    this.applianceBrandName,
    this.applianceLocationCode,
    this.applianceInWarranty,
    this.serviceComplaintCode,
    this.applianceWarrantyBaseYears,
    this.applianceWarrantyExtendedYears,
    this.technicianCode,
    this.technicianName,
    this.technicianMobile,
    this.vendorCode,
    this.vendorEmail,
    this.vendorMobile,
    this.vendorName,
    this.createdDate,
  });

  int? serviceRequestDetailCode;
  String? scheduledDate;
  String? scheduledTimeFrom;
  String? scheduledTimeTill;
  int? applianceCode;
  String? applianceSerialNumber;
  String? applianceMfgDate;
  String? applianceName;
  String? applianceBrandCode;
  String? applianceBrandName;
  int? applianceLocationCode;
  bool? applianceInWarranty;
  List<ServiceComplaintCode>? serviceComplaintCode;
  int? applianceWarrantyBaseYears;
  int? applianceWarrantyExtendedYears;
  int? technicianCode;
  String? technicianName;
  String? technicianMobile;
  int? vendorCode;
  String? vendorEmail;
  String? vendorMobile;
  String? vendorName;
  String? createdDate;

  factory ServiceRequestDetail.fromJson(Map<String, dynamic> json) => ServiceRequestDetail(
    serviceRequestDetailCode: json["serviceRequestDetailCode"],
    scheduledDate: json["scheduled_Date"],
    scheduledTimeFrom: json["scheduled_Time_From"],
    scheduledTimeTill: json["scheduled_Time_Till"],
    applianceCode: json["appliance_Code"],
    applianceSerialNumber: json["appliance_SerialNumber"],
    applianceMfgDate: json["appliance_MFG_Date"],
    applianceName: json["appliance_Name"],
    applianceBrandCode: json["appliance_BrandCode"],
    applianceBrandName: json["appliance_BrandName"],
    applianceLocationCode: json["applianceLocationCode"],
    applianceInWarranty: json["appliance_InWarranty"],
    serviceComplaintCode: List<ServiceComplaintCode>.from(json["serviceComplaintCode"].map((x) => ServiceComplaintCode.fromJson(x))),
    applianceWarrantyBaseYears: json["appliance_WarrantyBaseYears"],
    applianceWarrantyExtendedYears: json["appliance_WarrantyExtendedYears"],
    technicianCode: json["technician_Code"],
    technicianName: json["technician_Name"],
    technicianMobile: json["technician_Mobile"],
    vendorCode: json["vendorCode"],
    vendorEmail: json["vendorEmail"],
    vendorMobile: json["vendorMobile"],
    vendorName: json["vendorName"],
    createdDate: json["created_Date"],
  );

  Map<String, dynamic> toJson() => {
    "serviceRequestDetailCode": serviceRequestDetailCode,
    "scheduled_Date": scheduledDate,
    "scheduled_Time_From": scheduledTimeFrom,
    "scheduled_Time_Till": scheduledTimeTill,
    "appliance_Code": applianceCode,
    "appliance_SerialNumber": applianceSerialNumber,
    "appliance_MFG_Date": applianceMfgDate,
    "appliance_Name": applianceName,
    "appliance_BrandCode": applianceBrandCode,
    "appliance_BrandName": applianceBrandName,
    "applianceLocationCode": applianceLocationCode,
    "appliance_InWarranty": applianceInWarranty,
    "serviceComplaintCode": List<dynamic>.from(serviceComplaintCode!.map((x) => x.toJson())),
    "appliance_WarrantyBaseYears": applianceWarrantyBaseYears,
    "appliance_WarrantyExtendedYears": applianceWarrantyExtendedYears,
    "technician_Code": technicianCode,
    "technician_Name": technicianName,
    "technician_Mobile": technicianMobile,
    "vendorCode": vendorCode,
    "vendorEmail": vendorEmail,
    "vendorMobile": vendorMobile,
    "vendorName": vendorName,
    "created_Date": createdDate,
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
