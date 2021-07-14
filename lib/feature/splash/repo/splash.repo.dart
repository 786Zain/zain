import 'dart:io';
import 'package:farm_system/navigator.dart';
import 'package:farm_system/routes/router.gr.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:package_info/package_info.dart';
import 'package:supercharged/supercharged.dart';
import 'package:validators/validators.dart';

class SplashRepo extends ChangeNotifier {
  bool enableSignUpWidget = false;
  
  checkLogin() async {
    Future.delayed(2.seconds, () async {
      PackageInfo.fromPlatform().then((packageInfo) {
        if (Platform.isAndroid) {
          if (int.parse(packageInfo.buildNumber) <= 0) {
            StorageService.clearPrefs();
          }
        } else if (Platform.isIOS) {
          if (int.parse(packageInfo.buildNumber) <= 0) {
            StorageService.clearPrefs();
          }
        }
      });

      final _token = await StorageService.getToken();

      if (!isNull(_token)) {
        AppNavigator.pp(Routes.dashBoard);
      } else {
        enableSignUpWidget = true;
        notifyListeners();
      }
    });
  }
}
