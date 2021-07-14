import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:farm_system/common/custom_widget.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/feed/models/getFeed.model.dart';
import 'package:farm_system/feature/message/models/chatlist.model.dart';
import 'package:farm_system/feature/message/models/conversationlist.model.dart';
import 'package:farm_system/feature/message/models/follows.model.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/services/error_handler.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MessageRepo extends ChangeNotifier {
  List<Datum> _conversationList = List<Datum>();
  List<Datum> get conversationList => _conversationList;

  List<Follows> _followerList = List<Follows>();
  List<Follows> get followerList => _followerList;

  List<Follows> _followingList = List<Follows>();
  List<Follows> get followingList => _followingList;

  int _conversationLength = 0;
  bool _searchClicked = false;

  int get conversationLength => _conversationLength;
  bool get searchClicked => _searchClicked;

  List<Chat> _chatList = List<Chat>();
  List<Chat> get chatlist => _chatList;

  int _chatLength = 0;
  int get chatLength => _chatLength;


  String _conversationId = "";
  String get conversationId => _conversationId;

  bool _notificationType= false;
  bool get notificationType => _notificationType;

  List<String> _messageList = List<String>();
  List<String> get deletingMessageList => _messageList;

  setAllMessages(){

  }


  int _page = 1;
  int get page => _page;
  setPage(val) {
    _page = val;
    notifyListeners();
  }

  setConversationId(id) {
    _conversationId = id;
    notifyListeners();
  }

  getConversations(int page, String searchKey) async {
//    if(page==1){
//      _conversationList.clear();
//    }
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    return await _apiCall
        .getConversations("Bearer $auth", searchKey, page)
        .then((value) {
      _searchClicked = false;
      if (searchKey != "") {
        _searchClicked = true;
        _conversationList.clear();
      }
      _conversationLength = value.count;
      value.data.forEach((convo) => {
            if (_conversationList.indexWhere((chat) => chat.id == convo.id) ==
                -1)
              {_conversationList.add(convo)}
          });

      notifyListeners();
      return null;
    }).catchError((e) => ErrorHandler.handleError(e));
  }

  getChats(int page, String conversationId, String userId) async {
    if (page == 1) {
      _chatList.clear();
    }
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    return await _apiCall
        .getChats("Bearer $auth", conversationId, page, userId)
        .then((value) {
      _chatList.addAll(value.data);
      _chatLength = value.count ?? 0;
      _notificationType=value.isNotificationDisabled;
      notifyListeners();
      return null;
    }).catchError((e) => ErrorHandler.handleError(e));
  }

  getFollows(bool follower, bool following, String searchKey) async {
    if (follower == true) {
      _followerList.clear();
    }
    if (following == true) {
      _followingList.clear();
    }
    await getMyFollows(follower, following, searchKey);
  }

  addReceivedMessage(Chat chat) {
    _chatList.insert(0, chat);
    notifyListeners();
  }

  addReceivedConversation(Datum conversation) {
    _conversationList.insert(0, conversation);
    notifyListeners();
  }

  removeConversation(int index) {
    _conversationList.removeAt(index);
    notifyListeners();
  }

  clearRepo() {
    _conversationList.clear();
    _chatList.clear();
  }

  getMyFollows(bool follower, bool following, String searchKey) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    return await _apiCall
        .getMyFollows("Bearer $auth", searchKey, following, follower)
        .then((value) {
      if (follower == true) {
        _followerList = value.data;
      }
      if (following == true) {
        _followingList = value.data;
      }
      notifyListeners();
      return null;
    }).catchError((e) => ErrorHandler.handleError(e));
  }

  getConversationId(Map<String, dynamic> body) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    return await _apiCall
        .getConversation("Bearer $auth", json.encode(body))
        .then((value) {
      _conversationId = value.id;
      notifyListeners();
      return null;
    }).catchError((e) => ErrorHandler.handleError(e));
  }

  manageNotification(bool boolType) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    return await _apiCall
        .manageNotification("Bearer $auth", boolType, _conversationId)
        .then((value) {
      _notificationType = boolType;
        notifyListeners();
      return null;
    }).catchError((e) => ErrorHandler.handleError(e));
  }

  sendMessage(Map map, FormData body, context) async {
    print(body.toString());
    final _token = await StorageService.getToken();
    Dio dio = new Dio();
    dio.options.headers['Authorization'] = "Bearer $_token";

//    data.conversationId=map['conversationId'];
//    data.createdAt= DateTime.now();
//    data.messageBody=map['messageBody'];
//    data.iaMsender=true;
    Response response =
        await dio.post(BASE_API_URL + 'chat/postChat', data: body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      var data = Chat.fromJson(response.data['data']);
      data.iaMsender = true;
      _page = 1;
      chatlist.insert(0, data);
      notifyListeners();
      await getConversations(1, "");
      return response;
    }
  }

  deleteMessages(List messageList, String conversationId, String userId, bool _selectAll) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    print(messageList);
    var convo = _conversationId;
    if (_selectAll == true) {
      messageList = null;
      conversationId = _conversationId;
    } else {
      messageList= messageList;
      conversationId = 'null';
    }
    return await _apiCall
        .deleteMessages("Bearer $auth", json.encode(messageList),conversationId)
        .then((value) async {
      if(conversationId !='null'){
        _chatList=[];
      }else{
        await getChats(1, convo, userId);
      }
      notifyListeners();
      return null;
    }).catchError((e) => ErrorHandler.handleError(e));
  }

}
