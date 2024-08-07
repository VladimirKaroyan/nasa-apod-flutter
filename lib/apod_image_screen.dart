import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'api_client.dart';
import 'full_screen_picture.dart';

class ApodImageScreen extends StatefulWidget {
  const ApodImageScreen({
    super.key,
    this.fetchApodFuture,
  });

  final Future<Map<String, dynamic>> Function()? fetchApodFuture;

  @override
  ApodImageScreenState createState() => ApodImageScreenState();
}

class ApodImageScreenState extends State<ApodImageScreen> {
  late Future<Map<String, dynamic>> _futureApod;

  @override
  void initState() {
    super.initState();
    _futureApod = widget.fetchApodFuture != null
        ? widget.fetchApodFuture!()
        : fetchApod();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NASA’s Astronomy Picture of the Day'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _futureApod,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            String imageUrl = data['url'];
            String title = data['title'];

            return Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    toggleFullScreenTransition(imageUrl, title),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: imageUrl,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 2,
                      fit: BoxFit.contain,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: Text('No data available'),
          );
        },
      ),
    );
  }
}
