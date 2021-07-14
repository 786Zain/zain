import 'dart:convert';

import 'package:farm_system/services/error_handler.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/cupertino.dart';

class FollowRepo extends ChangeNotifier {
  static followOrUnfollow( String id,  bool follow) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    final userId = await StorageService.getUserId();
    Map map = {
      "userId": id,
      "unFollow": follow,
    };
    return _apiCall
        .followOrUnfollow("Bearer $auth", json.encode(map))
        .then((data) {

      print(data.message);

      // notifyListeners();
      return null;
    }).catchError((err) {
      ErrorHandler.handleError(err);
    });
  }
}
