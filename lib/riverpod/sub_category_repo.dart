import 'package:farm_system/models/sub_category_models.dart';
import 'package:farm_system/services/error_handler.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/material.dart';

class SubCategoryRepo extends ChangeNotifier {
  final _apiCall = RestClient(DioClient.getDio());
  // final auth = await StorageService.getToken();
  //

  List<Data> discoverySubList = List<Data>();
  List<PostFeed> discoverySubListImages = List<PostFeed>();
  List<Feed> newFeedVar;
  var indexVarForMAin;
  

  getSubCategoryDscover(idString) async {
    final auth = await StorageService.getToken();
    print(auth);

    await _apiCall
        .getSubDiscoverCategoryList("Bearer $auth", idString)
        .then((value) {
      discoverySubList.clear();
      print(value.data.feeds.length);
      print("getiing list of feeds");
      newFeedVar = value.data.feeds;
      print(newFeedVar.length);
      indexVarForMAin = newFeedVar.length;
       
    

      discoverySubList.add(value.data);
      var ceck = value.data.feeds[0].postFeeds.length;
      print(ceck);

      for (var i = 0; i < 10; i++) {
        discoverySubListImages.addAll(value.data.feeds[1].postFeeds);
      }
      // var ceck = value.data.feeds[0].postFeeds.length;
      // print(ceck);
      // for (i=0)
    }).catchError((e) => ErrorHandler.handleError(e));
  }
}
