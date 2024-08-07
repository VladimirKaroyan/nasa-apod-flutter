import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'apod_image_screen.dart';

Future main() async {
  await dotenv.load(
    fileName: ".env",
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    this.fetchApodFuture,
  });

  final Future<Map<String, dynamic>> Function()? fetchApodFuture;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NASA’s Astronomy Picture of the Day',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ApodImageScreen(
        fetchApodFuture: fetchApodFuture,
      ),
    );
  }
}
