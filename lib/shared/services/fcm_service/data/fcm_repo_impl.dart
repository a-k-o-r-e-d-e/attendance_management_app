import 'dart:async';
import 'dart:io';
import 'package:attendance_management_app/shared/services/saved_info_service/domain/repository/saved_info_repo.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../../utilities/app_strings.dart';
import '../domain/repository/fcm_service_repo.dart';

class FcmServiceImpl extends FcmService {
  final FirebaseMessaging firebaseMessagingInstance;
  final SavedInfoService savedInfo;

  FcmServiceImpl(this.firebaseMessagingInstance, this.savedInfo);

  @override
  Future<String?> fetchAndSaveFcmToken() async {
    String? token =
        (await savedInfo.getInfo(AppStrings.FCM_TOKEN_KEY)) as String?;

    if (token == null) {
      token = await firebaseMessagingInstance.getToken();
      await savedInfo.saveInfo(AppStrings.FCM_TOKEN_KEY, token!);
    }

    return token;
  }

  @override
  Future<void> setAutoInitEnabled() async {
    await firebaseMessagingInstance.setAutoInitEnabled(true);
  }

  @override
  Future<bool> requestPermission(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    NotificationSettings settings =
        await firebaseMessagingInstance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    bool? req = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    await savedInfo.saveInfo(
        AppStrings.NOTIFICATION_PERMISSION,
        (settings.authorizationStatus == AuthorizationStatus.authorized) &&
            req!);
    if (Platform.isIOS) {
      await firebaseMessagingInstance
          .setForegroundNotificationPresentationOptions(
        alert: true, // Required to display a heads up notification
        badge: true,
        sound: true,
      );
    }

    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  @override
  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    if (kDebugMode) {
      print("Handling a background message: ${message.messageId}");
      print('Message data: ${message.data}');
      print('Message notification: ${message.notification?.title}');
      print('Message notification: ${message.notification?.body}');
    }
  }

  @override
  Future<void> createChannel(AndroidNotificationChannel channel,
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  @override
  Future<void> showNotification(
      AndroidNotificationChannel channel,
      RemoteNotification? notification,
      AndroidNotification? android,
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification?.title,
        notification?.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: '@mipmap/ic_launcher',
            // other properties...
          ),
        ));
  }
}
