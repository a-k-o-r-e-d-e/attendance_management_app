import 'package:attendance_management_app/features/course/domain/models/course_model.dart';
import 'package:attendance_management_app/features/home/domain/model/upcoming_class_model.dart';
import 'package:attendance_management_app/features/home/presentation/providers/upcoming_class_provider.dart';
import 'package:attendance_management_app/shared/widgets/general_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../shared/utilities/app_colors.dart';
import '../../../../shared/utilities/size_utils.dart';
import '../../../../shared/widgets/custom_appbar.dart';
import '../../../../shared/widgets/custom_text.dart';

@RoutePage()
class SingleClassScreen extends ConsumerWidget {
  final CourseModel course;

  const SingleClassScreen({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<UpcomingClassModel>> activity =
        ref.watch(upcomingClassProvider);
    return Scaffold(
        appBar: CustomAppBar(
          title: course.title,
          prefixIcon: GestureDetector(
              onTap: () {
                context.back();
              },
              child: const Icon(Icons.keyboard_arrow_left_rounded)),
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: Padding(
          padding: EdgeInsets.zero,
          child: Row(
            children: [
              Expanded(
                child: GeneralButton(
                  buttonText: 'Start class',
                  borderRadius: 0,
                  onPressed: () {
                    context.navigateNamedTo("/start-class");
                  },
                ),
              ),
              Expanded(
                child: GeneralButton(
                  buttonColor: Colors.white,
                  textColor: AppColors.primary500,
                  buttonText: 'Cancel class',
                  borderRadius: 0,
                  onPressed: () {
                    //context.router.navigateNamed("/create-class");
                  },
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 174,
                color: Colors.grey,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: course.title,
                      size: 20,
                      weight: FontWeight.w500,
                    ),
                    verticalSpace(16),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_filled_rounded,
                              color: AppColors.medium200,
                            ),
                            CustomText(
                              title: " 08 - 10AM",
                              size: 14,
                              weight: FontWeight.w500,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: AppColors.medium200,
                            ),
                            CustomText(
                              title: " 15/02/24",
                              size: 14,
                              weight: FontWeight.w500,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: AppColors.medium200,
                            ),
                            CustomText(
                              title: " Online",
                              size: 14,
                              weight: FontWeight.w500,
                            )
                          ],
                        ),
                      ],
                    ),
                    verticalSpace(16),
                    const CustomText(
                      title: "Class Description",
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
                  ],
                ),
              ),
              const Divider(
                color: AppColors.appLight30,
              ),
              ExpansionWidget(
                  initiallyExpanded: false,
                  titleBuilder: (double animationValue, _, bool isExpaned,
                      toogleFunction) {
                    return InkWell(
                        onTap: () => toogleFunction(animated: true),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                        "assets/svgs/users-group.svg"),
                                    CustomText(
                                      title:
                                          " 1,239 student enrolled for this course",
                                      size: widthSizer(16, context),
                                      weight: FontWeight.w400,
                                      color: AppColors.medium300,
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                isExpaned
                                    ? Icons.keyboard_arrow_up_outlined
                                    : Icons.keyboard_arrow_down,
                                color: AppColors.medium300,
                              )
                            ],
                          ),
                        ));
                  },
                  content: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            context.navigateNamedTo("/student-info");
                          },
                          leading: const CircleAvatar(
                            radius: 24,
                          ),
                          title: const CustomText(
                            title: "Adebimpe Ade",
                            size: 16,
                            weight: FontWeight.w500,
                          ),
                        );
                      },
                      separatorBuilder: (ctx, idx) => verticalSpace(8),
                      itemCount: 10)),
              verticalSpace(12),
              ExpansionWidget(
                  initiallyExpanded: true,
                  titleBuilder: (double animationValue, _, bool isExpaned,
                      toogleFunction) {
                    return InkWell(
                        onTap: () => toogleFunction(animated: true),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    SvgPicture.asset("assets/svgs/report.svg"),
                                    CustomText(
                                      title: " Quick overview for this class",
                                      size: widthSizer(16, context),
                                      weight: FontWeight.w400,
                                      color: AppColors.medium300,
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                isExpaned
                                    ? Icons.keyboard_arrow_up_outlined
                                    : Icons.keyboard_arrow_down,
                                color: AppColors.medium300,
                              )
                            ],
                          ),
                        ));
                  },
                  content: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title: "15/02/24",
                          size: widthSizer(16, context),
                          weight: FontWeight.w500,
                          color: AppColors.medium300,
                        ),
                        verticalSpace(8),
                        CustomText(
                          title: "Number of student that attended this class",
                          size: widthSizer(16, context),
                          weight: FontWeight.w500,
                          overflow: TextOverflow.clip,
                        ),
                        verticalSpace(24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.appBlue),
                                ),
                                horizontalSpace(8),
                                CustomText(
                                  title: "Present",
                                  size: widthSizer(16, context),
                                  weight: FontWeight.w500,
                                  color: AppColors.medium300,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.appOrange),
                                ),
                                horizontalSpace(8),
                                CustomText(
                                  title: "Absent",
                                  size: widthSizer(16, context),
                                  weight: FontWeight.w500,
                                  color: AppColors.medium300,
                                ),
                              ],
                            ),
                          ],
                        ),
                        verticalSpace(46),
                        const Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 135,
                            height: 135,
                            child: CircularProgressIndicator(
                                strokeCap: StrokeCap.round,
                                strokeWidth: 8,
                                value: 0.20,
                                color: AppColors.appOrange,
                                backgroundColor: AppColors.appBlue),
                          ),
                        ),
                        verticalSpace(46),
                        Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.appBlue),
                            ),
                            horizontalSpace(8),
                            Expanded(
                              child: CustomText(
                                title: "800 student attended this class (80%)",
                                size: widthSizer(16, context),
                                weight: FontWeight.w500,
                                color: AppColors.medium300,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ],
                        ),
                        verticalSpace(8),
                        Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.appOrange),
                            ),
                            horizontalSpace(8),
                            Expanded(
                              child: CustomText(
                                title:
                                    "439 student did not attend this class (20%)",
                                size: widthSizer(16, context),
                                weight: FontWeight.w500,
                                color: AppColors.medium300,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ],
                        ),
                        verticalSpace(12),
                      ],
                    ),
                  )),

              /*    activity.when(data: (List<UpcomingClassModel> data) {
                return SizedBox();
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
            ],
          ),
        ));
  }
}
