import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/models/lecturer_model.dart';
import '../../../../shared/utilities/app_colors.dart';
import '../../../../shared/utilities/size_utils.dart';
import '../../../../shared/widgets/custom_appbar.dart';
import '../../../../shared/widgets/custom_text.dart';

@RoutePage()
class LecturerInfoScreen extends ConsumerWidget {
  final Lecturer lecturer;

  const LecturerInfoScreen({
    super.key,
    required this.lecturer,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final AsyncValue<List<UpcomingClassModel>> activity = ref.watch(upcomingClassProvider);
    return Scaffold(
      appBar: CustomAppBar(
        prefixIcon: GestureDetector(
            onTap: () {
              context.back();
            },
            child: const Icon(Icons.keyboard_arrow_left_rounded)),
        centerTitle: true,
        title: 'Lecturer Info',
        showBorder: true,
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        NetworkImage("https://i.pravatar.cc/300?img=70"),
                  ),
                ),
                verticalSpace(32),
                CustomText(
                  title:
                      "${lecturer.title}. ${lecturer.lastName} ${lecturer.firstName}",
                  size: 24,
                  weight: FontWeight.w500,
                ),
                verticalSpace(8),
                CustomText(
                  title: "Department: ${lecturer.department}",
                  size: 16,
                  weight: FontWeight.w500,
                  color: AppColors.medium300,
                ),
                verticalSpace(32),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title: "Classes held",
                          size: 16,
                          weight: FontWeight.w500,
                          color: AppColors.medium300,
                        ),
                        CustomText(
                          title: "0",
                          size: 24,
                          weight: FontWeight.w600,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 62,
                      child: VerticalDivider(
                        color: AppColors.appLight100,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title: "Classes Cancelled",
                          size: 16,
                          weight: FontWeight.w500,
                          color: AppColors.medium300,
                        ),
                        CustomText(
                          title: "0",
                          size: 24,
                          weight: FontWeight.w600,
                          color: AppColors.medium300,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            color: AppColors.appLight30,
          ),
          verticalSpace(24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  title: "Faculty",
                  size: 16,
                  weight: FontWeight.w500,
                ),
                CustomText(
                  title: "${lecturer.faculty}",
                  size: 14,
                  weight: FontWeight.w500,
                ),
                verticalSpace(24),
                const CustomText(
                  title: "Department",
                  size: 16,
                  weight: FontWeight.w500,
                ),
                CustomText(
                  title: "${lecturer.department}",
                  size: 14,
                  weight: FontWeight.w500,
                ),
                verticalSpace(24),
                const CustomText(
                  title: "Phone number",
                  size: 16,
                  weight: FontWeight.w500,
                ),
                CustomText(
                  title: "${lecturer.phoneNumber}",
                  size: 14,
                  weight: FontWeight.w500,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
