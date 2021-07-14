import 'dart:convert';

import 'package:farm_system/common/custom_widget.dart';
import 'package:farm_system/feature/set_password/set_password.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:farm_system/update_password/update_password.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:dio/dio.dart';

class OtpVarificationNewRepo1 {
  static otpVarification(BuildContext context, String value, String otp) {
    print('bjkbkbjknj');
    print(value);
    print(otp);
    if (isNull(value)) {
      CustomWidget.showWarningFlushBar(context, 'Invalid Email');
    } else if (isNull(otp)) {
      CustomWidget.showWarningFlushBar(context, 'Please Enter Again OTP');
    } else {
      _callOtpVaricationApi(context, value, otp);
    }
  }

  static _callOtpVaricationApi(BuildContext context, String value, String otp) {
    try {
      final _apiCall = RestClient(DioClient.getDio());
      Map map = {"email": value, "otp": otp};
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UpdatePasswordScreen(
                value: value,
                otp: otp,
              )));
      // _apiCall.varifyOtp(json.encode(map)).then((data) async {
      //   // Navigator.push(
      //   //     context,
      //   //     MaterialPageRoute(
      //   //         builder: (context) => UpdatePasswordScreen(
      //   //               value: value,
      //   //               otp: otp,
      //   //             )));
      // }).catchError((err) {
      //   CustomWidget.showWarningFlushBar(context, err.response.data['message']);
      // });
    } catch (e) {}
  }
}
