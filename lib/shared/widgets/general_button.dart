import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utilities/app_colors.dart';
import '../utilities/size_utils.dart';

class GeneralButton extends StatelessWidget {
  final Color? buttonColor;
  final String buttonText;
  final Color? textColor;
  final Color? iconColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? iconSize;
  final double? height;
  final String? iconPath;
  final double? width;
  final double? borderRadius;
  final Border? border;
  final bool? iconOnly;
  final void Function() onPressed;

  const GeneralButton(
      {super.key,
        this.buttonColor,
        required this.buttonText,
        this.textColor,
        required this.onPressed,
        this.borderRadius,
        this.height,
        this.fontWeight,
        this.fontSize,
        this.border,
        this.width,
        this.iconPath,
        this.iconSize,
        this.iconOnly,
        this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(borderRadius ?? 200),
      color: buttonColor ?? AppColors.primary500,
      child: InkWell(
        onTap: onPressed,
        child: Ink(
          height: height ?? 48,
          width: width ?? screenWidth(context),
          decoration: BoxDecoration(
            border: border,
            borderRadius: BorderRadius.circular(borderRadius ?? 200),
            color: Colors.transparent,
            //border: Border.all(width: 3, color: AppColor.primary)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              iconPath != null
                  ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    iconPath!,
                    height: iconSize ?? 15,
                    width: iconSize ?? 15,
                    colorFilter: ColorFilter.mode(
                        iconColor ?? Colors.white, BlendMode.srcIn),
                  ),
                ],
              )
                  : const SizedBox(),
              /*Visibility(
                visible: iconPath != null,
                replacement: const SizedBox(),
                child: SvgPicture.asset(iconPath!),
              ),*/
              SizedBox(width: iconOnly == true ? 0 : 6),
              Text(
                buttonText,
                style: TextStyle(
                    color: textColor ?? Colors.white,
                    fontSize: fontSize ?? 15,
                    fontWeight: fontWeight ?? FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}