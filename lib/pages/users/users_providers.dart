// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:karbala/models/mohammad.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/user.dart';
import '../../models/item.dart';
import '../../providers/dio_provider.dart';

part 'users_providers.g.dart';

// final userListProvider = FutureProvider.autoDispose<List<User>>((ref) async {
//   ref.onDispose(() {
//     print('[userListProvider] disposed');
//   });
//   final response = await ref.watch(dioProvider).get('/users');
//   // throw 'Fail to fetch user list';
//   final List userList = response.data;
//   final users = [for (final user in userList) User.fromJson(user)];
//   return users;
// });

@riverpod
FutureOr<List<NotionItem>> notionItem(Ref ref) async {
  ref.onDispose(() {
    print('[userListProvider] disposed');
  });
  final response = await ref.watch(dioProvider).post('');
  // throw 'Fail to fetch user list';
  final List itemList = response.data['results'];
  final items = [for (final user in itemList) NotionItem.fromJson(user)];
  // print(items.length);
  return items;
}

final myHammadListProvider =
    StateNotifierProvider<MyHammadListNotifier, List<Temu>>((ref) {
      return MyHammadListNotifier();
    });

class MyHammadListNotifier extends StateNotifier<List<Temu>> {
  MyHammadListNotifier() : super([]);

  void addAll(List<Temu> items) {
    state = [...state, ...items];
  }
}

@riverpod
FutureOr<List<Temu>> mohammadItem(Ref ref) async {
  ref.onDispose(() {});
  final response = await ref.watch(dioProvider).post('');
  // throw 'Fail to fetch user list';
  final List itemList = response.data['results'];
  final items = [for (final user in itemList) Temu.fromJson(user)];
  // print(items.length);
  ref.read(myHammadListProvider.notifier).addAll(items);

  return items;
}

final wasLoadingProvider = StateProvider<bool>((ref) {
  return false;
});

// final userDetailProvider =
//     FutureProvider.autoDispose.family<User, int>((ref, id) async {
//   ref.onDispose(() {
//     print('[userDetailProvider($id)] disposed');
//   });
//   final response = await ref.watch(dioProvider).get('/users/$id');
//   final user = User.fromJson(response.data);
//   return user;
// });

@riverpod
FutureOr<User> userDetail(Ref ref, int id) async {
  ref.onDispose(() {
    print('[userDetailProvider($id)] disposed');
  });
  final response = await ref.watch(dioProvider).get('/users/$id');
  ref.keepAlive();
  final user = User.fromJson(response.data);
  return user;
}

@Riverpod(keepAlive: false)
FutureOr<int> returnOne(Ref ref) {
  ref.keepAlive();
  return Future.value(1);
}
