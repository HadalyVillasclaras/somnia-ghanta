import 'package:dio/dio.dart';
import 'package:ghanta/config/constants/enviroment.dart';

class ApiConfig {
  static final dio = Dio(BaseOptions(
    baseUrl: Environment.apiUrl
  ));
}