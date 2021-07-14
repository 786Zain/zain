import 'package:farm_system/feature/message/models/follows.model.dart';
import 'dart:convert';

import 'package:farm_system/feature/profile_user/model/UserProfileInfoModel.dart';
import 'package:farm_system/services/error_handler.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ProfileRepo extends ChangeNotifier {
  Data _userProfileDeatils = Data();

  Data get userProfileDeatils => _userProfileDeatils;
  bool isFollowing;



  resetRepo() {
    _userProfileDeatils = Data();
  }

  getUserProfileInfo(userId) async {
    _userProfileDeatils = Data();
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    _apiCall.userInfoBasedOnId("Bearer $auth", userId).then((value) {
      print("-------------###################-------------------");
      _userProfileDeatils = value.data;
      isFollowing = value.isFollowing;
      notifyListeners();
      print(userProfileDeatils);
    }).catchError((err) {
      ErrorHandler.handleError(err);
    });
    return userProfileDeatils;
  }

  followOrUnfollow(String id, bool follow) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    final userId = await StorageService.getUserId();
    Map map = {
      "userId": id,
      "unFollow": follow,
    };
    print('follow ${follow}');
    _apiCall.followOrUnfollow("Bearer $auth", json.encode(map)).then((data) {
      print(data.message);
      isFollowing = !follow;
      notifyListeners();
      //return null;
    }).catchError((err) {
      ErrorHandler.handleError(err);
    });
  }
}

//
//   static followOrUnfollowProfile(id, unFollow) async {
//     final _apiCall = RestClient(DioClient.getDio());
//     final auth = await StorageService.getToken();
//     final userId = await StorageService.getUserId();
//     Map map = {
//       "userId": id,
//       "unFollow": unFollow,
//     };
//     return _apiCall
//         .followOrUnfollow("Bearer $auth", json.encode(map))
//         .then((data) {
//
//       print(data.message);
//
//       // notifyListeners();
//       return null;
//     }).catchError((err) {
//       ErrorHandler.handleError(err);
//     });
//   }
