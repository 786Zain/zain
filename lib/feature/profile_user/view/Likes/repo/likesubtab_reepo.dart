import 'package:farm_system/common/custom_widget.dart';
import 'package:farm_system/feature/feed/models/getFeed.model.dart';
import 'package:farm_system/feature/profile_user/view/Likes/model/likeSubTab_model.dart';
import 'package:farm_system/feature/profile_user/view/Likes/model/likesubcategory_model.dart';
import 'package:farm_system/services/error_handler.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/material.dart';


class LikeSubTabCategory extends ChangeNotifier{

  List<FeedDetail> feedList = [];
  List<likeCategory> likecategory = [];
  List<LikeSubTab> userLikecategory = [];

  List<dynamic> likeCollection = [];
  List<dynamic> likeCollectionCount = [];

  String _likeCategoryId = "";
  String get likeCategoryIdnId => _likeCategoryId;

  setLikeCategoryIdnId(id){
    _likeCategoryId=id;
    notifyListeners();
  }
  getLikeSubTabDetails() async{
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    return await _apiCall.getLikeSubTab("Bearer $auth", "false", '').then((value) {
      likecategory = value.data;
      // mediaCategory = value.data;
      print("Printing theeeeeeeeeeeeeee");
      print(value.toJson());
      notifyListeners();
      return null;
    }).catchError((e) => ErrorHandler.handleError(e));
  }

  LikeSubCategoryIndividual(String userId,String categoryId) async {
    print("subcategory id here");
    print(categoryId);
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    return await _apiCall.getLikeSubCategoryIndividual("Bearer $auth", userId,categoryId).then((value) {
      userLikecategory = value.data;

      likeCollection = value.data[0].like;
      likeCollectionCount = value.data;
      notifyListeners();

      return null;
    }).catchError((e) => ErrorHandler.handleError(e));
  }


  likeOrDislikeSubTabLike(BuildContext context, postId, postLikeArray) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    final userId = await StorageService.getUserId();
    print("aray collections");
    print(userId);
    //bool unlike = postLikeArray.contains(userId);

    bool unlike;



    userLikecategory.forEach((element) {
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

      for(int i=0; i<= userLikecategory.length - 1; i++){

        if(userLikecategory[i].id == postId){

          if(unlike == true){
            userLikecategory[i].like.remove(userId);
          }else
          {
            print('pppppp');
            print(userId);
            userLikecategory[i].like.add(userId);
          }
        }
      }


      notifyListeners();
      return null;
    }).catchError((err) {


      ErrorHandler.handleError(err);
    });
  }



  likeOrDislikeSubTabLikeComment(BuildContext context, commentId, postLikeArray) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    final userId = await StorageService.getUserId();
    print("aray collections");
    print(userId);
    //bool unlike = postLikeArray.contains(userId);

    bool unlike;



    userLikecategory.forEach((element) {
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

      for(int i=0; i<= userLikecategory.length - 1; i++){

        if(userLikecategory[i].id == commentId){

          if(unlike == true){
            userLikecategory[i].like.remove(userId);
          }else
          {
            print('pppppp');
            print(userId);
            userLikecategory[i].like.add(userId);
          }
        }
      }


      notifyListeners();
      return null;
    }).catchError((err) {


      ErrorHandler.handleError(err);
    });
  }
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