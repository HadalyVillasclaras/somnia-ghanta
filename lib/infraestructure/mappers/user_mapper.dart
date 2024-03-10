import 'package:ghanta/domain/entities/user.dart';
import 'package:ghanta/infraestructure/models/responses/login_api_response.dart';

class UserMapper {
  User userApiToEntity(LoginApiResponse loginApiResponse) => User(
        id: loginApiResponse.user.id,
        name: loginApiResponse.user.name,
        email: loginApiResponse.user.email,
        role: loginApiResponse.user.role,
        status: loginApiResponse.user.status,
        token: loginApiResponse.authorization.token,
      );
}
