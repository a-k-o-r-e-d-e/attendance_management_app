// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_courses_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchCourseHash() => r'3780e341cbd0c90785aaafd901eece7af9ffeeab';

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

/// See also [fetchCourse].
@ProviderFor(fetchCourse)
const fetchCourseProvider = FetchCourseFamily();

/// See also [fetchCourse].
class FetchCourseFamily extends Family<AsyncValue<List<Course>>> {
  /// See also [fetchCourse].
  const FetchCourseFamily();

  /// See also [fetchCourse].
  FetchCourseProvider call(
    UserType userType,
  ) {
    return FetchCourseProvider(
      userType,
    );
  }

  @override
  FetchCourseProvider getProviderOverride(
    covariant FetchCourseProvider provider,
  ) {
    return call(
      provider.userType,
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
  String? get name => r'fetchCourseProvider';
}

/// See also [fetchCourse].
class FetchCourseProvider extends FutureProvider<List<Course>> {
  /// See also [fetchCourse].
  FetchCourseProvider(
    UserType userType,
  ) : this._internal(
          (ref) => fetchCourse(
            ref as FetchCourseRef,
            userType,
          ),
          from: fetchCourseProvider,
          name: r'fetchCourseProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchCourseHash,
          dependencies: FetchCourseFamily._dependencies,
          allTransitiveDependencies:
              FetchCourseFamily._allTransitiveDependencies,
          userType: userType,
        );

  FetchCourseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userType,
  }) : super.internal();

  final UserType userType;

  @override
  Override overrideWith(
    FutureOr<List<Course>> Function(FetchCourseRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchCourseProvider._internal(
        (ref) => create(ref as FetchCourseRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userType: userType,
      ),
    );
  }

  @override
  FutureProviderElement<List<Course>> createElement() {
    return _FetchCourseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchCourseProvider && other.userType == userType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userType.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchCourseRef on FutureProviderRef<List<Course>> {
  /// The parameter `userType` of this provider.
  UserType get userType;
}

class _FetchCourseProviderElement extends FutureProviderElement<List<Course>>
    with FetchCourseRef {
  _FetchCourseProviderElement(super.provider);

  @override
  UserType get userType => (origin as FetchCourseProvider).userType;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
