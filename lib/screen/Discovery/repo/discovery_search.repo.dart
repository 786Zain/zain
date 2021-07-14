import 'package:farm_system/screen/Discovery/Model/discovery_search_model.dart';
import 'package:farm_system/services/error_handler.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/material.dart';

import '../discovery_model.dart';

class DiscoverySearchRepo extends ChangeNotifier {
  List<Datum> searchList = List<Datum>();

  getSearchList(String searchKey) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    return await _apiCall
        .getDiscoverySearchList("Bearer $auth", searchKey)
        .then((value) {
      searchList.clear();
      searchList.addAll(value.data);
      print(value);
      notifyListeners();
      return null;
    }).catchError((e) => ErrorHandler.handleError(e));
  }
  notifyListeners();
}
