import 'package:attendance_management_app/features/authentication/presentation/providers/states/user_type_state.dart';
import 'package:attendance_management_app/features/course/domain/models/course_model.dart';
import 'package:attendance_management_app/features/course/presentation/widgets/course_widget.dart';
import 'package:attendance_management_app/features/home/presentation/providers/available_courses_provider.dart';
import 'package:attendance_management_app/shared/providers/app_user_provider.dart';
import 'package:attendance_management_app/shared/services/local_auth_service/domain/repository/local_auth_service_repo.dart';
import 'package:attendance_management_app/shared/services/local_auth_service/providers/local_auth_provider.dart';
import 'package:attendance_management_app/shared/widgets/custom_bottom_navbar.dart';
import 'package:attendance_management_app/shared/widgets/general_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../shared/routes/app_route.dart';
import '../../../../shared/utilities/app_colors.dart';
import '../../../../shared/utilities/size_utils.dart';
import '../../../../shared/widgets/custom_appbar.dart';
import '../../../../shared/widgets/custom_text.dart';
import '../../../course/presentation/providers/fetch_courses_provider.dart';

@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  UserType? appUser;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      initialSetup();
    });
    super.initState();
  }

  Future<void> initialSetup() async {
    final LocalAuthService localAuth =
        ref.watch(localAuthServiceMethodsProvider);

    print(await localAuth.canCheckBiometrics());
  }

  Future<void> refresh() async {
    appUser == UserType.lecturer
        ? ref.invalidate(fetchCourseProvider(UserType.lecturer))
        : ref.invalidate(getAvailableCoursesProvider);
  }

  @override
  Widget build(BuildContext context) {
    appUser = ref.watch(appUserProvider).profile?.user?.roles![0] == 'lecturer'
        ? UserType.lecturer
        : UserType.student;
    final AsyncValue<List<Course>> activity = appUser == UserType.lecturer
        ? ref.watch(fetchCourseProvider(UserType.lecturer))
        : ref.watch(getAvailableCoursesProvider);

    //print(appUser);
    return Scaffold(
      appBar: CustomAppBar(
        prefixIcon: null,
        centerTitle: false,
        title: 'Home',
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: SvgPicture.asset("assets/svgs/notif.svg"),
        ),
        showBorder: true,
      ),
      backgroundColor: Colors.white,
      body: CustomBottomNavBar(
        parent: NavIdentifier.home,
        child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: appUser == UserType.lecturer
              ? Padding(
                  padding:
                      const EdgeInsets.only(bottom: 16.0, left: 20, right: 20),
                  child: GeneralButton(
                    buttonText: 'Create a course',
                    onPressed: () {
                      context.router.navigateNamed("/create-course");
                    },
                  ),
                )
              : null,
          body: RefreshIndicator(
            onRefresh: refresh,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    /*verticalSpace(24),
                    SizedBox(
                      height: 44,
                      child: CustomTextFormField(
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFFD5D7DB)),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        hintText: "Search for Classes",
                        suffixIcon: SvgPicture.asset(
                          "assets/svgs/search.svg",
                          width: 20,
                          height: 20,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),*/
                    verticalSpace(24),
                    /* activity.when(data: (List<Course> data) {
                      return Visibility(
                        visible: data.isNotEmpty,
                        replacement: Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              verticalSpace(heightSizer(165, context)),
                              SvgPicture.asset("assets/svgs/info.svg"),
                              verticalSpace(32),
                              const CustomText(
                                title: "No available courses yet.",
                                size: 24,
                                weight: FontWeight.w400,
                                textAlign: TextAlign.center,
                                color: AppColors.medium200,
                                overflow: TextOverflow.clip,
                              )
                            ],
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText(
                                  title: "Upcoming Class",
                                  weight: FontWeight.w500,
                                  size: 20,
                                  color: AppColors.appDark700,
                                ),
                                Row(
                                  children: [
                                    const CustomText(
                                      title: "See all",
                                      weight: FontWeight.w500,
                                      size: 16,
                                      color: AppColors.appDark700,
                                    ),
                                    horizontalSpace(4),
                                    const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 12,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            verticalSpace(16),
                            SizedBox(
                              height: 280,
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) =>
                                      UpcomingClassWidget(
                                        model: data[index],
                                      ),
                                  separatorBuilder: (ctx, idx) =>
                                      horizontalSpace(24),
                                  itemCount: data.length),
                            ),
                          ],
                        ),
                      );
                    }, error: (Object error, StackTrace stackTrace) {
                      print(stackTrace);
                      return Text(stackTrace.toString());
                    }, loading: () {
                      return Shimmer(
                        period: const Duration(seconds: 2),
                        //Default value
                        loop: 1,
                        enabled: true,
                        //Default value
                        direction: ShimmerDirection.ltr,
                        gradient: LinearGradient(
                            colors: [Colors.white, Colors.grey.withOpacity(.5)]),
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.appGrey,
                              borderRadius: BorderRadius.circular(8)),
                          width: double.infinity,
                          height: heightSizer(318, context),
                        ),
                      );
                    }),*/
                    activity.when(data: (List<Course> data) {
                      return Visibility(
                        visible: data.isNotEmpty,
                        replacement: Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              verticalSpace(heightSizer(165, context)),
                              SvgPicture.asset("assets/svgs/info.svg"),
                              verticalSpace(32),
                              const CustomText(
                                title: "No available courses yet.",
                                size: 24,
                                weight: FontWeight.w400,
                                textAlign: TextAlign.center,
                                color: AppColors.medium200,
                                overflow: TextOverflow.clip,
                              )
                            ],
                          ),
                        ),
                        child: Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  title: "Available Courses",
                                  weight: FontWeight.w500,
                                  size: 20,
                                  color: AppColors.appDark700,
                                ),
                                /*
                                Row(
                                  children: [
                                    const CustomText(
                                      title: "See all",
                                      weight: FontWeight.w500,
                                      size: 16,
                                      color: AppColors.appDark700,
                                    ),
                                    horizontalSpace(4),
                                    const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 12,
                                    ),
                                  ],
                                )
                                */
                              ],
                            ),
                            verticalSpace(16),
                            ListView.separated(
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  Course course = data[index];
                                  return GestureDetector(
                                    onTap: () {
                                      context.pushRoute(
                                          SingleCourseRoute(course: course));
                                    },
                                    child: CourseWidget(
                                      model: course,
                                    ),
                                  );
                                },
                                separatorBuilder: (ctx, idx) =>
                                    verticalSpace(24),
                                itemCount: data.length),
                            verticalSpaceSmall
                          ],
                        ),
                      );
                    }, error: (Object error, StackTrace stackTrace) {
                      print(stackTrace);
                      return const Text("An error has occurred");
                    }, loading: () {
                      return Shimmer(
                        period: const Duration(seconds: 2),
                        //Default value
                        loop: 1,
                        enabled: true,
                        //Default value
                        direction: ShimmerDirection.ltr,
                        gradient: LinearGradient(colors: [
                          Colors.white,
                          Colors.grey.withOpacity(.5)
                        ]),
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.appGrey,
                              borderRadius: BorderRadius.circular(8)),
                          width: double.infinity,
                          height: heightSizer(318, context),
                        ),
                      );
                    })
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
