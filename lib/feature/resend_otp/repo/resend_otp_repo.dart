import 'dart:convert';

import 'package:farm_system/common/custom_widget.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:dio/dio.dart';

class ResendOTPRepo {
  static bool isNumeric(String str) {
    // ignore: valid_regexps
    var s = str.replaceAll(new RegExp(r'[^a-zA-Z0-9]'), '');
    if(s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }
  static resendOTP(BuildContext context, String value,String userId) {
    print('saagaravsh');
    print(value);
    print(userId);
    if (isNull(value)) {
      CustomWidget.showWarningFlushBar(context, 'Please provide email');
    }  else {
      // stl();
      try {
        final _apiCall = RestClient(DioClient.getDio());
        Map map = {
          isNumeric(value) ? "mobileNumber" : "email" : value,
          "_id": userId,
        };

        _apiCall.resendOTP(json.encode(map)).then((data) async {
          print('sagarvalue');
          print( isNumeric(value));
          //String value1 = "mobileNumber" ;
          Future.delayed(const Duration(milliseconds: 300), () {
            if (isNumeric(value) == true) {
              CustomWidget.showSuccessFlushBar(
                  context, "Please Check your Phone!");
            }else {
              CustomWidget.showSuccessFlushBar(
                  context, "Please Check your email!");
            }
          });
        }).catchError((err) {
          final error = (err as DioError).response;
          print('here is the status code ${error.statusCode}');
          if (error.statusCode == 500) {
            CustomWidget.showSuccessFlushBar(
                context, "Please make sure your email is correct!");
          } else {
            CustomWidget.showWarningFlushBar(context, 'Something went wrong');
          }
        });
      } catch (e) {
        print(e);
      }
    }
  }

  static _callResendOTPApi(BuildContext context, String email) {
    // try {
    //   final _apiCall = RestClient(DioClient.getDio());
    //   Map map = {"email": email};

    //   _apiCall.resendOTP(json.encode(map)).then((data) async {
    //             stol();

    //     String permission = "granted";
    //     Future.delayed(const Duration(milliseconds: 300), () {
    //       if (permission == "granted") {
    //          CustomWidget.showSuccessFlushBar(
    //         context, "Please Check your email!");

    //       } else {

    //       }
    //     });
    //   }).catchError((err) {
    //      final error = (err as DioError).response;
    //     if (error.statusCode == 500) {
    //       CustomWidget.showSuccessFlushBar(
    //         context, "Please make sure your email is correct!");

    //     } else {
    //       CustomWidget.showWarningFlushBar(context, 'Something went wrong');
    //     }
    //   });
    // } catch (e) {}
  }
}
