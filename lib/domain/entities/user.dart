

enum Role {
  roleAdmin,
  roleUser,
  roleCourseManager
}

//Role from json


class User {
  
  final int id;
  final String name;
  final String email;
  final Role role;
  final String status;
  final String? token;
  
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.status,
    this.token
  });


  /// TO JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'role': role,
    'status': status,
    'token': token
  };

  static Role roleFromJson(String role) {
  switch (role) {
    case 'ROLE_ADMIN':
      return Role.roleAdmin;
    case 'ROLE_USER':
      return Role.roleUser;
    case 'ROLE_COURSE_MANAGER':
      return Role.roleCourseManager;
    default:
      return Role.roleUser;
  }
}


}
