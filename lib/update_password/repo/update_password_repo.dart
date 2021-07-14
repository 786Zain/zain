import 'dart:convert';
import 'package:farm_system/common/custom_widget.dart';
import 'package:farm_system/feature/login/login.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class UpdatePasswordRepo {
  static otpVarification(BuildContext context, String email, String otp,
      String password) {
    if (isNull(email)) {
      CustomWidget.showWarningFlushBar(context, 'Invalid Email');
    } else if (!isEmail(email)) {
      CustomWidget.showWarningFlushBar(context, 'Please enter valid email');
    } else if (isNull(otp)) {
      CustomWidget.showWarningFlushBar(context, 'Please otp');
    } else {
      //print('here is otp ${otp}');
      _callOtpVaricationApi(context, email, otp, password);
    }
  }

  static _callOtpVaricationApi(
      BuildContext context, email, otp, password) {
    try {
      final _apiCall = RestClient(DioClient.getDio());
      Map map = {
        "email" : email,
        "otp" : otp,
        "newPassword": password
      };

      _apiCall
          .setNewPassowrdNew(json.encode(map))
          .then((data) async {
        Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => LoginPage(isRestPassword: true)),
          (Route<dynamic> route) => false,
        );
      }).catchError((err) {
        CustomWidget.showWarningFlushBar(context, err.response.data['message']);
      });
    } catch (e) {}
  }
}
