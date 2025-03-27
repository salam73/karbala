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
  final apiKey = 'secret_qC28KRlsKIdNPpySs0NKAW9y2YFvhqRhn64DKJRY2UU';
  final databaseId = 'ff9ca896efcb45c99509c50fe4e23f64';
  final mathDatabaseId = '42d381c5ab3d4423b1613aa0be752f77';
  final String baseUrl = 'https://api.notion.com/v1/databases';

  @override
  ConsumerState<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends ConsumerState<UserListPage> {
  String extractGoogleDriveFileId(String url) {
    final uri = Uri.parse(url);
    final segments = uri.pathSegments;
    if (segments.length > 2 && segments[1] == 'd') {
      print(' sugmpent 2${segments[2]}');
      return segments[2]; // The file ID is the third segment
    }
    return ''; // Return an empty string if the URL is invalid
  }

  @override
  Widget build(BuildContext context) {
    // final userList = ref.watch(userListProvider);
    //final notionItemList = ref.watch(notionItemProvider);
    AsyncValue<List<moh.Temu>> mohammadItemList = const AsyncValue.loading();
    //final mohammadItemList2 = ref.watch(myHammadListProvider);

    mohammadItemList = ref.watch(mohammadItemProvider);

    // print(userList);
    // print(notionItemList);
    print(
      'isLoading: ${mohammadItemList.isLoading}, isRefreshing: ${mohammadItemList.isRefreshing}, isReloading: ${mohammadItemList.isReloading}',
    );
    print(
      'hasValue: ${mohammadItemList.hasValue}, hasError: ${mohammadItemList.hasError}',
    );
    //test

    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        actions: [RefreshButton()],
      ),
      body: switch (mohammadItemList) {
        AsyncData(value: final users) => ListView.separated(
          itemCount: users.length,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
          itemBuilder: (BuildContext context, int index) {
            final user = users[index];

            return Column(
              children: [
                Text(user.properties!.name!.title.first['text']['content']),
                /*  user.properties!.image!.richText.isEmpty
                    ? const SizedBox()
                    : CachedNetworkImage(
                      imageUrl:
                          'https://drive.google.com/uc?export=download&id=${extractGoogleDriveFileId(user.properties!.image!.richText[0]['plain_text'])}',
                      placeholder:
                          (context, url) => const CircularProgressIndicator(),
                      errorWidget:
                          (context, url, error) => const Icon(Icons.error),
                      // imageBuilder:
                      //     (context, imageProvider) =>
                      //         CircleAvatar(backgroundImage: imageProvider),
                    ), */
                /*     user.properties!.image!.richText.length < 2
                    ? const SizedBox()
                    : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            user.properties!.image!.richText.map<Widget>((
                              image,
                            ) {
                              String imageUrl = image['plain_text'];
                              String fileId = extractGoogleDriveFileId(
                                imageUrl,
                              );

                              return fileId.isEmpty
                                  ? const SizedBox()
                                  : CachedNetworkImage(
                                    imageUrl:
                                        'https://drive.google.com/uc?export=download&id=$fileId',
                                    placeholder:
                                        (context, url) =>
                                            const CircularProgressIndicator(),
                                    errorWidget:
                                        (context, url, error) =>
                                            const Icon(Icons.error),
                                    width: 50, // Adjust the width as needed
                                    height: 50, // Adjust the height as needed
                                  );
                            }).toList(),
                      ),
                    ),
 */
                /*               user.properties!.image!.richText.length < 2
                    ? const SizedBox()
                    : SizedBox(
                      height: 200, // Adjust the height as needed
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

                          // Display the image using CachedNetworkImage
                          return CachedNetworkImage(
                            imageUrl:
                                'https://drive.google.com/uc?export=download&id=$fileId',
                            placeholder:
                                (context, url) =>
                                    const CircularProgressIndicator(),
                            errorWidget:
                                (context, url, error) =>
                                    const Icon(Icons.error),
                          );
                        },
                      ),
                    ),
    */
                /*   GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://drive.google.com/uc?export=download&id=${extractGoogleDriveFileId(user.properties!.image!.richText[0]['plain_text'])}',
                            placeholder:
                                (context, url) =>
                                    const CircularProgressIndicator(),
                            errorWidget:
                                (context, url, error) =>
                                    const Icon(Icons.error),
                            fit: BoxFit.contain,
                          ),
                        );
                      },
                    );
                  },
                  child:
                      user.properties!.image!.richText.isEmpty
                          ? const SizedBox()
                          : CachedNetworkImage(
                            imageUrl:
                                'https://drive.google.com/uc?export=download&id=${extractGoogleDriveFileId(user.properties!.image!.richText[0]['plain_text'])}',
                            placeholder:
                                (context, url) =>
                                    const CircularProgressIndicator(),
                            errorWidget:
                                (context, url, error) =>
                                    const Icon(Icons.error),
                          ),
                ), */
                user.properties!.image!.richText.isEmpty
                    ? const SizedBox()
                    : SizedBox(
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
                                  placeholder:
                                      (context, url) =>
                                          const CircularProgressIndicator(),
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
        ),
        AsyncLoading() => const Center(child: CircularProgressIndicator()),
        AsyncError(error: final error, stackTrace: final stackTrace) => Center(
          child: Text(
            'Error: $error',
            style: const TextStyle(color: Colors.red, fontSize: 18),
          ),
        ),
        _ => const Center(child: Text('Unexpected state')),
      },
    );
  }
}

class RefreshButton extends ConsumerStatefulWidget {
  @override
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
