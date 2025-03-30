//import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
//import 'package:flutter_layout_grid/flutter_layout_grid.dart';
//import 'package:future_provider/models/item.dart' as item;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
    double maxLength =
        MediaQuery.of(context).size.width /
        4.7; // Adjust this based on your layout
    if (text.length > maxLength) {
      return '${text.substring(0, maxLength.toInt())}... تفاصيل';
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    final MyTemuListNotifier myTemuListNotifier = ref.watch(
      myTemu.notifier,
    ); // Access the notifier
    AsyncValue<List<tm.Temu>> temuItemList = ref.watch(temuItemProvider);
    print(
      'isLoading: ${temuItemList.isLoading}, isRefreshing: ${temuItemList.isRefreshing}, isReloading: ${temuItemList.isReloading}',
    );
    print(
      'hasValue: ${temuItemList.hasValue}, hasError: ${temuItemList.hasError}',
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        actions: const [RefreshButton()],
      ),
      body:
          ref.watch(myTemu).isNotEmpty
              ? MasonryGridView.count(
                crossAxisCount: 2, // Number of columns
                mainAxisSpacing: 8.0, // Spacing between rows
                crossAxisSpacing: 8.0, // Spacing between columns
                itemCount: myTemuListNotifier.state.length,
                itemBuilder: (context, index) {
                  final user = myTemuListNotifier.state[index];
                  if (user.properties!.name!.title.isEmpty) {
                    return const SizedBox();
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (user.properties!.image!.richText.isNotEmpty)
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
                                          body: ImagePageView(
                                            user: user,
                                            length: validFileIds.length,
                                            index2: index,
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
                      const SizedBox(height: 8),
                      Center(
                        child: Text(
                          textDirection: TextDirection.rtl,
                          truncateText(
                            user.properties!.name!.title.first.text!.content,
                            2,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  );
                },
              )
              : temuItemList.when(
                data: (users) {
                  // Pre-cache all images in the ListView
                  for (final user in users) {
                    if (user.properties?.image?.richText != null) {
                      for (final image in user.properties!.image!.richText) {
                        final fileId = extractGoogleDriveFileId(
                          image.plainText,
                        );
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

                  return MasonryGridView.count(
                    crossAxisCount: 2, // Number of columns
                    mainAxisSpacing: 8.0, // Spacing between rows
                    crossAxisSpacing: 8.0, // Spacing between columns
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      if (user.properties!.name!.title.isEmpty) {
                        return const SizedBox();
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (user.properties!.image!.richText.isNotEmpty)
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
                                                title: const Text(
                                                  'Image Viewer',
                                                ),
                                                leading: IconButton(
                                                  icon: const Icon(
                                                    Icons.arrow_back,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ),
                                              body: ImagePageView(
                                                user: user,
                                                length: validFileIds.length,
                                                index2: index,
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
                                                (downloadProgress.progress ??
                                                    0) *
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
                                            color: Colors.black.withOpacity(
                                              0.3,
                                            ),
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
                          const SizedBox(height: 8),
                          Center(
                            child: Text(
                              textDirection: TextDirection.rtl,
                              truncateText(
                                user
                                    .properties!
                                    .name!
                                    .title
                                    .first
                                    .text!
                                    .content,
                                2,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                loading: () {
                  return const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Loading data...'),
                      ],
                    ),
                  );
                },
                error: (error, stack) {
                  return Center(
                    child: Text(
                      'Error: $error',
                      style: const TextStyle(color: Colors.red, fontSize: 18),
                    ),
                  );
                },
              ),
    );
  }
}

class ImagePageView extends StatelessWidget {
  const ImagePageView({
    super.key,
    required this.user,
    required this.length,
    required this.index2,
  });

  String extractGoogleDriveFileId(String url) {
    final uri = Uri.parse(url);
    final segments = uri.pathSegments;
    if (segments.length > 2 && segments[1] == 'd') {
      return segments[2]; // The file ID is the third segment
    }
    return ''; // Return an empty string if the URL is invalid
  }

  final tm.Temu user;
  final int length;
  final int index2;

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(initialPage: index2);

    return PageView.builder(
      controller: pageController,
      itemCount: length,

      itemBuilder: (context, index) {
        // Filter valid file IDs
        final validFileIds =
            user.properties!.image!.richText
                .map((image) => extractGoogleDriveFileId(image.plainText))
                .where((fileId) => fileId.isNotEmpty)
                .toList();

        // Get the file ID for the current index
        final fileId = validFileIds[index];

        // Display the image with the index as text
        return Stack(
          children: [
            CachedNetworkImage(
              imageUrl:
                  'https://drive.google.com/uc?export=download&id=$fileId',
              progressIndicatorBuilder: (context, url, downloadProgress) {
                final progress = (downloadProgress.progress ?? 0) * 100;
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
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.contain,
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
        );
      },
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
