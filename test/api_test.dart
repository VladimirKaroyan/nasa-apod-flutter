import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:nasa_apod/api_client.dart';

void main() {
  test(
    'API Call completes successfully',
    () async {
      // Mock HTTP client
      final client = MockClient(
        (request) async {
          return http.Response(
            '{"url": "https://apod.nasa.gov/apod/image/2408/DolomitesSky_Lioce_960.jpg", "title": "Milky Way Behind Three Merlons"}',
            200,
          );
        },
      );

      // Call fetchApod and verify the result
      final result = await fetchApod(client: client);
      expect(result['url'], 'https://apod.nasa.gov/apod/image/2408/DolomitesSky_Lioce_960.jpg');
      expect(result['title'], 'Milky Way Behind Three Merlons');
    },
  );

  test(
    'API Call fails',
    () async {
      // Create HTTP client with error
      final client = MockClient((request) async {
        return http.Response('Error', 500);
      });

      // Call function with mocked client
      expect(
        fetchApod(client: client),
        throwsException,
      );
    },
  );
}
