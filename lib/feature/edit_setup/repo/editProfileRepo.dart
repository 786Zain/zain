import 'dart:io';

import 'package:dio/dio.dart';
import 'package:farm_system/common/custom_widget.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/profile_user/view/profile_info.dart';
import 'package:farm_system/feature/profile_user/view/profiletab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';

import '../../../storage.dart';

class EditProfileRepo extends ChangeNotifier {
  editProfileInfo(
      BuildContext context,
      String firstname,
      String bio,
      String city,
      String birthDate,
      File filePath,
      File filePaths,
      File cropImgae,
      File cropCoverPic,
      bool birthDateStatus,
      String competition,
      String website,
      String userId) async {
    print("birthDate-----------------------------------$birthDate");
    print("firrst-------------------------$firstname");
    final _token = await StorageService.getToken();
    Dio dio = new Dio();
    dio.options.headers['Authorization'] = "Bearer $_token";

    Map<String, String> map = {
      'name': firstname,
      'bio': bio,
      'city': city,
      'category': competition,
      'website': website,
    };
    if (birthDateStatus) {
      map['birthDate'] = birthDate;
    }

    FormData formData = new FormData.fromMap(map);

    if (cropImgae != null && !cropImgae.path.contains('https://')) {
      String fileName = cropImgae.path.split('/').last;
      String type = cropImgae.path.split('.').last;
      String name = cropImgae.path.split('/').last;
      String format = imageFileType().indexOf(type) != -1 ? "Image" : "Video";
      MultipartFile fileData = MultipartFile.fromFileSync(cropImgae.path,
          filename: name, contentType: MediaType(format, type));
      formData.files.add(MapEntry("profilePic", fileData));
    }

    if (cropCoverPic != null && !cropCoverPic.path.contains('https://')) {
      String fileNames = cropCoverPic.path.split('/').last;
      String types = cropCoverPic.path.split('.').last;
      String names1 = cropCoverPic.path.split('/').last;
      String formats = imageFileType().indexOf(types) != -1 ? "Image" : "Video";
      MultipartFile coverPic = MultipartFile.fromFileSync(cropCoverPic.path,
          filename: names1, contentType: MediaType(formats, types));
      formData.files.add(MapEntry("coverPic", coverPic));
    }

    Response response =
        await dio.put(BASE_API_URL + 'farm/editUserProfile', data: formData);
    if (response.statusCode == 201 || response.statusCode == 200) {
      String image = response.data['data']['profilePic'].length == 0
          ? "https://image.shutterstock.com/image-vector/people-icon-isolated-flat-design-600w-401277397.jpg"
          : response.data['data']['profilePic'][0]['location'];

      CustomWidget.showSuccessFlushBar(context, response.statusMessage);
      StorageService.setName(firstname);
      StorageService.setUserProfile(image);

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileTab(userId: userId),
          ));
    } else {
      CustomWidget.showWarningFlushBar(context, "something went wrong");
    }
    notifyListeners();
  }
}
