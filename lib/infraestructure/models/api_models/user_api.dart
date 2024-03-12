import 'package:ghanta/domain/entities/user.dart';

class UserApiModel {
    int id;
    String name;
    String email;
    dynamic emailVerifiedAt;
    DateTime createdAt;
    DateTime updatedAt;
    Role role;
    Status status;

    UserApiModel({
        required this.id,
        required this.name,
        required this.email,
        required this.emailVerifiedAt,
        required this.createdAt,
        required this.updatedAt,
        required this.role,
        required this.status,
    });


    factory UserApiModel.fromJson(Map<String, dynamic> json) => UserApiModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        role: User.roleFromJson(json["role"]),
        status: User.statusFromJson(json["status"]),
    );

}