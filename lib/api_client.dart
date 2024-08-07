import 'dart:convert';

import 'package:http/http.dart' as http;

import 'config.dart' show config;

String apiKey = config['NASA_API_KEY']!;
String apiUrl = '${config['NASA_API_URL']}?api_key=$apiKey';

Future<Map<String, dynamic>> fetchApod({http.Client? client}) async {
  try {
    final response = await (client ?? http.Client()).get(Uri.parse(apiUrl));

    return json.decode(response.body);
  } catch (e) {
    return Future.error(e);
  }
}
