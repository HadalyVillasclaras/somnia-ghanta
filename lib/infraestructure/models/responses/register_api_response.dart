import 'package:ghanta/domain/entities/user.dart';

class RegisterApiResponse {
  int id;
  String name;
  String email;
  Role role;
  Authorization authorization;

  RegisterApiResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.authorization,
  });

  factory RegisterApiResponse.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = json['data'];
    return RegisterApiResponse(
      id: data["id"],
      name: data["name"],
      email: data["email"],
      role: User.roleFromJson(data["role"]),
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
