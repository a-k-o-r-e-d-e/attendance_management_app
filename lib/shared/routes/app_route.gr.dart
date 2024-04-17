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
      final args = routeData.argsAs<CreateClassRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CreateClassScreen(
          args.courseId,
          args.editClass,
          args.courseTitle,
          key: args.key,
        ),
      );
    },
    CreateCourseRoute.name: (routeData) {
      final args = routeData.argsAs<CreateCourseRouteArgs>(
          orElse: () => const CreateCourseRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CreateCourseScreen(
          key: args.key,
          editCourse: args.editCourse,
        ),
      );
    },
    EditProfileRoute.name: (routeData) {
      final args = routeData.argsAs<EditProfileRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EditProfileScreen(
          args.user,
          key: args.key,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    LecturerInfoRoute.name: (routeData) {
      final args = routeData.argsAs<LecturerInfoRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LecturerInfoScreen(
          key: args.key,
          lecturer: args.lecturer,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginScreen(key: args.key),
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
          classInstance: args.classInstance,
          classID: args.classID,
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
    StartupRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const StartupScreen(),
      );
    },
    StudentInfoRoute.name: (routeData) {
      final args = routeData.argsAs<StudentInfoRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: StudentInfoScreen(
          args.student,
          key: args.key,
          attendance: args.attendance,
        ),
      );
    },
    StudentListRoute.name: (routeData) {
      final args = routeData.argsAs<StudentListRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: StudentListScreen(
          args.students,
          key: args.key,
        ),
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
class CreateClassRoute extends PageRouteInfo<CreateClassRouteArgs> {
  CreateClassRoute({
    required String courseId,
    required Base? editClass,
    required String? courseTitle,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          CreateClassRoute.name,
          args: CreateClassRouteArgs(
            courseId: courseId,
            editClass: editClass,
            courseTitle: courseTitle,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'CreateClassRoute';

  static const PageInfo<CreateClassRouteArgs> page =
      PageInfo<CreateClassRouteArgs>(name);
}

class CreateClassRouteArgs {
  const CreateClassRouteArgs({
    required this.courseId,
    required this.editClass,
    required this.courseTitle,
    this.key,
  });

  final String courseId;

  final Base? editClass;

  final String? courseTitle;

  final Key? key;

  @override
  String toString() {
    return 'CreateClassRouteArgs{courseId: $courseId, editClass: $editClass, courseTitle: $courseTitle, key: $key}';
  }
}

/// generated route for
/// [CreateCourseScreen]
class CreateCourseRoute extends PageRouteInfo<CreateCourseRouteArgs> {
  CreateCourseRoute({
    Key? key,
    Course? editCourse,
    List<PageRouteInfo>? children,
  }) : super(
          CreateCourseRoute.name,
          args: CreateCourseRouteArgs(
            key: key,
            editCourse: editCourse,
          ),
          initialChildren: children,
        );

  static const String name = 'CreateCourseRoute';

  static const PageInfo<CreateCourseRouteArgs> page =
      PageInfo<CreateCourseRouteArgs>(name);
}

class CreateCourseRouteArgs {
  const CreateCourseRouteArgs({
    this.key,
    this.editCourse,
  });

  final Key? key;

  final Course? editCourse;

  @override
  String toString() {
    return 'CreateCourseRouteArgs{key: $key, editCourse: $editCourse}';
  }
}

/// generated route for
/// [EditProfileScreen]
class EditProfileRoute extends PageRouteInfo<EditProfileRouteArgs> {
  EditProfileRoute({
    required UserAccount user,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          EditProfileRoute.name,
          args: EditProfileRouteArgs(
            user: user,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static const PageInfo<EditProfileRouteArgs> page =
      PageInfo<EditProfileRouteArgs>(name);
}

class EditProfileRouteArgs {
  const EditProfileRouteArgs({
    required this.user,
    this.key,
  });

  final UserAccount user;

  final Key? key;

  @override
  String toString() {
    return 'EditProfileRouteArgs{user: $user, key: $key}';
  }
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
/// [LecturerInfoScreen]
class LecturerInfoRoute extends PageRouteInfo<LecturerInfoRouteArgs> {
  LecturerInfoRoute({
    Key? key,
    required Lecturer lecturer,
    List<PageRouteInfo>? children,
  }) : super(
          LecturerInfoRoute.name,
          args: LecturerInfoRouteArgs(
            key: key,
            lecturer: lecturer,
          ),
          initialChildren: children,
        );

  static const String name = 'LecturerInfoRoute';

  static const PageInfo<LecturerInfoRouteArgs> page =
      PageInfo<LecturerInfoRouteArgs>(name);
}

class LecturerInfoRouteArgs {
  const LecturerInfoRouteArgs({
    this.key,
    required this.lecturer,
  });

  final Key? key;

  final Lecturer lecturer;

  @override
  String toString() {
    return 'LecturerInfoRouteArgs{key: $key, lecturer: $lecturer}';
  }
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<LoginRouteArgs> page = PageInfo<LoginRouteArgs>(name);
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
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
    required Base classInstance,
    required String classID,
    List<PageRouteInfo>? children,
  }) : super(
          SingleClassRoute.name,
          args: SingleClassRouteArgs(
            key: key,
            classInstance: classInstance,
            classID: classID,
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
    required this.classInstance,
    required this.classID,
  });

  final Key? key;

  final Base classInstance;

  final String classID;

  @override
  String toString() {
    return 'SingleClassRouteArgs{key: $key, classInstance: $classInstance, classID: $classID}';
  }
}

/// generated route for
/// [SingleCourseScreen]
class SingleCourseRoute extends PageRouteInfo<SingleCourseRouteArgs> {
  SingleCourseRoute({
    Key? key,
    required Course course,
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

  final Course course;

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
/// [StartupScreen]
class StartupRoute extends PageRouteInfo<void> {
  const StartupRoute({List<PageRouteInfo>? children})
      : super(
          StartupRoute.name,
          initialChildren: children,
        );

  static const String name = 'StartupRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [StudentInfoScreen]
class StudentInfoRoute extends PageRouteInfo<StudentInfoRouteArgs> {
  StudentInfoRoute({
    required Profile student,
    Key? key,
    bool? attendance = false,
    List<PageRouteInfo>? children,
  }) : super(
          StudentInfoRoute.name,
          args: StudentInfoRouteArgs(
            student: student,
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
    required this.student,
    this.key,
    this.attendance = false,
  });

  final Profile student;

  final Key? key;

  final bool? attendance;

  @override
  String toString() {
    return 'StudentInfoRouteArgs{student: $student, key: $key, attendance: $attendance}';
  }
}

/// generated route for
/// [StudentListScreen]
class StudentListRoute extends PageRouteInfo<StudentListRouteArgs> {
  StudentListRoute({
    required List<Profile> students,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          StudentListRoute.name,
          args: StudentListRouteArgs(
            students: students,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'StudentListRoute';

  static const PageInfo<StudentListRouteArgs> page =
      PageInfo<StudentListRouteArgs>(name);
}

class StudentListRouteArgs {
  const StudentListRouteArgs({
    required this.students,
    this.key,
  });

  final List<Profile> students;

  final Key? key;

  @override
  String toString() {
    return 'StudentListRouteArgs{students: $students, key: $key}';
  }
}
