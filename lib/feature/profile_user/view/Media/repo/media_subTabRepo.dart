import 'package:farm_system/common/custom_widget.dart';
import 'package:farm_system/feature/feed/models/getFeed.model.dart';
import 'package:farm_system/feature/profile_user/view/Media/model/mediaSubTab.model.dart';
import 'package:farm_system/feature/profile_user/view/Media/model/userMedia_model.dart';
import 'package:farm_system/services/error_handler.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/material.dart';


class MediaSubTab extends ChangeNotifier{

  List<FeedDetail> feedList = [];
  List<mediaCategory> mediacategory = [];
  List<Datum> userMediaAll = [];

  List<dynamic> likeCollection = [];
  List<dynamic> likeCollectionCount = [];

  String _mediaCategoryId = "";
  String get mediaCategoryIdnId => _mediaCategoryId;

  setMediaCategoryIdnId(id){
    _mediaCategoryId=id;
    notifyListeners();
  }
  getMediaSubTabDetails() async{
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    return await _apiCall.getMediaSubTab("Bearer $auth", "false", '').then((value) {
      mediacategory = value.data;
      // mediaCategory = value.data;
      print("Printing theeeeeeeeeeeeeee");
      print(value.toJson());
      notifyListeners();
      return null;
    }).catchError((e) => ErrorHandler.handleError(e));
  }

  mediaSubCategoryIndividual(String userId,String categoryId) async {
    print("subcategory id here");
    print(categoryId);
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    return await _apiCall.getMediaSubCategoryIndividual("Bearer $auth",userId, categoryId).then((value) {
      userMediaAll = value.data;

      likeCollection = value.data[0].like;
      likeCollectionCount = value.data;
      //userAll.addAll(value.data);
      notifyListeners();

      return null;
    }).catchError((e) => ErrorHandler.handleError(e));
  }


  // likeOrDislikeSubTabMedia(BuildContext context, postId, postLikeArray) async {
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
  //   userMediaAll.forEach((element) {
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
  //     for(int i=0; i<= userMediaAll.length - 1; i++){
  //
  //       if(userMediaAll[i].id == postId){
  //
  //         if(unlike == true){
  //           userMediaAll[i].like.remove(userId);
  //         }else
  //         {
  //           print('pppppp');
  //           print(userId);
  //           userMediaAll[i].like.add(userId);
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

  likeOrDislikeSubTabMedia(BuildContext context, commentId, postLikeArray) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    final userId = await StorageService.getUserId();
    print("aray collections");
    print(userId);
    //bool unlike = postLikeArray.contains(userId);

    bool unlike;



    userMediaAll.forEach((element) {
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

      for(int i=0; i<= userMediaAll.length - 1; i++){

        if(userMediaAll[i].id == commentId){

          if(unlike == true){
            userMediaAll[i].like.remove(userId);
          }else
          {
            print('pppppp');
            print(userId);
            userMediaAll[i].like.add(userId);
          }
        }
      }


      notifyListeners();
      return null;
    }).catchError((err) {


      ErrorHandler.handleError(err);
    });
  }

  likeOrDislikSubMedia(BuildContext context, postId, postLikeArray) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    final userId = await StorageService.getUserId();
    print("aray collections");
    print(userId);
    //bool unlike = postLikeArray.contains(userId);

    bool unlike;



    userMediaAll.forEach((element) {
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

      for(int i=0; i<= userMediaAll.length - 1; i++){

        if(userMediaAll[i].id == postId){

          if(unlike == true){
            userMediaAll[i].like.remove(userId);
          }else
          {
            print('pppppp');
            print(userId);
            userMediaAll[i].like.add(userId);
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