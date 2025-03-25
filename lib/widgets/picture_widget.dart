import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/mohammad.dart' as moh;

class PictureWidget extends StatelessWidget {
  const PictureWidget({super.key, required this.mohammad});

  final moh.Mohmmad mohammad;

  @override
  Widget build(BuildContext context) {
    return Row(
      children:
          mohammad.properties!.pic!.files
              .map(
                (file) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: CachedNetworkImage(
                    imageUrl: file.file!.url,
                    height: 150,
                    width: 150,
                    placeholder:
                        (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                    errorWidget:
                        (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              )
              .toList(),
    );
  }
}
