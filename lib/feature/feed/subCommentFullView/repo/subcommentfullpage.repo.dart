import 'package:farm_system/feature/feed/models/ModelBasedonPostId.dart';
import 'package:farm_system/feature/feed/subCommentFullView/model/subcommentfullviewmodel.dart';
import 'package:farm_system/services/error_handler.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/material.dart';

class SubCommentFullPageRepo extends ChangeNotifier{

  List<Datum> subComment = [];
   Comment userData;

  getSubCommentView(parentId) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();

    return await _apiCall.getCommentFullView("Bearer $auth", parentId).then((value) {
      subComment = value.data;
      notifyListeners();
      return null;
    }).catchError((e) => ErrorHandler.handleError(e));
  }

 setUserData(Comment comment){

   userData=comment;

}

  repostNestedCommentPost(String id, repost) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    final userId = await StorageService.getUserId();
    bool unRepost = repost.contains(userId);

    _apiCall.repostSubCommentPost("Bearer $auth", id, !unRepost).then((value) {
      subComment
        ..asMap().forEach((index, data) => {
          if (data.id == id)
            {
              !unRepost
                  ? data.repost.add(userId)
                  : data.repost.remove(userId)
            }
        });
      notifyListeners();
      return null;
    }).catchError((err) {
      ErrorHandler.handleError(err);
    });
  }

  //For sub Comment
  likeOrDislikeSubComment(BuildContext context, commentId, parentId) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    final userId = await StorageService.getUserId();
    bool unlike;



    subComment.forEach((element) {
      if(element.id == commentId){

        if(element.like.contains(userId)){
          unlike = true;
        }else{
          unlike = false;
        }
      }


    });


    return _apiCall.likeOrDislikeComment("Bearer $auth", commentId, unlike).then((data) {
      getSubCommentView(parentId);

      for(int i=0; i<= subComment.length-1; i++){

        if(subComment[i].id == commentId){

          if(unlike == true){
            subComment[i].like.remove(userId);
          }else
          {
            subComment[i].like.add(userId);
          }
        }
      }

      notifyListeners();
      return null;
    }).catchError((err) {

      ErrorHandler.handleError(err);
    });
  }


}