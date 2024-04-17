import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class FcmService {
  Future<String?> fetchAndSaveFcmToken();

  void setAutoInitEnabled();

  Future<bool> requestPermission(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin);

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message);

  Future<void> createChannel(AndroidNotificationChannel channel,
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin);

  Future<void> showNotification(
      AndroidNotificationChannel channel,
      RemoteNotification? notification,
      AndroidNotification? android,
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin);
}
