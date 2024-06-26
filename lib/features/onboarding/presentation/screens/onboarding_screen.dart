import 'package:attendance_management_app/features/onboarding/presentation/providers/onboarding_provider.dart';
import 'package:attendance_management_app/shared/widgets/general_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/utilities/app_colors.dart';
import '../../../../shared/utilities/size_utils.dart';
import '../widgets/onboarding_page.dart';

@RoutePage()
class OnboardingScreen extends ConsumerWidget {
  OnboardingScreen({super.key});

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int pageIndex = ref.watch(onboardingProvider);
    return Scaffold(
      backgroundColor: AppColors.appBlue,
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
          child: GeneralButton(
            buttonText: "Get started",
            onPressed: () {
              //context.replaceRoute(const SelectUserTypeRoute());
              context.router.replaceNamed("/select-user-type");
            },
            height: 48,
          ),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          height: screenHeight(context),
          //padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              verticalSpace(heightSizer(48, context)),
              Expanded(
                child: PageView(
                  pageSnapping: true,
                  controller: pageController,
                  padEnds: false,
                  onPageChanged: (int page) {
                    ref.read(onboardingProvider.notifier).setCurrentPage(page);
                  },
                  children: const <Widget>[
                    OnBoardingPage(
                      index: 1,
                      description:
                          'Effortlessly manage attendance with our intuitive app.',
                    ),
                    OnBoardingPage(
                      index: 2,
                      description: 'Secure and private data management',
                    ),
                    OnBoardingPage(
                      index: 3,
                      description:
                          'No more classroom roll calls. Attendance, just a tap away.',
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.zero,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    border:
                        Border(top: BorderSide(color: Colors.white, width: 0))),
                padding: const EdgeInsets.only(bottom: 36),
                child: SizedBox(
                  height: 6,
                  child: Center(
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              height: 6.0,
                              width: pageIndex == index ? 30.0 : 15,
                              decoration: BoxDecoration(
                                color: pageIndex == index
                                    ? AppColors.primary500
                                    : AppColors.appGrey,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                        separatorBuilder: (ctx, idx) => const SizedBox(
                              width: 4,
                            ),
                        itemCount: 3),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
