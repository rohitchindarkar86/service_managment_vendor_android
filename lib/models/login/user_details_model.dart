// To parse this JSON data, do
//
//     final userDetailsModel = userDetailsModelFromJson(jsonString);

import 'dart:convert';
UserDetailsModel? userDetailsModel;

setUserDetailsModel(UserDetailsModel obj){
  userDetailsModel  = obj;
}
getUserDetailsModel() {
  if (userDetailsModel == null) {
    userDetailsModel = UserDetailsModel();
  }
  return userDetailsModel;
}
UserDetailsModel userDetailsModelFromJson(String str) => UserDetailsModel.fromJson(json.decode(str));

String userDetailsModelToJson(UserDetailsModel data) => json.encode(data.toJson());

class UserDetailsModel {
  UserDetailsModel({
    this.userCode,
    this.vendorUserCode,
    this.login,
    this.password,
    this.userTypeCode,
    this.userTypeDescription,
    this.gender,
    this.titleCode,
    this.titleAbbreviation,
    this.titleName,
    this.firstName,
    this.middleName,
    this.lastName,
    this.technicianName,
    this.email,
    this.mobile1,
    this.mobile2,
    this.landLine,
    this.uidaI_Aadhar,
    this.uidaI_Aadhar_Masked,
    this.bloodGroup_Code,
    this.bloodGroup_Type,
    this.bloodGroup_Desc,
    this.profileImage,
    this.postalAddress,
    this.addressCountryCode,
    this.addressStateCode,
    this.addressDistrictCode,
    this.addressCityCode,
    this.addressZipCode,
    this.addressLine_1,
    this.addressLine_2,
    this.addressLandMark,
    this.vendorCode,
    this.isVendorActive,
    this.vendorName,
    this.vendorEmail,
  });

  dynamic? userCode;
  dynamic? vendorUserCode;
  dynamic? login;
  dynamic? password;
  int? userTypeCode;
  dynamic? userTypeDescription;
  dynamic? gender;
  int? titleCode;
  dynamic? titleAbbreviation;
  dynamic? titleName;
  dynamic? firstName;
  dynamic? middleName;
  dynamic? lastName;
  dynamic? technicianName;
  dynamic? email;
  dynamic? mobile1;
  dynamic? mobile2;
  dynamic? landLine;
  dynamic? uidaI_Aadhar;
  dynamic? uidaI_Aadhar_Masked;
  dynamic? bloodGroup_Code;
  dynamic? bloodGroup_Type;
  dynamic? bloodGroup_Desc;
  dynamic? profileImage;
  dynamic? postalAddress;
  dynamic? addressCountryCode;
  dynamic? addressStateCode;
  dynamic? addressDistrictCode;
  dynamic? addressCityCode;
  dynamic? addressZipCode;
  dynamic? addressLine_1;
  dynamic? addressLine_2;
  dynamic? addressLandMark;
  dynamic? vendorCode;
  dynamic? isVendorActive;
  dynamic? vendorName;
  dynamic? vendorEmail;

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) => UserDetailsModel(
    userCode: json["userCode"],
    vendorUserCode: json["vendorUserCode"],
    login: json["login"],
    password: json["password"],
    userTypeCode: json["userTypeCode"],
    userTypeDescription: json["userTypeDescription"],
    gender: json["gender"],
    titleCode: json["titleCode"],
    titleAbbreviation: json["titleAbbreviation"],
    titleName: json["titleName"],
    firstName: json["firstName"],
    middleName: json["middleName"],
    lastName: json["lastName"],
    technicianName: json["technicianName"],
    email: json["email"],
    mobile1: json["mobile_1"],
    mobile2: json["mobile_2"],
    landLine: json["landLine"],
    uidaI_Aadhar: json["uidaI_Aadhar"],
    uidaI_Aadhar_Masked: json["uidaI_Aadhar_Masked"],
    bloodGroup_Code: json["bloodGroup_Code"],
      bloodGroup_Type: json["bloodGroup_Type"],
      bloodGroup_Desc: json["bloodGroup_Desc"],
      profileImage: json["profileImage"],
      postalAddress: json["postalAddress"],
      addressCountryCode: json["addressCountryCode"],
      addressStateCode: json["addressStateCode"],
      addressDistrictCode: json["addressDistrictCode"],
      addressCityCode: json["addressCityCode"],
      addressZipCode: json["addressZipCode"],
      addressLine_1: json["addressLine_1"],
      addressLine_2: json["addressLine_2"],
      addressLandMark: json["addressLandMark"],
      vendorCode: json["vendorCode"],
      isVendorActive: json["isVendorActive"],
      vendorName: json["vendorName"],
      vendorEmail: json["vendorEmail"],

  );

  Map<String, dynamic> toJson() => {
    "userCode": userCode,
    "vendorUserCode": vendorUserCode,
    "login": login,
    "password": password,
    "userTypeCode": userTypeCode,
    "userTypeDescription": userTypeDescription,
    "gender": gender,
    "titleCode": titleCode,
    "titleAbbreviation": titleAbbreviation,
    "titleName": titleName,
    "firstName": firstName,
    "middleName": middleName,
    "lastName": lastName,
    "technicianName": technicianName,
    "email": email,
    "mobile_1": mobile1,
    "mobile_2": mobile2,
    "landLine": landLine,
    "uidaI_Aadhar": uidaI_Aadhar,
    "uidaI_Aadhar_Masked": uidaI_Aadhar_Masked,
    "bloodGroup_Code": bloodGroup_Code,
    "bloodGroup_Type": bloodGroup_Type,
    "bloodGroup_Desc": bloodGroup_Desc,
    "profileImage": profileImage,
    "postalAddress": postalAddress,
    "addressCountryCode": addressCountryCode,
    "addressStateCode": addressStateCode,
    "addressDistrictCode": addressDistrictCode,
    "addressCityCode": addressCityCode,
    "addressZipCode": addressZipCode,
    "addressLine_1": addressLine_1,
    "addressLine_2": addressLine_2,
    "addressLandMark": addressLandMark,
    "vendorCode": vendorCode,
    "isVendorActive": isVendorActive,
    "vendorName": vendorName,
    "vendorEmail": vendorEmail,
  };
}
