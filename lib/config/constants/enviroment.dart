import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  
  static String apiUrl = dotenv.env['ENTORNO'] == 'PROD' ? dotenv.env['API_URL_PROD']! : dotenv.env['API_URL_DEV']!;

  static String apiToken = dotenv.env['API_TOKEN']!;
}