


import 'package:farm_system/dashboard/deatailsPost.dart';
import 'package:farm_system/feature/farm_post/RepeatDetail/view/repeatPostFull.view.dart';
import 'package:farm_system/feature/feed/models/ModelBasedonPostId.dart';
import 'package:farm_system/feature/feed/subCommentFullView/view/subcommentfull.view.dart';
import 'package:farm_system/feature/first_screen/repo/NotificationCommentModel.dart';
import 'package:farm_system/feature/first_screen/repo/NotificationModel.dart';
import 'package:farm_system/feature/first_screen/view/notification_comment.dart';
import 'package:farm_system/feature/profile_user/view/profiletab.dart';
import 'package:farm_system/services/error_handler.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/material.dart';

class NotificationRepo extends ChangeNotifier {

  List<Datum> notificationList = List<Datum>();
  List<Comment> comments = List<Comment>();
  int isNotSeenCount;
  List<Result> commentList = List<Result>();

  bool Type= false;

  getNotifications() async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    return await _apiCall
        .getNotifications("Bearer $auth")
        .then((value) {
      notificationList=value.data;
      isNotSeenCount = value.isNotSeenCount;
      notifyListeners();
      return null;
    }).catchError((e) => ErrorHandler.handleError(e));
  }


  getList(Datum notification) {
    notificationList.insert(0, notification);
    notifyListeners();
  }

    callApiBasedOnType(context,String activityType,String refrenceId) async{
     final _apiCall = RestClient(DioClient.getDio());
     final auth = await StorageService.getToken();
     print('--------------------------------------in repooooooooooooooo');
       print(activityType);
     print('--------------------------------------in repooooooooooooooo');
       print(refrenceId);
       if(activityType=="post"){
         Navigator.push(
             context,
             MaterialPageRoute(
                 builder: (context) => DetailsPost(
                   id: refrenceId,
                 )));
       }
       else if(activityType=="comment"){
         Navigator.push(
             context,
             MaterialPageRoute(
                 builder: (context) =>
                     NotificationCommentPage(
                   commentId: refrenceId,
                 )));
       }
       else if(activityType=="Follower"){
         Navigator.push(
             context,
             MaterialPageRoute(
                 builder: (context) => ProfileTab(
                   userId: refrenceId,
                 )));

       }
       else{
         print("activity type unknown");
       }
   }

  clearNotification() async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    return await _apiCall
        .clearNotification("Bearer $auth")
        .then((value) {
      notifyListeners();
      return null;
    }).catchError((e) => ErrorHandler.handleError(e));
  }


  onOffNotification(bool boolType,) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    return await _apiCall
        .OnOffNotification("Bearer $auth", boolType,)
        .then((value) {
      Type = !boolType;
      notifyListeners();
    }).catchError((e) => ErrorHandler.handleError(e));
  }

  notificationComment(String commentId) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    return await _apiCall
        .getNotificationsComment("Bearer $auth", commentId)
        .then((value) {
      commentList = value.result;
      notifyListeners();
      return null;
    }).catchError((e) => ErrorHandler.handleError(e));
  }
}