import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

import "../../../../shared/utilities/size_utils.dart";
import "../../../../shared/widgets/custom_text.dart";

class OnBoardingPage extends StatelessWidget {
  final int index;
  final String description;

  const OnBoardingPage({
    super.key,
    required this.index,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: SizedBox(
            //height: 274,
            width: double.infinity,
            child: index == 1
                ? SvgPicture.asset("assets/svgs/onboarding-$index.svg",
                    fit: BoxFit.scaleDown)
                : Image.asset("assets/images/onboarding-$index.png"),
          ),
        ),
        SizedBox(height: heightSizer(56, context)),
        CustomText(
          title: description,
          textAlign: TextAlign.center,
          size: 24,
          weight: FontWeight.w500,
          overflow: TextOverflow.clip,
        ),
        verticalSpace(24)
      ],
    );
  }
}
