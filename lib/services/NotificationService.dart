import 'package:Gym/model/ReceivedNotification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final ReceivedNotification receivedNotification;
  NotificationService(this.receivedNotification);

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

  void initializing() async {
    androidInitializationSettings = AndroidInitializationSettings('app_icon');
    iosInitializationSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(
        androidInitializationSettings, iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  void showNotifications() async {
    await notification();
  }

  /* Show Notification scheduled for specific date & time */
  void showNotificationsAtSpecificDateTime(DateTime delayedTime) async {
    await notificationAtSpecificDateTime(delayedTime);
  }

  /* Notification scheduled for specific date & time */
  Future<void> notificationAtSpecificDateTime(DateTime delayedTime) async {
    //var date = new DateTime(2020, 08, 19, 12, 47);
    //var timeDelayed = DateTime.now().add(Duration(seconds: 5));
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'second channel ID', 'second Channel title', 'second channel body',
            priority: Priority.High,
            importance: Importance.Max,
            ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails =
        NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    await flutterLocalNotificationsPlugin.schedule(
        receivedNotification.id,
        receivedNotification.title,
        receivedNotification.body,
        delayedTime,
        notificationDetails,
        payload: receivedNotification.payload);
  }

  /* Show Notification 15 minutes before the scheduled date & time */
  void showNotificationsBefore15MinutesDateTime(DateTime delayedTime) async {
    await notificationBefore15MinutesDateTime(delayedTime);
  }

  /* Notification 15 minutes before the scheduled date & time */
  Future<void> notificationBefore15MinutesDateTime(DateTime delayedTime) async {
    var timeDelayed = delayedTime.subtract(Duration(minutes: 15));
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'second channel ID', 'second Channel title', 'second channel body',
            priority: Priority.High,
            importance: Importance.Max,
            ticker: 'test');
    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();
    NotificationDetails notificationDetails =
        NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    await flutterLocalNotificationsPlugin.schedule(
        receivedNotification.id,
        receivedNotification.title,
        receivedNotification.body,
        timeDelayed,
        notificationDetails,
        payload: receivedNotification.payload);
  }

  Future<void> notification() async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'Channel ID', 'Channel title', 'channel body',
            priority: Priority.High,
            importance: Importance.Max,
            ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails =
        NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        receivedNotification.id,
        receivedNotification.title,
        receivedNotification.body,
        notificationDetails,
        payload: receivedNotification.payload);
  }

  Future onSelectNotification(String payLoad) {
    if (payLoad != null) {
      print(payLoad);
    }
    return null;
    // we can set navigator to navigate another screen
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              print("");
            },
            child: Text("Okay")),
      ],
    );
  }
}
