
import 'package:farm_system/services/error_handler.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/material.dart';

class DeleteCommentRepo extends ChangeNotifier{

  //List<DatumModel> nestedComment = [];

  deletePostComment(commentId) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();

    return await _apiCall.deletecomment("Bearer $auth", commentId).then((values) {

      print("Succesfull Delete ");
      return null;
    }).catchError((e) => ErrorHandler.handleError(e));
  }

}