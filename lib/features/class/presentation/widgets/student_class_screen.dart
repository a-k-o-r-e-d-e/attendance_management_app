import 'dart:developer';
import 'package:attendance_management_app/features/class/presentation/providers/states/attendance_enum.dart';
import 'package:attendance_management_app/shared/providers/ongoing_classes_provider.dart';
import 'package:attendance_management_app/shared/routes/app_route.dart';
import 'package:attendance_management_app/shared/services/saved_info_service/providers/saved_info_provider.dart';
import 'package:attendance_management_app/shared/widgets/general_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:intl/intl.dart';
import '../../../../shared/models/base_model.dart';
import '../../../../shared/utilities/app_colors.dart';
import '../../../../shared/utilities/app_strings.dart';
import '../../../../shared/utilities/size_utils.dart';
import '../../../../shared/utilities/string_utils.dart';
import '../../../../shared/utilities/toast_utils.dart';
import '../../../../shared/widgets/custom_appbar.dart';
import '../../../../shared/widgets/custom_text.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../authentication/presentation/providers/states/user_type_state.dart';
import '../providers/get_classes_provider.dart';

class StudentClassScreen extends ConsumerStatefulWidget {
  final Base classInstance;
  final String classID;

  const StudentClassScreen({
    super.key,
    required this.classInstance,
    required this.classID,
  });

  @override
  ConsumerState<StudentClassScreen> createState() => _StudentClassScreenState();
}

class _StudentClassScreenState extends ConsumerState<StudentClassScreen> {
  late IO.Socket socket;

  bool classJoined = false;
  bool classStart = false;
  AttendanceState attendanceState = AttendanceState.none;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      initSocket();
    });
  }

  DateTime computeEndTime() {
    return widget.classInstance.startDate!.copyWith(
        hour: StringUtils.parseTime(widget.classInstance.startTime!).hour,
        minute: StringUtils.parseTime(widget.classInstance.startTime!).minute);
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  initSocket() async {
    String? token = await ref
        .read(savedInfoServiceMethodsProvider)
        .getInfo(AppStrings.AUTH_TOKEN_KEY) as String?;
    //log(token!);
    String authToken = 'Bearer $token';
    socket = IO.io(
      "https://attendio-api-146c740682dd.herokuapp.com",
      <String, dynamic>{
        'autoConnect': false,
        'transports': ['websocket'],
        'extraHeaders': {'Authorization': authToken},
        // Add the Authorization header
      },
    );
    socket.connect();
    socket.onConnect((_) {
      log("Connection established");
    });
    socket.on(AppStrings.ATTENDANCE_INITIATED_EVENT, (data) {
      log(data.toString());
      if (attendanceState == AttendanceState.marked) {
      } else {
        setState(() {
          attendanceState = AttendanceState.unMarked;
        });
      }
    });
    socket.on(AppStrings.ATTENDANCE_STOPPED_EVENT, (data) {
      log(data.toString());
      if (attendanceState == AttendanceState.marked) {
      } else {
        setState(() {
          attendanceState = AttendanceState.none;
        });
      }
    });
    socket.on(AppStrings.EVENT_EXCEPTION, (data) {
      log(data['message']);
      ToastService.error(context, data['message']);
    });
    socket.on(AppStrings.CLASS_ENDED_EVENT, (data) {
      log(data.toString());
      setState(() {
        classJoined = false;
        classStart = false;
      });
      ref.invalidate(getClassesProvider(UserType.student));
    });
    socket.onConnectError((err) => log(err));
    socket.onDisconnect((_) {
      log("connection Disconnection");
    });
    socket.onError((err) => log("", error: err));
  }

  void joinClass() {
    try {
      socket.emitWithAck(
          AppStrings.JOIN_CLASS_EVENT, {"class_instance_id": widget.classID},
          ack: (data) {
        log('ack $data');
        if (data != null) {
          log('from server $data');
          setState(() {
            classJoined = true;
          });
        } else {
          log("Null");
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }

  void markAttendance() {
    try {
      socket.emitWithAck(AppStrings.MARK_ATTENDANCE_EVENT,
          {"class_instance_id": widget.classID}, ack: (data) {
        log('ack $data');
        if (data != null) {
          log('from server $data');
          setState(() {
            attendanceState = AttendanceState.marked;
          });
        } else {
          log("Null");
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    print(ref.read(ongoingClassProvider));
    bool classOn = ref.read(ongoingClassProvider).contains(widget.classID);
    print(classOn);
    ref.listen(ongoingClassProvider, (prev, next) {
      print(prev);
      classOn = next.contains(widget.classID);
      print(next);
      setState(() {});
    });
    return classJoined == false
        ? Scaffold(
            appBar: CustomAppBar(
              title: widget.classInstance.title!,
              prefixIcon: GestureDetector(
                  onTap: () {
                    context.router.pop();
                  },
                  child: const Icon(Icons.keyboard_arrow_left_rounded)),
            ),
            backgroundColor: Colors.white,
            bottomNavigationBar: Visibility(
              visible: classOn == false,
              replacement: Visibility(
                visible: classStart == false,
                replacement: GeneralButton(
                  buttonText: 'Waiting for lecturer to start class',
                  borderRadius: 0,
                  buttonColor: AppColors.appGreen,
                  onPressed: () {
                    //context.navigateNamedTo("/start-class");
                  },
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  //height: 48,
                  color: AppColors.primary500,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomText(
                          title: "Class starts in  ",
                          size: 16,
                          weight: FontWeight.w400,
                          color: Colors.white),
                      Expanded(
                        child: TimerCountdown(
                          //enableDescriptions: false,
                          timeTextStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                          descriptionTextStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                          format: CountDownTimerFormat.daysHoursMinutes,
                          endTime:
                              DateTime.now().add(const Duration(seconds: 10)),
                          onEnd: () {
                            log("Timer finished");
                            setState(() {
                              classStart = true;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              child: GeneralButton(
                buttonText: 'Join class',
                borderRadius: 0,
                onPressed: () {
                  joinClass();
                  //context.navigateNamedTo("/start-class");
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 174,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/cover-photo-3.jpeg"),
                          fit: BoxFit.cover),
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title: widget.classInstance.title,
                          size: 20,
                          weight: FontWeight.w500,
                        ),
                        verticalSpace(16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.access_time_filled_rounded,
                                  color: AppColors.medium200,
                                ),
                                CustomText(
                                  title:
                                      "${StringUtils.formatTime(widget.classInstance.startTime.toString())} - ${StringUtils.formatTime(widget.classInstance.endTime.toString())}",
                                  size: 14,
                                  weight: FontWeight.w500,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month,
                                  color: AppColors.medium200,
                                ),
                                CustomText(
                                  title:
                                      " ${DateFormat('dd/MM/yy').format(widget.classInstance.startDate!)}",
                                  size: 14,
                                  weight: FontWeight.w500,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: AppColors.medium200,
                                ),
                                CustomText(
                                  title: " ${widget.classInstance.mode}",
                                  size: 14,
                                  weight: FontWeight.w500,
                                )
                              ],
                            ),
                          ],
                        ),
                        verticalSpace(8),
                      ],
                    ),
                  ),
                  const Divider(
                    color: AppColors.appLight30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svgs/info.svg",
                              width: 20,
                            ),
                            const CustomText(
                              title: " Additional Information",
                              size: 16,
                              weight: FontWeight.w400,
                            ),
                          ],
                        ),
                        verticalSpace(16),
                        const CustomText(
                          title: "Lecturer",
                          size: 16,
                          weight: FontWeight.w400,
                        ),
                        verticalSpaceSmall,
                        ListTile(
                          onTap: () {
                            context.navigateTo(LecturerInfoRoute(
                                lecturer:
                                    widget.classInstance.course!.lecturer!));
                          },
                          leading: const CircleAvatar(
                            radius: 24,
                            backgroundImage: NetworkImage(
                                "https://i.pravatar.cc/300?img=70"),
                          ),
                          trailing:
                              const Icon(Icons.keyboard_arrow_right_rounded),
                          title: CustomText(
                            title:
                                "${widget.classInstance.course!.lecturer!.lastName} ${widget.classInstance.course!.lecturer!.firstName}",
                            size: 16,
                            weight: FontWeight.w500,
                          ),
                        ),
                        const Divider(
                          color: AppColors.appLight30,
                        ),
                        verticalSpaceSmall,
                        const CustomText(
                          title: "Faculty",
                          size: 16,
                          weight: FontWeight.w400,
                          color: AppColors.appDark500,
                        ),
                        verticalSpaceSmall,
                        CustomText(
                          title: widget.classInstance.course!.lecturer!.faculty
                              .toString(),
                          size: 16,
                          weight: FontWeight.w500,
                        ),
                        verticalSpace(8),
                        const Divider(
                          color: AppColors.appLight30,
                        ),
                        const CustomText(
                          title: "Department",
                          size: 16,
                          weight: FontWeight.w400,
                          color: AppColors.appDark500,
                        ),
                        verticalSpaceSmall,
                        CustomText(
                          title: widget
                              .classInstance.course!.lecturer!.department
                              .toString(),
                          size: 16,
                          weight: FontWeight.w500,
                        ),
                        verticalSpace(8),
                        const Divider(
                          color: AppColors.appLight30,
                        ),
                        const CustomText(
                          title: "Venue",
                          size: 16,
                          weight: FontWeight.w400,
                          color: AppColors.appDark500,
                        ),
                        verticalSpaceSmall,
                        CustomText(
                          title: widget.classInstance.venue.toString(),
                          size: 16,
                          weight: FontWeight.w500,
                        ),
                        verticalSpace(24),
                      ],
                    ),
                  ),
                ],
              ),
            ))
        : Scaffold(
            appBar: CustomAppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                      radius: 5,
                      colors: <Color>[Color(0xFF25314C), Colors.white]),
                ),
              ),
              title: "Class in progress",
              titleColor: Colors.white,
/*
            prefixIcon: GestureDetector(
                onTap: () {
                  context.router.pop();
                },
                child: const Icon(
                  Icons.keyboard_arrow_left_rounded,
                  color: Colors.white,
                )),
*/
            ),
            backgroundColor: Colors.white,
            bottomNavigationBar: GeneralButton(
              buttonText: attendanceState == AttendanceState.marked
                  ? 'Action recorded'
                  : 'Take attendance',
              borderRadius: 0,
              buttonColor: attendanceState == AttendanceState.none
                  ? AppColors.appGreyDark
                  : attendanceState == AttendanceState.unMarked
                      ? AppColors.primary500
                      : AppColors.appGreen,
              onPressed: () {
                if (attendanceState == AttendanceState.unMarked) {
                  markAttendance();
                } else {}
              },
            ),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      context.navigateTo(LecturerInfoRoute(
                          lecturer: widget.classInstance.course!.lecturer!));
                    },
                    leading: const CircleAvatar(
                      radius: 24,
                      backgroundImage:
                          NetworkImage("https://i.pravatar.cc/300?img=70"),
                    ),
                    trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                    title: CustomText(
                      title:
                          "${widget.classInstance.course!.lecturer!.lastName} ${widget.classInstance.course!.lecturer!.firstName}",
                      size: 14,
                      weight: FontWeight.w500,
                    ),
                    subtitle: const CustomText(
                        title: "Lecturer",
                        size: 14,
                        weight: FontWeight.w400,
                        color: AppColors.medium300),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          title: attendanceState == AttendanceState.none
                              ? "Waiting for lecturer to start taking attendance."
                              : attendanceState == AttendanceState.unMarked
                                  ? "Lecturer is now taking attendance."
                                  : "You have taken attendance for this class.",
                          size: 16,
                          weight: FontWeight.w400,
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ));
  }

  @override
  void dispose() {
    super.dispose();
    socket.disconnect();
    socket.dispose();
  }
}
