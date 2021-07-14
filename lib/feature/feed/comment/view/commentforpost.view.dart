import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:farm_system/camera/video.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/farm_post/custom_gallery.dart';
import 'package:farm_system/feature/feed/models/ModelBasedonPostId.dart';
import 'package:farm_system/feature/feed/models/getFeed.model.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class CommentForPost extends StatefulWidget {
  final String post;
  final String profilePicUser;
  final String adminPicUser;
  final String postId;
  final File filePath;
  final String userNamePost;
  final String textTyped;
  //For Update Comment
  final String commentUpdate;
  final String userFile;
  final String postSecondaryName, famAll, subCateFarm;
  final String catId;
  final String subcateId;
  final String dataMediaId, dataLikeId;
  final String userId;
  final String profileSubTabId, mediaPost, subMediaCommentId, subMediaId, dataLikeMain, dataLikeSubId, likeSubId, likeSubComment;

  const CommentForPost(
      {Key key,
      this.post,
      this.profilePicUser,
      this.adminPicUser,
      this.postId,
      this.filePath,
      this.userNamePost,
      this.textTyped,
      this.commentUpdate,
      this.userFile,
      this.postSecondaryName,  this.famAll,  this.subCateFarm, this.catId, this.subcateId,
      this.dataMediaId,  this.dataLikeId,
      this.userId,  this.profileSubTabId,  this.mediaPost,  this.subMediaCommentId,  this.subMediaId,  this.dataLikeMain, this.dataLikeSubId,  this.likeSubId,
        this.likeSubComment,
      })
      : super(key: key);

  @override
  _CommentForPostState createState() => _CommentForPostState();
}

class _CommentForPostState extends State<CommentForPost> {
  final _captionController = TextEditingController();

  String commentImage = 'Comment Post';

  String _userName;

  File path;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("indside the comment post");
    print(widget.filePath);
    path = widget.filePath;
    _captionController.text = widget.textTyped;
    _userName = widget.post == null ? widget.userNamePost : widget.post;
  }

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

  @override
  Widget build(BuildContext context) {
    print("comment Image is here");

    print('USER id indieeee');
    print(widget.dataMediaId);

    final _bottomLayer = Container(
      alignment: Alignment.center,
      // color: Colors.black12,
      color: Colors.black,
      height: 40,
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: GestureDetector(
                  onTap: () {
                    //  _controller.dispose();


                    print(widget.post);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              // Video()),
                              CustomGallery(
                                commentPostImage: commentImage,
                                textTyped: _captionController.text,
                                profilePicUser: widget.profilePicUser,
                                adminPicUser: widget.adminPicUser,
                                userNamePost: widget.post,
                                postId: widget.postId,
                                postSecondaryName: widget.postSecondaryName,
                              )),
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
              widget.commentUpdate == 'Post Update' ?
              Container(
               // padding: EdgeInsets.only(left: 10),
                child: GestureDetector(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Video(
                            commentPostImage: widget.commentUpdate,
                            textTyped: _captionController.text,
                            profilePicUser: widget.profilePicUser,
                            adminPicUser: widget.adminPicUser,
                            userNamePost: widget.userNamePost,
                            postId: widget.postId,
                          )),
                    )
                  },
                  child: Container(
                      height: 25,
                      width: 25,
                      child: SvgPicture.asset(camera,
                          color: Colors.red, fit: BoxFit.none)),
                ),
              )
              : Container(
                //padding: EdgeInsets.only(left: 10),
                child: GestureDetector(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Video(
                                commentPostImage: commentImage,
                                textTyped: _captionController.text,
                                profilePicUser: widget.profilePicUser,
                                adminPicUser: widget.adminPicUser,
                                userNamePost: widget.post,
                                postId: widget.postId,
                              )),
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
            ]),
      ),
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer(builder: (context, watch, child) {
              final commentProviderRepo = watch(commentProvider);
              final feedProviderRepo = watch(feedProvider);
              final userProfileAllRepo = watch(userAllProvider);
              final profileSubTabRepo = watch(profileSubTabProvider);
              final userAllMedia = watch(userMedia);
              final mediaSubTabRepo = watch(mediaSubTabProvider);
              final userAllLikes = watch(userLikes);
              final LikeSubTabCategory = watch(LikeSubTabProvider);
              return Padding(
                padding:  EdgeInsets.only(right:20.0, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        child:  Icon(
                          Icons.arrow_back,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding:  EdgeInsets.only(left: 78.0),
                    //   child: Container(
                    //       width: 180,
                    //       height: 80,
                    //       child: SvgPicture.asset(newLogoFarm)),
                    // ),
                  widget.likeSubComment == 'likeSubComment' ?
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)),
                    onPressed: () async {
                      print('KJCGV GKJBDB');
                      print(widget.subMediaId);
                      print(widget.dataMediaId);
                      await commentProviderRepo.commentPost(
                          context,
                          widget.postId,
                          _captionController.text,
                          widget.filePath, widget.catId, widget.subcateId);



                      await  LikeSubTabCategory.LikeSubCategoryIndividual(widget.likeSubId, widget.dataLikeSubId);




                    },
                    color: Colors.red,
                    textColor: Colors.white,
                    child: Text("Comment",
                        style: TextStyle(fontSize: 14, letterSpacing: 2)),
                  ) :
                  widget.subMediaCommentId == 'subMediaCommentId' ?
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)),
                    onPressed: () async {
                      print('KJCGV GKJBDB');
                      print(widget.subMediaId);
                      print(widget.dataMediaId);
                      await commentProviderRepo.commentPost(
                          context,
                          widget.postId,
                          _captionController.text,
                          widget.filePath, widget.catId, widget.subcateId);



                        await  mediaSubTabRepo.mediaSubCategoryIndividual(widget.subMediaId, widget.dataMediaId);




                    },
                    color: Colors.red,
                    textColor: Colors.white,
                    child: Text("Comment",
                        style: TextStyle(fontSize: 14, letterSpacing: 2)),
                  ) :
                  widget.dataLikeMain == 'dataLikeMain' ?
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)),
                    onPressed: () async {
                      await commentProviderRepo.commentPost(
                          context,
                          widget.postId,
                          _captionController.text,
                          widget.filePath, widget.catId, widget.subcateId);
                        await  userAllLikes.getUserLikes(widget.dataLikeId);
                    },
                    color: Colors.red,
                    textColor: Colors.white,
                    child: Text("Comment",
                        style: TextStyle(fontSize: 14, letterSpacing: 2)),
                  ) :
                  widget.mediaPost == 'MediaPost' ?
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)),
                    onPressed: () async {
                      await commentProviderRepo.commentPost(
                          context,
                          widget.postId,
                          _captionController.text,
                          widget.filePath, '', '');
                      await userAllMedia.getUserMedia(widget.dataMediaId);
                    },
                    color: Colors.red,
                    textColor: Colors.white,
                    child: Text("Comment",
                        style: TextStyle(fontSize: 14, letterSpacing: 2)),
                  ) :
                  widget.dataMediaId != null ?
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)),
                    onPressed: () async {
                      await commentProviderRepo.commentPost(
                          context,
                          widget.postId,
                          _captionController.text,
                          widget.filePath, widget.catId, widget.subcateId);
                      await userAllMedia.getUserMedia(widget.dataMediaId);
                      // await mediaSubTabRepo.mediaSubCategoryIndividual(widget.dataMediaId,widget.userId);

                    },
                    color: Colors.red,
                    textColor: Colors.white,
                    child: Text("Comment hrb ejrh",
                        style: TextStyle(fontSize: 14, letterSpacing: 2)),
                  ) :
                  widget.commentUpdate == 'Post Update' ?
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)),
                    onPressed: () async {
                      print("updatedddddddd post viewwww");
                      print( widget.postId);
                      print( _captionController.text);
                      print(widget.filePath);
                      await commentProviderRepo.commentPostUpdate(
                          context,
                          widget.postId,
                          _captionController.text,
                          widget.filePath);
                      feedProviderRepo.getFeedUserInfo(widget.postId);
                      await userProfileAllRepo.userProfileAll(widget.postId);
                    },
                    color: Colors.red,
                    textColor: Colors.white,
                    child: Text("Comment",
                        style: TextStyle(fontSize: 14, letterSpacing: 2)),
                  )
                      : RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)),
                      onPressed: () async {
                        await commentProviderRepo.commentPost(
                            context,
                            widget.postId,
                            _captionController.text,
                            widget.filePath,
                          widget.catId,
                          widget.subcateId
                        );
                    if(widget.subCateFarm != null) {
                      await profileSubTabRepo.profileSubCategoryIndividual(widget.profileSubTabId,
                          widget.subCateFarm);

                      print(widget.profileSubTabId);
                      print(widget.subCateFarm);

                    }else{
                      await feedProviderRepo.getFeedUserInfo(widget.postId);
                      await feedProviderRepo.getFeedList();


                      await userProfileAllRepo.userProfileAll(widget.famAll);
                    }
                      },
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text("Comment",
                          style: TextStyle(fontSize: 14, letterSpacing: 2)),
                    ),
                  ],
                ),
              );
            }),
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left:8.0, right: 8.0),
                                child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                    child: CachedNetworkImage(
                                        fit: BoxFit.fill,
                                        height: 52,
                                        width: 52,
                                        imageUrl: widget.adminPicUser)),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          new Radius.circular(10.0)),
                                      color: Color(0xff222222)),
                                  child: TextFormField(
                                    controller: _captionController,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xffFFFFFF)
                                    ),
                                    // TextStyle(
                                    //     color: Colors.white
                                    // ),
                                    autofocus: true,
                                    minLines: 1,
                                    maxLines: null,
                                    maxLengthEnforced: true,
                                    cursorColor: Colors.white,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "What's happening?",
                                      // hintStyle: GoogleFonts.poppins(
                                      //   fontWeight: FontWeight.w400,
                                      //   fontSize: 15,
                                      //   color: Colors.white,
                                      // ),
                                    ),
                                  ),
                                ),
                              )
                            ]),
                      ),
                      Column(
                        children: [
                          widget.userFile != null ? Container(
                            child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                height: 52,
                                width: 52,
                                imageUrl: getImageUrl( widget.userFile)),
                          )
                              :
                          path != null
                              ?
                          // widget.portraits ?
                          imageFileTypes
                              .indexOf(path.path.split('.').last) !=
                              -1
                              ? Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Navigator.of(context)
                                  //     .push(SlideFromRight(
                                  //     widget: FullScreenView(
                                  //       filePaths: path,
                                  //     )));
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 30,
                                      right: 30,
                                      bottom: 30),
                                  child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(12.0),
                                    child: Image.file(path),
                                  ),
                                ),
                              ),
                              Positioned(
                                  right: 40,
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
                              // Navigator.of(context).push(SlideFromRight(
                              //     widget: FullScreenView(
                              //       filePaths: path,
                              //     )));
                            },
                            child: Container(
                              width:
                              MediaQuery.of(context).size.width,
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
                                  Positioned(
                                      top: 90,
                                      left: 160,
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
                                      )),
                                  Positioned(
                                      right: 0,
                                      top: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          // VideoPlayerController.file(
                                          //     path)
                                          //     .dispose();
                                          // setState(() {
                                          //   path = null;
                                          // });
                                        },
                                        child: Icon(Icons.close),
                                      )),
                                ],
                              ),
                            ),
                          )
                              : Container(),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Text(
              "Replying to:",
              style: TextStyle(color: Colors.white),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          height: 52,
                          width: 52,
                          imageUrl: widget.profilePicUser)),
                ),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     widget.postSecondaryName ?? '',
                     style:  GoogleFonts.montserrat(
                         fontSize: 14,
                         fontWeight: FontWeight.normal,
                         color: Color(0xff666666)
                     ),
                   ),
                   Text(
                     '@${_userName}',
                     style: GoogleFonts.montserrat(
                         fontSize: 14,
                         fontWeight: FontWeight.normal,
                         color: Color(0xff666666)
                     ),
                   ),
                 ],
               )
              ],
            ),
            _bottomLayer
          ],
        ),
      ),
    );
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
