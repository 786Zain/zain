import 'package:farm_system/feature/farm_post/postcategory/postcategory.model.dart';
import 'package:farm_system/services/error_handler.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/material.dart';

class PostCategory extends ChangeNotifier{
  List<Datum> feedCategory = [];
   getCategoryPost() async{
     final _apiCall = RestClient(DioClient.getDio());
     final auth = await StorageService.getToken();
     return await _apiCall.getCategoryList("Bearer $auth", "false", '').then((value) {
       feedCategory = value.data;
       print("Printing the value for Category");
       print(value.toJson());
       return null;
     }).catchError((e) => ErrorHandler.handleError(e));
  }
}