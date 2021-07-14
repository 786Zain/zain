import 'dart:convert';

import 'package:farm_system/feature/farm_post/postsubcategory/postsubcategory.model.dart';
import 'package:farm_system/services/error_handler.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/material.dart';


class SubPostCategory extends ChangeNotifier{


  List<Datum> feedSubCategory = [];
  // List<SubCategory> subCategory = [];




  String searchText = "Search here";

  resetSubCategory(){
    feedSubCategory.clear();
  }

  getSubCategoryPost(String id) async{
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();


    print("idddd");
    print(id);

    return await _apiCall.getSubCategoryList("Bearer $auth", "true", id).then((value) {

      print(value.toJson());
      // feedSubCategory = value.data;
     //  if(value.data.length > 0){
     //    subCategory.addAll(value.data[0].subCategory);
     //  }
     // searchText = subCategory.indexOf(valu)

      if(value.data.length > 0){
        feedSubCategory.addAll(value.data);
      }
      

      print("Printing the value for SubCategory");
      print("${feedSubCategory.length}");
      return null;
    }).catchError((e) => ErrorHandler.handleError(e));
  }

  postSearchCategory( String search, String id) async{
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();

    print(auth);

    Map map =
    {
      "mainCategory": id,
      "subCategory" : search,
    };

    return await _apiCall.postSaveSearch("Bearer $auth", json.encode(map)).then((value) {

      // print("search save");
      // print(search);
      // print("Successfull");
      // subCategory = value.data;
      feedSubCategory
        ..asMap().forEach((index, data) => {
          print(index),
          print(data),
        });
      notifyListeners();
       return null;

    }).catchError((e) => ErrorHandler.handleError(e));
  }

}