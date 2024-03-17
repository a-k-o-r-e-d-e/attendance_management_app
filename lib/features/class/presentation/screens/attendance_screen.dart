import 'package:attendance_management_app/shared/routes/app_route.dart';
import 'package:attendance_management_app/shared/services/location_service/domain/repository/location_service_repo.dart';
import 'package:attendance_management_app/shared/services/location_service/providers/location_provider.dart';
import 'package:attendance_management_app/shared/widgets/general_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../shared/utilities/app_colors.dart';
import '../../../../shared/utilities/size_utils.dart';
import '../../../../shared/widgets/custom_appbar.dart';
import '../../../../shared/widgets/custom_text.dart';
import '../../../../shared/widgets/custom_text_form_field.dart';


@RoutePage()
class AttendanceScreen extends ConsumerWidget {
  //final CourseModel course;

  const AttendanceScreen({
    super.key,
    //required this.course,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LocationService locationService =
        ref.read(locationServiceMethodsProvider);
    return Scaffold(
        appBar: CustomAppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                  radius: 5, colors: <Color>[Color(0xFF25314C), Colors.white]),
            ),
          ),
          title: "Attendance in progress",
          titleColor: Colors.white,
          prefixIcon: GestureDetector(
              onTap: () {
                context.back();
              },
              child: const Icon(
                Icons.keyboard_arrow_left_rounded,
                color: Colors.white,
              )),
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: Padding(
          padding: EdgeInsets.zero,
          child: GeneralButton(
            buttonColor: AppColors.appRed,
            buttonText: 'Stop taking attendance',
            borderRadius: 0,
            onPressed: () {
              context.back();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 44,
                child: CustomTextFormField(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Color(0xFFD5D7DB)),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  hintText: "Search for student",
                  suffixIcon: SvgPicture.asset(
                    "assets/svgs/search.svg",
                    width: 20,
                    height: 20,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              verticalSpace(16),
              Expanded(
                child: ListView.separated(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          context.pushRoute(StudentInfoRoute(attendance: true));
                        },
                        leading: const CircleAvatar(
                          radius: 24,
                        ),
                        title: const CustomText(
                          title: "Adebimpe Ade",
                          size: 16,
                          weight: FontWeight.w500,
                        ),
                        subtitle: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 12),
                            decoration: BoxDecoration(
                              color: AppColors.success,
                              borderRadius: BorderRadius.circular(200),
                            ),
                            child: const CustomText(
                              title: "Present",
                              size: 12,
                              weight: FontWeight.w600,
                            ),
                          ),
                        ),
                        trailing: const Icon(
                          Icons.keyboard_arrow_right_rounded,
                          size: 24,
                          color: AppColors.medium300,
                        ),
                      );
                    },
                    separatorBuilder: (ctx, idx) => verticalSpace(8),
                    itemCount: 10),
              )
            ],
          ),
        ));
  }
}
