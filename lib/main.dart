import 'dart:developer';
import 'package:attendance_management_app/shared/providers/app_route_provider.dart';
import 'package:attendance_management_app/shared/services/fcm_service/domain/repository/fcm_service_repo.dart';
import 'package:attendance_management_app/shared/services/fcm_service/providers/fcm_provider.dart';
import 'package:attendance_management_app/shared/services/saved_info_service/providers/saved_info_provider.dart';
import 'package:attendance_management_app/shared/utilities/app_strings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await firebaseInit();
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
    print('Message data: ${message.data}');
    print('Message notification: ${message.notification?.title}');
    print('Message notification: ${message.notification?.body}');
  }
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> firebaseInit() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final container = ProviderContainer();
  final FcmService fcmService = container.read(fcmServiceMethodsProvider);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.',
    // description
    importance: Importance.high,
  );
  await fcmService.createChannel(channel, flutterLocalNotificationsPlugin);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    // If `onMessage` is triggered with a notification, construct our own
    // local notification to show to users using the created channel.
    if (notification != null && android != null) {
      fcmService.showNotification(
          channel, notification, android, flutterLocalNotificationsPlugin);
    }
  });
  fcmService.setAutoInitEnabled();
  bool? notificationPermission = await container
      .read(savedInfoServiceMethodsProvider)
      .getInfo(AppStrings.NOTIFICATION_PERMISSION) as bool?;

  log(notificationPermission.toString());
  notificationPermission == true
      ? null
      : await fcmService.requestPermission(flutterLocalNotificationsPlugin);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.read(appRouterProvider).config(),
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
