import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/router/router.dart';
import 'package:tm8/app/services/service_locator.dart';

//class used for showing local notifications
// meaning if notification is received when the app is opened
class NotificationService {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  late AndroidNotificationChannel channel;
  Future<void> initLocalNotifications() async {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.high,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(badge: true, sound: true, alert: true);
    const androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    const iosInitializationSettings = DarwinInitializationSettings();

    const initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: selectNotification,
    );
  }

  Future<void> showNotification(
    int id,
    String title,
    String body,
    String data,
  ) async {
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/launcher_icon',
          color: primaryTeal,
        ),
        iOS: const DarwinNotificationDetails(
          sound: 'default.wav',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: data,
    );
  }

  Future selectNotification(NotificationResponse? notification) async {
    final payload = notification?.payload;
    if (payload == null) return;

    if (payload.contains('CallScreen')) {
      final call = payload.split('/');

      sl<AppRouter>().push(
        CallRoute(
          userCallId: call[1],
          username: call.last,
          callId: call[1],
        ),
      );
    }
  }
}
