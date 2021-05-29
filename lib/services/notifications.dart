import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Notifications() {
    this.getPermission();
    _messaging.subscribeToTopic("News");
    FirebaseMessaging.onMessage.listen((event) {
      this.getMessage(event);
    });

    FirebaseMessaging.onBackgroundMessage(this.receiveBackgroundMessage);
  }

  Future<void> receiveBackgroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
    print('Handling a background message ${message.messageId}');
  }

  getToken() async {
    return _messaging.getToken();
  }

  getMessage(RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  }

  getPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }
}
