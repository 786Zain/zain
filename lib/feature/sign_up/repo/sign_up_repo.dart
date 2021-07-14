import 'dart:convert';
import 'package:farm_system/common/custom_widget.dart';
import 'package:farm_system/feature/login/login.dart';
import 'package:farm_system/feature/otp/otp.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class SignUpRepo {
  static bool isNumeric(String str) {
    // ignore: valid_regexps
    var s = str.replaceAll(new RegExp(r'[^a-zA-Z0-9]'), '');
    if(s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }
  static register(BuildContext context, String firstName,String lastName, String value, String dob) {
    print('value to be printed');
    print(value);
    if (isNull(firstName)) {
      CustomWidget.showWarningFlushBar(context, 'Please provide First name');
      return false;
    } else if(isNull(lastName)){
      CustomWidget.showWarningFlushBar(context, 'Please provide Last name');
      return false;
    }
    var type = isNumeric(value) ? 'mobileNumber' : 'email';
    if (type == 'mobileNumber'){
      // ignore: unrelated_type_equality_checks
      if(RegExp(r'^[+][1][/(][0-9]|^[+][1][0-9]|^[+][1][/ ][0-9]').hasMatch(value) == false){
        CustomWidget.showWarningFlushBar(context, 'Number Should Start with a Valid country code');
        return false;
      }
      var phoneValid = RegExp(r'^[+][1](\+{0,})(\d{0,})([(]{1}\d{1,3}[)]{0,}){0,}(\s?\d+|\+\d{2,3}\s{1}\d+|\d+){1}[\s|-]?\d+([\s|-]?\d+){1,2}(\s){0,}$')
          .hasMatch(value);
       print(phoneValid);
      if (phoneValid == false){
        CustomWidget.showWarningFlushBar(context, 'Please enter Valid number');
        return false;
      }
    }else {
      var emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value);
      if(isNull(value)){
        CustomWidget.showWarningFlushBar(context, 'Please enter Email or Phone Number');
        return false;
      }
      if (emailValid == false){
        CustomWidget.showWarningFlushBar(context, 'Please enter Valid Email');
        return false;
      }
    }
    if (isNull(dob)) {
      CustomWidget.showWarningFlushBar(context, 'Please enter DOB');
    } else {
      _callSignUpApi(context, firstName,lastName, value, dob);
    }
  }

  static _callSignUpApi(
      BuildContext context, String firstName,String lastName, String value, String birthDate) {
    try {
      final _apiCall = RestClient(DioClient.getDio());
      Map map = {
        "name": firstName +" "+ lastName,
        isNumeric(value) ? 'mobileNumber' : 'email': value,
        "birthDate": birthDate
      };
      CustomWidget.loader(true, context);
      print(map);
      _apiCall.register(json.encode(map)).then((data) async {
        await StorageService.setResendUserId(data.id);
        if(data.message != 'OTP Already Sent') {
           CustomWidget.loader(false, context);
          return Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Otp(value: value, userId: data.id)));
        }else{
          CustomWidget.loader(false, context);
          CustomWidget.showWarningFlushBar(context, 'Email or Phone Number Already Exist');
        }
      }).catchError((err) {
        CustomWidget.loader(false, context);
        CustomWidget.showWarningFlushBar(context, 'Please Enter valid Number Format\nEx:+1123 456-7895');
      });
    } catch (e) {
      CustomWidget.loader(false, context);
    }
  }
}
