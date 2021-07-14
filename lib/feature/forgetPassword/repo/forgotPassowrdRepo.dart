import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:farm_system/common/custom_widget.dart';
import 'package:farm_system/feature/otp/forget_password_otp_screen.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:farm_system/update_password/update_password.dart';
import 'package:flutter/material.dart';

import 'package:validators/validators.dart';

class ForgotPasswordRepo {
  static forgotPassword(context, String email, token) async {
    if (isNull(email)) {
      CustomWidget.showWarningFlushBar(context, "Please enter email");
    } else {
      Map map = {"email": email};

      final apiCall = RestClient(DioClient.getDio());

      apiCall.forgotPassword(token, json.encode(map)).then((data) async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ForgetPasswordOTPScreen(value: email)));
      }).catchError((err) {
        CustomWidget.showWarningFlushBar(context, err.response.data['message']);
      });
    }
  }
}
