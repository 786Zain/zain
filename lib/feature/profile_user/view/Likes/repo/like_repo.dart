import 'package:farm_system/common/custom_widget.dart';
import 'package:farm_system/feature/feed/models/getFeed.model.dart';
import 'package:farm_system/feature/profile_user/view/Likes/model/Like_model.dart';
import 'package:farm_system/services/error_handler.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../storage.dart';

class LikeDetails extends ChangeNotifier {
  List<Datum> userLikesAll = [];
  List<FeedDetail> feedListLike = [];

  List<dynamic> likeCollection = [];
  List<dynamic> likeCollectionCount = [];

  getUserLikes(userId) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    return await _apiCall.getUserLikeAll("Bearer $auth",userId).then((value) {
      print(value.data);
      userLikesAll = value.data;
      likeCollection = value.data[0].like;
      likeCollectionCount = value.data;
      notifyListeners();
      return null;
    }).catchError((e) => ErrorHandler.handleError(e));
  }


  likeOrDislikeTabLike(BuildContext context, postId, postLikeArray) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    final userId = await StorageService.getUserId();
    print("aray collections");
    print(userId);
    //bool unlike = postLikeArray.contains(userId);

    bool unlike;



    userLikesAll.forEach((element) {
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

    return _apiCall.likeOrDislike("Bearer $auth", postId, unlike).then((data) {
      // getFeedList();
      // getFeedUserInfo(postId);

      for(int i=0; i<= userLikesAll.length - 1; i++){

        if(userLikesAll[i].id == postId){

          if(unlike == true){
            userLikesAll[i].like.remove(userId);
          }else
          {
            print('pppppp');
            print(userId);
            userLikesAll[i].like.add(userId);
          }
        }
      }


      notifyListeners();
      return null;
    }).catchError((err) {


      ErrorHandler.handleError(err);
    });
  }

  likeOrDislikeTabLikeComment(BuildContext context, commentId, postLikeArray) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    final userId = await StorageService.getUserId();
    print("aray collections");
    print(userId);
    //bool unlike = postLikeArray.contains(userId);

    bool unlike;



    userLikesAll.forEach((element) {
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

      for(int i=0; i<= userLikesAll.length - 1; i++){

        if(userLikesAll[i].id == commentId){

          if(unlike == true){
            userLikesAll[i].like.remove(userId);
          }else
          {
            print('pppppp');
            print(userId);
            userLikesAll[i].like.add(userId);
          }
        }
      }


      notifyListeners();
      return null;
    }).catchError((err) {


      ErrorHandler.handleError(err);
    });
  }

  // likeOrDislikes(BuildContext context, postId, postLikeArray) async {
  //   final _apiCall = RestClient(DioClient.getDio());
  //   final auth = await StorageService.getToken();
  //   final userId = await StorageService.getUserId();
  //   bool unlike = postLikeArray.contains(userId);
  //   return _apiCall.likeOrDislike("Bearer $auth", postId, unlike).then((data) {
  //     if (data.message != "Posted user cannot like") {
  //       feedListLike
  //         ..asMap().forEach((index, data) => {
  //               print(index),
  //               print(data),
  //               if (data.id == postId)
  //                 {!unlike ? data.like.add(userId) : data.like.remove(userId)}
  //             });
  //     } else {
  //       CustomWidget.showWarningFlushBar(
  //           context, 'Posted user cannot like their post');
  //     }
  //     notifyListeners();
  //     return null;
  //   }).catchError((err) {
  //     ErrorHandler.handleError(err);
  //   });
  // }
}
