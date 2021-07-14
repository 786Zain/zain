

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSetupCopper {

  // static Future<File> cropProfileImageFromCamera(String file) async {
  //   final _image = await takeImageFromCamera();
  //   var _file;
  //   if (_image != null) {
  //      _file = await ImageCropper.cropImage(sourcePath: _image,
  //         cropStyle: CropStyle.circle,
  //         androidUiSettings: AndroidUiSettings(
  //           backgroundColor: Colors.black,
  //           toolbarColor: Colors.black,
  //           toolbarWidgetColor: Colors.white,
  //           toolbarTitle: 'Profile-Setup',
  //           hideBottomControls: true,
  //           showCropGrid: false,
  //           cropFrameColor: Colors.black,
  //
  //         ),
  //         iosUiSettings: IOSUiSettings(
  //           cancelButtonTitle: 'Cancel',
  //           doneButtonTitle: 'Save',
  //
  //         )
  //     );
  //     if (_file != null) {
  //       return _file;
  //     } else {
  //       return null;
  //     }
  //   } else {
  //     return null;
  //   }
  // }
  static Future<File> cropImageFromCamera() async {
    final _image = await takeImageFromCamera();
    if (_image != null) {
      var _file = await ImageCropper.cropImage(sourcePath: _image,
          cropStyle: CropStyle.circle,
          androidUiSettings: AndroidUiSettings(
            backgroundColor: Colors.black,
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            toolbarTitle: 'Profile-Setup',
            hideBottomControls: true,
            showCropGrid: false,
            cropFrameColor: Colors.black,

          ),
          iosUiSettings: IOSUiSettings(
            cancelButtonTitle: 'Cancel',
            doneButtonTitle: 'Save',

          )
      );
      if (_file != null) {
        return _file;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<String> takeImageFromCamera() async {
    final _imagePicker = ImagePicker();
    final _image = await _imagePicker.getImage(source: ImageSource.camera);
    if (_image != null) {
      return _image.path;
    } else {
      return null;
    }
  }

  static Future<File> cropImageFromGallery() async {
    final _image = await takeImageFromGallery();
    if (_image != null) {
      var _file = await ImageCropper.cropImage(sourcePath: _image,
          cropStyle: CropStyle.circle,
          androidUiSettings: AndroidUiSettings(
            backgroundColor: Colors.black,
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            toolbarTitle: 'Profile-Setup',
            hideBottomControls: true,
            showCropGrid: false,
            cropFrameColor: Colors.black,

          ),
          iosUiSettings: IOSUiSettings(
            cancelButtonTitle: 'Cancel',
            doneButtonTitle: 'Save',

          )
      );
      if (_file != null) {
        return _file;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<String> takeImageFromGallery() async {
    final _imagePicker = ImagePicker();
    final _image = await _imagePicker.getImage(source: ImageSource.gallery);
    if (_image != null) {
      return _image.path;
    } else {
      return null;
    }
  }
}