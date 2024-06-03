import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

import '../firebase_options.dart';

class FirebaseService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else {
      print('User declined or has not accepted permission');
    }

    _initializeLocalNotification();
    setupForegroundListeners();
  }

  static void setupForegroundListeners() {
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
  }

  static void setupBackgroundListeners() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> _initializeLocalNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> _onMessageHandler(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      print('Handling a message while in the foreground!');
      _showNotification(notification, android);
    }
  }

  static Future<void> _showNotification(RemoteNotification notification, AndroidNotification android) async {
    final BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      notification.body ?? '',
      contentTitle: '<b>${notification.title}</b>',
      htmlFormatContentTitle: true,
      htmlFormatBigText: true,
    );

    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'high_importance_channel', // id channel
      'High Importance Notifications', // nama channel
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: bigTextStyleInformation,
      icon: '@mipmap/sentinel', // Explicitly specify the icon here
    );

    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      platformChannelSpecifics,
    );
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    // Note: Do not manually show notification here if you are already handling it in the foreground.
    print('Handling a message in the background!');
    // Additional handling if needed (e.g., update local database)
  }

  static Future<String?> getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    assert(token != null);
    print("Device Token: $token");

    sendTokenToServer(token!);

    return token;
  }

  static Future<void> sendTokenToServer(String token) async {
    final url = Uri.parse('https://3c95-2001-448a-5110-9379-ac62-aced-ebb7-52f0.ngrok-free.app/update-token'); // Ganti dengan URL server Anda
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': token}),
    );

    if (response.statusCode == 200) {
      print('Token updated successfully');
    } else {
      print('Failed to update token');
    }
  }
}
