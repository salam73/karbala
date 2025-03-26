// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notionItemHash() => r'200f1ae534b8223b7ff1aced3bb4d83d5e9128c5';

/// See also [notionItem].
@ProviderFor(notionItem)
final notionItemProvider = AutoDisposeFutureProvider<List<NotionItem>>.internal(
  notionItem,
  name: r'notionItemProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$notionItemHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NotionItemRef = AutoDisposeFutureProviderRef<List<NotionItem>>;
String _$mohammadItemHash() => r'85bef7eebe9d3ef8dd074d974a5c8ffb2e2618f0';

/// See also [mohammadItem].
@ProviderFor(mohammadItem)
final mohammadItemProvider = AutoDisposeFutureProvider<List<Mohmmad>>.internal(
  mohammadItem,
  name: r'mohammadItemProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$mohammadItemHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MohammadItemRef = AutoDisposeFutureProviderRef<List<Mohmmad>>;
String _$userDetailHash() => r'6716910e38764a9c82cf880b8fce0782c543b6af';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [userDetail].
@ProviderFor(userDetail)
const userDetailProvider = UserDetailFamily();

/// See also [userDetail].
class UserDetailFamily extends Family<AsyncValue<User>> {
  /// See also [userDetail].
  const UserDetailFamily();

  /// See also [userDetail].
  UserDetailProvider call(
    int id,
  ) {
    return UserDetailProvider(
      id,
    );
  }

  @override
  UserDetailProvider getProviderOverride(
    covariant UserDetailProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userDetailProvider';
}

/// See also [userDetail].
class UserDetailProvider extends AutoDisposeFutureProvider<User> {
  /// See also [userDetail].
  UserDetailProvider(
    int id,
  ) : this._internal(
          (ref) => userDetail(
            ref as UserDetailRef,
            id,
          ),
          from: userDetailProvider,
          name: r'userDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userDetailHash,
          dependencies: UserDetailFamily._dependencies,
          allTransitiveDependencies:
              UserDetailFamily._allTransitiveDependencies,
          id: id,
        );

  UserDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(
    FutureOr<User> Function(UserDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserDetailProvider._internal(
        (ref) => create(ref as UserDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<User> createElement() {
    return _UserDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserDetailProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserDetailRef on AutoDisposeFutureProviderRef<User> {
  /// The parameter `id` of this provider.
  int get id;
}

class _UserDetailProviderElement extends AutoDisposeFutureProviderElement<User>
    with UserDetailRef {
  _UserDetailProviderElement(super.provider);

  @override
  int get id => (origin as UserDetailProvider).id;
}

String _$returnOneHash() => r'b1b3e40507130e0c37e541546365f30a90fa15b1';

/// See also [returnOne].
@ProviderFor(returnOne)
final returnOneProvider = AutoDisposeFutureProvider<int>.internal(
  returnOne,
  name: r'returnOneProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$returnOneHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ReturnOneRef = AutoDisposeFutureProviderRef<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
