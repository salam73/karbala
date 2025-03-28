import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/mohammad.dart' as moh;

class PictureWidget extends StatelessWidget {
  const PictureWidget({super.key, required this.mohammad});

  final moh.Mohammad mohammad;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CachedNetworkImage(
          imageUrl: mohammad.cover,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mohammad.id!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                mohammad.createdTime.toString(),
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
