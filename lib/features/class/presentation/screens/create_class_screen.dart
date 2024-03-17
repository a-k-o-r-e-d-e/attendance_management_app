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
import '../../domain/models/class_enums.dart';

@RoutePage()
class CreateClassScreen extends ConsumerStatefulWidget {
  const CreateClassScreen({super.key});

  @override
  ConsumerState<CreateClassScreen> createState() => _CreateClassScreenState();
}

class _CreateClassScreenState extends ConsumerState<CreateClassScreen> {
  String? classType;
  String? classFrequency;
  String? classMode;
  String? courseUnitValue;
  DateTime? selectedDate;

  DateTime? startDate;
  DateTime? endDate;
  final TextEditingController courseTitleController = TextEditingController();
  final TextEditingController courseCodeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  void selectDate(BuildContext context) async {
    selectedDate = (await showDatePicker(
        context: context,
        initialDate: null,
        firstDate: DateTime.now().add(const Duration(days: 1)),
        lastDate: DateTime.now().add(const Duration(days: 14))))!;

    setState(() {});
  }

  void selectStartDate(BuildContext context) async {
    startDate = (await showDatePicker(
        context: context,
        initialDate: null,
        firstDate: DateTime.now().add(const Duration(days: 1)),
        lastDate: DateTime.now().add(const Duration(days: 14))))!;

    setState(() {});
  }

  void selectEndDate(BuildContext context) async {
    endDate = (await showDatePicker(
        context: context,
        initialDate: null,
        firstDate: DateTime.now().add(const Duration(days: 1)),
        lastDate: DateTime.now().add(const Duration(days: 14))))!;

    setState(() {});
  }

  void selectStartTime(BuildContext context) async {
    startTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ) as TimeOfDay;

    setState(() {});
  }

  void selectEndTime(BuildContext context) async {
    endTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ) as TimeOfDay;

    setState(() {});
  }

  Map<String, bool> days = {
    'Monday': false,
    'Tuesday': false,
    'Wednesday': false,
    'Thursday': false,
    'Friday': false,
    'Saturday': false,
    'Sunday': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: true,
        title: 'Add a class',
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
            buttonText: 'Add class',
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
                        title: "Class title",
                        size: 14,
                        weight: FontWeight.w400,
                      ),
                      verticalSpace(8),
                      CustomTextFormField(
                        hintText: "Enter class title",
                        controller: courseTitleController,
                      ),
                      verticalSpace(18),
                      const CustomText(
                        title: "Class mode",
                        size: 14,
                        weight: FontWeight.w400,
                      ),
                      verticalSpace(8),
                      DropdownButtonFormField<String>(
                        value: classMode,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        isExpanded: true,
                        hint: const CustomText(
                          title: "Select class mode",
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
                            classMode = newValue!;
                          });
                        },
                        items: ClassMode.values
                            .map((mode) => mode.nameString)
                            .toList()
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      verticalSpace(18),
                      Visibility(
                          visible: classMode != null &&
                              ClassModeX.getClassModeFromName(classMode!) ==
                                  ClassMode.online,
                          replacement: const SizedBox(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                title: "Class Link",
                                size: 14,
                                weight: FontWeight.w400,
                              ),
                              verticalSpace(8),
                              CustomTextFormField(
                                hintText: "Enter class link",
                                controller: courseTitleController,
                              ),
                              verticalSpace(18),
                            ],
                          )),
                      const CustomText(
                        title: "Class type",
                        size: 14,
                        weight: FontWeight.w400,
                      ),
                      verticalSpace(8),
                      DropdownButtonFormField<String>(
                        value: classType,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        isExpanded: true,
                        hint: const CustomText(
                          title: "Select class type",
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
                            classType = newValue!;
                          });
                        },
                        items: ClassType.values
                            .map((mode) => mode.nameString)
                            .toList()
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      verticalSpace(18),
                      Visibility(
                        visible: classType != null &&
                            ClassTypeX.getClassTypeFromName(classType!) ==
                                ClassType.recurring,
                        replacement: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                    border: Border.all(
                                        color: AppColors.medium200),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      title: selectedDate == null
                                          ? "Select date"
                                          : DateFormat("d/M/y")
                                              .format(selectedDate!),
                                    ),
                                    const Icon(
                                      Icons.calendar_month,
                                      color: AppColors.medium200,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            verticalSpace(18),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const CustomText(
                                        title: "From",
                                        size: 14,
                                        weight: FontWeight.w400,
                                      ),
                                      verticalSpace(8),
                                      GestureDetector(
                                        onTap: () {
                                          selectStartTime(context);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColors.medium200),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              CustomText(
                                                title: startTime == null
                                                    ? "Start time"
                                                    : DateFormat.jm().format(
                                                        DateTime.now().copyWith(
                                                            hour: startTime!
                                                                .hour,
                                                            minute: startTime!
                                                                .minute)),
                                              ),
                                              const Icon(
                                                Icons
                                                    .access_time_filled_rounded,
                                                color: AppColors.medium200,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                horizontalSpace(30),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const CustomText(
                                        title: "To",
                                        size: 14,
                                        weight: FontWeight.w400,
                                      ),
                                      verticalSpace(8),
                                      GestureDetector(
                                        onTap: () {
                                          selectEndTime(context);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColors.medium200),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              CustomText(
                                                title: endTime == null
                                                    ? "End time"
                                                    : DateFormat.jm().format(
                                                        DateTime.now().copyWith(
                                                            hour:
                                                                endTime!.hour,
                                                            minute: endTime!
                                                                .minute)),
                                              ),
                                              const Icon(
                                                Icons
                                                    .access_time_filled_rounded,
                                                color: AppColors.medium200,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            verticalSpace(18),
                          ],
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: AppColors.appLight20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                title: "How often does this class occur?",
                                size: 14,
                                weight: FontWeight.w500,
                                color: AppColors.medium300,
                              ),
                              verticalSpace(8),
                              DropdownButtonFormField<String>(
                                value: classFrequency,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                isExpanded: true,
                                hint: const CustomText(
                                  title: "Select class frequency",
                                ),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                            color: AppColors.medium200))),
                                iconSize: 24,
                                elevation: 16,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    classFrequency = newValue!;
                                  });
                                },
                                items: ClassFrequency.values
                                    .map((mode) => mode.nameString)
                                    .toList()
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                              verticalSpace(18),
                              Visibility(
                                  visible: classFrequency != null &&
                                      ClassFrequencyX
                                              .getClassFrequencyFromName(
                                                  classFrequency!) ==
                                          ClassFrequency.weekly,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: const Color(0xFFE8E9F0)),
                                        borderRadius:
                                            BorderRadius.circular(4)),
                                    child: Column(
                                      children: [
                                        const CustomText(
                                          title: "Day of the week",
                                          size: 14,
                                          weight: FontWeight.w500,
                                          color: AppColors.medium300,
                                        ),
                                        ListView(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          children:
                                              days.keys.map((String day) {
                                            return CheckboxListTile(
                                              dense: true,
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              title: CustomText(
                                                title: day,
                                                size: 14,
                                                weight: FontWeight.w500,
                                              ),
                                              value: days[day],
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  days[day] = value!;
                                                });
                                              },
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                  )),
                              verticalSpace(8),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const CustomText(
                                          title: "From",
                                          size: 14,
                                          weight: FontWeight.w400,
                                        ),
                                        verticalSpace(8),
                                        GestureDetector(
                                          onTap: () {
                                            selectStartTime(context);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        AppColors.medium200),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CustomText(
                                                  title: startTime == null
                                                      ? "Start time"
                                                      : DateFormat.jm().format(
                                                          DateTime.now().copyWith(
                                                              hour: startTime!
                                                                  .hour,
                                                              minute: startTime!
                                                                  .minute)),
                                                ),
                                                const Icon(
                                                  Icons
                                                      .access_time_filled_rounded,
                                                  color: AppColors.medium200,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  horizontalSpace(30),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const CustomText(
                                          title: "To",
                                          size: 14,
                                          weight: FontWeight.w400,
                                        ),
                                        verticalSpace(8),
                                        GestureDetector(
                                          onTap: () {
                                            selectEndTime(context);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        AppColors.medium200),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CustomText(
                                                  title: endTime == null
                                                      ? "End time"
                                                      : DateFormat.jm().format(
                                                          DateTime.now().copyWith(
                                                              hour: endTime!
                                                                  .hour,
                                                              minute: endTime!
                                                                  .minute)),
                                                ),
                                                const Icon(
                                                  Icons
                                                      .access_time_filled_rounded,
                                                  color: AppColors.medium200,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              verticalSpace(18),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const CustomText(
                                          title: "Occurs from",
                                          size: 14,
                                          weight: FontWeight.w400,
                                        ),
                                        verticalSpace(8),
                                        GestureDetector(
                                          onTap: () {
                                            selectStartDate(context);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        AppColors.medium200),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CustomText(
                                                  title: startDate == null
                                                      ? "Start date"
                                                      : DateFormat("d/M/y")
                                                          .format(startDate!),
                                                ),
                                                const Icon(
                                                  Icons.calendar_month,
                                                  color: AppColors.medium200,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  horizontalSpace(30),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const CustomText(
                                          title: "Until",
                                          size: 14,
                                          weight: FontWeight.w400,
                                        ),
                                        verticalSpace(8),
                                        GestureDetector(
                                          onTap: () {
                                            selectEndDate(context);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        AppColors.medium200),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CustomText(
                                                  title: endDate == null
                                                      ? "End date"
                                                      : DateFormat("d/M/y")
                                                          .format(endDate!),
                                                ),
                                                const Icon(
                                                  Icons.calendar_month,
                                                  color: AppColors.medium200,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              verticalSpace(18),
                            ],
                          ),
                        ),
                      )
                    ],
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
