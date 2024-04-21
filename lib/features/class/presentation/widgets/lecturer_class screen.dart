import 'dart:developer';
import 'package:attendance_management_app/features/class/domain/models/attendance_event_model.dart';
import 'package:attendance_management_app/features/class/domain/providers/class_repo_provider.dart';
import 'package:attendance_management_app/features/class/domain/repository/class_repo.dart';
import 'package:attendance_management_app/features/class/presentation/providers/get_classes_provider.dart';
import 'package:attendance_management_app/shared/routes/app_route.dart';
import 'package:attendance_management_app/shared/services/saved_info_service/providers/saved_info_provider.dart';
import 'package:attendance_management_app/shared/widgets/general_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../shared/models/base_model.dart';
import '../../../../shared/services/dio_service/domain/models/api_response_model.dart';
import '../../../../shared/services/local_auth_service/domain/repository/local_auth_service_repo.dart';
import '../../../../shared/services/local_auth_service/providers/local_auth_provider.dart';
import '../../../../shared/services/location_service/domain/repository/location_service_repo.dart';
import '../../../../shared/services/location_service/providers/location_provider.dart';
import '../../../../shared/utilities/app_colors.dart';
import '../../../../shared/utilities/app_strings.dart';
import '../../../../shared/utilities/size_utils.dart';
import '../../../../shared/utilities/string_utils.dart';
import '../../../../shared/utilities/toast_utils.dart';
import '../../../../shared/widgets/custom_appbar.dart';
import '../../../../shared/widgets/custom_text.dart';
import '../../../../shared/widgets/dialogs/loading_dialog.dart';
import '../../../../shared/models/user_model.dart';
import '../../../authentication/presentation/providers/states/user_type_state.dart';
import '../../../course/presentation/providers/get_enrolled_student_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../domain/models/join_class_event_model.dart';

class LecturerClassScreen extends ConsumerStatefulWidget {
  final Base classInstance;
  final String classID;

  const LecturerClassScreen({
    super.key,
    required this.classInstance,
    required this.classID,
  });

  @override
  ConsumerState<LecturerClassScreen> createState() =>
      _LecturerClassScreenState();
}

class _LecturerClassScreenState extends ConsumerState<LecturerClassScreen> {
  late IO.Socket socket;
  JoinClassModel? joinedStudentData;
  AttendanceEventModel? attendanceData;
  bool classOn = false;
  bool classAttendance = false;

  //bool classStart = false;

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
    socket.on(AppStrings.START_CLASS_EVENT, (data) => log(data));
    socket.on(AppStrings.EVENT_EXCEPTION, (data) {
      log(data['message']);
      ToastService.error(context, data['message']);
    });
    socket.on(AppStrings.END_CLASS_ACK, (data) {
      log(data.toString());
      setState(() {
        classOn = false;
      });
      ref.invalidate(getClassesProvider(UserType.lecturer));
    });
    socket.on(AppStrings.STUDENT_JOINED_CLASS_EVENT, (data) {
      log(data.toString());
      setState(() {
        joinedStudentData = JoinClassModel.fromJson(data);
      });
    });
    socket.on(AppStrings.STUDENT_MARKED_PRESENT_EVENT, (data) {
      log(data.toString());
      setState(() {
        attendanceData = AttendanceEventModel.fromJson(data);
      });
    });
    socket.onConnectError((err) => log(err));
    socket.onDisconnect((_) {
      log("connection Disconnection");
    });
    socket.onError((err) => log("", error: err));
  }

  void startClass() {
    try {
      socket.emitWithAck(
          AppStrings.START_CLASS_EVENT, {"class_instance_id": widget.classID},
          ack: (data) {
        log('ack $data');
        if (data != null) {
          log('from server $data');
          setState(() {
            classOn = true;
            joinedStudentData = JoinClassModel.fromJson(data);
          });
        } else {
          log("Null");
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }

  void startAttendance() {
    try {
      socket.emitWithAck(AppStrings.TAKE_ATTENDANCE_EVENT,
          {"class_instance_id": widget.classID}, ack: (data) {
        log('ack $data');
        if (data != null) {
          log('from server $data');
          setState(() {
            joinedStudentData = JoinClassModel.fromJson(data);
          });
        } else {
          log("Null");
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }

  void stopAttendance() {
    try {
      socket.emitWithAck(AppStrings.HALT_ATTENDANCE_EVENT,
          {"class_instance_id": widget.classID}, ack: (data) {
        log('ack $data');
        if (data != null) {
          log('from server $data');
          setState(() {
            joinedStudentData = JoinClassModel.fromJson(data);
          });
        } else {
          log("Null");
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }

  void stopClass() {
    try {
      socket.emit(
        AppStrings.END_CLASS_EVENT,
        {"class_instance_id": widget.classID},
      );
      setState(() {
        classOn = false;
      });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    /*final LocationService locationService =
        ref.read(locationServiceMethodsProvider);*/
    final LocalAuthService localAuth =
        ref.watch(localAuthServiceMethodsProvider);

    Future<void> deleteClass() async {
      ClassRepository classService = ref.watch(classRepoProvider);
      try {
        LoadingDialog.show(context);
        var _ = await classService.deleteClass(widget.classInstance.id!);

        if (!mounted) return;
        context.router.pop();
        ref.invalidate(getClassesProvider);

        ToastService.success(context, "course deleted", seconds: 2);
        context.router.back();
      } on ErrorResponse catch (exception, _) {
        context.router.pop();

        log('', error: exception.exception);
        ToastService.error(context, exception.exception.error.toString());
      }
    }

    //final String? appUser = ref.watch(appUserProvider).profile?.user?.roles![0];
    return (classOn == false)
        ? Scaffold(
            appBar: CustomAppBar(
              title: widget.classInstance.title!,
              prefixIcon: GestureDetector(
                  onTap: () {
                    context.router.pop();
                  },
                  child: const Icon(Icons.keyboard_arrow_left_rounded)),
              suffixIcon: (classOn == false)
                  ? PopupMenuButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Colors.white,
                      child: const Icon(
                        Icons.more_vert,
                        color: AppColors.appDark700,
                        size: 24,
                      ),
                      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                        PopupMenuItem(
                          child: const Text('Edit Class'),
                          onTap: () {
                            context.navigateTo(CreateClassRoute(
                                editClass: widget.classInstance,
                                courseId: widget.classInstance.course!.id!,
                                courseTitle: null));
                          },
                        ),
                        PopupMenuItem(
                          child: const Text('Delete Class'),
                          onTap: () {
                            deleteClass();
                          },
                        ),
                      ],
                    )
                  : null,
            ),
            backgroundColor: Colors.white,
            bottomNavigationBar: Padding(
              padding: EdgeInsets.zero,
              child: Row(
                children: [
                  Expanded(
                    child: GeneralButton(
                      buttonText: 'Start class',
                      borderRadius: 0,
                      onPressed: () {
                        startClass();
                      },
                    ),
                  ),
                  Expanded(
                    child: GeneralButton(
                      textColor: AppColors.primary500,
                      buttonColor: Colors.white,
                      buttonText: 'Cancel class',
                      borderRadius: 0,
                      onPressed: () {
                        //stopClass();
                      },
                    ),
                  ),
                ],
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
                  Column(
                    children: [
                      StudentEnrolled(widget.classInstance.course!.id!),
                      verticalSpace(12),
                      ExpansionWidget(
                          initiallyExpanded: true,
                          titleBuilder: (double animationValue, _,
                              bool isExpaned, toogleFunction) {
                            return InkWell(
                                onTap: () => toogleFunction(animated: true),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                                "assets/svgs/report.svg"),
                                            CustomText(
                                              title:
                                                  " Quick overview for this class",
                                              size: widthSizer(16, context),
                                              weight: FontWeight.w400,
                                              color: AppColors.medium300,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Icon(
                                        isExpaned
                                            ? Icons.keyboard_arrow_up_outlined
                                            : Icons.keyboard_arrow_down,
                                        color: AppColors.medium300,
                                      )
                                    ],
                                  ),
                                ));
                          },
                          content: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  title:
                                      " ${DateFormat('dd/MM/yy').format(widget.classInstance.startDate!)}",
                                  size: widthSizer(16, context),
                                  weight: FontWeight.w500,
                                  color: AppColors.medium300,
                                ),
                                verticalSpace(8),
                                CustomText(
                                  title:
                                      "Number of student that attended this class",
                                  size: widthSizer(16, context),
                                  weight: FontWeight.w500,
                                  overflow: TextOverflow.clip,
                                ),
                                verticalSpace(24),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 20,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.appBlue),
                                        ),
                                        horizontalSpace(8),
                                        CustomText(
                                          title: "Present",
                                          size: widthSizer(16, context),
                                          weight: FontWeight.w500,
                                          color: AppColors.medium300,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 20,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.appOrange),
                                        ),
                                        horizontalSpace(8),
                                        CustomText(
                                          title: "Absent",
                                          size: widthSizer(16, context),
                                          weight: FontWeight.w500,
                                          color: AppColors.medium300,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                verticalSpace(46),
                                const Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    width: 135,
                                    height: 135,
                                    child: CircularProgressIndicator(
                                        strokeCap: StrokeCap.round,
                                        strokeWidth: 8,
                                        value: 0.20,
                                        color: AppColors.appOrange,
                                        backgroundColor: AppColors.appBlue),
                                  ),
                                ),
                                verticalSpace(46),
                                Row(
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.appBlue),
                                    ),
                                    horizontalSpace(8),
                                    Expanded(
                                      child: CustomText(
                                        title:
                                            "800 student attended this class (80%)",
                                        size: widthSizer(16, context),
                                        weight: FontWeight.w500,
                                        color: AppColors.medium300,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                  ],
                                ),
                                verticalSpace(8),
                                Row(
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.appOrange),
                                    ),
                                    horizontalSpace(8),
                                    Expanded(
                                      child: CustomText(
                                        title:
                                            "439 student did not attend this class (20%)",
                                        size: widthSizer(16, context),
                                        weight: FontWeight.w500,
                                        color: AppColors.medium300,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                  ],
                                ),
                                verticalSpace(12),
                              ],
                            ),
                          )),
                    ],
                  )

                  /*    activity.when(data: (List<UpcomingClassModel> data) {
                  return SizedBox();
                }, error: (Object error, StackTrace stackTrace) {
                  print(stackTrace);
                  return Text(stackTrace.toString());
                }, loading: () {
                  return Shimmer(
                    period: const Duration(seconds: 2),
                    //Default value
                    loop: 1,
                    enabled: true,
                    //Default value
                    direction: ShimmerDirection.ltr,
                    gradient: LinearGradient(
                        colors: [Colors.white, Colors.grey.withOpacity(.5)]),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.appGrey,
                          borderRadius: BorderRadius.circular(8)),
                      width: double.infinity,
                      height: heightSizer(318, context),
                    ),
                  );
                }),*/
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
              title: joinedStudentData?.currentlyTakingAttendance == false
                  ? "Class in progress"
                  : "Attendance in progress",
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
            bottomNavigationBar: Padding(
              padding: EdgeInsets.zero,
              child: Row(
                children: [
                  Expanded(
                    child: joinedStudentData?.currentlyTakingAttendance == false
                        ? GeneralButton(
                            buttonText: 'Take attendance',
                            borderRadius: 0,
                            onPressed: () async {
                              if (await localAuth.authenticate()) {
                                /*if (await locationService.hasPermission()) {
                          SetDistanceModal.show(
                            context,
                            ref,
                          );
                        } else {
                          bool permitted =
                              await locationService.requestPermission();
                          if (permitted) {
                            SetDistanceModal.show(
                              context,
                              ref,
                            );
                          }
                        }*/
                                startAttendance();
                              } else {
                                if (!mounted) return;
                                ToastService.error(context,
                                    "Biometrics is needed for taking attendance");
                                //startAttendance();
                              }
                            },
                          )
                        : GeneralButton(
                            buttonText: 'Stop attendance',
                            borderRadius: 0,
                            buttonColor: AppColors.appRed,
                            onPressed: () async {
                              stopAttendance();
                            },
                          ),
                  ),
                  Expanded(
                    child: GeneralButton(
                      buttonColor: Colors.white,
                      textColor: AppColors.primary500,
                      buttonText: 'Stop class',
                      borderRadius: 0,
                      onPressed: () {
                        stopClass();
                      },
                    ),
                  ),
                ],
              ),
            ),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
              child: ContainedTabBarView(
                tabs: const [
                  Text('Present'),
                  Text('Attendance'),
                ],
                views: [
                  Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset("assets/svgs/users-group.svg"),
                          Expanded(
                            child: CustomText(
                              title:
                                  " ${joinedStudentData?.presentEnrolledStudents!.length} out of ${joinedStudentData?.countOfEnrolledStudents} enrolled student in class",
                              size: widthSizer(16, context),
                              weight: FontWeight.w400,
                              color: AppColors.medium300,
                            ),
                          ),
                        ],
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
                                      student: joinedStudentData!
                                          .presentEnrolledStudents![index]
                                          .student as Profile,
                                      index: index));
                                },
                                leading: CircleAvatar(
                                  radius: 24,
                                  backgroundImage: NetworkImage(
                                      "https://i.pravatar.cc/300?img=$index"),
                                ),
                                title: CustomText(
                                  title:
                                      "${joinedStudentData?.presentEnrolledStudents![index].student!.lastName} ${joinedStudentData?.presentEnrolledStudents![index].student!.firstName}",
                                  size: 16,
                                  weight: FontWeight.w500,
                                ),
                              );
                            },
                            separatorBuilder: (ctx, idx) => verticalSpace(8),
                            itemCount: joinedStudentData!
                                .presentEnrolledStudents!.length),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset("assets/svgs/users-group.svg"),
                          Expanded(
                            child: CustomText(
                              title:
                                  " ${attendanceData == null ? 0 : attendanceData?.attendanceRecords!.length} out of ${joinedStudentData?.presentEnrolledStudents!.length} present student have marked attendance",
                              size: widthSizer(16, context),
                              weight: FontWeight.w400,
                              color: AppColors.medium300,
                            ),
                          ),
                        ],
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
                                      student: attendanceData
                                          ?.attendanceRecords![index]
                                          .studentEnrollment!
                                          .student as Profile,
                                      index: index));
                                },
                                leading: CircleAvatar(
                                  radius: 24,
                                  backgroundImage: NetworkImage(
                                      "https://i.pravatar.cc/300?img=$index"),
                                ),
                                title: CustomText(
                                  title:
                                      "${attendanceData?.attendanceRecords![index].studentEnrollment!.student!.lastName} ${attendanceData?.attendanceRecords![index].studentEnrollment!.student!.firstName}",
                                  size: 16,
                                  weight: FontWeight.w500,
                                ),
                              );
                            },
                            separatorBuilder: (ctx, idx) => verticalSpace(8),
                            itemCount: attendanceData == null
                                ? 0
                                : attendanceData!.attendanceRecords!.length),
                      )
                    ],
                  ),
                ],
                onChange: (index) => print(index),
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

class StudentEnrolled extends ConsumerWidget {
  final String courseId;

  const StudentEnrolled(this.courseId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Profile>> activity =
        ref.watch(getEnrolledStudentProvider(courseId));
    return activity.when(data: (List<Profile> students) {
      return ExpansionWidget(
          initiallyExpanded: false,
          titleBuilder:
              (double animationValue, _, bool isExpaned, toogleFunction) {
            return InkWell(
                onTap: () => toogleFunction(animated: true),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/svgs/users-group.svg"),
                            CustomText(
                              title:
                                  " ${students.length} ${students.length > 1 ? "students" : "student"} enrolled for this course",
                              size: widthSizer(16, context),
                              weight: FontWeight.w400,
                              color: AppColors.medium300,
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        isExpaned
                            ? Icons.keyboard_arrow_up_outlined
                            : Icons.keyboard_arrow_down,
                        color: AppColors.medium300,
                      )
                    ],
                  ),
                ));
          },
          content: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    context.navigateTo(StudentInfoRoute(
                        student: students[index], index: index));
                  },
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundImage:
                        NetworkImage("https://i.pravatar.cc/300?img=$index"),
                  ),
                  title: CustomText(
                    title:
                        "${students[index].lastName} ${students[index].firstName}",
                    size: 16,
                    weight: FontWeight.w500,
                  ),
                );
              },
              separatorBuilder: (ctx, idx) => verticalSpace(8),
              itemCount: students.length));
    }, error: (Object error, StackTrace stackTrace) {
      print(stackTrace);
      return const Text("An error has occurred!");
    }, loading: () {
      return Shimmer(
        period: const Duration(seconds: 2),
        //Default value
        loop: 1,
        enabled: true,
        //Default value
        direction: ShimmerDirection.ltr,
        gradient:
            LinearGradient(colors: [Colors.white, Colors.grey.withOpacity(.5)]),
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.appGrey, borderRadius: BorderRadius.circular(8)),
          width: double.infinity,
          height: heightSizer(40, context),
        ),
      );
    });
  }
}
