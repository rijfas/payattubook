import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import '../../data/discover_payattu/models/payattu.dart';
import '../themes/app_theme.dart';

class NotificationManager {
  const NotificationManager._();

  static late final AwesomeNotifications _instance;

  static void initialize() {
    _instance = AwesomeNotifications();

    _instance.initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: 'payatt_channel_group',
          channelKey: 'payatt_channel',
          channelName: 'Payatt notifications',
          channelDescription: 'Notification channel for payatt',
          importance: NotificationImportance.High,
          defaultColor: AppTheme.lightPrimaryColor,
          ledColor: Colors.white,
        )
      ],
      debug: true,
    );

    _instance.isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        _instance.requestPermissionToSendNotifications();
      }
    });
  }

  static Future<void> addNotification({required Payattu payattu}) async {
    await _instance.createNotification(
      content: NotificationContent(
        id: payattu.id,
        channelKey: 'payatt_channel',
        title: 'Todays Payattu: ${payattu.host}',
        body: 'at ${payattu.location} on ${payattu.time.toString()}',
        notificationLayout: NotificationLayout.Default,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'MARK_DONE',
          label: 'Open App',
        ),
      ],
      schedule: NotificationCalendar(
        year: payattu.date.year,
        month: payattu.date.month,
        day: payattu.date.day,
        hour: payattu.time.hour,
        minute: payattu.time.minute,
        second: 0,
        millisecond: 0,
      ),
    );
  }

  static Future<void> removeNotification({required int payattId}) async {
    await _instance.cancel(payattId);
  }

  static void removeAllNotifications() async {
    await _instance.dismissAllNotifications();
  }
}
