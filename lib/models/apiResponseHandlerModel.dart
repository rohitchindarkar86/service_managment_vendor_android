class ApiResponseHandlerModel {
  var status;
  var message;
  var data;

  ApiResponseHandlerModel({this.status, this.message, this.data});

  factory ApiResponseHandlerModel.fromJson(Map<String, dynamic> json) =>
      ApiResponseHandlerModel(
          status: json["status"], message: json["message"], data: json["data"]);

  Map<String, dynamic> toJson() => {
        "status": status.toJson(),
        "message": message.toJson(),
        "data": data.toJson()
      };
}
