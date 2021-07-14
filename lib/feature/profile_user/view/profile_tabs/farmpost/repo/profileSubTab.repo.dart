import 'package:farm_system/common/custom_widget.dart';
import 'package:farm_system/feature/feed/models/getFeed.model.dart';
import 'package:farm_system/feature/profile_user/view/profile_tabs/farmpost/modal/profileSubCategoryIndividual.modal.dart';
import 'package:farm_system/feature/profile_user/view/profile_tabs/farmpost/modal/profileSubTab.modal.dart';
import 'package:farm_system/services/error_handler.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/material.dart';


class ProfileSubTab extends ChangeNotifier{

  List<FeedDetail> feedList = [];
  List<Datum> feedCategory = [];

  List<Datums> userAll = [];


  List<dynamic> likeCollection = [];
  List<dynamic> likeCollectionCount = [];

  String _profileCategoryId = "";
  String get profileCategoryIdnId => _profileCategoryId;

  setProfileCategoryIdnId(id){
    _profileCategoryId=id;
    notifyListeners();
  }
  getProfileSubTabDetails() async{
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    return await _apiCall.getProfileSubTab("Bearer $auth", "false", '').then((value) {


      feedCategory = value.data;
      print("Printing theeeeeeeeeeeeeee");
      print(value.toJson());
      notifyListeners();
      return null;
    }).catchError((e) => ErrorHandler.handleError(e));
  }

  profileSubCategoryIndividual(String userId, String categoryId) async {
    print("subcategory id here");
    print(categoryId);
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    return await _apiCall.getProfileSubCategoryIndividual("Bearer $auth",userId, categoryId).then((value) {
      userAll = value.data;
      likeCollection = value.data[0].like;
      likeCollectionCount = value.data;
      //userAll.addAll(value.data);
      notifyListeners();

      return null;
    }).catchError((e) => ErrorHandler.handleError(e));
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


  likeOrDislikeAllTabFarm(BuildContext context, postId, postLikeArray) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    final userId = await StorageService.getUserId();
    print("aray collections");
    print(userId);
    //bool unlike = postLikeArray.contains(userId);

    bool unlike;

    print('unlike value');
    print(unlike);
    userAll.forEach((element) {
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
      //  userProfileAll(postId);

      for(int i=0; i<= userAll.length - 1; i++){

        if(userAll[i].id == postId){

          if(unlike == true){
            userAll[i].like.remove(userId);
          }else
          {
            print('pppppp');
            print(userId);
            userAll[i].like.add(userId);
          }
        }
      }
      // if (data.message == "Posted user $postLikeArray  $unlike like") {
      //   Flushbar(
      //     // There is also a messageText property for when you want to
      //     // use a Text widget and not just a simple String
      //     message: 'Posted user cannot like',
      //     // Even the button can be styled to your heart's content
      //     mainButton: FlatButton(
      //       child: Text(
      //         'Click Me',
      //         style: TextStyle(color: Theme.of(context).accentColor),
      //       ),
      //       onPressed: () {},
      //     ),
      //     duration: Duration(seconds: 3),
      //     // Show it with a cascading operator
      //   )..show(context);
      //   // feedList
      //   //   ..asMap().forEach((index, data) => {
      //   //         print(index),
      //   //         print(data),
      //   //         if (data.id == postId)
      //   //           {!unlike ? data.like.add(userId) : data.like.remove(userId)}
      //   //       });
      // } else {
      //   Flushbar(
      //     // There is also a messageText property for when you want to
      //     // use a Text widget and not just a simple String
      //     message: '${data.message}  $postLikeArray   $unlike',
      //     // Even the button can be styled to your heart's content
      //     mainButton: FlatButton(
      //       child: Text(
      //         'Click Me',
      //         style: TextStyle(color: Theme.of(context).accentColor),
      //       ),
      //       onPressed: () {},
      //     ),
      //     duration: Duration(seconds: 3),
      //     // Show it with a cascading operator
      //   )..show(context);
      // }

      notifyListeners();
      return null;
    }).catchError((err) {
      // Flushbar(
      //   // There is also a messageText property for when you want to
      //   // use a Text widget and not just a simple String
      //   message: '${err.message}  $postLikeArray   $unlike',
      //   // Even the button can be styled to your heart's content
      //   mainButton: FlatButton(
      //     child: Text(
      //       'Click Me',
      //       style: TextStyle(color: Theme.of(context).accentColor),
      //     ),
      //     onPressed: () {},
      //   ),
      //   duration: Duration(seconds: 3),
      //   // Show it with a cascading operator
      // )..show(context);

      ErrorHandler.handleError(err);
    });
  }


}