import 'dart:async';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;




class NotificationRepository{


  NotificationRepository(){
    // Khởi tạo timezone
    tz.initializeTimeZones();
  }

  // logic cấp quyền cho thông báo
  Future<void> requestPermissionNotification() async {
    PermissionStatus status = await Permission.notification.request();
    if(status != PermissionStatus.granted){
      throw  Exception("Permission not granted");
    }
  }

  int id = 0;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotification({
    required Function(String payload) selectNotification,
    required Function(int? id,String? title, String? body, String? payload) onDidReceiveLocalNotification}) async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings(
        '@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification
    );
    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin);
    await _flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
          switch (notificationResponse.notificationResponseType) {
            case NotificationResponseType.selectedNotification:
              selectNotification(notificationResponse.payload!);
              break;
            case NotificationResponseType.selectedNotificationAction:
              selectNotification(notificationResponse.payload!);
              break;
          }});
  }



  Future<void> showNotification(int id, String title, String body, String payload, String bigText) async {
    BigTextStyleInformation bigTextStyleInformation =
    BigTextStyleInformation(
      bigText,
      htmlFormatBigText: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
      htmlFormatSummaryText: true,
    );
    await _flutterLocalNotificationsPlugin.show(
        id,
        title,
        body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            timeoutAfter: 4000,
            styleInformation: bigTextStyleInformation,
            "ACGNoti Channel",
            "ACGNoti Channel",
            channelDescription: "This channel is used for noti",
            importance: Importance.max,
            priority: Priority.max,
          ),
          iOS: const DarwinNotificationDetails(
            sound: 'default.wav',
            presentAlert: true,
            presentBadge: true,
            presentSound: true,

          ),
        ),

        payload: payload
    );
  }



  Future<bool> checkDidNotificationLaunchApp() async{
    final check = await _flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    return check?.didNotificationLaunchApp ?? false;
  }

  // Future<void> _showNotificationWithCustomTimestamp() async {
  //   final AndroidNotificationDetails androidNotificationDetails =
  //   AndroidNotificationDetails(
  //     'your channel id',
  //     'your channel name',
  //     channelDescription: 'your channel description',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //     when: DateTime.now().millisecondsSinceEpoch - 120 * 1000,
  //   );
  //   final NotificationDetails notificationDetails =
  //   NotificationDetails(android: androidNotificationDetails);
  //   await _flutterLocalNotificationsPlugin.show(
  //       id, 'plain title', 'plain body', notificationDetails,);
  //
  //   }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;

  }

  Future<void> scheduleDailyNotification(int id, String title, String body, String payload, int hour, int minute) async {
    print('Scheduling notification at $hour:$minute');
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      _nextInstanceOfTime(hour, minute),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'ACGNoti Channel',
          'ACGNoti Channel',
          channelDescription: 'This channel is used for notifications',
          importance: Importance.max,
          priority: Priority.max,
        ),
        iOS: DarwinNotificationDetails(
          sound: 'default.wav',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time, // Lặp lại hàng ngày tại cùng thời điểm
      payload: payload,
    );
  }


}
