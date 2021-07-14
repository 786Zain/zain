import 'dart:io';
import 'dart:typed_data';

import 'package:analyzer/file_system/file_system.dart';
import 'package:farm_system/camera/video.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/navigator.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/screen/Discovery/all_element.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:photo_manager/photo_manager.dart';

import 'edit_profile.dart';

class EditGallery extends StatefulWidget {
  final String textTyped;
  final String id;
  final String subCategory;
  final String commentPostImage;
  final String profilePicUser;
  final String adminPicUser;
  final String userNamePost;
  final String postId;
  final String parentId, parentUserId, grandParentId;

  EditGallery({
    Key key,
    this.textTyped,
    this.id,
    this.subCategory,
    this.commentPostImage,
    this.profilePicUser,
    this.userNamePost,
    this.adminPicUser,
    this.postId,
    this.parentId,
    this.parentUserId,
    this.grandParentId,
  }) : super(key: key);

  @override
  _EditGalleryState createState() => _EditGalleryState();
}

class _EditGalleryState extends State<EditGallery> {
  List<AssetEntity> assets = [];
  AssetEntity image;
  String selectedFileId;

  fetchAssets() async {
    final albums = await PhotoManager.getAssetPathList(hasAll: true);
    final recentAlbum = albums.first;
    final recentAssets = await recentAlbum.getAssetListRange(
      start: 0,
      end: 1000000,
    );
    setState(() => assets = recentAssets);
  }

  fetchAssetsImage() async {
    final albums = await PhotoManager.getAssetPathList(
        onlyAll: true, hasAll: true, type: RequestType.image);
    final recentAlbum = albums.first;
    final recentAssets = await recentAlbum.getAssetListRange(
      start: 0,
      end: 1000000,
    );
    setState(() => assets = recentAssets);
  }

  @override
  void initState() {
    // For Hiding he video show in gallery here

    widget.commentPostImage == 'Crop Profile'
        ? fetchAssetsImage()
        : fetchAssets();
    super.initState();
  }

  String cropImage = 'Crop';

  @override
  Widget build(BuildContext context) {
    var list = 0;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        backgroundColor: HexColor('#222222'),
        title: Consumer(builder: (context, watch, child) {
          final postProviderRepo = watch(postProvider);
          return Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                FlatButton(
                    onPressed: () {
                      navigationToScreen(context, EditProfile(), false);
                    },
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0),
                    )),
                FlatButton(
                    onPressed: () async {
                      postProviderRepo.fetchingCropGallery(
                          context, postProviderRepo.image.originFile);
                    },
                    child: Text(
                      "Add",
                      style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0),
                    ))
              ])
            ],
          );
        }),
      ),
      body: Consumer(builder: (context, watch, child) {
        final postProviderRepo = watch(postProvider);
        return SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1
              ),
              itemCount: assets.length,
              itemBuilder: (_, index) {
                return index == 0
                    ? GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Video(
                                      commentPostImage: cropImage,
                                    )),
                          )
                        },
                        child: Container(
                          color: Colors.black,
                            child: SvgPicture.asset(camera,
                                color: Colors.black, fit: BoxFit.none)),
                      )
                    : InkWell(
                        onTap: () {
                          setState(() {
                            selectedFileId = assets[index].id;
                          });
                          print(
                              "assets[index] -------------------- ${assets[index]}");
                          var n = assets[index].size.height;

                          print("nnnnnnnnnnnnnnnnnnnnnn");
                          print(n);

                          postProviderRepo.image = assets[index];
                        },
                        child: FutureBuilder<Uint8List>(
                          future: assets[index].thumbData,
                          builder: (_, snapshot) {
                            final bytes = snapshot.data;
                            if (bytes == null)
                              return CircularProgressIndicator();
                            return Stack(children: [
                              SizedBox(
                                child: Image.memory(bytes, fit: BoxFit.cover),
                                height: MediaQuery.of(context).size.height / 2,
                                width: MediaQuery.of(context).size.width / 2,
                              ),
                              if (assets[index].type == AssetType.video)
                                Center(
                                  child: Container(
                                    color: Colors.blue,
                                    child: Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              Visibility(
                                  visible: selectedFileId != null &&
                                      selectedFileId == assets[index].id,
                                  child: Positioned(
                                    top: 0,
                                    right: 0,
                                    child:
                                        Icon(CupertinoIcons.check_mark_circled),
                                  ))
                            ]);
                          },
                        ),
                      );
              },
            ),
          ),
        );
      }),
    );
  }
}
