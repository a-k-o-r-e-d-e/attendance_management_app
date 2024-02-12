import 'package:attendance_management_app/shared/widgets/general_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../../../shared/utilities/app_colors.dart';
import '../../../../shared/utilities/size_utils.dart';
import '../../../../shared/widgets/custom_appbar.dart';
import '../../../../shared/widgets/custom_text.dart';
import '../../../../shared/widgets/custom_text_form_field.dart';


@RoutePage()
class CreateClassScreen extends ConsumerStatefulWidget {
  const CreateClassScreen({super.key});

  @override
  ConsumerState<CreateClassScreen> createState() => _CreateClassScreenState();
}

class _CreateClassScreenState extends ConsumerState<CreateClassScreen> {
  String? courseRequirementValue;
  String? courseUnitValue;
  DateTime? selectedDate;
  final TextEditingController courseTitleController = TextEditingController();
  final TextEditingController courseCodeController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          centerTitle: true,
          title: 'Create class',
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
              buttonText: 'Create new class',
              onPressed: () {},
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
                          title: "Date",
                          size: 14,
                          weight: FontWeight.w400,
                        ),
                        verticalSpace(8),
                        GestureDetector(
                          onTap: () {
                            selectDate(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.medium200),
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  title: selectedDate == null
                                      ? "Select date"
                                      : DateFormat("d/M/y")
                                          .format(selectedDate!),
                                ),
                                const Icon(Icons.keyboard_arrow_down),
                              ],
                            ),
                          ),
                        ),
                        verticalSpace(18),
                        const CustomText(
                          title: "Time",
                          size: 14,
                          weight: FontWeight.w400,
                        ),
                        verticalSpace(8),
                        GestureDetector(
                          onTap: () {
                            selectTime(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.medium200),
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  title: time == null
                                      ? "Select time"
                                      : DateFormat.jm().format(DateTime.now()
                                          .copyWith(
                                              hour: time!.hour,
                                              minute: time!.minute)),
                                ),
                                const Icon(Icons.keyboard_arrow_down),
                              ],
                            ),
                          ),
                        ),
                        verticalSpace(18),
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
