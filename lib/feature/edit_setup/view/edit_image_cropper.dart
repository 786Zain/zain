import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';


class CameraUtils {

  static Future<File> cropImageFromCamera(String file) async {
    if (file != null) {
      var _file = await ImageCropper.cropImage(sourcePath: file,
          cropStyle: CropStyle.circle,
          androidUiSettings: AndroidUiSettings(
            backgroundColor: Colors.black,
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            toolbarTitle: 'Edit Profile',
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

  static Future<File> cropCoverImageFromCamera(String file) async {
    if (file != null) {
      var _file = await ImageCropper.cropImage(sourcePath: file,
          cropStyle: CropStyle.rectangle,
          aspectRatioPresets: [
            CropAspectRatioPreset.ratio16x9
          ],
          androidUiSettings: AndroidUiSettings(
            backgroundColor: Colors.black,
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            toolbarTitle: 'Edit Profile',
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


  static Future<File> cropImageFromGallery(String file) async {
    if (file != null) {
      var _file = await ImageCropper.cropImage(sourcePath: file,
          cropStyle: CropStyle.circle,
          androidUiSettings: AndroidUiSettings(
            backgroundColor: Colors.black,
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            toolbarTitle: 'Edit Profile',
            hideBottomControls: true,
            showCropGrid: false,
            cropFrameColor: Colors.black,
          ),
          iosUiSettings: IOSUiSettings(
              cancelButtonTitle: 'Cancel',
              doneButtonTitle: 'Save'
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

  static Future<File> cropCoverImageFromGallery(String file) async {
    if (file != null) {
      var _file = await ImageCropper.cropImage(sourcePath: file,
          cropStyle: CropStyle.rectangle,
          aspectRatioPresets: [
            CropAspectRatioPreset.ratio16x9
          ],
          androidUiSettings: AndroidUiSettings(
            initAspectRatio: CropAspectRatioPreset.ratio16x9,
            backgroundColor: Colors.black,
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            toolbarTitle: 'Edit Profile',
            hideBottomControls: true,
            showCropGrid: false,
            cropFrameColor: Colors.black,
          ),
          iosUiSettings: IOSUiSettings(
              cancelButtonTitle: 'Cancel',
              doneButtonTitle: 'Save'
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
}