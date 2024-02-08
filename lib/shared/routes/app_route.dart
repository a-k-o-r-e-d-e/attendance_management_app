import 'package:attendance_management_app/features/authentication/presentation/screens/create_account_screen.dart';
import 'package:attendance_management_app/features/authentication/presentation/screens/login_screen.dart';
import 'package:attendance_management_app/features/authentication/presentation/screens/select_user_type_screen.dart';
import 'package:attendance_management_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
part 'app_route.gr.dart';

final appRouterProvider = Provider((_) => AppRouter());

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [
    /// routes go here
    AutoRoute(page: OnboardingRoute.page, initial: true, path: "/"),
    AutoRoute(page: SelectUserTypeRoute.page, path: "/select-user-type"),
    AutoRoute(page: CreateAccountRoute.page, path: "/create-account"),
    AutoRoute(page: LoginRoute.page, path: "/login"),

  ];
}