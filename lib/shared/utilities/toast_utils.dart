import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../widgets/custom_text.dart';
import 'app_colors.dart';

class ToastService {
  ToastService._();

  static void success(context, String msg, {int? seconds}) {
    toastification.show(
      context: context,
      backgroundColor: AppColors.appGreen,
      title: CustomText(
        title: msg,
        color: Colors.white,
        overflow: TextOverflow.clip,
      ),
      showProgressBar: false,
      autoCloseDuration: Duration(seconds: seconds ?? 5),
    );
  }

  static void error(context, String msg, {int? seconds}) {
    toastification.show(
      context: context,
      backgroundColor: AppColors.appRed,
      title: CustomText(
        title: msg,
        color: Colors.white,
        overflow: TextOverflow.clip,
      ),
      showProgressBar: false,
      autoCloseDuration: Duration(seconds: seconds ?? 5),
    );
  }
}
