import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_apod/main.dart';

void main() {
  testWidgets(
    'Displays loading while waiting for data',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MyApp(),
      );

      // Check if the CircularProgressIndicator is displayed
      expect(
        find.byType(CircularProgressIndicator),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'Displays error message when API call fails',
    (WidgetTester tester) async {
      Future<Map<String, dynamic>> fetchApod() => Future.error(
            'Failed to load picture',
          );

      await tester.pumpWidget(
        MyApp(
          fetchApodFuture: fetchApod,
        ),
      );
      tester.takeException();

      // Pump to build the error message
      await tester.pump();

      expect(
        find.text('Error: Failed to load picture'),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'Displays image and title when API call succeeds',
    (WidgetTester tester) async {
      // Mock the fetchApod function to return data
      Future<Map<String, dynamic>> mockFetchApod() => Future.value({
            'url':
                'https://apod.nasa.gov/apod/image/2408/DolomitesSky_Lioce_960.jpg',
            'title': 'Milky Way Behind Three Merlons',
          });

      await tester.pumpWidget(
        MyApp(
          fetchApodFuture: mockFetchApod,
        ),
      );

      // Pump to build the image and title
      await tester.pump();

      expect(
        find.byType(Image),
        findsOneWidget,
      );
      expect(
        find.text('Milky Way Behind Three Merlons'),
        findsOneWidget,
      );
    },
  );
}
