import 'package:farm_system/screen/Discovery/Model/discovery_search_model.dart';
import 'package:farm_system/services/error_handler.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/material.dart';

// import '../discovery_model.dart';

class AddSearchRepo extends ChangeNotifier {
  List<Datum> _searchList = List<Datum>();
  List<Datum> get searchList => _searchList;

  getSearchList(String searchKey) async {
    final _apiCall = RestClient(DioClient.getDio());
    print(searchKey);
    print("shdsg---------------------");
    final auth = await StorageService.getToken();
    return await _apiCall
        .getDiscoverySearchList("Bearer $auth", searchKey)
        .then((value) {
      _searchList=value.data;
      print(value);
      notifyListeners();
      return null;
    }).catchError((e) => ErrorHandler.handleError(e));
  }

  setbool(String id, bool followstatus) {
    for (var i = 0; i < searchList.length; i++) {
      print(searchList);

      if (searchList[i].id == id) {
        print(searchList.length);

        searchList[i].isFollowing = followstatus;
        print(followstatus);
        print("hello=----------");
        _searchList = searchList;
        notifyListeners();
      }
      print(searchList[i].isFollowing);
      print("djhfldj------");
    }
    return followstatus;
  }
}
