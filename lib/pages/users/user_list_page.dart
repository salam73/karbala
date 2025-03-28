//import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
//import 'package:future_provider/models/item.dart' as item;

//import 'package:http/http.dart' as http;
import 'package:karbala/models/mohammad.dart' as moh;
//import '../../models/item.dart' as item;
import 'user_detail_page.dart' show UserDetailPage;
import 'users_providers.dart';

class UserListPage extends ConsumerStatefulWidget {
  const UserListPage({super.key});

  @override
  ConsumerState<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends ConsumerState<UserListPage> {
  String extractGoogleDriveFileId(String url) {
    final uri = Uri.parse(url);
    final segments = uri.pathSegments;
    if (segments.length > 2 && segments[1] == 'd') {
      return segments[2]; // The file ID is the third segment
    }
    return ''; // Return an empty string if the URL is invalid
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<List<moh.Temu>> mohammadItemList = ref.watch(
      mohammadItemProvider,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        actions: const [RefreshButton()],
      ),
      body: mohammadItemList.when(
        data: (users) {
          // Pre-cache all images in the ListView
          for (final user in users) {
            if (user.properties?.image?.richText != null) {
              for (final image in user.properties!.image!.richText) {
                final fileId = extractGoogleDriveFileId(image['plain_text']);
                if (fileId.isNotEmpty) {
                  precacheImage(
                    CachedNetworkImageProvider(
                      'https://drive.google.com/uc?export=download&id=$fileId',
                    ),
                    context,
                  );
                }
              }
            }
          }

          return ListView.separated(
            itemCount: users.length,
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
            itemBuilder: (BuildContext context, int index) {
              final user = users[index];

              return Column(
                children: [
                  Text(user.properties!.name!.title.first['text']['content']),
                  if (user.properties!.image!.richText.isEmpty)
                    const SizedBox()
                  else
                    SizedBox(
                      height: 400, // Adjust the height as needed
                      child: PageView.builder(
                        itemCount:
                            user.properties!.image!.richText
                                .map(
                                  (image) => extractGoogleDriveFileId(
                                    image['plain_text'],
                                  ),
                                )
                                .where((fileId) => fileId.isNotEmpty)
                                .length,
                        itemBuilder: (context, index) {
                          // Filter valid file IDs
                          final validFileIds =
                              user.properties!.image!.richText
                                  .map(
                                    (image) => extractGoogleDriveFileId(
                                      image['plain_text'],
                                    ),
                                  )
                                  .where((fileId) => fileId.isNotEmpty)
                                  .toList();

                          // Get the file ID for the current index
                          final fileId = validFileIds[index];

                          // Display the image with the index as text
                          return GestureDetector(
                            onTap: () {
                              // Show the popup with the current image
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    child: InteractiveViewer(
                                      panEnabled: true, // Allow panning
                                      minScale: 0.5, // Minimum zoom scale
                                      maxScale: 4.0, // Maximum zoom scale
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            'https://drive.google.com/uc?export=download&id=$fileId',
                                        placeholder:
                                            (context, url) =>
                                                const CircularProgressIndicator(),
                                        errorWidget:
                                            (context, url, error) =>
                                                const Icon(Icons.error),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl:
                                      'https://drive.google.com/uc?export=download&id=$fileId',
                                  progressIndicatorBuilder: (
                                    context,
                                    url,
                                    downloadProgress,
                                  ) {
                                    final progress =
                                        (downloadProgress.progress ?? 0) * 100;
                                    return Center(
                                      child: Text(
                                        '${progress.toStringAsFixed(0)}%', // Show progress as a percentage
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    );
                                  },
                                  errorWidget:
                                      (context, url, error) =>
                                          const Icon(Icons.error),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                                Positioned(
                                  bottom: 10,
                                  right: 10,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 4.0,
                                    ),
                                    color: Colors.black.withOpacity(0.3),
                                    child: Text(
                                      '${index + 1} of ${validFileIds.length}', // Display the index (1-based) and total count
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                ],
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (error, stack) => Center(
              child: Text(
                'Error: $error',
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
            ),
      ),
    );
  }
}

class RefreshButton extends ConsumerStatefulWidget {
  const RefreshButton({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RefreshButtonState createState() => _RefreshButtonState();
}

class _RefreshButtonState extends ConsumerState<RefreshButton> {
  bool _isLoading = false;

  Future<void> _refreshData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      ref.invalidate(mohammadItemProvider);
      await ref.read(mohammadItemProvider.future); // Wait for data to reload
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Refresh complete')));
    } catch (error) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $error')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Padding(
          padding: EdgeInsets.all(8.0),
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        )
        : IconButton(icon: const Icon(Icons.refresh), onPressed: _refreshData);
  }
}
