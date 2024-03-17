// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_route.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AttendanceRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AttendanceScreen(),
      );
    },
    ClassRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ClassScreen(),
      );
    },
    CourseRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CourseScreen(),
      );
    },
    CreateAccountRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CreateAccountScreen(),
      );
    },
    CreateClassRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CreateClassScreen(),
      );
    },
    CreateCourseRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CreateCourseScreen(),
      );
    },
    EditProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const EditProfileScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginScreen(),
      );
    },
    OnboardingRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingRouteArgs>(
          orElse: () => const OnboardingRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: OnboardingScreen(key: args.key),
      );
    },
    ProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfileScreen(),
      );
    },
    SelectUserTypeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SelectUserTypeScreen(),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsScreen(),
      );
    },
    SingleClassRoute.name: (routeData) {
      final args = routeData.argsAs<SingleClassRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SingleClassScreen(
          key: args.key,
          course: args.course,
        ),
      );
    },
    SingleCourseRoute.name: (routeData) {
      final args = routeData.argsAs<SingleCourseRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SingleCourseScreen(
          key: args.key,
          course: args.course,
        ),
      );
    },
    StartClassRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const StartClassScreen(),
      );
    },
    StudentInfoRoute.name: (routeData) {
      final args = routeData.argsAs<StudentInfoRouteArgs>(
          orElse: () => const StudentInfoRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: StudentInfoScreen(
          key: args.key,
          attendance: args.attendance,
        ),
      );
    },
    StudentListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const StudentListScreen(),
      );
    },
  };
}

/// generated route for
/// [AttendanceScreen]
class AttendanceRoute extends PageRouteInfo<void> {
  const AttendanceRoute({List<PageRouteInfo>? children})
      : super(
          AttendanceRoute.name,
          initialChildren: children,
        );

  static const String name = 'AttendanceRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ClassScreen]
class ClassRoute extends PageRouteInfo<void> {
  const ClassRoute({List<PageRouteInfo>? children})
      : super(
          ClassRoute.name,
          initialChildren: children,
        );

  static const String name = 'ClassRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CourseScreen]
class CourseRoute extends PageRouteInfo<void> {
  const CourseRoute({List<PageRouteInfo>? children})
      : super(
          CourseRoute.name,
          initialChildren: children,
        );

  static const String name = 'CourseRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CreateAccountScreen]
class CreateAccountRoute extends PageRouteInfo<void> {
  const CreateAccountRoute({List<PageRouteInfo>? children})
      : super(
          CreateAccountRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateAccountRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CreateClassScreen]
class CreateClassRoute extends PageRouteInfo<void> {
  const CreateClassRoute({List<PageRouteInfo>? children})
      : super(
          CreateClassRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateClassRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CreateCourseScreen]
class CreateCourseRoute extends PageRouteInfo<void> {
  const CreateCourseRoute({List<PageRouteInfo>? children})
      : super(
          CreateCourseRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateCourseRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [EditProfileScreen]
class EditProfileRoute extends PageRouteInfo<void> {
  const EditProfileRoute({List<PageRouteInfo>? children})
      : super(
          EditProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OnboardingScreen]
class OnboardingRoute extends PageRouteInfo<OnboardingRouteArgs> {
  OnboardingRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          OnboardingRoute.name,
          args: OnboardingRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static const PageInfo<OnboardingRouteArgs> page =
      PageInfo<OnboardingRouteArgs>(name);
}

class OnboardingRouteArgs {
  const OnboardingRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'OnboardingRouteArgs{key: $key}';
  }
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SelectUserTypeScreen]
class SelectUserTypeRoute extends PageRouteInfo<void> {
  const SelectUserTypeRoute({List<PageRouteInfo>? children})
      : super(
          SelectUserTypeRoute.name,
          initialChildren: children,
        );

  static const String name = 'SelectUserTypeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SingleClassScreen]
class SingleClassRoute extends PageRouteInfo<SingleClassRouteArgs> {
  SingleClassRoute({
    Key? key,
    required CourseModel course,
    List<PageRouteInfo>? children,
  }) : super(
          SingleClassRoute.name,
          args: SingleClassRouteArgs(
            key: key,
            course: course,
          ),
          initialChildren: children,
        );

  static const String name = 'SingleClassRoute';

  static const PageInfo<SingleClassRouteArgs> page =
      PageInfo<SingleClassRouteArgs>(name);
}

class SingleClassRouteArgs {
  const SingleClassRouteArgs({
    this.key,
    required this.course,
  });

  final Key? key;

  final CourseModel course;

  @override
  String toString() {
    return 'SingleClassRouteArgs{key: $key, course: $course}';
  }
}

/// generated route for
/// [SingleCourseScreen]
class SingleCourseRoute extends PageRouteInfo<SingleCourseRouteArgs> {
  SingleCourseRoute({
    Key? key,
    required CourseModel course,
    List<PageRouteInfo>? children,
  }) : super(
          SingleCourseRoute.name,
          args: SingleCourseRouteArgs(
            key: key,
            course: course,
          ),
          initialChildren: children,
        );

  static const String name = 'SingleCourseRoute';

  static const PageInfo<SingleCourseRouteArgs> page =
      PageInfo<SingleCourseRouteArgs>(name);
}

class SingleCourseRouteArgs {
  const SingleCourseRouteArgs({
    this.key,
    required this.course,
  });

  final Key? key;

  final CourseModel course;

  @override
  String toString() {
    return 'SingleCourseRouteArgs{key: $key, course: $course}';
  }
}

/// generated route for
/// [StartClassScreen]
class StartClassRoute extends PageRouteInfo<void> {
  const StartClassRoute({List<PageRouteInfo>? children})
      : super(
          StartClassRoute.name,
          initialChildren: children,
        );

  static const String name = 'StartClassRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [StudentInfoScreen]
class StudentInfoRoute extends PageRouteInfo<StudentInfoRouteArgs> {
  StudentInfoRoute({
    Key? key,
    bool? attendance = false,
    List<PageRouteInfo>? children,
  }) : super(
          StudentInfoRoute.name,
          args: StudentInfoRouteArgs(
            key: key,
            attendance: attendance,
          ),
          initialChildren: children,
        );

  static const String name = 'StudentInfoRoute';

  static const PageInfo<StudentInfoRouteArgs> page =
      PageInfo<StudentInfoRouteArgs>(name);
}

class StudentInfoRouteArgs {
  const StudentInfoRouteArgs({
    this.key,
    this.attendance = false,
  });

  final Key? key;

  final bool? attendance;

  @override
  String toString() {
    return 'StudentInfoRouteArgs{key: $key, attendance: $attendance}';
  }
}

/// generated route for
/// [StudentListScreen]
class StudentListRoute extends PageRouteInfo<void> {
  const StudentListRoute({List<PageRouteInfo>? children})
      : super(
          StudentListRoute.name,
          initialChildren: children,
        );

  static const String name = 'StudentListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
