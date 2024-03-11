import 'package:ghanta/infraestructure/models/api_models/user_api.dart';

class LoginApiResponse {
    UserApiModel user;
    bool status;
    int code;
    String message;
    Authorization authorization;

    LoginApiResponse({
        required this.user,
        required this.status,
        required this.code,
        required this.message,
        required this.authorization,
    });

    factory LoginApiResponse.fromJson(Map<String, dynamic> json) {  
    return LoginApiResponse(
        user: UserApiModel.fromJson(json["data"]),
        status: json["status"],
        code: json["code"],
        message: json["message"],
        authorization: Authorization.fromJson(json["authorization"]),
    );
}

}

class Authorization {
    String token;
    String type;

    Authorization({
        required this.token,
        required this.type,
    });

    factory Authorization.fromJson(Map<String, dynamic> json) => Authorization(
        token: json["token"],
        type: json["type"],
    );

}


