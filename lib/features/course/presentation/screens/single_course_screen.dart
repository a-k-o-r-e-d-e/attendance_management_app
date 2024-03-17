import 'package:attendance_management_app/features/course/domain/models/course_model.dart';
import 'package:attendance_management_app/features/home/domain/model/upcoming_class_model.dart';
import 'package:attendance_management_app/features/home/presentation/providers/upcoming_class_provider.dart';
import 'package:attendance_management_app/shared/widgets/general_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../shared/utilities/app_colors.dart';
import '../../../../shared/utilities/size_utils.dart';
import '../../../../shared/widgets/custom_appbar.dart';
import '../../../../shared/widgets/custom_text.dart';
import '../widgets/class_tab.dart';
import '../widgets/course_report_tab.dart';

@RoutePage()
class SingleCourseScreen extends ConsumerStatefulWidget {
  final CourseModel course;

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
    final AsyncValue<List<UpcomingClassModel>> activity =
        ref.watch(upcomingClassProvider);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: CustomAppBar(
            title: widget.course.title,
            prefixIcon: GestureDetector(
                onTap: () {
                  context.back();
                },
                child: const Icon(Icons.keyboard_arrow_left_rounded)),
          ),
          backgroundColor: Colors.white,
          bottomNavigationBar: Padding(
            padding: EdgeInsets.zero,
            child: GeneralButton(
              buttonText: 'Add a class',
              borderRadius: 0,
              onPressed: () {
                context.router.navigateNamed("/create-class");
              },
            ),
          ),
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  collapsedHeight: 500,
                  flexibleSpace: Column(
                    children: [
                      Container(
                        height: 174,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              title: widget.course.title,
                              size: 20,
                              weight: FontWeight.w500,
                            ),
                            verticalSpace(16),
                            const CustomText(
                              title: "Course Description",
                              size: 16,
                              weight: FontWeight.w500,
                            ),
                            verticalSpace(8),
                            const CustomText(
                              title:
                                  "Computers are powerful devices that process and store information, enabling a wide range of tasks. From basic calculations to complex simulations, computers have become indispensable in our daily lives.",
                              size: 16,
                              weight: FontWeight.w400,
                              color: AppColors.medium300,
                              overflow: TextOverflow.clip,
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
                                      const EdgeInsets.symmetric(horizontal: 0),
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
            body: activity.when(data: (List<UpcomingClassModel> data) {
              return TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _controller,
                children: const [ClassTab(), CourseReportTab()],
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
            }),
          )),
    );
  }
}
