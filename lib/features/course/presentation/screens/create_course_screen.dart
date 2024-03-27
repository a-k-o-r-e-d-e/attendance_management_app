import 'package:attendance_management_app/features/course/domain/providers/course_repo_provider.dart';
import 'package:attendance_management_app/features/course/presentation/providers/fetch_courses_provider.dart';
import 'package:attendance_management_app/shared/utilities/validator.dart';
import 'package:attendance_management_app/shared/widgets/general_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../shared/services/dio_service/domain/models/api_response_model.dart';
import '../../../../shared/utilities/app_colors.dart';
import '../../../../shared/utilities/size_utils.dart';
import '../../../../shared/utilities/toast_utils.dart';
import '../../../../shared/widgets/custom_appbar.dart';
import '../../../../shared/widgets/custom_text.dart';
import '../../../../shared/widgets/custom_text_form_field.dart';
import '../../../../shared/widgets/dialogs/loading_dialog.dart';
import '../../domain/repository/course_repo.dart';

@RoutePage()
class CreateCourseScreen extends ConsumerStatefulWidget {
  const CreateCourseScreen({super.key});

  @override
  ConsumerState<CreateCourseScreen> createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends ConsumerState<CreateCourseScreen> {
  String? courseRequirementValue;
  String? courseUnitValue;
  DateTime? selectedDate;
  final TextEditingController courseTitleController = TextEditingController();
  final TextEditingController courseDescriptionController =
      TextEditingController();
  final TextEditingController courseCodeController = TextEditingController();
  final TextEditingController sessionController = TextEditingController();
  final TextEditingController attendanceController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TimeOfDay? time;

  void selectDate(BuildContext context) async {
    selectedDate = (await showDatePicker(
        context: context,
        initialDate: null,
        firstDate: DateTime.now().add(const Duration(days: 1)),
        lastDate: DateTime.now().add(const Duration(days: 14))))!;

    setState(() {});
  }

  void selectTime(BuildContext context) async {
    time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ) as TimeOfDay;

    setState(() {});
  }

  Future createCourse() async {
    Map<String, dynamic> data = {
      "title": courseTitleController.text,
      "course_code": courseCodeController.text,
      "category": courseRequirementValue?.toLowerCase(),
      "unit": int.tryParse(courseUnitValue!),
      "session": sessionController.text,
      "min_attendance_percentage":
          attendanceController.text.isEmpty ? 70 : attendanceController.text,
      "description": courseDescriptionController.text
    };

    print(data);
    CourseRepository courseService = ref.watch(courseRepoProvider);
    try {
      LoadingDialog.show(context);
      var _ = await courseService.createCourse(data);

      if (!mounted) return;
      context.router.pop();
      ref.invalidate(fetchCourseProvider);

      ToastService.success(context, "course created", seconds: 2);
    } on ErrorResponse catch (exception, _) {
      context.router.pop();

      print(exception.exception);
      ToastService.error(context, exception.exception.error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          centerTitle: true,
          title: 'Create course',
          showBorder: true,
          prefixIcon: InkWell(
              onTap: () {
                context.router.back();
              },
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 16,
              )),
        ),
        backgroundColor: Colors.white,
        body: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 16.0, left: 20, right: 20),
            child: GeneralButton(
              buttonText: 'Create course',
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  // Do something with the validated and saved values
                  if (courseRequirementValue == null) {
                    ToastService.error(context, "select course requirement");
                  } else if (courseUnitValue == null) {
                    ToastService.error(context, "select course unit");
                  } else {
                    createCourse();
                  }
                }
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 218,
                  child: Stack(
                    children: [
                      Container(
                        color: AppColors.appLight20,
                        height: 190,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 20,
                        child: Container(
                          height: 56,
                          width: 56,
                          decoration: const BoxDecoration(
                              color: AppColors.primary500,
                              shape: BoxShape.circle),
                          child: SvgPicture.asset(
                            "assets/svgs/add-img.svg",
                            width: 24,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          title: "Course title",
                          size: 14,
                          weight: FontWeight.w400,
                        ),
                        verticalSpace(8),
                        CustomTextFormField(
                          hintText: "Enter course title",
                          controller: courseTitleController,
                          validator: (val) => Validator.validateName(val),
                        ),
                        verticalSpace(18),
                        const CustomText(
                          title: "Course description",
                          size: 14,
                          weight: FontWeight.w400,
                        ),
                        verticalSpace(8),
                        CustomTextFormField(
                          hintText: "Enter course description",
                          controller: courseDescriptionController,
                          validator: (val) =>
                              Validator.validateEmptyOrMaxiMin(val, 1, 200),
                        ),
                        verticalSpace(18),
                        const CustomText(
                          title: "Course code",
                          size: 14,
                          weight: FontWeight.w400,
                        ),
                        verticalSpace(8),
                        CustomTextFormField(
                          hintText: "Enter course code",
                          controller: courseCodeController,
                          validator: (val) => Validator.validateName(val),
                        ),
                        verticalSpace(18),
                        const CustomText(
                          title: "Course Requirement",
                          size: 14,
                          weight: FontWeight.w400,
                        ),
                        verticalSpace(8),
                        DropdownButtonFormField<String>(
                          value: courseRequirementValue,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          isExpanded: true,
                          hint: const CustomText(
                            title: "Select course requirement",
                          ),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: AppColors.medium200))),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          onChanged: (String? newValue) {
                            setState(() {
                              courseRequirementValue = newValue!;
                            });
                          },
                          items: <String>['Compulsory', 'Required', 'Elective']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        verticalSpace(18),
                        const CustomText(
                          title: "Course unit",
                          size: 14,
                          weight: FontWeight.w400,
                        ),
                        verticalSpace(8),
                        DropdownButtonFormField<String>(
                          value: courseUnitValue,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          isExpanded: true,
                          hint: const CustomText(
                            title: "Select course unit",
                          ),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: AppColors.medium200))),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          onChanged: (String? newValue) {
                            setState(() {
                              courseUnitValue = newValue!;
                            });
                          },
                          items: <String>['2', '3', '4']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        verticalSpace(18),
                        const CustomText(
                          title: "Academic Session",
                          size: 14,
                          weight: FontWeight.w400,
                        ),
                        verticalSpace(8),
                        CustomTextFormField(
                          hintText: "2024/2025",
                          controller: sessionController,
                          validator: (val) => Validator.validateName(val),
                        ),
                        verticalSpace(18),
                        const CustomText(
                          title: "Minimum attendance requirement",
                          size: 14,
                          weight: FontWeight.w400,
                        ),
                        verticalSpace(8),
                        CustomTextFormField(
                          hintText: "70%",
                          controller: attendanceController,
                          keyboardType: TextInputType.number,
                          validator: (val) => Validator.validateNumberRange(
                              double.tryParse(val!), 0, 100),
                        ),
                        verticalSpace(18),
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svgs/info.svg",
                              width: 20,
                              fit: BoxFit.scaleDown,
                            ),
                            const CustomText(
                              title:
                                  "Default minimum attendance requirement is 70%",
                              size: 14,
                              weight: FontWeight.w400,
                              color: AppColors.medium300,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
