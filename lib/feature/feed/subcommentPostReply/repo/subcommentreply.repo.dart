import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:farm_system/common/custom_widget.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/dashboard/deatailsPost.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';

class SubCommentReplyToPost extends ChangeNotifier {

  File file;

  subCommentReplyToPost(BuildContext context, String parentId,
      String parentUserId, String grandParentId, String subPostCaption,
      file) async {
    // final apiCall = RestClient(DioClient.getDio());
    // final auth = await StorageService.getToken();

    final _token = await StorageService.getToken();
    Dio dio = new Dio();

    dio.options.headers["Authorization"] = "Bearer $_token";

    print(subPostCaption);

    if (subPostCaption != null) {
      FormData formData = new FormData.fromMap({
        "commentMessage": subPostCaption,
      });


      print("Image id before pushing innnnnnnnnnnn");
      print(parentId);
      print(parentUserId);
      print(grandParentId);

      if (file != null) {
        String type = file.path
            .split('.')
            .last;
        String name = file.path
            .split('/')
            .last;
        String format = imageFileType().indexOf(type) != -1 ? "Image" : "Video";
        MultipartFile fileData = MultipartFile.fromFileSync(file.path,
            filename: name, contentType: MediaType(format, type));
        formData.files.add(MapEntry("comment", fileData));
      }

   //   CustomWidget.loader(true, context);


      // apiCall.commentPostReply(
      //     "Bearer $_token", parentId, parentUserId, grandParentId, formData)
      //     .then((data) async {
      //   CustomWidget.loader(false, context);
      //   Navigator.pop(context);
      // }).catchError((err) {
      //   CustomWidget.showWarningFlushBar(context, err.response.data['message']);
      // });


      // apiCall.commentPostReply("Bearer $auth", parentId, parentUserId, grandParentId, formData).then((data) async {
      //
      //
      //     CustomWidget.loader(false, context);
      //     Navigator.pop(context);
      //
      // }).catchError((err) {
      //   CustomWidget.showWarningFlushBar(context, err.response.data['message']);
      // });


        Response response;
        try{
          response = await dio.post(BASE_API_URL + 'feed/postReply', queryParameters: {"parentId" : parentId, "parentUserId": parentUserId, "grandParentId": grandParentId }, data: formData);
        }catch(e){
          print(e);
        }

     //   CustomWidget.loader(false, context);
        if (response.statusCode == 201) {
          print('posted $response');
         Navigator.pop(context);

          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context); });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailsPost(
              id: parentUserId,
            )),
          );
        } else {
          CustomWidget.showWarningFlushBar(
              context, 'Unable to create an empty post');
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

    //For Update Sub Comment POst


  subCommentReplyToPostUpdated(BuildContext context, String parentId,
      String parentUserId, String grandParentId, String subPostCaption,
      file) async {
    // final apiCall = RestClient(DioClient.getDio());
    // final auth = await StorageService.getToken();

    final _token = await StorageService.getToken();
    Dio dio = new Dio();

    dio.options.headers["Authorization"] = "Bearer $_token";

    print(subPostCaption);

    if (subPostCaption != null) {
      FormData formData = new FormData.fromMap({
        "commentMessage": subPostCaption,
      });


      print("Image id before pushing innnnnnnnnnnn");
      print(parentId);
      print(parentUserId);
      print(grandParentId);


      print(file);

      if (file != null) {
        String type = file.path
            .split('.')
            .last;
        String name = file.path
            .split('/')
            .last;
        String format = imageFileType().indexOf(type) != -1 ? "Image" : "Video";
        MultipartFile fileData = MultipartFile.fromFileSync(file.path,
            filename: name, contentType: MediaType(format, type));
        formData.files.add(MapEntry("comment", fileData));
      }

      CustomWidget.loader(true, context);


      // apiCall.commentPostReply(
      //     "Bearer $_token", parentId, parentUserId, grandParentId, formData)
      //     .then((data) async {
      //   CustomWidget.loader(false, context);
      //   Navigator.pop(context);
      // }).catchError((err) {
      //   CustomWidget.showWarningFlushBar(context, err.response.data['message']);
      // });


      // apiCall.commentPostReply("Bearer $auth", parentId, parentUserId, grandParentId, formData).then((data) async {
      //
      //
      //     CustomWidget.loader(false, context);
      //     Navigator.pop(context);
      //
      // }).catchError((err) {
      //   CustomWidget.showWarningFlushBar(context, err.response.data['message']);
      // });


      Response response;
      try{
        response = await dio.put(BASE_API_URL + 'feed/updateComment', queryParameters: {"commentId" : parentId}, data: formData);
      }catch(e){
        print(e);
      }

      CustomWidget.loader(false, context);
      if (response.statusCode == 201) {
        print('posted $response');
        Navigator.pop(context);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => DetailsPost(
        //     id: parentUserId,
        //   )),
        // );
      } else {
        CustomWidget.showWarningFlushBar(
            context, 'Unable to create an empty post');
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


