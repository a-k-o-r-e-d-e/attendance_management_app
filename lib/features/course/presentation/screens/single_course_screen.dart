import 'package:attendance_management_app/features/course/domain/models/course_model.dart';
import 'package:attendance_management_app/features/home/presentation/providers/available_courses_provider.dart';
import 'package:attendance_management_app/shared/providers/app_user_provider.dart';
import 'package:attendance_management_app/shared/routes/app_route.dart';
import 'package:attendance_management_app/shared/widgets/general_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/services/dio_service/domain/models/api_response_model.dart';
import '../../../../shared/utilities/app_colors.dart';
import '../../../../shared/utilities/size_utils.dart';
import '../../../../shared/utilities/toast_utils.dart';
import '../../../../shared/widgets/custom_appbar.dart';
import '../../../../shared/widgets/custom_text.dart';
import '../../../../shared/widgets/dialogs/loading_dialog.dart';
import '../../domain/providers/course_repo_provider.dart';
import '../../domain/repository/course_repo.dart';
import '../providers/fetch_courses_provider.dart';
import '../widgets/class_tab.dart';
import '../widgets/course_engagement_tab.dart';
import '../widgets/course_report_tab.dart';

@RoutePage()
class SingleCourseScreen extends ConsumerStatefulWidget {
  final Course course;

  const SingleCourseScreen({
    super.key,
    required this.course,
  });

  @override
  ConsumerState<SingleCourseScreen> createState() => _SingleCourseScreenState();
}

class _SingleCourseScreenState extends ConsumerState<SingleCourseScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 2);
    _controller.addListener(_handleTabSelection);
  }

  Future<void> deleteCourse() async {
    CourseRepository courseService = ref.watch(courseRepoProvider);
    try {
      LoadingDialog.show(context);
      var _ = await courseService.deleteCourse(widget.course.id!);

      if (!mounted) return;
      context.router.pop();
      ref.invalidate(fetchCourseProvider);

      ToastService.success(context, "course deleted", seconds: 2);
      context.router.back();
    } on ErrorResponse catch (exception, _) {
      context.router.pop();

      print(exception.exception);
      ToastService.error(context, exception.exception.error.toString());
    }
  }

  Future<void> enrollCourse() async {
    CourseRepository courseService = ref.watch(courseRepoProvider);
    try {
      LoadingDialog.show(context);
      if (widget.course.isStudentEnrolled == true) {
        await courseService.unEnrollCourse(widget.course.id!);
      } else {
        await courseService.enrollCourse(widget.course.id!);
      }

      if (!mounted) return;
      context.router.pop();
      ref.invalidate(getAvailableCoursesProvider);
      setState(() {
        if (widget.course.isStudentEnrolled == null) {
          widget.course.isStudentEnrolled = true;
        } else {
          widget.course.isStudentEnrolled = !(widget.course.isStudentEnrolled!);
        }
      });
      ToastService.success(
          context,
          widget.course.isStudentEnrolled == true
              ? "course enrolled successfully"
              : "course unenrolled successfully",
          seconds: 2);
    } on ErrorResponse catch (exception, _) {
      context.router.pop();

      print(exception.exception);
      ToastService.error(context, exception.exception.error.toString());
    }
  }

  _handleTabSelection() {
    setState(() {
      _currentIndex = _controller.index;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String? appUser = ref.watch(appUserProvider).profile?.user?.roles![0];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: CustomAppBar(
            title: widget.course.title!,
            prefixIcon: GestureDetector(
                onTap: () {
                  context.back();
                },
                child: const Icon(Icons.keyboard_arrow_left_rounded)),
            suffixIcon: appUser == "lecturer"
                ? PopupMenuButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Colors.white,
                    child: const Icon(
                      Icons.more_vert,
                      color: AppColors.appDark700,
                      size: 24,
                    ),
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                      PopupMenuItem(
                        child: const Text('Edit Course'),
                        onTap: () {
                          context.navigateTo(
                              CreateCourseRoute(editCourse: widget.course));
                        },
                      ),
                      PopupMenuItem(
                        child: const Text('Delete Course'),
                        onTap: () {
                          deleteCourse();
                        },
                      ),
                    ],
                  )
                : null,
          ),
          backgroundColor: Colors.white,
          bottomNavigationBar: Padding(
            padding: EdgeInsets.zero,
            child: Visibility(
              visible: appUser == "lecturer",
              replacement: GeneralButton(
                buttonText: widget.course.isStudentEnrolled == true
                    ? 'Unenroll for this course'
                    : 'Enrol for this course',
                borderRadius: 0,
                onPressed: () {
                  enrollCourse();
                },
              ),
              child: GeneralButton(
                buttonText: 'Add a class',
                borderRadius: 0,
                onPressed: () {
                  context.router.navigate(CreateClassRoute(
                      courseId: widget.course.id!,
                      editClass: null,
                      courseTitle: widget.course.title));
                },
              ),
            ),
          ),
          body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    collapsedHeight: 400,
                    flexibleSpace: Column(
                      children: [
                        Container(
                          height: 174,
                          color: Colors.grey,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/cover-photo-1.jpeg"),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                title: widget.course.title,
                                size: 20,
                                weight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis,
                              ),
                              verticalSpace(16),
                              const CustomText(
                                title: "Course Description",
                                size: 16,
                                weight: FontWeight.w500,
                              ),
                              verticalSpace(8),
                              CustomText(
                                title: widget.course.description,
                                size: 16,
                                weight: FontWeight.w400,
                                color: AppColors.medium300,
                                overflow: TextOverflow.ellipsis,
                              ),
                              verticalSpace(8),
                              Container(
                                height: 64,
                                decoration: BoxDecoration(
                                    color: AppColors.appLight20,
                                    borderRadius: BorderRadius.circular(8)),
                                padding: const EdgeInsets.all(8),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.appLight20,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: TabBar(
                                    controller: _controller,
                                    indicatorPadding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 0),
                                    dividerColor: Colors.transparent,
                                    indicator: BoxDecoration(
                                        color: AppColors.primary500,
                                        borderRadius: BorderRadius.circular(8)),
                                    indicatorColor: AppColors.primary500,
                                    tabs: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomText(
                                            title: 'Classes',
                                            size: 14,
                                            weight: FontWeight.w700,
                                            color: _currentIndex == 0
                                                ? Colors.white
                                                : AppColors.medium300,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomText(
                                            title: 'Course report',
                                            size: 14,
                                            weight: FontWeight.w700,
                                            color: _currentIndex == 1
                                                ? Colors.white
                                                : AppColors.medium300,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: AppColors.appLight30,
                        ),
                      ],
                    ),
                  )
                ];
              },
              body: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _controller,
                children: [
                  ClassTab(courseId: widget.course.id!),
                  Visibility(
                    visible: appUser == "lecturer",
                    replacement: const CourseEngagementTab(),
                    child: CourseReportTab(
                      courseId: widget.course.id!,
                    ),
                  )
                ],
              ))),
    );
  }
}
