import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:farm_system/common/custom_widget.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/dashboard/dashboard.dart';
import 'package:farm_system/dashboard/deatailsPost.dart';
import 'package:farm_system/services/error_handler.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';

class CommentRepo extends ChangeNotifier {

  File file;

   commentPost(BuildContext context, String userId,  String postCaption, file,String catId,String subcateId) async {
     final _token = await StorageService.getToken();
     Dio dio = new Dio();

     dio.options.headers["Authorization"] = "Bearer $_token";


     if (postCaption != null) {
       FormData formData = new FormData.fromMap({
         "commentMessage": postCaption,
         "category":catId,
         "subCategory":subcateId
       });

       if (file != null) {
         String type = file.path.split('.').last;
         String name = file.path.split('/').last;
         String format = imageFileType().indexOf(type) != -1 ? "Image" : "Video";
         MultipartFile fileData = MultipartFile.fromFileSync(file.path,
             filename: name, contentType: MediaType(format, type));
         formData.files.add(MapEntry("comment", fileData));
       }

       // CustomWidget.loader(true, context);
       Response response;
       try{
         response = await dio.post(BASE_API_URL + 'feed/postComment', queryParameters: {"parentId" : userId}, data: formData);
       }catch(e){
         print(e);
       }

       // CustomWidget.loader(false, context);
       if(file != null){
         print('coming inside the data');
         Navigator.push(
           context,
           MaterialPageRoute(builder: (context) => DetailsPost()),
         );
         // Navigator.push(
         //   context,
         //   MaterialPageRoute(builder: (context) => DashBoard()),
         // );
       }else{
         Navigator.pop(context);
       }
       // if (response.statusCode == 201 && postCaption != null ) {
       //   print('posted $response');
       //   Navigator.pop(context);
       //
       // } else {
       //   CustomWidget.showWarningFlushBar
       //       context, 'Unable to create an empty post');
       // }
     } else {
       CustomWidget.showWarningFlushBar(
           context, 'Unable to create an empty post');
     }




     // commentPost( String postId,String comment) async{
     //   final _apiCall = RestClient(DioClient.getDio());
     //   final auth = await StorageService.getToken();
     //
     //   print(auth);
     //
     //   Map map =
     //   {
     //     "parentId": postId,
     //     "comment": "",
     //     "commentMessage": comment,
     //   };
     //
     //   return await _apiCall.commentPost("Bearer $auth", json.encode(map)).then((value) {
     //
     //     // print("search save");
     //     // print(search);
     //     // print("Successfull");
     //     // subCategory = value.data;
     //    print("successfull");
     //     notifyListeners();
     //     return null;
     //
     //   }).catchError((e) => ErrorHandler.handleError(e));
     // }


   }

   // Comment Post Update

  commentPostUpdate(BuildContext context, String userId,  String postCaption, file) async {
    final _token = await StorageService.getToken();
    Dio dio = new Dio();

    dio.options.headers["Authorization"] = "Bearer $_token";




    print('Inside repooooo');
    print(userId);
    print(postCaption);

    if (postCaption != null) {
      FormData formData = new FormData.fromMap({
        "commentMessage": postCaption,
      });

      if (file != null) {
        String type = file.path.split('.').last;
        String name = file.path.split('/').last;
        String format = imageFileType().indexOf(type) != -1 ? "Image" : "Video";
        MultipartFile fileData = MultipartFile.fromFileSync(file.path,
            filename: name, contentType: MediaType(format, type));
        formData.files.add(MapEntry("comment", fileData));
      }




      CustomWidget.loader(true, context);
      Response response;
      try{
        print('Inside innnnnn');
        print(userId);
        print(postCaption);
        response = await dio.put(BASE_API_URL + 'feed/updateComment', queryParameters: {"commentId" : userId}, data: formData);
      }catch(e){
        print(e);
      }

      CustomWidget.loader(false, context);
      if (response.statusCode == 201) {

        print('bdb skhbkhbkhshkfkhskhbhkfbhksfkhsh');
        print('posted $response');
        Navigator.pop(context);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => DashBoard()),
        // );
      } else {
        CustomWidget.showWarningFlushBar(
            context, 'Unable to crete due to mis-match');
      }
    } else {
      CustomWidget.showWarningFlushBar(
          context, 'Unable to create an empty post');
    }




    // commentPost( String postId,String comment) async{
    //   final _apiCall = RestClient(DioClient.getDio());
    //   final auth = await StorageService.getToken();
    //
    //   print(auth);
    //
    //   Map map =
    //   {
    //     "parentId": postId,
    //     "comment": "",
    //     "commentMessage": comment,
    //   };
    //
    //   return await _apiCall.commentPost("Bearer $auth", json.encode(map)).then((value) {
    //
    //     // print("search save");
    //     // print(search);
    //     // print("Successfull");
    //     // subCategory = value.data;
    //    print("successfull");
    //     notifyListeners();
    //     return null;
    //
    //   }).catchError((e) => ErrorHandler.handleError(e));
    // }


  }

}