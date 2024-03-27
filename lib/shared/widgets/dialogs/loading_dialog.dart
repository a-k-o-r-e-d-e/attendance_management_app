import 'package:attendance_management_app/shared/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingDialog extends StatelessWidget {
  static show(
    BuildContext context,
  ) {
    showDialog(
        context: context,
        barrierColor: Colors.white70,
        barrierDismissible: false,
        builder: (context) {
          return const LoadingDialog._();
        });
  }

  const LoadingDialog._({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      backgroundColor: Colors.transparent,
      child: Container(
        color: Colors.transparent,
        width: double.infinity,
        //height: 223,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.scale(
              scale: 0.65,
              child: const LoadingIndicator(
                  indicatorType: Indicator.ballClipRotatePulse,
                  colors: [
                    AppColors.appOrange,
                    AppColors.primary500,
                  ],
                  strokeWidth: 2,
                  backgroundColor: Colors.transparent,
                  pathBackgroundColor: Colors.transparent),
            )
          ],
        ),
      ),
    );
  }
}
