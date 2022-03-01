class NetworkHelperErrModel {
  var statusCode;
  var message;

  NetworkHelperErrModel({this.statusCode, this.message});

  factory NetworkHelperErrModel.fromJson(Map<String, dynamic> json) =>
      NetworkHelperErrModel(statusCode: json["statusCode"], message: json["message"]);

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode.toJson(),
        "message": message.toJson(),
      };
}
