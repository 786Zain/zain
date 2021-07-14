import 'dart:convert';
import 'dart:io';
import 'package:farm_system/services/error_handler.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:farm_system/storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PushNotificationsManager {
  static FirebaseMessaging _fcm = FirebaseMessaging();
  static SharedPreferences preferences;

  static init() {
    if (Platform.isIOS) getIOSPermission();
    _fcm.getToken().then((token) async {
      print('hiiii ${token}');
      await StorageService.setDeviceToken(token);
    });

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  static void getIOSPermission() {
    _fcm.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _fcm.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      // print("Settings registered: $settings");
    });
  }

  static storeToken(String token) async {
    preferences = await SharedPreferences.getInstance();
    await preferences.setString('fcm_token', token);
    final auth = await StorageService.getToken();
    final _apiCall = RestClient(DioClient.getDio());
    Map map = {"token": token};
//    return await _apiCall.storeToken(auth, json.encode(map)).then((data) {
//      return;
//    }).catchError((e) => ErrorHandler.handleError(e));
  }
}
