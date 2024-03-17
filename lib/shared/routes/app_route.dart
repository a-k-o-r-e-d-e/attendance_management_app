import 'package:attendance_management_app/features/authentication/presentation/screens/create_account_screen.dart';
import 'package:attendance_management_app/features/authentication/presentation/screens/login_screen.dart';
import 'package:attendance_management_app/features/authentication/presentation/screens/select_user_type_screen.dart';
import 'package:attendance_management_app/features/class/presentation/screens/attendance_screen.dart';
import 'package:attendance_management_app/features/class/presentation/screens/class_screen.dart';
import 'package:attendance_management_app/features/class/presentation/screens/create_class_screen.dart';
import 'package:attendance_management_app/features/class/presentation/screens/single_class_screen.dart';
import 'package:attendance_management_app/features/class/presentation/screens/start_class_screen.dart';
import 'package:attendance_management_app/features/course/domain/models/course_model.dart';
import 'package:attendance_management_app/features/course/presentation/screens/course_screen.dart';
import 'package:attendance_management_app/features/course/presentation/screens/create_course_screen.dart';
import 'package:attendance_management_app/features/course/presentation/screens/single_course_screen.dart';
import 'package:attendance_management_app/features/course/presentation/screens/student_info.dart';
import 'package:attendance_management_app/features/course/presentation/screens/student_list.dart';
import 'package:attendance_management_app/features/home/presentation/screens/home_screen.dart';
import 'package:attendance_management_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:attendance_management_app/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:attendance_management_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:attendance_management_app/features/profile/presentation/screens/settings_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

part 'app_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        /// routes go here
        AutoRoute(page: OnboardingRoute.page, initial: true, path: "/"),
        AutoRoute(page: SelectUserTypeRoute.page, path: "/select-user-type"),
        AutoRoute(page: CreateAccountRoute.page, path: "/create-account"),
        AutoRoute(page: LoginRoute.page, path: "/login"),
        AutoRoute(page: HomeRoute.page, path: "/home"),
        AutoRoute(page: ClassRoute.page, path: "/class"),
        AutoRoute(page: CreateClassRoute.page, path: "/create-class"),
        AutoRoute(page: CreateCourseRoute.page, path: "/create-course"),
        AutoRoute(page: CourseRoute.page, path: "/course"),
        AutoRoute(page: SingleCourseRoute.page, path: "/single-course"),
        AutoRoute(page: SingleClassRoute.page, path: "/single-class"),
        AutoRoute(page: StudentListRoute.page, path: "/student-list"),
        AutoRoute(page: StudentInfoRoute.page, path: "/student-info"),
        AutoRoute(page: StartClassRoute.page, path: "/start-class"),
        AutoRoute(page: AttendanceRoute.page, path: "/attendance"),
        AutoRoute(page: ProfileRoute.page, path: "/profile"),
        AutoRoute(page: EditProfileRoute.page, path: "/edit-profile"),
        AutoRoute(page: SettingsRoute.page, path: "/settings"),
  ];
}
