import 'package:farm_system/services/error_handler.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/material.dart';

import '../discovery_model.dart';

class DiscoveryRepo extends ChangeNotifier {
  List<Data> _discoveryList = List<Data>();
  List<bool> buttonClicked = [];
  List<Post> postVar = [];
  String thumbnail;

  List<Data> get discoveryList => _discoveryList;
  bool buttonColor = true;

  getCategoryPost() async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    return await _apiCall.getDiscovery("Bearer $auth").then((value) {
      thumbnail = value.data.content[0].thumbnailurl;
      postVar = value.data.posts;
      _discoveryList.add(value.data);
      notifyListeners();
      return null;
    }).catchError((e) => ErrorHandler.handleError(e));
  }

  changeButtonBorder(val) {
    buttonColor = !val;
    notifyListeners();
  }
}
