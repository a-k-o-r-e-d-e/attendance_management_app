import 'package:attendance_management_app/shared/routes/app_route.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../shared/utilities/app_colors.dart';
import '../../../../shared/utilities/size_utils.dart';
import '../../../../shared/widgets/custom_appbar.dart';
import '../../../../shared/widgets/custom_text.dart';
import '../../../../shared/widgets/custom_text_form_field.dart';
import '../../../../shared/models/user_model.dart';

@RoutePage()
class StudentListScreen extends ConsumerWidget {
  final List<Profile> students;

  const StudentListScreen(this.students, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final AsyncValue<List<UpcomingClassModel>> activity = ref.watch(upcomingClassProvider);
    return Scaffold(
      appBar: CustomAppBar(
        prefixIcon: GestureDetector(
            onTap: () {
              context.router.pop();
            },
            child: const Icon(Icons.keyboard_arrow_left_rounded)),
        centerTitle: true,
        title: 'Student list',
        showBorder: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            verticalSpace(24),
            SizedBox(
              height: 44,
              child: CustomTextFormField(
                border: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Color(0xFFD5D7DB)),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                hintText: "Search for student",
                suffixIcon: SvgPicture.asset(
                  "assets/svgs/search.svg",
                  width: 20,
                  height: 20,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            verticalSpace(16),
            Expanded(
              child: ListView.separated(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        context.navigateTo(StudentInfoRoute(
                            student: students[index], index: index));
                      },
                      leading: CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(
                            "https://i.pravatar.cc/300?img=$index"),
                      ),
                      title: CustomText(
                        title:
                            "${students[index].lastName} ${students[index].firstName}",
                        size: 16,
                        weight: FontWeight.w500,
                      ),
                      trailing: const Icon(
                        Icons.keyboard_arrow_right_rounded,
                        size: 24,
                        color: AppColors.medium300,
                      ),
                    );
                  },
                  separatorBuilder: (ctx, idx) => verticalSpace(8),
                  itemCount: students.length),
            )
          ],
        ),
      ),
    );
  }
}
