import 'package:farm_system/feature/farm_plus_setup/farm_plus_model/farm_plus_model.dart';
import 'package:farm_system/feature/farm_plus_setup/farm_plus_model/farm_category_post_model.dart' as categoryData;
import 'package:farm_system/feature/farm_plus_setup/farm_plus_model/farm_category_post_model.dart';
import 'package:farm_system/feature/farm_plus_setup/farm_plus_model/farm_plus_category_model.dart';
import 'package:farm_system/feature/farm_plus_setup/farm_plus_model/farm_subcategory_model.dart';
import 'package:farm_system/services/error_handler.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/material.dart';

import '../farm_plus_model/farm_plus_model.dart';


class FarmPlusRepo extends ChangeNotifier {
  bool isOneMonth = false;
  bool isOneYear = false;

  List<Data> farmplusList  = List<Data>();

  farmCategoryPost() async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    return await _apiCall.getFarmPlusCategory("Bearer $auth").then((value) {
      farmplusList.add(value.data);
      print(value.data);
      notifyListeners();
      return null;
    }).catchError((e) => ErrorHandler.handleError(e));
  }
    notifyListeners();




  CategoryData categoryPostPic = CategoryData();

  farmCategory(String categoryId,) async {
    print('categoryIDDDDDD');
    print(categoryId);
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    return await _apiCall.getFarmPlusCategoryPost("Bearer $auth",categoryId).then((value) {
      categoryPostPic = value.data;
      print(value.data);
      notifyListeners();
      return null;
    }).catchError((e) => ErrorHandler.handleError(e));
  }




  SubCategoryData subcategoryList = SubCategoryData();

  farmSubCategory(String categoryId,String subCategory) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    return await _apiCall.getFarmPlusSubCategoryPost("Bearer $auth",categoryId,subCategory).then((value) {
      subcategoryList = value.data;
      print(value.data);
      notifyListeners();
      return null;
    }).catchError((e) => ErrorHandler.handleError(e));
  }




  List<Datum> farmpluscategory = List<Datum>();
  farmPlusCategoryList() async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    return await _apiCall.getFarmCategory("$auth").then((value){
      farmpluscategory = value.data;
      notifyListeners();
      return null;
    }).catchError((e) => ErrorHandler.handleError(e));
  }

  bool ActiveButton(String active){
   if('OneYear' == active){
     isOneYear = true;
     isOneMonth = false;
     notifyListeners();
   }else{
     isOneMonth = true;
     isOneYear = false;
     notifyListeners();
   }
  }
}


