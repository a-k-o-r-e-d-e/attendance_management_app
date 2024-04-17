// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_course_classes_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getCourseClassesHash() => r'7895d60f725ebf881636ff16fed8b29b85289387';

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

/// See also [getCourseClasses].
@ProviderFor(getCourseClasses)
const getCourseClassesProvider = GetCourseClassesFamily();

/// See also [getCourseClasses].
class GetCourseClassesFamily
    extends Family<AsyncValue<List<CourseClassesModel>>> {
  /// See also [getCourseClasses].
  const GetCourseClassesFamily();

  /// See also [getCourseClasses].
  GetCourseClassesProvider call(
    String courseId,
  ) {
    return GetCourseClassesProvider(
      courseId,
    );
  }

  @override
  GetCourseClassesProvider getProviderOverride(
    covariant GetCourseClassesProvider provider,
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
  String? get name => r'getCourseClassesProvider';
}

/// See also [getCourseClasses].
class GetCourseClassesProvider
    extends AutoDisposeFutureProvider<List<CourseClassesModel>> {
  /// See also [getCourseClasses].
  GetCourseClassesProvider(
    String courseId,
  ) : this._internal(
          (ref) => getCourseClasses(
            ref as GetCourseClassesRef,
            courseId,
          ),
          from: getCourseClassesProvider,
          name: r'getCourseClassesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getCourseClassesHash,
          dependencies: GetCourseClassesFamily._dependencies,
          allTransitiveDependencies:
              GetCourseClassesFamily._allTransitiveDependencies,
          courseId: courseId,
        );

  GetCourseClassesProvider._internal(
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
    FutureOr<List<CourseClassesModel>> Function(GetCourseClassesRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetCourseClassesProvider._internal(
        (ref) => create(ref as GetCourseClassesRef),
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
  AutoDisposeFutureProviderElement<List<CourseClassesModel>> createElement() {
    return _GetCourseClassesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetCourseClassesProvider && other.courseId == courseId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, courseId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetCourseClassesRef
    on AutoDisposeFutureProviderRef<List<CourseClassesModel>> {
  /// The parameter `courseId` of this provider.
  String get courseId;
}

class _GetCourseClassesProviderElement
    extends AutoDisposeFutureProviderElement<List<CourseClassesModel>>
    with GetCourseClassesRef {
  _GetCourseClassesProviderElement(super.provider);

  @override
  String get courseId => (origin as GetCourseClassesProvider).courseId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
