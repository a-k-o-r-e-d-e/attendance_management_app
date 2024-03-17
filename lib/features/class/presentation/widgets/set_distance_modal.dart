import 'package:attendance_management_app/features/class/domain/providers/meeting_repo_provider.dart';
import 'package:attendance_management_app/shared/utilities/app_colors.dart';
import 'package:attendance_management_app/shared/utilities/size_utils.dart';
import 'package:attendance_management_app/shared/widgets/custom_text.dart';
import 'package:attendance_management_app/shared/widgets/custom_text_form_field.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../shared/widgets/general_button.dart';

class SetDistanceModal extends StatelessWidget {
  static show(context, WidgetRef ref,) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        builder: (context) {
          return SetDistanceModal._(
            ref: ref,
            //saveFunction: saveFunction,
          );
        });
  }

  const SetDistanceModal._({
    Key? key,
    required this.ref,
    //required this.saveFunction,
  }) : super(key: key);
  final WidgetRef ref;
  //final void Function() saveFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              color: Colors.white),
          padding: const EdgeInsets.all(20),
          width: screenWidth(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              verticalSpace(12),
              const CustomText(
                title: "Set Distance",
                weight: FontWeight.w500,
                size: 20,
              ),
              verticalSpace(24),
              const CustomTextFormField(
                hintText: "Enter measurement digit, e.g 100.",
              ),
              verticalSpace(8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    "assets/svgs/info.svg",
                    width: 20,
                    fit: BoxFit.scaleDown,
                  ),
                  horizontalSpace(12),
                  const Expanded(
                    child: CustomText(
                      title:
                          "The distance for remote attendance is measured in meters",
                      weight: FontWeight.w400,
                      size: 14,
                      color: AppColors.medium300,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
              verticalSpace(24),
              Row(
                children: [
                  Expanded(
                    child: GeneralButton(
                        buttonText: 'Save, continue',
                        borderRadius: 200,
                        onPressed: (){
                          context.router.pop();
                          context.navigateNamedTo('/attendance');
                        }),
                  ),
                  horizontalSpace(16),
                  Expanded(
                    child: GeneralButton(
                        buttonText: 'Cancel',
                        borderRadius: 200,
                        textColor: AppColors.primary500,
                        buttonColor: Colors.white,
                        border: Border.all(color: AppColors.primary500),
                        onPressed: () {
                          context.router.pop();
                        }),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
