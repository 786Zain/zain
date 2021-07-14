import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:farm_system/camera/video.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/farm_post/custom_gallery.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';


class SubCommentPostReply extends StatefulWidget {

  final String parentId;
  final String parentUserId;
  final String grandParentId;
  final String replying;
  final String commentPicUser;
  final String userProfile;
  final File filePath;
  final String textTyped;
  final String replyingName;
  final String commentUpdate;
  final String userMedia;
  final String replyingSecondaryName;
  final String replyingUserName;
  final String dataCheck, dataMedia, dataMediaId;
  final String userId, postSubReplyId, dataSubMedia, dataSubMediaId, dataLikeAll, dataLikeId;
  final String likeSubId, likeSubComment;

  const SubCommentPostReply({Key key, this.parentId, this.parentUserId,
    this.grandParentId, this.replying, this.commentPicUser, this.userProfile, this.filePath, this.textTyped, this.replyingName,
    this.commentUpdate, this.userMedia, this.replyingSecondaryName,  this.replyingUserName, this.dataCheck,  this.dataMedia,
    this.dataMediaId, this.userId,  this.postSubReplyId,  this.dataSubMedia,  this.dataSubMediaId,  this.dataLikeAll,  this.dataLikeId,
    this.likeSubId,  this.likeSubComment,
  }) : super(key: key);

  @override
  _SubCommentPostReplyState createState() => _SubCommentPostReplyState();
}

class _SubCommentPostReplyState extends State<SubCommentPostReply> {

  final _subCommentCaption = TextEditingController();

  String parentId;
  String parentUserId;
  String grandParentId;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    path = widget.filePath;

    parentId = widget.parentId;
    parentUserId = widget.parentUserId;
    grandParentId = widget.grandParentId;

    _subCommentCaption.text = widget.textTyped;
    // _userName = widget.post == null ? widget.userNamePost : widget.post;
  }
  File path;

  var imageFileTypes = ["png", "jpg", "jpeg", "gif", "JPG" , "PNG", "JPEG", "GIF", "HEIC"];

  @override
  Widget build(BuildContext context) {


    print("Image id before pushing");
    print(parentId);
    print(parentUserId);
    print(grandParentId);

    print("media id");
    print(widget.dataMediaId);

    String commentImage = 'Comment Reply';


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
                padding: EdgeInsets.only(left: 15, right: 25),
                child: GestureDetector(
                  onTap: () {
                    //  _controller.dispose();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          // Video()),
                          CustomGallery(
                              commentPostImage: commentImage,
                              textTyped: _subCommentCaption.text,
                              profilePicUser: widget.commentPicUser,
                              adminPicUser: widget.userProfile,
                              parentId: parentId,
                              parentUserId: parentUserId,
                              grandParentId: grandParentId,
                              replyingSecondaryName: widget.replyingSecondaryName,
                              replyingUserName: widget.replyingUserName,
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
              widget.commentUpdate == 'SubComment Update' ?
              Container(
                padding: EdgeInsets.only(left: 10),
                child: GestureDetector(
                  onTap: () => {


                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Video(
                          commentPostImage: widget.commentUpdate,
                          textTyped: _subCommentCaption.text,
                          profilePicUser: widget.commentPicUser,
                          adminPicUser: widget.userProfile,
                          parentId: parentId,
                          parentUserId: parentUserId,
                          grandParentId: grandParentId
                        // userNamePost: widget.post,
                        // postId:  widget.postId,
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
                padding: EdgeInsets.only(left: 10),
                child: GestureDetector(
                  onTap: () => {


                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Video(
                        commentPostImage: commentImage,
                        textTyped: _subCommentCaption.text,
                        profilePicUser: widget.commentPicUser,
                        adminPicUser: widget.userProfile,
                          parentId: parentId,
                          parentUserId: parentUserId,
                          grandParentId: grandParentId
                        // userNamePost: widget.post,
                        // postId:  widget.postId,
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
              Consumer(
              builder: (context, watch, child){

                final subCommentPostProviderRepo = watch(subCommentPostProvider);

                final subCommentProviderRepo =
                watch(subCommentFullPostViewProvider);

                final feedProviderRepo = watch(feedProvider);
                final nestedProviderRepo = watch(nestedProvider);
                final userAllMedia = watch(userMedia);
                final mediaSubTabRepo = watch(mediaSubTabProvider);
                final postRepliesRepo = watch(postRepliesProvider);
                final PostreplySubTabCategory = watch(PostReplySubTabProvider);
                final userAllLikes = watch(userLikes);
                final LikeSubTabCategory = watch(LikeSubTabProvider);
                return  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        child: Icon(Icons.close, color: Colors.white),
                      ),
                    ),
                   // Padding(padding: EdgeInsets.only(top: 15),
                   // child:  Container(
                   //     width: 160,
                   //     height: 80,
                   //     child: SvgPicture.asset(newLogoFarm)),
                   // ),
                    widget.likeSubComment == 'likeSubComment' ?
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right:20),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red)),
                        onPressed: () async{

                          print('yu kshb fd');
                          print(parentId);
                          print(parentUserId);
                          print(grandParentId);
                          print( widget.dataLikeId);


                          await subCommentPostProviderRepo.subCommentReplyToPost(
                              context,parentId, parentUserId, grandParentId, _subCommentCaption.text, widget.filePath
                          );
                         await  LikeSubTabCategory.LikeSubCategoryIndividual(widget.likeSubId,widget.dataMediaId);

                        },
                        color: Colors.red,
                        textColor: Colors.white,
                        child: Text("Comment Like",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2
                            )),
                      ),
                    ) :
                    widget.dataLikeAll == 'dataLikeAll' ?
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right:20),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red)),
                        onPressed: () async{

                          print('yu kshb fd');
                          print(parentId);
                          print(parentUserId);
                          print(grandParentId);
                          print( widget.dataLikeId);


                          await subCommentPostProviderRepo.subCommentReplyToPost(
                              context,parentId, parentUserId, grandParentId, _subCommentCaption.text, widget.filePath
                          );
                          await userAllLikes.getUserLikes(widget.dataLikeId);

                        },
                        color: Colors.red,
                        textColor: Colors.white,
                        child: Text("Comment Like",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2
                            )),
                      ),
                    ) :
                    widget.dataSubMedia == 'SubMedia'?
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right:20),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red)),
                        onPressed: () async{
                          await subCommentPostProviderRepo.subCommentReplyToPost(
                              context,parentId, parentUserId, grandParentId, _subCommentCaption.text, widget.filePath
                          );
                          mediaSubTabRepo.mediaSubCategoryIndividual(widget.dataSubMediaId, widget.dataMediaId);

                        },
                        color: Colors.red,
                        textColor: Colors.white,
                        child: Text("Comment",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2
                            )),
                      ),
                    ) :
                    widget.dataMedia == 'PostSubTab' ?
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right:20),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red)),
                        onPressed: () async{
                          await subCommentPostProviderRepo.subCommentReplyToPost(
                              context,parentId, parentUserId, grandParentId, _subCommentCaption.text, widget.filePath
                          );
                          PostreplySubTabCategory.PostReplySubCategoryIndividual(widget.postSubReplyId,widget.dataMediaId);

                        },
                        color: Colors.red,
                        textColor: Colors.white,
                        child: Text("Comment",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2
                            )),
                      ),
                    ) :
                    widget.dataMedia == 'Post Reply Profile' ?
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right:20),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red)),
                        onPressed: () async{

                          print('post replies');
                          print(parentId);
                          print(parentUserId);
                          print(grandParentId);
                          print( widget.dataMediaId);
                          await subCommentPostProviderRepo.subCommentReplyToPost(
                              context,parentId, parentUserId, grandParentId, _subCommentCaption.text, widget.filePath
                          );
                          postRepliesRepo.postRepliesProfile(widget.dataMediaId);

                        },
                        color: Colors.red,
                        textColor: Colors.white,
                        child: Text("Comment",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2
                            )),
                      ),
                    ) :
                    widget.dataMedia == 'Media' ?
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right:20),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red)),
                        onPressed: () async{
                          print("---------------------kndsj kj kjsdnk-------------------");
                          print(parentId);
                          print(parentUserId);
                          print(grandParentId);

                          await subCommentPostProviderRepo.subCommentReplyToPost(
                              context,parentId, parentUserId, grandParentId, _subCommentCaption.text, widget.filePath
                          );
                          await userAllMedia.getUserMedia(widget.dataMediaId);
                          await mediaSubTabRepo.mediaSubCategoryIndividual(widget.dataMediaId,widget.userId);

                       //
                          // await nestedProviderRepo.getNestedReplyCommentView(parentId);
                          // await subCommentProviderRepo.getSubCommentView(grandParentId);
                          // await feedProviderRepo.getFeedUserInfo(parentUserId);




                          // await nestedProviderRepo.getNestedReplyCommentView(grandParentId);


                          // await feedProviderRepo.getFeedUserInfo(grandParentId);
                          // await nestedProviderRepo.getNestedReplyCommentView(grandParentId);
                          // await subCommentProviderRepo.getSubCommentView(grandParentId);


                          // await subCommentProviderRepo.getSubCommentView(parentId);
                          // await nestedProviderRepo.getNestedReplyCommentView(grandParentId);
                          // await feedProviderRepo.getFeedUserInfo(grandParentId);



                        },
                        color: Colors.red,
                        textColor: Colors.white,
                        child: Text("Comment Media",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2
                            )),
                      ),
                    ) :
                    widget.dataCheck == 'Data Checks' ?
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right:20),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red)),
                        onPressed: () async{
                          print("---------------------kndsj kj kjsdnk-------------------");
                          print(parentId);
                          print(parentUserId);
                          print(grandParentId);

                          await subCommentPostProviderRepo.subCommentReplyToPost(
                              context,parentId, parentUserId, grandParentId, _subCommentCaption.text, widget.filePath
                          );
                          await nestedProviderRepo.getNestedReplyCommentView(parentId);
                          await subCommentProviderRepo.getSubCommentView(grandParentId);
                          await feedProviderRepo.getFeedUserInfo(parentUserId);




                          // await nestedProviderRepo.getNestedReplyCommentView(grandParentId);


                          // await feedProviderRepo.getFeedUserInfo(grandParentId);
                          // await nestedProviderRepo.getNestedReplyCommentView(grandParentId);
                          // await subCommentProviderRepo.getSubCommentView(grandParentId);


                          // await subCommentProviderRepo.getSubCommentView(parentId);
                          // await nestedProviderRepo.getNestedReplyCommentView(grandParentId);
                          // await feedProviderRepo.getFeedUserInfo(grandParentId);



                        },
                        color: Colors.red,
                        textColor: Colors.white,
                        child: Text("Comment",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2
                            )),
                      ),
                    ) :
                 widget.commentUpdate == 'SubComment Update' ?
                 RaisedButton(
                   shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(18.0),
                       side: BorderSide(color: Colors.red)),
                   onPressed: () async{
                     print("---------------------inside the dataa-------------------");
                     print(parentId);
                     print(parentUserId);
                     print(grandParentId);

                     await subCommentPostProviderRepo.subCommentReplyToPostUpdated(
                         context,parentId, parentUserId, grandParentId, _subCommentCaption.text, widget.filePath
                     );
                   await  subCommentProviderRepo.getSubCommentView(parentId);

                  await   nestedProviderRepo.getNestedReplyCommentView(parentId);



                   },
                   color: Colors.red,
                   textColor: Colors.white,
                   child: Text("Comment updateeee",
                       style: TextStyle(
                           fontSize: 14,
                           letterSpacing: 2
                       )),
                 )
                 : Padding(
                padding: const EdgeInsets.only(left: 10, right:20),
                   child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red)),
                        onPressed: () async{
                          print("---------------------kndsj kj kjsdnk-------------------");
                          print(parentId);
                          print(parentUserId);
                          print(grandParentId);

                          await subCommentPostProviderRepo.subCommentReplyToPost(
                              context,parentId, parentUserId, grandParentId, _subCommentCaption.text, widget.filePath
                          );

                          if(widget.dataCheck == "Data Check"){
                            await feedProviderRepo.getFeedUserInfo(grandParentId);
                            await nestedProviderRepo.getNestedReplyCommentView(grandParentId);
                            await subCommentProviderRepo.getSubCommentView(grandParentId);
                          }else{
                            await subCommentProviderRepo.getSubCommentView(parentId);
                            await nestedProviderRepo.getNestedReplyCommentView(grandParentId);
                            await feedProviderRepo.getFeedUserInfo(grandParentId);
                          }

                          // await feedProviderRepo.getFeedUserInfo(grandParentId);
                          // await nestedProviderRepo.getNestedReplyCommentView(grandParentId);
                          // await subCommentProviderRepo.getSubCommentView(grandParentId);


                            // await subCommentProviderRepo.getSubCommentView(parentId);
                            // await nestedProviderRepo.getNestedReplyCommentView(grandParentId);
                            // await feedProviderRepo.getFeedUserInfo(grandParentId);



                        },
                        color: Colors.red,
                        textColor: Colors.white,
                        child: Text("Comment",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2
                            )),
                      ),
                 ),
                  ],
                );
              }
              ),
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
                                  padding: EdgeInsets.only(left:8.0, right:8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(25)),
                                    child: CachedNetworkImage(
                                        fit: BoxFit.fill,
                                        height: 52,
                                        width: 52,
                                        imageUrl: widget.userProfile),
                                  ),
                                ),
                                // Padding(
                                //   padding: EdgeInsets.all(8.0),
                                //   child:  ClipRRect(
                                //       borderRadius:
                                //       BorderRadius.all(Radius.circular(20)),
                                //       child:
                                //       CachedNetworkImage(
                                //           fit: BoxFit.fill,
                                //           height: 52,
                                //           width: 52,
                                //           imageUrl:  widget.userProfile)
                                //   ),
                                // ),
                                Expanded(
                                  child: Container(

                                    decoration: BoxDecoration (
                                        borderRadius: BorderRadius.all(new Radius.circular(10.0)),
                                        color: Colors.white30
                                    ),
                                    child: TextFormField(
                                      controller: _subCommentCaption,
                                      style: TextStyle(
                                          color: Colors.white
                                      ),
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
                              ]
                          ),
                        ),
                        Column(
                          children: [
                            widget.userMedia != null ? Container(
                              child: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  height: 52,
                                  width: 52,
                                  imageUrl: getImageUrl( widget.userMedia)),
                            ):
                            path  != null
                                ?
                            // widget.portraits ?
                            imageFileTypes.indexOf(path.path.split('.').last) !=
                                -1
                                ?
                            Stack(
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
                                        left: 30, right: 30, bottom: 30),
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
                                width: MediaQuery.of(context).size.width,
                                height:
                                MediaQuery.of(context).size.height /
                                    2.2,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(1)),
                                      child:
                                      ChewieListItem(
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
                                            VideoPlayerController.file(
                                                path)
                                                .dispose();
                                            setState(() {
                                              path = null;
                                            });
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
              Text("Replying to:",
                style: TextStyle(
                    color: Colors.white
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child:  ClipRRect(
                        borderRadius:
                        BorderRadius.all(Radius.circular(25)),
                       child:
                        CachedNetworkImage(
                            fit: BoxFit.fill,
                            height: 52,
                            width: 52,
                            imageUrl: widget.commentPicUser)
                    ),
                  ),
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(widget.replyingSecondaryName,
                       style:  GoogleFonts.montserrat(
                           fontSize: 14,
                           fontWeight: FontWeight.normal,
                           color: Color(0xff666666)
                       ),
                     ),
                     Text('@${widget.replyingUserName}',
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
              _bottomLayer,
            ],
          ),
        )
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
