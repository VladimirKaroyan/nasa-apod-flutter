import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FullScreenPicture extends StatelessWidget {
  const FullScreenPicture({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  final String imageUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.contain,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

PageRouteBuilder toggleFullScreenTransition(String imageUrl, String title) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return FullScreenPicture(
        imageUrl: imageUrl,
        title: title,
      );
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      Animation<double> transitionAnimation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(animation);

      return FadeTransition(
        opacity: transitionAnimation,
        child: ScaleTransition(
          scale: transitionAnimation,
          child: child,
        ),
      );
    },
    transitionDuration: const Duration(
      milliseconds: 350,
    ),
  );
}
