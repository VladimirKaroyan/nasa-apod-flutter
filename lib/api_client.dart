import 'dart:convert';
import 'package:http/http.dart' as http;

const String apiKey = '5b6eYRGoaYyemd8BSB4b7XeljKcgTVzLmEAPeOAF';
const String apiUrl = 'https://api.nasa.gov/planetary/apod?api_key=$apiKey';

Future<Map<String, dynamic>> fetchApod({http.Client? client}) async {
  try {
    final response = await (client ?? http.Client()).get(Uri.parse(apiUrl));

    return json.decode(response.body);
  } catch (e) {
    return Future.error(e);
  }
}
