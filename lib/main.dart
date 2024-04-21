import 'dart:developer';
import 'package:attendance_management_app/shared/providers/app_route_provider.dart';
import 'package:attendance_management_app/shared/providers/ongoing_classes_provider.dart';
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

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  //showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.data}');
  handleNotification(message);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    await setupFlutterNotifications();
  }

  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

/*
Future<void> notificationSetup() async {
  final container = ProviderContainer();
  final FcmService fcmService = container.read(fcmServiceMethodsProvider);

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
    log(notification!.title.toString());
    log(notification.body.toString());
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});

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
*/

late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;
final container = ProviderContainer();

Future<void> setupFlutterNotifications() async {
  final FcmService fcmService = container.read(fcmServiceMethodsProvider);
  fcmService.setAutoInitEnabled();

  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  bool? notificationPermission = await container
      .read(savedInfoServiceMethodsProvider)
      .getInfo(AppStrings.NOTIFICATION_PERMISSION) as bool?;

  log(notificationPermission.toString());
  notificationPermission == true
      ? null
      : await fcmService.requestPermission(flutterLocalNotificationsPlugin);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  handleNotification(message);

  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  }
}

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void handleNotification(RemoteMessage message) {
  if (message.data.containsKey('class_instance_id')) {
    if (message.data["message"] == "Class Started") {
      container
          .read(ongoingClassProvider.notifier)
          .addClass(message.data["class_instance_id"]);
    } else if (message.data["message"] == "Class Ended") {
      container
          .read(ongoingClassProvider.notifier)
          .removeClass(message.data["class_instance_id"]);
    }
  } else {
    // Handle other types of notifications
  }
  print("ongoing class ${container.read(ongoingClassProvider)}");
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen(showFlutterNotification);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp: ${message.data}");

      //handleNotification(message);
    });
  }

  @override
  Widget build(BuildContext context) {
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
