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
import '../widgets/set_distance_modal.dart';

@RoutePage()
class StartClassScreen extends ConsumerWidget {
  //final CourseModel course;

  const StartClassScreen({
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
          title: "Class in progress",
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
          child: Row(
            children: [
              Expanded(
                child: GeneralButton(
                  buttonText: 'Take attendance',
                  borderRadius: 0,
                  onPressed: () async {
                    if (await locationService.hasPermission()) {
                      SetDistanceModal.show(
                        context,
                        ref,
                      );
                    } else {
                      bool permitted =
                          await locationService.requestPermission();
                      if (permitted) {
                        SetDistanceModal.show(
                          context,
                          ref,
                        );
                      }
                    }
                  },
                ),
              ),
              Expanded(
                child: GeneralButton(
                  buttonColor: Colors.white,
                  textColor: AppColors.primary500,
                  buttonText: 'Cancel class',
                  borderRadius: 0,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/svgs/users-group.svg"),
                  Expanded(
                    child: CustomText(
                      title: " 644 out of 1,239 enrolled student in class",
                      size: widthSizer(16, context),
                      weight: FontWeight.w400,
                      color: AppColors.medium300,
                    ),
                  ),
                ],
              ),
              verticalSpace(16),
              Expanded(
                child: ListView.separated(
                    physics: const ScrollPhysics(),
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
                    itemCount: 10),
              )
            ],
          ),
        ));
  }
}
