import 'dart:convert';
import 'dart:io';
import 'package:farm_system/common/custom_widget.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/dashboard/dashboard.dart';
import 'package:farm_system/feature/profile_setUp/profile_setup_page2.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:validators/validators.dart';
import 'dart:async';
import 'package:http_parser/http_parser.dart';

class ProfileSetupRepo1 {
  static selectType(BuildContext context, String value, String password,
      String userId, File file, String player) {
    selectTypeNext(context, value, password, userId, file, player);
  }

  static selectTypeNext(BuildContext context, String value, String password,
      String userId, File file, String player) async {
    CustomWidget.loader(true, context);
    Dio dio = new Dio();
    dio.options.headers["user"] = userId;
    FormData formData = new FormData();
    if (player != 'Competition level') {
      formData.fields.add(MapEntry("competition", player));
    }
    if (file != null) {
      String type = file.path.split('.').last;
      String name = file.path.split('/').last;
      String format = imageFileType().indexOf(type) != -1 ? "Image" : "Video";
      MultipartFile fileData = MultipartFile.fromFileSync(file.path,
          filename: name, contentType: MediaType(format, type));
      formData.files.add(MapEntry("image", fileData));
    }

    Response response = await dio
        //   .post('http://161.35.118.126/api/farm/profileSetup', data: formData);
        .post(BASE_API_URL + 'farm/profileSetup', data: formData);

    if (response.statusCode == 201 || response.statusCode == 200) {
      CustomWidget.loader(false, context);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileSetupPage2(
                value: value, password: password, userId: userId),
          ));
    } else {
      CustomWidget.loader(false, context);
      CustomWidget.showWarningFlushBar(context, "something went wrong");
    }
  }

//---------- SKIP -----------------

  static skipNow(BuildContext context, String value, String password,
      String userId, skipNow) {
    if (isNull(value)) {
      CustomWidget.showWarningFlushBar(context, 'Please enter email');
    } else {
      skipNowNext(context, value, password, userId, skipNow);
    }
  }

  static skipNowNext(BuildContext context, String value, String password,
      String userId, skipNow) {
    try {
      final _apiCall = RestClient(DioClient.getDio());
      _apiCall.skipNow(userId, skipNow).then((data) async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProfileSetupPage2(
                      value: value,
                      password: password,
                      userId: userId,
                      skip: skipNow,
                    )));
      }).catchError((err) {
        CustomWidget.showWarningFlushBar(context, err.response.data['message']);
      });
    } catch (e) {}
  }
}
