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
    return Stack(
      alignment: Alignment.bottomCenter,
      //mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          alignment: Alignment.bottomCenter,
          width: double.infinity,
          child: Image.asset("assets/images/onboarding-image-$index.png"),
        ),
        Container(
          height: 120,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          color: Colors.white,
          child: CustomText(
            title: description,
            textAlign: TextAlign.center,
            size: 20,
            weight: FontWeight.w500,
            overflow: TextOverflow.clip,
          ),
        ),
      ],
    );
  }
}
