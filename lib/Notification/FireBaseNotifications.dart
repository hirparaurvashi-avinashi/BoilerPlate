
import 'dart:convert';
import 'dart:io';

import 'package:boilerplate/Constants/Config.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class FireBaseNotificationEvents {
  Function tapOnNotification;
  Function onSelectLocalNotification;
  Function getTokenEvent;
  Function getOnMessageEvent;
  Function getOnResumeMessageEvent;
  Function getOnLaunchMessageEvent;

  FireBaseNotificationEvents(Function tapOnNotifications,Function onSelectionOfLocalNotification,Function getTokenEvents,
      Function getMesageEvent,
      Function getOnResumeMessageEvents,
      Function getOnLaunchMessageEvents
      ){
    tapOnNotification = tapOnNotifications;
    onSelectLocalNotification = onSelectionOfLocalNotification;
    getTokenEvent = getTokenEvents;
    getOnMessageEvent = getMesageEvent;
    getOnResumeMessageEvent = getOnResumeMessageEvents;
    getOnLaunchMessageEvent = getOnLaunchMessageEvents;
  }

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  static FlutterLocalNotificationsPlugin notifications;

  void iOSPermission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  void intializeLocalNotification() {
    var initSettingsAndroid =
    new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initSettingsIos = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initSettings =
    new InitializationSettings(initSettingsAndroid, initSettingsIos);
    notifications = new FlutterLocalNotificationsPlugin();
    notifications.initialize(initSettings,
        onSelectNotification: onSelectNotification);
  }

  // ignore: missing_return
  Future onDidReceiveLocalNotification(int id, String title, String body,
      String payload) {
    print(payload);
  }

  Future onTapNotification(Map<String, dynamic> payload) async {
    tapOnNotification(payload);
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      final message = json.decode(payload);
      var jsonData = new Map<String, dynamic>.from(message);
      onSelectLocalNotification(jsonData);
      tapOnNotification(jsonData);
    }
  }

  static Future<String> _downloadAndSaveImage(String url, String fileName) async {
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/$fileName';
    var response = await http.get(url);
    var file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  static void showNotification(Map<String, dynamic> jsonData,String imageURL) async {
    var jsonString = json.encode(jsonData);
    print(jsonString);

    var largeIconPath = await _downloadAndSaveImage(
  //        'https://lh3.googleusercontent.com/PW1VIV6Z6q_aRuIqdEJmEUSKoKLSMRo9gQe0LFODfLX0cjFQp-1djP5lleTk_tmk-g',
    imageURL,
    'largeIcon');
    var bigPicturePath =
        await _downloadAndSaveImage(jsonData["data"]["image"], 'bigPicture');
    String title = "";
    String message = "";

    var bigPictureStyleInformation = BigPictureStyleInformation(
        FilePathAndroidBitmap(bigPicturePath),
        largeIcon: FilePathAndroidBitmap(largeIconPath)
    );

    var androidSpecifics = new AndroidNotificationDetails(
        Config.appChannelIDorNotification, Config.applicationName, Config.applicationName,
        styleInformation: bigPictureStyleInformation,
        importance: Importance.Max,
        priority: Priority.High,
        ticker: 'ticker');

    var iosSpecifics = new IOSNotificationDetails();
    var channelSpecific =
    new NotificationDetails(androidSpecifics, iosSpecifics);

    title = jsonData['notification']['body'];
    message = jsonData['notification']['title'];
    await notifications.show(1, title, message, channelSpecific,
        payload: jsonString);
  }


  void fireBaseCloudMessagingListeners() {
    if (Platform.isIOS) iOSPermission();

    _firebaseMessaging.getToken().then((token) {
      getTokenEvent(token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        getOnMessageEvent(message);
      },
      onResume: (Map<String, dynamic> message) async {
        getOnResumeMessageEvent(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        getOnLaunchMessageEvent(message);
      },
    );
  }

}