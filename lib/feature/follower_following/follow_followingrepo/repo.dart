import 'package:farm_system/feature/feed/models/getFeed.model.dart';
import 'package:farm_system/feature/message/models/conversationlist.model.dart';
import 'package:farm_system/feature/message/models/follows.model.dart';
import 'package:farm_system/services/error_handler.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/material.dart';

class ProfileFollowRepo extends ChangeNotifier {
  // List<Datum> _conversationList = List<Datum>();
  // List<Datum> get conversationList => _conversationList;

  List<Follows> _followerList = List<Follows>();
  List<Follows> get followerList => _followerList;

  List<Follows> _followingList = List<Follows>();
  List<Follows> get followingList => _followingList;

  // int _conversationLength = 0;
  bool _searchClicked = false;

  // int get conversationLength => _conversationLength;
  bool get searchClicked => _searchClicked;

  // getConversations(int page, String searchKey) async {
  //   final _apiCall = RestClient(DioClient.getDio());
  //   final auth = await StorageService.getToken();
  //   return await _apiCall
  //       .getConversations("Bearer $auth", searchKey, page)
  //       .then((value) {
  //     _searchClicked = false;
  //     if (searchKey != "") {
  //       _searchClicked = true;
  //       _conversationList.clear();
  //     }
  //     _conversationList.addAll(value.data);
  //     _conversationLength = value.count;
  //     notifyListeners();
  //     return null;
  //   }).catchError((e) => ErrorHandler.handleError(e));
  // }

  getFollows(bool follower, bool following, String searchKey) async {
    if (follower == true) {
      _followerList.clear();
    }
    if (following == true) {
      _followingList.clear();
    }
    await getMyFollows(follower, following, searchKey);
  }

  getMyFollows(bool follower, bool following, String searchKey) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    return await _apiCall
        .getMyFollows("Bearer $auth", searchKey, following, follower)
        .then((value) {
      if (follower == true) {
        _followerList=value.data;
      }
      if (following == true) {
        _followingList=value.data;
      }
      notifyListeners();
      return null;
    }).catchError((e) => ErrorHandler.handleError(e));
  }
}
