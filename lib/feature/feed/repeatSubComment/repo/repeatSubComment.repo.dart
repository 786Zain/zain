import 'dart:convert';

import 'package:farm_system/dashboard/dashboard.dart';
import 'package:farm_system/services/error_handler.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/material.dart';


class RepeatSubCommentRepo extends ChangeNotifier{



  repeatSubCommentPost(BuildContext context, String id, String repeatCaption) async{
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();

    Map map =
    {
      "commentMessage": repeatCaption,
      "parentId" : id,
    };

    return await _apiCall.postRepeatFromPost("Bearer $auth", json.encode(map)).then((value) {


      // subCategory = value.data;
      // feedSubCategory
      //   ..asMap().forEach((index, data) => {
      //     print(index),
      //     print(data),
      //   });

      notifyListeners();
      Navigator.pop(context);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => DashBoard()),
      // );
      return null;

    }).catchError((e) => ErrorHandler.handleError(e));
  }


}