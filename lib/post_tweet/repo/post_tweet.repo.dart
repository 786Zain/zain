import 'dart:io';

import 'package:farm_system/camera/camera_form_gallery_view.dart';
import 'package:farm_system/common/custom_widget.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/dashboard/dashboard.dart';
import 'package:farm_system/feature/edit_setup/view/edit_image_cropper.dart';
import 'package:farm_system/feature/edit_setup/view/edit_profile.dart';
import 'package:farm_system/screen/Discovery/all_element.dart';
import 'package:farm_system/storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:validators/validators.dart';

class PostRepo extends ChangeNotifier {
  AssetEntity image;
  File file;
  var cropperProfileImage;
  var cropperCoverImage;

  restCropperfile() {
    cropperCoverImage = null;
    cropperProfileImage = null;
  }

  createPost(cate, subcate, file, caption, context) async {
    print(isNull(caption));
    final _token = await StorageService.getToken();

    Dio dio = new Dio();
    dio.options.headers["Authorization"] = "Bearer $_token";

    if (file != null || caption != null) {
      FormData formData = new FormData.fromMap({
        "caption": caption,
        "subCategory": subcate,
        "category": cate,
      });

      if (file != null) {
        String type = file.path.split('.').last;
        String name = file.path.split('/').last;
        String format = imageFileType().indexOf(type) != -1 ? "Image" : "Video";
        MultipartFile fileData = MultipartFile.fromFileSync(file.path,
            filename: name, contentType: MediaType(format, type));
        formData.files.add(MapEntry("post", fileData));
      }

      CustomWidget.loader(true, context);

      Response response =
          await dio.post(BASE_API_URL + 'feed/postFeed', data: formData);

      CustomWidget.loader(false, context);

      ///  return response;

      if (response.statusCode == 201) {
        print('posted $response');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DashBoard()),
        );
      } else {
        CustomWidget.showWarningFlushBar(
            context, 'Unable to create an empty post');
      }
    } else {
      CustomWidget.showWarningFlushBar(
          context, 'Unable to create an empty post');
    }
  }

  Future<void> fetchingTheFileGallery(
      BuildContext context,
      Future<File> image,
      String textTyped,
      String id,
      String subCategory,
      String commentPostImage,
      String profilePicUser,
      String adminPicUser,
      String userNamePost,
      String postId,
      String parentId,
      String parentUserId,
      String grandParentId,
      String subcategoryId,
      String mainCategoryId,
      String userName,
      String userId,
      String postSecondaryName,
      String replyingSecondaryName,
      String replyingUserName) async {
    file = await image;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DisplayPictureScreen1(
          imagePath: file,
          portrait: true,
          textTyped: textTyped,
          id: id,
          subCategory: subCategory,
          commentPostImage: commentPostImage,
          profilePicUser: profilePicUser,
          adminPicUser: adminPicUser,
          userNamePost: userNamePost,
          postId: postId,
          parentId: parentId,
          parentUserId: parentUserId,
          grandParentId: grandParentId,
          subcategoryId: subcategoryId,
          mainCategoryId: mainCategoryId,
          userId:userId,
          userName:userName,
          postSecondaryName: postSecondaryName,
          replyingSecondaryName:replyingSecondaryName,
          replyingUserName: replyingUserName
        ),
      ),
    );
  }

  //For Crop

  Future<void> fetchingCropGallery(
      BuildContext context, Future<File> image) async {
    file = await image;
    print(file);
    var cropperImage = await CameraUtils.cropImageFromGallery(file.path);
    cropperProfileImage = cropperImage;
    var userId = await StorageService.getUserId();
    await navigationToScreen(
        context,
        EditProfile(
            cropImgae: cropperProfileImage,
            cropCoverPic: cropperCoverImage,
            userId: userId),
        false);
    print(file.path);
  }

  Future<void> fetchingCropCamera(BuildContext context, File image) async {
    print('sagarimagecamera');
    print(file);
    file = await image;
    var cropperImage = await CameraUtils.cropImageFromCamera(file.path);
    cropperProfileImage = cropperImage;
    var userId = await StorageService.getUserId();
    await navigationToScreen(
        context,
        EditProfile(
          cropImgae: cropperProfileImage,
          cropCoverPic: cropperCoverImage,
          userId: userId,
        ),
        false);
    print(file.path);
  }

  Future<void> fetchingCropCoverGallery(
      BuildContext context, Future<File> image) async {
    file = await image;
    print(file);
    var cropperImage = await CameraUtils.cropCoverImageFromGallery(file.path);
    cropperCoverImage = cropperImage;
    var userId = await StorageService.getUserId();
    await navigationToScreen(
        context,
        EditProfile(
            cropImgae: cropperProfileImage,
            cropCoverPic: cropperCoverImage,
            userId: userId),
        false);
    print(file.path);
  }

  Future<void> fetchingCropCoverCamera(BuildContext context, File image) async {
    file = await image;
    var cropperImage = await CameraUtils.cropCoverImageFromCamera(file.path);
    cropperCoverImage = cropperImage;
    var userId = await StorageService.getUserId();
    await navigationToScreen(
        context,
        EditProfile(
            cropImgae: cropperProfileImage,
            cropCoverPic: cropperCoverImage,
            userId: userId),
        false);
    print(file.path);
  }
}
