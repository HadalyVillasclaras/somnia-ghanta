class WrongCredentialsError implements Exception {}
class UnauthenticatedError implements Exception {}
class ConnectionTimeoutError implements Exception {}

class CustomError implements Exception {
  final String message;
  final int errorCode;

  CustomError(
    this.message, 
    this.errorCode
  );
}
