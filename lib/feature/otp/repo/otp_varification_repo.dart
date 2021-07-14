import 'dart:convert';

import 'package:farm_system/common/custom_widget.dart';
import 'package:farm_system/feature/set_password/set_password.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:dio/dio.dart';

class OtpVarificationRepo {
  static bool isNumeric(String str) {
    // ignore: valid_regexps
    var s = str.replaceAll(new RegExp(r'[^a-zA-Z0-9]'), '');
    if(s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }
  static otpVerification(
      BuildContext context, String value, String userId, String otp) {
    if (isNull(value)) {
      CustomWidget.showWarningFlushBar(context, 'Invalid Email');
    } else if (isNull(otp)) {
      CustomWidget.showWarningFlushBar(context, 'Please Enter Again OTP');
    } else {
      print('here is otp ${otp}');
      _callOtpVericationApi(context, value, userId, otp);
    }
  }

  static _callOtpVericationApi(
      BuildContext context, String value, String userId, String otp) {
    final _apiCall = RestClient(DioClient.getDio());
    CustomWidget.loader(true, context);
    Map map = {
      isNumeric(value) ? 'mobileNumber' : 'email': value,
      "otp": otp
    };
    _apiCall.varifyOtp(json.encode(map)).then((data) async {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  SetPasswordScreen(value: value, userId: userId)));
    }).catchError((err) {
      CustomWidget.loader(false, context);
      CustomWidget.showWarningFlushBar(context, err.response.data['message']);
    });
  }
}
