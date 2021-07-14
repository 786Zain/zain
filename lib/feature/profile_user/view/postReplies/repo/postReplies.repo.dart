
import 'package:farm_system/feature/feed/models/getFeed.model.dart';
import 'package:farm_system/services/error_handler.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/material.dart';
import 'package:farm_system/feature/profile_user/view/postReplies/modal/postReplies.modal.dart';

class PostRepliesProfileRepo extends ChangeNotifier{


  List<PostReply> postReplies = [];
  List<FeedDetail> feedList = [];

  List<dynamic> likeCollection = [];
  List<dynamic> likeCollectionCount = [];

  postRepliesProfile(userId) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    return await _apiCall.getUserReplies("Bearer $auth",userId).then((value) {
      postReplies = value.data;
      likeCollection = value.data[0].like;
      likeCollectionCount = value.data;
      print("print the profile user data");
      print(value.data);
      notifyListeners();
      return null;
    }).catchError((e) => ErrorHandler.handleError(e));
  }




  likeOrDislikesReple(BuildContext context, postId, postLikeArray) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    final userId = await StorageService.getUserId();
    print("aray collections");
    print(userId);
    //bool unlike = postLikeArray.contains(userId);

    bool unlike;

    print('unlike value');
    print(unlike);
    postReplies.forEach((element) {
      if(element.id == postId){

        if(element.like.contains(userId)){
          unlike = true;
        }else{
          unlike = false;
        }
      }


    });

    print('Likeeeee');
    print(unlike);

    return _apiCall.likeOrDislikeComment("Bearer $auth", postId, unlike).then((data) {
      // getFeedList();
      //  userProfileAll(postId);

      for(int i=0; i<= postReplies.length - 1; i++){

        if(postReplies[i].id == postId){

          if(unlike == true){
            postReplies[i].like.remove(userId);
          }else
          {
            print('pppppp');
            print(userId);
            postReplies[i].like.add(userId);
          }
        }
      }

      notifyListeners();
      return null;
    }).catchError((err) {


      ErrorHandler.handleError(err);
    });
  }

  // likeOrDislikesReples(BuildContext context, postId, postLikeArray) async {
  //   final _apiCall = RestClient(DioClient.getDio());
  //   final auth = await StorageService.getToken();
  //   final userId = await StorageService.getUserId();
  //   bool unlike = postLikeArray.contains(userId);
  //   return _apiCall.likeOrDislike("Bearer $auth", postId, unlike).then((data) {
  //     if(data.message!="Posted user cannot like") {
  //       feedList
  //         ..asMap().forEach((index, data) =>
  //         {
  //           print(index),
  //           print(data),
  //           if (data.id == postId){
  //             !unlike ? data.like.add(userId) : data.like.remove(userId)
  //           }
  //         });
  //     }else{
  //       CustomWidget.showWarningFlushBar(context, 'Posted user cannot like their post');
  //     }
  //     notifyListeners();
  //     return null;
  //   }).catchError((err) {
  //     ErrorHandler.handleError(err);
  //   });
  // }

}