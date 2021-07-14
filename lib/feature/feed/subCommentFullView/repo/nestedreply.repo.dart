
// import 'package:farm_system/feature/feed/subCommentFullView/model/nestedreplyview.modal.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/feed/subCommentFullView/model/nestedreplyview.modal.dart';
import 'package:farm_system/services/error_handler.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/material.dart';

class NestedReplyRepo extends ChangeNotifier{


  List<DatumModel> nestedComment = [];
  List<DatumModel> oldNerstedComment = [];

  List<List<DatumModel>> nestView = [];

 // List<dynamic> nestedLikes = [];

  getNestedReplyCommentView(parentId) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    oldNerstedComment=nestedComment;
    return await _apiCall.getNestedReplyView("Bearer $auth", parentId).then((values) {

      nestedComment = values.data;

      // nestedComment.forEach((element) {
      //
      //   nestedLikes.add({'id': element.id, 'like': element.like });
      //
      //
      // });

      print("sub comment details of shdkhkhkjhakhs dkfkasd");
      print(nestedComment);
      return null;
    }).catchError((e) => ErrorHandler.handleError(e));
  }


  repostNestedLoopCommentPost(String id, repost) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    final userId = await StorageService.getUserId();
    bool unRepost = repost.contains(userId);

    _apiCall.repostSubCommentPost("Bearer $auth", id, !unRepost).then((value) {
      nestedComment
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


  //For Nested Comment
  likeOrDislikeNestedComment(BuildContext context, commentId, String view, List userLike) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    final userId = await StorageService.getUserId();
    bool unlike;
    if(view=='listView'){
      nestedComment.forEach((element) {
        if(element.id == commentId){
          if(element.like.contains(userId)){
            unlike = true;
          }else{
            unlike = false;
          }
        }
      });
    }

    if(view=='fullView'){
      if(userLike.contains(userId)){
        unlike=true;
      }else{
        unlike=false;
      }
    }

    return _apiCall.likeOrDislikeComment("Bearer $auth", commentId, unlike).then((data) {
      if(view=='listView') {
        for (int i = 0; i <= nestedComment.length; i++) {
          if (nestedComment[i].id == commentId) {
            if (unlike == true) {
              nestedComment[i].like.remove(userId);
              notifyListeners();
            } else {
              nestedComment[i].like.add(userId);
              notifyListeners();
            }
          }
        }
      }

      if(view=='fullView'){
        if(userLike.contains(userId)){
          unlike=true;
        }else{
          unlike=false;
        }
      }

      notifyListeners();
      return null;
    }).catchError((err) {

      ErrorHandler.handleError(err);
    });
  }

}