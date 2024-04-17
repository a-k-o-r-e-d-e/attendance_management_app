// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_classes_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getClassesHash() => r'bab13395da3623759c21338d0b5076958dba96eb';

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

/// See also [getClasses].
@ProviderFor(getClasses)
const getClassesProvider = GetClassesFamily();

/// See also [getClasses].
class GetClassesFamily extends Family<AsyncValue<List<UpcomingClassModel>>> {
  /// See also [getClasses].
  const GetClassesFamily();

  /// See also [getClasses].
  GetClassesProvider call(
    UserType userType,
  ) {
    return GetClassesProvider(
      userType,
    );
  }

  @override
  GetClassesProvider getProviderOverride(
    covariant GetClassesProvider provider,
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
  String? get name => r'getClassesProvider';
}

/// See also [getClasses].
class GetClassesProvider extends FutureProvider<List<UpcomingClassModel>> {
  /// See also [getClasses].
  GetClassesProvider(
    UserType userType,
  ) : this._internal(
          (ref) => getClasses(
            ref as GetClassesRef,
            userType,
          ),
          from: getClassesProvider,
          name: r'getClassesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getClassesHash,
          dependencies: GetClassesFamily._dependencies,
          allTransitiveDependencies:
              GetClassesFamily._allTransitiveDependencies,
          userType: userType,
        );

  GetClassesProvider._internal(
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
    FutureOr<List<UpcomingClassModel>> Function(GetClassesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetClassesProvider._internal(
        (ref) => create(ref as GetClassesRef),
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
  FutureProviderElement<List<UpcomingClassModel>> createElement() {
    return _GetClassesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetClassesProvider && other.userType == userType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userType.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetClassesRef on FutureProviderRef<List<UpcomingClassModel>> {
  /// The parameter `userType` of this provider.
  UserType get userType;
}

class _GetClassesProviderElement
    extends FutureProviderElement<List<UpcomingClassModel>> with GetClassesRef {
  _GetClassesProviderElement(super.provider);

  @override
  UserType get userType => (origin as GetClassesProvider).userType;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
