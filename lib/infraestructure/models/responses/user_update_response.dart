import 'package:ghanta/infraestructure/models/api_models/user_api.dart';

class UserApiResponse {
  UserApiModel user;
  bool status;
  int code;
  String message;

  UserApiResponse({
    required this.user,
    required this.status,
    required this.code,
    required this.message,
  });

  factory UserApiResponse.fromJson(Map<String, dynamic> json) {
    return UserApiResponse(
      user: UserApiModel.fromJson(json["data"]),
      status: json["status"],
      code: json["code"],
      message: json["message"],
    );
  }
}
