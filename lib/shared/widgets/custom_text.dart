import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utilities/app_colors.dart';

class CustomText extends StatelessWidget {
  final String? title;
  final double? size;
  final Color? color;
  final FontStyle? fontStyle;
  final FontWeight? weight;
  final double? height;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final TextDecoration? underline;
  final String? iconPath;
  final bool? softWrap;

  const CustomText({
    Key? key,
    this.title,
    this.size,
    this.color,
    this.weight,
    this.height,
    this.textAlign,
    this.overflow,
    this.underline,
    this.iconPath,
    this.fontStyle,
    this.softWrap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title!,
        textAlign: textAlign ?? TextAlign.left,
        style: GoogleFonts.inter(
            textStyle: TextStyle(
                decoration: underline ?? TextDecoration.none,
                color: color ?? AppColors.appDark700,
                fontSize: size,
                fontWeight: weight ?? FontWeight.normal,
                overflow: overflow ?? TextOverflow.ellipsis,
                fontStyle: fontStyle)));
  }
}
