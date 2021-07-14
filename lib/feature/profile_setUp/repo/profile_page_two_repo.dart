import 'dart:convert';
import 'package:farm_system/common/custom_widget.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/routes/router.gr.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class ProfileSetupTwoRepo {
  static bool isNumeric(String str) {
    // ignore: valid_regexps
    var s = str.replaceAll(new RegExp(r'[^a-zA-Z0-9]'), '');
    if(s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }
  static profileTwo(BuildContext context, String bio, String city, String state,
      String website, String value, String password, String userId) {
    selectTypeNext(context, bio, city, state, website, value, password, userId);
  }

  static selectTypeNext(
      BuildContext context,
      String bio,
      String city,
      String state,
      String website,
      String value,
      String password,
      String userId) {
    try {
      final _apiCall = RestClient(DioClient.getDio());
      Map map = {"bio": bio, "city": city, "state": state, "website": website};
      _apiCall.uploadProfileTwo(userId, json.encode(map)).then((data) async {
        Map map = {
          "email": isNumeric(value) ? '' : value,
          "mobileNumber": isNumeric(value) ? value : '',
          "password": password,
        };
        print('profile page 2');
       print(map);
        _apiCall.login(json.encode(map)).then((data) async {
          String image = data.user.profilePic.length == 0
              ? "https://image.shutterstock.com/image-vector/people-icon-isolated-flat-design-600w-401277397.jpg"
              : data.user.profilePic[0].location;
          StorageService.setToken(data.token);
          StorageService.setUserName(data.user.userName);
          StorageService.setName(data.user.name);
          StorageService.setUserProfile(image);
          StorageService.setUserId(data.user.id);
          Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.dashBoard, (Route<dynamic> route) => false);
        }).catchError((err) {
          CustomWidget.showWarningFlushBar(
              context, err.response.data['message']);
        });
      }).catchError((err) {
        CustomWidget.showWarningFlushBar(context, err.response.data['message']);
      });
    } catch (e) {}
  }

  //---------- SKIP -----------------

  static skipNow(BuildContext context, String value, String password,
      String userId, bool skipNow) {
    print('sfhdhdsbshbd');
    print(value);
    if (isNull(value)) {
      CustomWidget.showWarningFlushBar(context, 'Please Pass email');
    } else {
      skipNowNext(context, value, password, userId, skipNow);
    }
  }

  static skipNowNext(BuildContext context, String value, String password,
      String userId, skipNow) {
    try {
      final _apiCall = RestClient(DioClient.getDio());
      Map map = {
        "email": isNumeric(value) ? '' : value,
        "mobileNumber": isNumeric(value) ? value : '',
        "password": password,
      };
      CustomWidget.loader(true, context);
      _apiCall.login(json.encode(map)).then((data) async {
        print(data.user.profilePic.length);
        String image = data.user.profilePic.length == 0
            ? "https://image.shutterstock.com/image-vector/people-icon-isolated-flat-design-600w-401277397.jpg"
            : data.user.profilePic[0].location;

        StorageService.setToken(data.token);
        StorageService.setName(data.user.name);
        StorageService.setUserName(data.user.userName);
        StorageService.setUserProfile(image);
        StorageService.setUserId(data.user.id);
        Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.dashBoard, (Route<dynamic> route) => false);
      }).catchError((err) {
        CustomWidget.showWarningFlushBar(context, err.response.data['message']);
      });
    } catch (e) {}
  }
}
