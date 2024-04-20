import 'package:attendance_management_app/shared/widgets/general_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/utilities/app_colors.dart';
import '../../../../shared/utilities/size_utils.dart';
import '../../../../shared/widgets/custom_appbar.dart';
import '../../../../shared/widgets/custom_text.dart';
import '../../../../shared/models/user_model.dart';

@RoutePage()
class StudentInfoScreen extends ConsumerStatefulWidget {
  final Profile student;
  final bool? attendance;
  final int? index;

  const StudentInfoScreen(this.student,
      {super.key, this.attendance = false, this.index = 7});

  @override
  ConsumerState<StudentInfoScreen> createState() => _StudentInfoScreenState();
}

class _StudentInfoScreenState extends ConsumerState<StudentInfoScreen> {
  bool present = false;

  @override
  Widget build(BuildContext context) {
    //final AsyncValue<List<UpcomingClassModel>> activity = ref.watch(upcomingClassProvider);
    return Scaffold(
      appBar: CustomAppBar(
        prefixIcon: GestureDetector(
            onTap: () {
              context.back();
            },
            child: const Icon(Icons.keyboard_arrow_left_rounded)),
        centerTitle: true,
        title: 'Student Info',
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
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        "https://i.pravatar.cc/300?img=${widget.index}"),
                  ),
                ),
                verticalSpace(32),
                CustomText(
                  title:
                      "${widget.student.lastName} ${widget.student.firstName}",
                  size: 24,
                  weight: FontWeight.w500,
                ),
                verticalSpace(8),
                CustomText(
                  title: "Student ID: ${widget.student.id}",
                  size: 16,
                  weight: FontWeight.w500,
                  color: AppColors.medium300,
                ),
                verticalSpace(32),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title: "Attendance",
                          size: 16,
                          weight: FontWeight.w500,
                          color: AppColors.medium300,
                        ),
                        CustomText(
                          title: "87%",
                          size: 24,
                          weight: FontWeight.w600,
                        )
                      ],
                    ),
                    SizedBox(
                      width: 51,
                      height: 51,
                      child: CircularProgressIndicator(
                        strokeCap: StrokeCap.round,
                        strokeWidth: 5,
                        value: 0.87,
                        backgroundColor: Color(0xFFD9D9D9),
                        color: Color(0xFFE036D9),
                      ),
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
                          title: "Eligible for exam",
                          size: 16,
                          weight: FontWeight.w500,
                          color: AppColors.medium300,
                        ),
                        CustomText(
                          title: "75%",
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
                  title: "Program of Study",
                  size: 16,
                  weight: FontWeight.w500,
                ),
                CustomText(
                  title: "B.Sc, ${widget.student.department}",
                  size: 14,
                  weight: FontWeight.w500,
                ),
                verticalSpace(24),
                const CustomText(
                  title: "Year of Study",
                  size: 16,
                  weight: FontWeight.w500,
                ),
                const CustomText(
                  title: "2024/2025",
                  size: 14,
                  weight: FontWeight.w500,
                ),
              ],
            ),
          ),
          verticalSpace(24),
          Visibility(
              visible: widget.attendance == true,
              replacement: const SizedBox(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Visibility(
                  visible: present == false,
                  replacement: Column(
                    children: [
                      GeneralButton(
                        buttonText: "Present",
                        onPressed: () {},
                        buttonColor: AppColors.success,
                        textColor: AppColors.appDark700,
                      ),
                      verticalSpace(8),
                      GeneralButton(
                        buttonText: "Mark Absent",
                        onPressed: () {
                          setState(() {
                            present = false;
                          });
                        },
                        borderSide:
                            const BorderSide(color: AppColors.primary500),
                        //border: Border.all(color: AppColors.primary500),
                        buttonColor: Colors.white,
                        textColor: AppColors.primary500,
                      ),
                    ],
                  ),
                  child: GeneralButton(
                    buttonText: "Mark Present",
                    onPressed: () {
                      setState(() {
                        present = true;
                      });
                    },
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
