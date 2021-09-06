import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

import 'dosya_indir.dart';

class LocalNotification {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  var initSetting;
  BehaviorSubject<ReceiveNotifications>
      get didReceiveLocalNotificationSubject =>
          BehaviorSubject<ReceiveNotifications>();
  LocalNotification() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
        onDidReceiveLocalNotification: (id, title, body, payload) async {
          ReceiveNotifications notification = ReceiveNotifications(
              id: id, title: title, body: body, payload: payload);
          didReceiveLocalNotificationSubject.add(notification);
        });
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  setOnNotificationReceive(Function onNotificationReceive) {
    didReceiveLocalNotificationSubject.listen((notification) {
      onNotificationReceive(notification);
    });
  }

  setOnNotificationClick(Function onNotificationClick) async {
    await flutterLocalNotificationsPlugin.initialize(initSetting,
        onSelectNotification: (String? payload) async {
      onNotificationClick(payload);
    });
  }

  static Future _notificationDetails(image_link) async {
    final bigPicturePath = await Indir.dosyaIndir(
      image_link,
      'bigPicture',
    );

    final _styleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
    );

    final sound = 'notification_sound.mp3';
    var androidChannel = AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      'CHANNEL_DESCRIPTION',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      styleInformation: _styleInformation,
      sound: RawResourceAndroidNotificationSound(sound.split('.').first),
    );
    var iosChannel = IOSNotificationDetails();
    return NotificationDetails(android: androidChannel, iOS: iosChannel);
  }

  saatlikBildirimGonder(int id, String title, String body, String image_link,
      String payload) async {
    await flutterLocalNotificationsPlugin.periodicallyShow(
      id,
      title,
      body,
      RepeatInterval.hourly,
      await _notificationDetails(image_link),
      payload: payload,
      androidAllowWhileIdle: true,
    );
  }

  Future<void> gunlukBildirimGonder(int id, String title, String body,
      Time saat, String image_link, String payload) async {
    await flutterLocalNotificationsPlugin.showDailyAtTime(
      id,
      title,
      body,
      saat,
      await _notificationDetails(image_link),
      payload: payload,
    );
  }

  void deleteNotificationPlan(int id) {
    flutterLocalNotificationsPlugin.cancel(id);
  }
}

class ReceiveNotifications {
  late final int id;
  late final String? title;
  late final String? body;
  late final String? payload;
  ReceiveNotifications(
      {required this.id,
      required this.title,
      required this.body,
      required this.payload});
}
