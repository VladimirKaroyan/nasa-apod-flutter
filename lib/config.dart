import 'package:flutter_dotenv/flutter_dotenv.dart';

Map<String, String> config = {
  "NASA_API_KEY": dotenv.env['NASA_API_KEY'] ?? '',
  "NASA_API_URL": dotenv.env['NASA_API_URL'] ?? '',
};
