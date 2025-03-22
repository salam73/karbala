import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:future_provider/models/item.dart' as item;

import 'package:http/http.dart' as http;

import '../../models/item.dart' as item;
import 'users_providers.dart';

class UserListPage extends ConsumerWidget {
  const UserListPage({super.key});
  final apiKey = 'secret_qC28KRlsKIdNPpySs0NKAW9y2YFvhqRhn64DKJRY2UU';
  final databaseId = 'ff9ca896efcb45c99509c50fe4e23f64';
  final mathDatabaseId = '42d381c5ab3d4423b1613aa0be752f77';
  final String baseUrl = 'https://api.notion.com/v1/databases';

  fetchData() async {
    http.Response response;
    final headers = {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
      'Notion-Version': '2022-06-28',
    };

    try {
      response = await http.post(
        Uri.parse('$baseUrl/$databaseId/query'),
        headers: headers,
        // body: requestBody,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<item.NotionItem> items = [];

        for (var result in data['results']) {
          items.add(item.NotionItem.fromJson(result));
        }
        for (var item in items) {
          // print(item.properties?.name?.title[0].plainText ?? 'no title');
          // print(item.properties?.area?.select!.name ?? 'no name');
          print(item.properties?.picture?.files[0].file?.url ?? 'no file');
        }
        print(items.length);
      } else {
        print('Failed to load data!');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final userList = ref.watch(userListProvider);
    final notionItemList = ref.watch(notionItemProvider);
    final mohammadItemList = ref.watch(mohammadItemProvider);
    // print(userList);
    // print(notionItemList);
    print(
      'isLoading: ${notionItemList.isLoading}, isRefreshing: ${notionItemList.isRefreshing}, isReloading: ${notionItemList.isReloading}',
    );
    print(
      'hasValue: ${notionItemList.hasValue}, hasError: ${notionItemList.hasError}',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
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
      body: mohammadItemList.when(
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
    );
  }
}
