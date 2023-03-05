import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;



class LocalNotificationServic{
  LocalNotificationServic();

  final _localNotificationService = FlutterLocalNotificationsPlugin();
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async{
    final details = await _notificationDetails();
    await _localNotificationService.show(id, title,body,details);
  }
  Future <void> initialize() async{
    const AndroidInitializationSettings androidInitializationSettings =
          AndroidInitializationSettings('@drawable');
    InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings
    );
    await _localNotificationService.initialize(
        settings,
      onDidReceiveNotificationResponse:onSelectNotification,
    );
  }
  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'channel_id',
            'channel_name',
          channelDescription: 'description',
          importance: Importance.max,
          priority: Priority.max,
          playSound: true
        );
    return const NotificationDetails(android: androidNotificationDetails);
  }

  void onSelectNotification(NotificationResponse details) {
    print('payload:$details' );
  }
}