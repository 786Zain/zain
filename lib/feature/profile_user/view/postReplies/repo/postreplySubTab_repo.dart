import 'package:farm_system/common/custom_widget.dart';
import 'package:farm_system/feature/feed/models/getFeed.model.dart';
import 'package:farm_system/feature/profile_user/view/postReplies/modal/PRsubTab_model.dart';
import 'package:farm_system/feature/profile_user/view/postReplies/modal/PRsubcategory_model.dart';
import 'package:farm_system/feature/profile_user/view/postReplies/modal/postReplies.modal.dart';
import 'package:farm_system/services/error_handler.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/material.dart';


class PostReplySubTabrepo extends ChangeNotifier{

  List<FeedDetail> feedList = [];
  List<postreplyCategory> postreplycategory = [];
  List<PostReply> userPostReply;

  List<dynamic> likeCollection = [];
  List<dynamic> likeCollectionCount = [];
  String _replyCategoryId = "";
  String get replyCategoryIdnId => _replyCategoryId;

  setreplyCategoryIdnId(id){
    _replyCategoryId=id;
    notifyListeners();
  }
  getReplySubTabDetails() async{
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    return await _apiCall.getPostReplySubTab("Bearer $auth", "false",'').then((value) {
      postreplycategory = value.data;
      print("Printing theeeeeeeeeeeeeee");
      print(value.data);
      print(value.toJson());
      notifyListeners();
      return null;
    }).catchError((e) => ErrorHandler.handleError(e));
  }


  PostReplySubCategoryIndividual(String userId,String categoryId) async {
    print("subcategory id here");
    print(categoryId);
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    return await _apiCall.getPostReplySubCategoryIndividual("Bearer $auth",userId,categoryId).then((value) {
    userPostReply =value.data;
    likeCollection = value.data[0].like;
    likeCollectionCount = value.data;
    notifyListeners();
    return null;
    }).catchError((e) => ErrorHandler.handleError(e));
  }

  likeOrDisPostProfileSubTab(BuildContext context, commentId, postLikeArray) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    final userId = await StorageService.getUserId();
    print("aray collections");
    print(userId);
    //bool unlike = postLikeArray.contains(userId);

    bool unlike;



    userPostReply.forEach((element) {
      if(element.id == commentId){

        if(element.like.contains(userId)){
          unlike = true;
        }else{
          unlike = false;
        }
      }


    });

    print('Likeeeee');
    print(unlike);

    return _apiCall.likeOrDislikeComment("Bearer $auth", commentId, unlike).then((data) {
      // getFeedList();
      // getFeedUserInfo(postId);

      for(int i=0; i<= userPostReply.length - 1; i++){

        if(userPostReply[i].id == commentId){

          if(unlike == true){
            userPostReply[i].like.remove(userId);
          }else
          {
            print('pppppp');
            print(userId);
            userPostReply[i].like.add(userId);
          }
        }
      }


      notifyListeners();
      return null;
    }).catchError((err) {


      ErrorHandler.handleError(err);
    });
  }

  // likeOrDisPostProfileSubTab(BuildContext context, postId, postLikeArray) async {
  //   final _apiCall = RestClient(DioClient.getDio());
  //   final auth = await StorageService.getToken();
  //   final userId = await StorageService.getUserId();
  //   print("aray collections");
  //   print(userId);
  //   //bool unlike = postLikeArray.contains(userId);
  //
  //   bool unlike;
  //
  //
  //
  //   userPostReply.forEach((element) {
  //     if(element.id == postId){
  //
  //       if(element.like.contains(userId)){
  //         unlike = true;
  //       }else{
  //         unlike = false;
  //       }
  //     }
  //
  //
  //   });
  //
  //   print('Likeeeee');
  //   print(unlike);
  //
  //   return _apiCall.likeOrDislike("Bearer $auth", postId, unlike).then((data) {
  //     // getFeedList();
  //     // getFeedUserInfo(postId);
  //
  //     for(int i=0; i<= userPostReply.length - 1; i++){
  //
  //       if(userPostReply[i].id == postId){
  //
  //         if(unlike == true){
  //           userPostReply[i].like.remove(userId);
  //         }else
  //         {
  //           print('pppppp');
  //           print(userId);
  //           userPostReply[i].like.add(userId);
  //         }
  //       }
  //     }
  //
  //
  //     notifyListeners();
  //     return null;
  //   }).catchError((err) {
  //
  //
  //     ErrorHandler.handleError(err);
  //   });
  // }

  likeOrDislikeSubCategoryIndividual(BuildContext context, postId, postLikeArray) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    final userId = await StorageService.getUserId();
    bool unlike = postLikeArray.contains(userId);
    return _apiCall.likeOrDislike("Bearer $auth", postId, unlike).then((data) {
      if(data.message!="Posted user cannot like") {
        feedList
          ..asMap().forEach((index, data) =>
          {
            print(index),
            print(data),
            if (data.id == postId){
              !unlike ? data.like.add(userId) : data.like.remove(userId)
            }
          });
      }else{
        CustomWidget.showWarningFlushBar(context, 'Posted user cannot like their post');
      }
      notifyListeners();
      return null;
    }).catchError((err) {
      ErrorHandler.handleError(err);
    });
  }


}