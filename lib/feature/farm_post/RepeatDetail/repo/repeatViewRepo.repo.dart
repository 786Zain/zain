import 'dart:convert';

// import 'package:farm_system/feature/farm_post/RepeatDetail/modal/repeatFullView.modal.dart';
import 'package:farm_system/feature/farm_post/RepeatDetail/modal/repeatFullView.modal.dart';
import 'package:flutter/material.dart';
import 'package:farm_system/services/error_handler.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:farm_system/storage.dart';

class RepeatPostView extends ChangeNotifier{

  Data repeatData;

 List<Comment> commentList = [];

  List<Post> postsList = [];



  repeatPostFullView(BuildContext context, String id) async{
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    postsList.clear();
    commentList.clear();


    return await _apiCall.getRepeatFullView("Bearer $auth", id).then((values) {

      postsList.addAll(values.data.posts);
      commentList.addAll(values.data.comments);
      repeatData =values.data;
      notifyListeners();
      return null;

    }).catchError((e) => ErrorHandler.handleError(e));
  }


}