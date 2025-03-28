//import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
//import 'package:future_provider/models/item.dart' as item;

//import 'package:http/http.dart' as http;
import 'package:karbala/models/temu.dart' as tm;
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

  String truncateText(String text, int maxLines) {
    const int maxLength = 40; // Adjust this based on your layout
    if (text.length > maxLength) {
      return '${text.substring(0, maxLength)}... no more';
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<List<tm.Temu>> temuItemList = ref.watch(temuItemProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        actions: const [RefreshButton()],
      ),
      body: temuItemList.when(
        data: (users) {
          // Pre-cache all images in the ListView
          for (final user in users) {
            if (user.properties?.image?.richText != null) {
              for (final image in user.properties!.image!.richText) {
                final fileId = extractGoogleDriveFileId(image.plainText);
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

          return SingleChildScrollView(
            child: LayoutGrid(
              columnSizes: [
                1.fr, // First column takes up remaining space
                1.fr, // Second column takes up remaining space
              ],
              // columnSizes: [1.fr, 1.fr], // Two columns with equal width
              rowSizes: List.generate(
                (users.length / 2).ceil(),
                (_) => auto, // Automatically adjust row height
              ),
              rowGap: 8.0, // Spacing between rows
              columnGap: 8.0, // Spacing between columns
              children: [
                for (final user in users)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (user.properties!.image!.richText.isEmpty)
                        const SizedBox()
                      else
                        SizedBox(
                          height: 200, // Adjust the height as needed
                          child: PageView.builder(
                            itemCount:
                                user.properties!.image!.richText
                                    .map(
                                      (image) => extractGoogleDriveFileId(
                                        image.plainText,
                                      ),
                                    )
                                    .where((fileId) => fileId.isNotEmpty)
                                    .length,
                            itemBuilder: (context, index) {
                              final validFileIds =
                                  user.properties!.image!.richText
                                      .map(
                                        (image) => extractGoogleDriveFileId(
                                          image.plainText,
                                        ),
                                      )
                                      .where((fileId) => fileId.isNotEmpty)
                                      .toList();
                              final fileId = validFileIds[index];
                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        insetPadding: EdgeInsets.zero,
                                        child: Scaffold(
                                          appBar: AppBar(
                                            title: const Text('Image Viewer'),
                                            leading: IconButton(
                                              icon: const Icon(
                                                Icons.arrow_back,
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ),
                                          body: InteractiveViewer(
                                            panEnabled: true,
                                            minScale: 0.5,
                                            maxScale: 4.0,
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  'https://drive.google.com/uc?export=download&id=$fileId',
                                              placeholder:
                                                  (
                                                    context,
                                                    url,
                                                  ) => const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Center(
                                                        child: Icon(
                                                          Icons.error,
                                                        ),
                                                      ),
                                              fit: BoxFit.contain,
                                            ),
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
                                            (downloadProgress.progress ?? 0) *
                                            100;
                                        return Center(
                                          child: Text(
                                            '${progress.toStringAsFixed(0)}%',
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
                                          '${index + 1} of ${validFileIds.length}',
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
                      if (user.properties!.name!.title.isEmpty)
                        const SizedBox()
                      else
                        Text(
                          truncateText(
                            user.properties!.name!.title.first.text!.content +
                                user
                                    .properties!
                                    .name!
                                    .title
                                    .first
                                    .text!
                                    .content
                                    .length
                                    .toString(),
                            2,
                          ),
                          maxLines:
                              user
                                          .properties!
                                          .name!
                                          .title
                                          .first
                                          .text!
                                          .content
                                          .length >
                                      40
                                  ? 2
                                  : 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 14),
                        ),
                    ],
                  ),
              ],
            ),
          );
          /*   return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              //  mainAxisExtent: 240, // Maximum width of each cell
              //
              // mainAxisExtent: (users.properties!.name!.title.first.text!.content.length > 30) ? 300 : 200,
              crossAxisSpacing: 8.0, // Spacing between columns
              mainAxisSpacing: 8.0, // Spacing between rows
              childAspectRatio: 0.8, // Adjust the aspect ratio as needed
            ),
            itemCount: users.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              final user = users[index];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*       SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          user.properties!.categories!.multiSelect.map((
                            category,
                          ) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 4.0,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 4.0,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Text(
                                category.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  ),
            */
                  if (user.properties!.image!.richText.isEmpty)
                    const SizedBox()
                  else
                    SizedBox(
                      height: 200, // Adjust the height as needed
                      child: PageView.builder(
                        itemCount:
                            user.properties!.image!.richText
                                .map(
                                  (image) =>
                                      extractGoogleDriveFileId(image.plainText),
                                )
                                .where((fileId) => fileId.isNotEmpty)
                                .length,
                        itemBuilder: (context, index) {
                          // Filter valid file IDs
                          final validFileIds =
                              user.properties!.image!.richText
                                  .map(
                                    (image) => extractGoogleDriveFileId(
                                      image.plainText,
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
                                    insetPadding:
                                        EdgeInsets
                                            .zero, // Remove default padding
                                    child: Scaffold(
                                      appBar: AppBar(
                                        title: const Text('Image Viewer'),
                                        leading: IconButton(
                                          icon: const Icon(Icons.arrow_back),
                                          onPressed: () {
                                            Navigator.of(
                                              context,
                                            ).pop(); // Close the dialog
                                          },
                                        ),
                                      ),
                                      body: InteractiveViewer(
                                        panEnabled: true, // Allow panning
                                        minScale: 0.5, // Minimum zoom scale
                                        maxScale: 4.0, // Maximum zoom scale
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://drive.google.com/uc?export=download&id=$fileId',
                                          placeholder:
                                              (context, url) => const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                          errorWidget:
                                              (context, url, error) =>
                                                  const Center(
                                                    child: Icon(Icons.error),
                                                  ),
                                          fit: BoxFit.contain,
                                        ),
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

                  if (user.properties!.name!.title.isEmpty)
                    const SizedBox()
                  else
                    Text(
                      truncateText(
                        user.properties!.name!.title.first.text!.content +
                            user
                                .properties!
                                .name!
                                .title
                                .first
                                .text!
                                .content
                                .length
                                .toString(),
                        2,
                      ),

                      //maxLines: 2,
                      maxLines:
                          user
                                      .properties!
                                      .name!
                                      .title
                                      .first
                                      .text!
                                      .content
                                      .length >
                                  40
                              ? 2
                              : 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                      ), // Still use ellipsis for safety
                    ),
                ],
              );
            },
          );
      */
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
      ref.invalidate(temuItemProvider);
      await ref.read(temuItemProvider.future); // Wait for data to reload
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
