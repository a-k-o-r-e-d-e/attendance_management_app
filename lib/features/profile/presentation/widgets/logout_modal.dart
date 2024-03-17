import 'package:attendance_management_app/shared/routes/app_route.dart';
import 'package:attendance_management_app/shared/utilities/app_colors.dart';
import 'package:attendance_management_app/shared/utilities/size_utils.dart';
import 'package:attendance_management_app/shared/widgets/custom_text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../shared/widgets/general_button.dart';

class LogoutModal extends StatelessWidget {
  static show(context) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        builder: (context) {
          return const LogoutModal._(
              //saveFunction: saveFunction,
              );
        });
  }

  const LogoutModal._({
    Key? key,
    //required this.saveFunction,
  }) : super(key: key);

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
                title: "You are about to log out",
                weight: FontWeight.w500,
                size: 20,
              ),
              verticalSpace(32),
              Row(
                children: [
                  Expanded(
                    child: GeneralButton(
                        buttonText: 'Cancel',
                        borderRadius: 200,
                        onPressed: () {
                          context.router.pop();
                        }),
                  ),
                  horizontalSpace(16),
                  Expanded(
                    child: GeneralButton(
                        buttonText: 'Yes, logout',
                        borderRadius: 200,
                        textColor: AppColors.appRed,
                        buttonColor: Colors.white,
                        border: Border.all(color: AppColors.appRed),
                        onPressed: () {
                          context.router.replaceAll([const LoginRoute()]);
                        }),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
