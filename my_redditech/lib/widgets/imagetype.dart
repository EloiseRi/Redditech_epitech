import 'package:flutter/material.dart';

class ImageType extends StatelessWidget {
  final String? url;

  const ImageType({Key? key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url ?? 'https://zupimages.net/up/21/43/6k02.png',
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.orange,
            ),
            backgroundColor: Colors.grey.shade200,
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    );
  }
}
