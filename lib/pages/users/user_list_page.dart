//import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
//import 'package:future_provider/models/item.dart' as item;

//import 'package:http/http.dart' as http;
import 'package:karbala/models/mohammad.dart' as moh;
//import '../../models/item.dart' as item;
import 'users_providers.dart';

class UserListPage extends ConsumerWidget {
  const UserListPage({super.key});
  final apiKey = 'secret_qC28KRlsKIdNPpySs0NKAW9y2YFvhqRhn64DKJRY2UU';
  final databaseId = 'ff9ca896efcb45c99509c50fe4e23f64';
  final mathDatabaseId = '42d381c5ab3d4423b1613aa0be752f77';
  final String baseUrl = 'https://api.notion.com/v1/databases';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final userList = ref.watch(userListProvider);
    //final notionItemList = ref.watch(notionItemProvider);
    final mohammadItemList = ref.watch(mohammadItemProvider);
    final mohammadItemList2 = ref.watch(myHammadListProvider);
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
        actions: [
          IconButton(
            onPressed: () {
              ref.invalidate(mohammadItemProvider);
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      // body: switch (userList) {
      //   AsyncData(value: final users) => ListView.separated(
      //       itemCount: users.length,
      //       separatorBuilder: (BuildContext context, int index) {
      //         return const Divider();
      //       },
      //       itemBuilder: (BuildContext context, int index) {
      //         final user = users[index];

      //         return ListTile(
      //           leading: CircleAvatar(
      //             child: Text(user.id.toString()),
      //           ),
      //           title: Text(user.name),
      //         );
      //       },
      //     ),
      //   AsyncError(error: final e) => Center(
      //       child: Text(
      //         e.toString(),
      //         style: const TextStyle(
      //           fontSize: 20,
      //           color: Colors.red,
      //         ),
      //       ),
      //     ),
      //   _ => const Center(
      //       child: CircularProgressIndicator(),
      //     ),
      // },
      body:
          mohammadItemList.isLoading && mohammadItemList2.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.separated(
                itemCount: mohammadItemList2.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
                itemBuilder: (BuildContext context, int index) {
                  final mohammad = mohammadItemList2[index];

                  return ListTile(
                    leading: CircleAvatar(child: Text(index.toString())),
                    title: Text(
                      mohammad.properties?.title?.title[0].plainText ??
                          'no title',
                    ),
                    subtitle: Column(
                      children: [
                        Text(
                          (mohammad
                                      .properties
                                      ?.description
                                      ?.richText
                                      .isNotEmpty ??
                                  false)
                              ? mohammad
                                      .properties!
                                      .description!
                                      .richText
                                      .first
                                      .text
                                      ?.content ??
                                  'No Description'
                              : 'No Description',
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: PictureWidget(mohammad: mohammad),
                        ),
                      ],
                    ),
                  );
                },
              ),

      /*   mohammadItemList.when(
        skipLoadingOnRefresh: false,
        data: (items) {
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(notionItemProvider),
            color: Colors.red,
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: items.length,
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
              itemBuilder: (BuildContext context, int index) {
                final item = items[index];

                return GestureDetector(
                  onTap: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (_) {
                    //       return UserDetailPage(userId: user.id);
                    //     },
                    //   ),
                    // );
                    //fetchData();
                  },
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child: Text(index.toString()),
                        ),
                        title: Text(
                          item.properties?.title?.title[0].plainText ??
                              'no title',
                        ),
                      ),
                      Column(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children:
                                  item.properties!.pic!.files
                                      .map(
                                        (file) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0,
                                          ),
                                          child: Image.network(
                                            file.file!.url,
                                            height: 150,
                                            width: 150,
                                            //fit: BoxFit.cover,
                                            loadingBuilder: (
                                              BuildContext context,
                                              Widget child,
                                              ImageChunkEvent? loadingProgress,
                                            ) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return Center(
                                                child: CircularProgressIndicator(
                                                  value:
                                                      loadingProgress
                                                                  .expectedTotalBytes !=
                                                              null
                                                          ? loadingProgress
                                                                  .cumulativeBytesLoaded /
                                                              (loadingProgress
                                                                      .expectedTotalBytes ??
                                                                  1)
                                                          : null,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                      .toList(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
        error: (e, st) {
          return Center(
            child: Text(
              e.toString(),
              style: const TextStyle(fontSize: 20, color: Colors.red),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
       */
    );
  }
}

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

//last change
