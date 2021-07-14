import 'dart:convert';
import 'package:farm_system/common/custom_widget.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/routes/router.gr.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:validators/validators.dart';

class LoginRepo {
  static login(BuildContext context, String value, String password) async {
    if (isNull(value)) {
      CustomWidget.showWarningFlushBar(context, 'Please provide email');
    } else if (isNull(value)
        ? true
        : isNumeric(value)
            ? false
            : !isEmail(value)) {
      CustomWidget.showWarningFlushBar(
          context, 'Please enter Email  or phone number');
    } else if (isNull(password)) {
      CustomWidget.showWarningFlushBar(context, 'Please enter password');
    } else if (!isLength(password, 6, 40)) {
      CustomWidget.showWarningFlushBar(context, 'Password is invalid');
    } else {
      _callLoginApi(context, value, password);
    }
  }

  static _callLoginApi(BuildContext context, String value, String password) async {
    try {
      final _apiCall = RestClient(DioClient.getDio());
      final token = await StorageService.getDeviceToken();
      Map map = {
        "email": isNumeric(value) ? '' : value,
        "mobileNumber": isNumeric(value) ? value : '',
        "password": password,
        "token":token
      };
      CustomWidget.loader(true, context);


      _apiCall.login(json.encode(map)).then((data) async {
        print(data.user.profilePic.length);
        String image = data.user.profilePic.length == 0
            ? "https://image.shutterstock.com/image-vector/people-icon-isolated-flat-design-600w-401277397.jpg"
            :  data.user.profilePic[0].location;

        StorageService.setToken(data.token);
        StorageService.setName(data.user.name);
        print('hgvhvhsvdhgvshvhchxhcghxvchgxhcxhc');
        var name1 = StorageService.getName();
        print(name1);
        StorageService.setUserName(data.user.userName);
        //StorageService.setUserProfile(data.user.profilePic[0].location);
        StorageService.setUserProfile(image);
        StorageService.setUserId(data.user.id);
        Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.dashBoard, (Route<dynamic> route) => false);
      }).catchError((err) {
        CustomWidget.loader(false, context);
        CustomWidget.showWarningFlushBar(context, err.response.data['message']);

      });
    } catch (e) {}
  }
}
