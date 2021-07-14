import 'dart:convert';

import 'package:farm_system/common/custom_widget.dart';
import 'package:farm_system/feature/profile_setUp/profile_setup_page1.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class SetPasswordRepo {
  static bool isNumeric(String str) {
    // ignore: valid_regexps
    var s = str.replaceAll(new RegExp(r'[^a-zA-Z0-9]'), '');
    if(s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }
  static setPassword(BuildContext context, String value, String userId,
      String newValue, String userName, String password) {
    if (newValue == "Level") {
      CustomWidget.showWarningFlushBar(context, 'Please Select the Level');
    } else if (isNull(userName)) {
      CustomWidget.showWarningFlushBar(context, 'Please enter username');
    } else if (!isLength(password, 5, 40)) {
      CustomWidget.showWarningFlushBar(context, 'Password is invalid');
    } else {
      _callSetPasswordApi(context, value, userId, newValue, userName, password);
    }
  }

  static _callSetPasswordApi(BuildContext context, String value, String userId,
      String newValue, String userName, String password) {
    try {

      final _apiCall = RestClient(DioClient.getDio());
      CustomWidget.loader(true, context);
      Map map = {
        isNumeric(value) ? "mobileNumber" : "email" : value,
        "categoryType": newValue,
        "userName": userName,
        "password": password
      };

      _apiCall.setPassword(json.encode(map)).then((data) async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProfileSetupPage1(
                    value: value, password: password, userId: userId,username: userName,)));
      }).catchError((err) {
        CustomWidget.loader(false, context);
        CustomWidget.showWarningFlushBar(context, err.response.data['message']);

      });
    } catch (e) {}
  }
}
