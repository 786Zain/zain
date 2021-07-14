import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:farm_system/animation/animation.dart';
import 'package:farm_system/camera/video.dart';
import 'package:farm_system/common/custom_widget.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/dashboard/dashboard.dart';
import 'package:farm_system/feature/farm_post/custom_gallery.dart';
import 'package:farm_system/feature/farm_post/fullscreenview.dart';
import 'package:farm_system/feature/farm_post/postcategory/postcategoryselect.dart';
import 'package:farm_system/feature/farm_post/postcategory/postcategoryselect.dart';
import 'package:farm_system/feature/farm_post/postcategory/postcategoryselect.dart';
import 'package:farm_system/navigator.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/routes/router.gr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player/video_player.dart' as PackagageVideoPlayer;

class FarmPost extends StatefulWidget {
  final File filePath;
  final Duration duration;
  final bool portraits;
  final String id;
  final String subCategory;
  final String textTyped;
  final String categoryId;
  final String subcategoryId;
  //final bool isImage;

  const FarmPost(
      {Key key,
      this.filePath,
      this.duration,
      this.portraits,
      this.id,
      this.subCategory,
      this.textTyped,
      this.categoryId,
      this.subcategoryId})
      : super(key: key);
  @override
  _FarmPostState createState() => _FarmPostState();
}

class _FarmPostState extends State<FarmPost> {
  final _captionController = TextEditingController();

  var imageFileTypes = [
    "png",
    "jpg",
    "jpeg",
    "gif",
    "JPG",
    "PNG",
    "JPEG",
    "GIF",
    "HEIC"
  ];

  // final videoInfo = FlutterVideoInfo();
  File path;
  var duration;

  String mainCategoryId;
  String subCategoryId;

  @override
  void initState() {
    print('category ID');
    print(widget.categoryId);
    print(widget.subcategoryId);

    mainCategoryId = widget.categoryId;
    subCategoryId = widget.subcategoryId;
    _captionController.text = widget.textTyped;
    var dur = widget.duration;
    path = widget.filePath;

    String a = dur.toString();

    print("date format");
    print(a);
    List<String> b = a.split(".")[0].split(":");
    b.removeAt(0);
    print("joinnnn here");
    print(b.join(":"));
    duration = b.join(":");

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("for videoooo");
    print(widget.textTyped);

    print(widget.subCategory);

    final _bottomLayer = Container(
      alignment: Alignment.center,
      color: Colors.black,
      height: 40,
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 15, right: 25),
                child: GestureDetector(
                  onTap: () {
                    //  _controller.dispose();

                    print("jjjj");
                    print(widget.id);
                    print(widget.subCategory);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              // Video()),
                              CustomGallery(
                                  textTyped: _captionController.text,
                                  id: widget.id,
                                  subCategory: widget.subCategory,
                                  subcategoryId: widget.subcategoryId,
                                  mainCategoryId: widget.categoryId)),
                    );
                  },
                  //  imgFromGallery(context),
                  // async => {imgFromGallery()},
                  child: Container(
                    height: 25,
                    width: 25,
                    child: SvgPicture.asset(
                      gallery,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: GestureDetector(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Video(
                              textTyped: _captionController.text,
                              id: widget.id,
                              subCategory: widget.subCategory)),
                    )
                  },
                  child: Container(
                      height: 25,
                      width: 25,
                      child: SvgPicture.asset(camera,
                          color: Colors.red, fit: BoxFit.none)),
                ),
              ),
              Spacer(),
              // GestureDetector(
              //   onTap: () {},
              //   child: Container(
              //       height: 25,
              //       width: 25,
              //       child: SvgPicture.asset(
              //         settings,
              //         color: Colors.red,
              //       )),
              // ),
              GestureDetector(
                onTap: () => _modalBottomSheetMenu(),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 8, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 30,
                        width: 25,
                        child: Image.asset(earth, fit: BoxFit.none),
                      ),
                      // ),
                      Text(
                        'Everyone can reply',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      )
                    ],
                  ),
                ),
              )
            ]),
      ),
    );
    final _privacyNtag = Container(
      padding: EdgeInsets.only(left: 10),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(SlideFromRight(
          widget: SelectCategoryPost(
            textTyped: _captionController.text,
            filePath: widget.filePath,
          ),
        )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CATEGORY OF POST : ',
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 10.0,
                  letterSpacing: 2),
            ),
            SizedBox(
              width: 0,
            ),
            Text(
                widget.id != null
                    ? "${widget.id.toUpperCase()?? ''} - ${widget.subCategory.toUpperCase() ?? ''}"
                    : 'SELECT A CATEGORY',
                style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 10.0,
                    letterSpacing: 2))
          ],
        ),
      ),
    );

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          resizeToAvoidBottomPadding: true,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black,
            title: Consumer(builder: (context, watch, child) {
              final postProviderRepo = watch(postProvider);
              final userProfileAllRepo = watch(userAllProvider);
              return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        child: Icon(Icons.close, color: Colors.white),
                      ),
                    ),
                    GestureDetector(
                        child: Container(
                            child: Text("POST",
                                style: GoogleFonts.montserrat(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2))),
                        onTap: () async {
                          print("posting");
                          print("Category ID");
                          print(mainCategoryId);
                          print(subCategoryId);
                          if(mainCategoryId != null && subCategoryId !=null ){
                            print('dfkjb');
                            await postProviderRepo.createPost(
                                mainCategoryId,
                                subCategoryId,
                                widget.filePath,
                                _captionController.text,
                                context);

                            await userProfileAllRepo.userProfileAll(widget.id);

                          }else{
                            CustomWidget.showWarningFlushBar(
                                context, 'Please select Category');
                          }


                          // AppNavigator.push(Routes.dashBoard);
                        }),
                  ]);
            }),
          ),
          body: Consumer(builder: (context, watch, child) {
            final dashBoardProviderRepo = watch(dashboardProvider);
            final profileRepo = watch(profileProvider);
            return Column(children: [
              Expanded(
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return new Column(children: [
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Visibility(
                                    visible:
                                        dashBoardProviderRepo.userProfilePic !=
                                            null,
                                    child: Container(
                                        height: 52,
                                        width: 52,
                                        decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: new DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(getImageUrl(
                                                        dashBoardProviderRepo
                                                            .userProfilePic) ??
                                                    // getImageUrl(
                                                    //     profileRepo
                                                    //         .userProfileDeatils.profilePic[0].location) ??
                                                    ''))))),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, bottom: 0),
                                  width: 240,
                                  child: TextFormField(
                                    style: TextStyle(color: Colors.white),
                                    autofocus: true,
                                    minLines: 1,
                                    maxLines: null,
                                    maxLengthEnforced: true,
                                    cursorColor: Colors.white,
                                    //  cursorColor: HexColor("080F18"),
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    controller: _captionController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "What's happening?",
                                      hintStyle: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Icon(Icons.error_outline),
                                )
                              ],
                            ),
                          ),
                        ),
                        Column(children: [
                          path != null
                              ?
                              // widget.portraits ?
                              imageFileTypes.indexOf(path.path.split('.').last) !=
                                      -1
                                  ? Stack(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context)
                                                .push(SlideFromRight(
                                                    widget: FullScreenView(
                                              filePaths: path,
                                            )));
                                          },
                                          child:Container(
                                            height: 300,
                                            width: 320,
                                            child: OverflowBox(
                                              minWidth: 320,
                                              minHeight: 200,
                                              maxHeight: 300,
                                              maxWidth: 320,

                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(12.0),
                                                  child: Image.file(path),
                                                ),
                                            ),
                                          ),
                                          // Padding(
                                          //   padding: EdgeInsets.only(
                                          //       left: 30, right: 30, bottom: 30),
                                          //   child: ClipRRect(
                                          //     borderRadius:
                                          //         BorderRadius.circular(12.0),
                                          //     child: Image.file(path),
                                          //   ),
                                          // ),
                                        ),
                                        Positioned(
                                            right: 20,
                                            top: 10,
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  path = null;
                                                });
                                              },
                                              child: CircleAvatar(
                                                backgroundColor: Colors.black,
                                                radius: 13,
                                                child: IconButton(
                                                  padding: EdgeInsets.zero,
                                                  icon: Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                    size: 18,
                                                  ),
                                                ),
                                              ),
                                            )),
                                      ],
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(SlideFromRight(
                                            widget: FullScreenView(
                                          filePaths: path,
                                        )));
                                      },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                2.2,
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(1)),
                                              child: ChewieListItem(
                                                videoPlayerController:
                                                    VideoPlayerController.file(
                                                        path),
                                              ),
                                            ),
                                            Container(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15, bottom: 10),
                                                child: Container(
                                                  alignment: Alignment.bottomLeft,
                                                  child: Text(
                                                    duration,
                                                    style: TextStyle(
                                                    color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              child: ClipOval(
                                                child: Material(
                                                  color: Colors
                                                      .blue, // button color
                                                  child: SizedBox(
                                                      width: 46,
                                                      height: 46,
                                                      child: Icon(
                                                        Icons.play_arrow,
                                                        color: Colors.white,
                                                        size: 30,
                                                      )),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10, top: 5),
                                              child: Container(
                                                alignment: Alignment.topRight,
                                                child: GestureDetector(
                                                  onTap: () {
                                                VideoPlayerController.file(
                                                        path)
                                                    .dispose();
                                                setState(() {
                                                  path = null;
                                                });
                                                  },
                                                  child: CircleAvatar(
                                                backgroundColor: Colors.black,
                                                radius: 13,
                                                child: IconButton(
                                                  padding: EdgeInsets.zero,
                                                  icon: Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                    size: 18,
                                                  ),
                                                ),
                                                  ),
                                                  // child: Icon(Icons.close),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                              //for height
                              //     : imageFileTypes.indexOf(widget.path.path.split('.').last)  != -1
                              //     ? Container(
                              //   height: 121,
                              //   width: 168,
                              //   child: Container(
                              //     width: MediaQuery.of(context).size.width,
                              //     margin: EdgeInsets.symmetric(horizontal: 5.0),
                              //     decoration: BoxDecoration(
                              //         image: DecorationImage(
                              //             image: FileImage(widget.path),
                              //             fit: BoxFit.fill),
                              //         borderRadius: BorderRadius.circular(0.0)),
                              //   ),
                              //   // child: Image.network(
                              //   //     'https://homepages.cae.wisc.edu/~ece533/images/watch.png')
                              // ) : GestureDetector(
                              //   onTap: (){
                              //     Navigator.of(context).push(SlideFromRight(widget: FullScreenView(
                              //       paths : widget.path,
                              //     )));
                              //   },
                              //   child: Container(
                              //     height: 250,
                              //     // width: 168,
                              //     child: Stack(
                              //       children: [
                              //         ClipRRect(
                              //           borderRadius: BorderRadius.all(
                              //               Radius.circular(1)),
                              //           child:  ChewieListItem(
                              //             videoPlayerController:
                              //             VideoPlayerController.file(
                              //                 widget.path
                              //             ),
                              //           ),
                              //         ),
                              //         Center(
                              //           child: Positioned(
                              //               top: 60,
                              //               child: ClipOval(
                              //                 child: Material(
                              //                   color: Colors.blue, // button color
                              //                   child: SizedBox(
                              //                       width: 46,
                              //                       height: 46,
                              //                       child: Icon(Icons.play_arrow,
                              //                         color: Colors.white,
                              //                         size: 30,
                              //                       )),
                              //                 ),
                              //               )
                              //           ),
                              //
                              //
                              //         ),
                              //         Positioned(
                              //             left: 0,
                              //             bottom: 40,
                              //             child: Text(c)
                              //         ),
                              //
                              //       ],
                              //     ),
                              //   ),
                              // )
                              : Container()
                        ]),
                      ]);
                    }),
              ),
              Divider(),
              Container(
                height: 30,
                child: _privacyNtag,
              ),
              Divider(
                height: 0,
              ),
              _bottomLayer,
            ]);
          })),
    );
  }

  /* imgFromGallery(BuildContext context) async {
     File image = await ImagePicker.pickImage(
       source: ImageSource.gallery, imageQuality: 50);
        File _image;
       if(image != null){
         print(image);
          setState(() {
       _image = image;
     });
     // setState(() {
     //   files.add(File(_image));
     //  });
       }


     // Navigator.push(
     //   context,
     //   MaterialPageRoute(
     //     builder: (context) => DisplayPictureScreen1(imagePath: _image),
     //   ),
     // );

   }   */

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        context: context,
        builder: (builder) {
          return SingleChildScrollView(
            child: Container(
              //  height: 380.0,
              color:
                  Colors.transparent, //could change this to Color(0xFF737373),
              //so you don't have to change MaterialApp canvasColor
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0))),
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                  // color: HexColor("C4C4C4"),
                                  color: Colors.white,
                                  height: 3,
                                  width: 65),
                            ),
                          ]),
                    ),
                    SizedBox(height: 40),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        "Select Privacy",
                        style: TextStyle(
                            fontSize: 15,
                            // color: HexColor("666666"),
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      )
                    ]),
                    SizedBox(height: 40),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Stack(
                                      overflow: Overflow.visible,
                                      alignment: Alignment.bottomLeft,
                                      children: <Widget>[
                                        Container(
                                          child: CircleAvatar(
                                            backgroundColor: Colors.red,
                                            radius: 30.0,
                                            child: Container(
                                                alignment: Alignment.center,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 10, 0, 0),
                                                  child:
                                                      Image.asset(privacyEarth),
                                                )),
                                          ),
                                        ),
                                        Positioned(
                                          top: 30,
                                          left: 40,
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            child: Image.asset(rightMark),
                                          ),
                                        ),
                                      ]),
                                  SizedBox(width: 30),
                                  Text(
                                    "Everyone",
                                    style: TextStyle(
                                      fontSize: 12,
                                      // color: HexColor("666666")
                                      color: Colors.white,
                                    ),
                                  ),
                                ]),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.red,
                                    radius: 30.0,
                                    child: Image.asset(
                                      person,
                                    ),
                                  ),
                                  SizedBox(width: 30),
                                  Text(
                                    "People you follow",
                                    style: TextStyle(
                                      fontSize: 12,
                                      // color: HexColor("666666")
                                      color: Colors.white,
                                    ),
                                  ),
                                ]),
                          ),
                        ]),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 30.0,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Image.asset(lock),
                              ),
                            ),
                            SizedBox(width: 30),
                            Text(
                              "Only People you mention",
                              style: TextStyle(
                                fontSize: 12,
                                // color: HexColor("666666")
                                color: Colors.white,
                              ),
                            ),
                          ]),
                    ),
                  ])),
            ),
          );
        });
  }
}

class ChewieListItem extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;

  ChewieListItem({
    @required this.videoPlayerController,
    this.looping,
    Key key,
  }) : super(key: key);

  @override
  _ChewieListItemState createState() => _ChewieListItemState();
}

class _ChewieListItemState extends State<ChewieListItem> {
  ChewieController _chewieController;
  Future<void> _future;

  @override
  void initState() {
    super.initState();

    _future = initVideoPlayer();

    print("Video file length here");
    print(widget.videoPlayerController.value.aspectRatio);
    // _chewieController = ChewieController(
    //   videoPlayerController: widget.videoPlayerController,
    //   aspectRatio: 16 / 9,
    //   autoInitialize: true,
    //   looping: widget.looping,
    //   allowMuting: false,
    //   allowedScreenSleep: false,
    //   allowPlaybackSpeedChanging: false,
    //   showControlsOnInitialize: false,
    //   allowFullScreen: false,
    //   autoPlay: false,
    //   showControls: false,
    //   errorBuilder: (context, errorMessage) {
    //     return Center(
    //       child: Text(
    //         errorMessage,
    //         style: TextStyle(color: Colors.white),
    //       ),
    //     );
    //   },
    // )
  }

  Future<void> initVideoPlayer() async {
    await widget.videoPlayerController.initialize();
    setState(() {
      _chewieController = ChewieController(
          videoPlayerController: widget.videoPlayerController,
          aspectRatio: widget.videoPlayerController.value.aspectRatio,
          autoInitialize: true,
          looping: widget.looping,
          allowMuting: false,
          allowedScreenSleep: false,
          allowPlaybackSpeedChanging: false,
          showControlsOnInitialize: false,
          allowFullScreen: false,
          autoPlay: false,
          showControls: false,
          placeholder: buildPlaceholderImage());
    });
  }

  buildPlaceholderImage() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return buildPlaceholderImage();
        return Center(
          child: Chewie(
            controller: _chewieController,
          ),
        );
      },
    );
    // return Padding(
    //   padding:  EdgeInsets.all(8.0),
    //   child: Chewie(
    //     controller: _chewieController,
    //   ),
    // );
  }

  @override
  void dispose() {
    super.dispose();
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
  }
}
