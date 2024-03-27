// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_enrolled_student_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getEnrolledStudentHash() =>
    r'f2a8c192fee24b938dbb9dfacb334143f67770bc';

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

/// See also [getEnrolledStudent].
@ProviderFor(getEnrolledStudent)
const getEnrolledStudentProvider = GetEnrolledStudentFamily();

/// See also [getEnrolledStudent].
class GetEnrolledStudentFamily extends Family<AsyncValue<List<Profile>>> {
  /// See also [getEnrolledStudent].
  const GetEnrolledStudentFamily();

  /// See also [getEnrolledStudent].
  GetEnrolledStudentProvider call(
    String courseId,
  ) {
    return GetEnrolledStudentProvider(
      courseId,
    );
  }

  @override
  GetEnrolledStudentProvider getProviderOverride(
    covariant GetEnrolledStudentProvider provider,
  ) {
    return call(
      provider.courseId,
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
  String? get name => r'getEnrolledStudentProvider';
}

/// See also [getEnrolledStudent].
class GetEnrolledStudentProvider
    extends AutoDisposeFutureProvider<List<Profile>> {
  /// See also [getEnrolledStudent].
  GetEnrolledStudentProvider(
    String courseId,
  ) : this._internal(
          (ref) => getEnrolledStudent(
            ref as GetEnrolledStudentRef,
            courseId,
          ),
          from: getEnrolledStudentProvider,
          name: r'getEnrolledStudentProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getEnrolledStudentHash,
          dependencies: GetEnrolledStudentFamily._dependencies,
          allTransitiveDependencies:
              GetEnrolledStudentFamily._allTransitiveDependencies,
          courseId: courseId,
        );

  GetEnrolledStudentProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.courseId,
  }) : super.internal();

  final String courseId;

  @override
  Override overrideWith(
    FutureOr<List<Profile>> Function(GetEnrolledStudentRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetEnrolledStudentProvider._internal(
        (ref) => create(ref as GetEnrolledStudentRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        courseId: courseId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Profile>> createElement() {
    return _GetEnrolledStudentProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetEnrolledStudentProvider && other.courseId == courseId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, courseId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetEnrolledStudentRef on AutoDisposeFutureProviderRef<List<Profile>> {
  /// The parameter `courseId` of this provider.
  String get courseId;
}

class _GetEnrolledStudentProviderElement
    extends AutoDisposeFutureProviderElement<List<Profile>>
    with GetEnrolledStudentRef {
  _GetEnrolledStudentProviderElement(super.provider);

  @override
  String get courseId => (origin as GetEnrolledStudentProvider).courseId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
