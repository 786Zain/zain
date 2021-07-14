import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:farm_system/feature/edit_setup/view/edit_profile.dart';
import 'package:farm_system/feature/farm_post/farm_post.dart';
import 'package:farm_system/feature/feed/comment/view/commentforpost.view.dart';
import 'package:farm_system/feature/feed/subcommentPostReply/view/subcomment.view.dart';
import 'package:farm_system/feature/message/view/message.dart';
import 'package:farm_system/navigator.dart';
import 'package:farm_system/post_tweet/post_tweet.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:video_player/video_player.dart' as PackagageVideoPlayer;
import 'package:video_player/video_player.dart';

// class DisplayPictureScreen1 extends StatelessWidget {
//   final File imagePath;
//
//   const DisplayPictureScreen1({Key key, this.imagePath}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//
//
//     var imageFileTypes = ["png", "jpg", "jpeg", "gif"];
//
//     PackagageVideoPlayer.VideoPlayerController __controller;
//
//     return Scaffold(
//       body: Center(
//         child: Container(
//           color: Colors.black,
//           child: imageFileTypes.indexOf(imagePath.path.split('.').last)  != -1
//               ? Column(
//             children: [
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height / 1.1,
//                 decoration: BoxDecoration(
//                     image: DecorationImage(
//                         image: FileImage(imagePath), fit: BoxFit.fill)),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 8,left: 8, right: 8),
//                 child: Positioned(
//                   bottom: 12,
//                   left: 12,
//                   right: 12,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       RaisedButton(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(18.0),
//                             side: BorderSide(color: Colors.transparent)),
//                         onPressed: () {
//                           AppNavigator.pop();
//                         },
//                         color: Colors.white,
//                         textColor: Color(0xffD41B47),
//                         child: Text("RETAKE",
//                             style: TextStyle(
//                                 fontSize: 14,
//                               letterSpacing: 2
//                             )),
//                       ),
//                       // RaisedButton(
//                       //   onPressed: () {
//                       //     AppNavigator.pop();
//                       //   },
//                       //   textColor: Colors.blue,
//                       //   child: Container(
//                       //     decoration:
//                       //     BoxDecoration(color: Colors.transparent),
//                       //     child: Container(child: Text("Retake")),
//                       //   ),
//                       // ),
//                       SizedBox(
//                         width: 53,
//                       ),
//                       RaisedButton(
//                         onPressed: () {
//                           Navigator.pushAndRemoveUntil(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                     FarmPost(filePath: imagePath)),
//                                 (Route<dynamic> route) => false,
//                           );
//                         },
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(18.0),
//                             side: BorderSide(color: Colors.transparent)),
//                         color: Color(0xffD41B47),
//                         textColor: Colors.white,
//                         child: Text("USE",
//                             style: TextStyle(
//                                 fontSize: 14,
//                               letterSpacing: 2
//                             )),
//                       ),
//                       // RaisedButton(
//                       //   onPressed: () {
//                       //     Navigator.pushAndRemoveUntil(
//                       //       context,
//                       //       MaterialPageRoute(
//                       //           builder: (context) =>
//                       //               FarmPost(filePath: imagePath)),
//                       //           (Route<dynamic> route) => false,
//                       //     );
//                       //   },
//                       //   textColor: Colors.blue,
//                       //   child: Container(
//                       //     decoration:
//                       //     BoxDecoration(color: Colors.transparent),
//                       //     child: Container(child: Text("Use Photo")),
//                       //   ),
//                       // ),
//                     ],
//                   ),
//                 ),
//               ),
//               // Stack(
//               //   children: [
//               //     Container(
//               //       width: MediaQuery.of(context).size.width,
//               //       decoration: BoxDecoration(
//               //           image: DecorationImage(
//               //               image: FileImage(imagePath), fit: BoxFit.fill)),
//               //     ),
//               //     Positioned(
//               //       bottom: 12,
//               //       left: 12,
//               //       right: 12,
//               //       child: Row(
//               //         mainAxisAlignment: MainAxisAlignment.center,
//               //         children: [
//               //           RaisedButton(
//               //             onPressed: () {
//               //               AppNavigator.pop();
//               //             },
//               //             textColor: Colors.blue,
//               //             child: Container(
//               //               decoration:
//               //               BoxDecoration(color: Colors.transparent),
//               //               child: Container(child: Text("Retake")),
//               //             ),
//               //           ),
//               //           SizedBox(
//               //             width: 53,
//               //           ),
//               //           RaisedButton(
//               //             onPressed: () {
//               //               Navigator.pushAndRemoveUntil(
//               //                 context,
//               //                 MaterialPageRoute(
//               //                     builder: (context) =>
//               //                         FarmPost(filePath: imagePath)),
//               //                     (Route<dynamic> route) => false,
//               //               );
//               //             },
//               //             textColor: Colors.blue,
//               //             child: Container(
//               //               decoration:
//               //               BoxDecoration(color: Colors.transparent),
//               //               child: Container(child: Text("Use Photo")),
//               //             ),
//               //           ),
//               //         ],
//               //       ),
//               //     ),
//               //   ],
//               // )
//             ],
//           )
//               : Column(
//             children: [
//               Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height / 1.1,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.all(
//                       Radius.circular(20)),
//                   child:  ChewieListItem(
//                     videoPlayerController:
//                     VideoPlayerController
//                         .file(
//                         imagePath
//                     ),
//                   ),
//                 )
//               ),
//               Positioned(
//                 bottom: 12,
//                 left: 12,
//                 right: 12,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     RaisedButton(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(18.0),
//                           side: BorderSide(color: Colors.transparent)),
//                       onPressed: () {
//                         AppNavigator.pop();
//                       },
//                       color: Colors.white,
//                       textColor: Colors.red,
//                       child: Text("RETAKE",
//                           style: TextStyle(fontSize: 14)),
//                     ),
//                     // RaisedButton(
//                     //   onPressed: () {
//                     //     AppNavigator.pop();
//                     //   },
//                     //   textColor: Colors.blue,
//                     //   child: Container(
//                     //     decoration:
//                     //     BoxDecoration(color: Colors.transparent),
//                     //     child: Container(child: Text("Retake")),
//                     //   ),
//                     // ),
//                     SizedBox(
//                       width: 53,
//                     ),
//                     RaisedButton(
//                       onPressed: () {
//                         Navigator.pushAndRemoveUntil(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   FarmPost(filePath: imagePath)),
//                               (Route<dynamic> route) => false,
//                         );
//                       },
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(18.0),
//                           side: BorderSide(color: Colors.transparent)),
//                       color: Colors.red,
//                       textColor: Colors.white,
//                       child: Text("USE",
//                           style: TextStyle(fontSize: 14)),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           )
//           // Image.network(
//           //         'https://picsum.photos/250?image=9',
//           //       ),
//         ),
//       ),
//     );
//   }
// }
//
// class ChewieListItem extends StatefulWidget {
//   final VideoPlayerController videoPlayerController;
//   final bool looping;
//
//   ChewieListItem({
//     @required this.videoPlayerController,
//     this.looping,
//     Key key,
//   }) : super(key: key);
//
//   @override
//   _ChewieListItemState createState() => _ChewieListItemState();
// }
//
// class _ChewieListItemState extends State<ChewieListItem> {
//   ChewieController _chewieController;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _chewieController = ChewieController(
//       videoPlayerController: widget.videoPlayerController,
//       aspectRatio: 16 / 9,
//       autoInitialize: true,
//       looping: widget.looping,
//      allowMuting: false,
//       allowedScreenSleep: false,
//       allowPlaybackSpeedChanging: false,
//       showControlsOnInitialize: false,
//       allowFullScreen: false,
//       autoPlay: true,
//       errorBuilder: (context, errorMessage) {
//         return Center(
//           child: Text(
//             errorMessage,
//             style: TextStyle(color: Colors.white),
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         child: Chewie(
//           controller: _chewieController,
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     widget.videoPlayerController.dispose();
//     _chewieController.dispose();
//     super.dispose();
//   }
// }


class DisplayPictureScreen1 extends StatefulWidget {
  final File imagePath;
  final bool portrait;
  final String textTyped;
  final String id;
  final String subCategory;
  final String commentPostImage;
  final String profilePicUser;
  final String adminPicUser;
  final String userNamePost;
  final String postId;
  final String parentId, parentUserId, grandParentId;
  final String subcategoryId, mainCategoryId;
  final String userId;
  final String userName;
  final String postSecondaryName;
  final String replyingSecondaryName;
  final String replyingUserName;

  const DisplayPictureScreen1({Key key, this.imagePath, this.portrait, this.textTyped, this.id, this.subCategory,
    this.commentPostImage, this.profilePicUser, this.adminPicUser, this.userNamePost, this.postId,
    this.parentId, this.parentUserId, this.grandParentId, this.subcategoryId, this.mainCategoryId, this.userId,this.userName,  this.postSecondaryName,
    this.replyingSecondaryName, this.replyingUserName
  }) : super(key: key);
  @override
  _DisplayPictureScreen1State createState() => _DisplayPictureScreen1State();
}

class _DisplayPictureScreen1State extends State<DisplayPictureScreen1> {

  // final GlobalKey _videoKeys = GlobalKey();
  Size videoSize;
  Offset videoPostion;

  PackagageVideoPlayer.VideoPlayerController _controller;

  Duration duration;
  VideoPlayerController __controller;
  ChewieController _chewieController;
  Future<void> _future;
  List<String> imageFileTypes = ["png", "jpg", "jpeg", "gif", "JPG" , "PNG", "JPEG", "GIF", "HEIC"];

  String parentId;
  String parentUserId;
  String grandParentId;


  void getVideo() async {
    _controller = PackagageVideoPlayer.VideoPlayerController.file(widget.imagePath)
      ..initialize().then((_) {
        duration = _controller.value.duration;
      });
  }


  @override
  void initState() {

    print("widget -------------------------------------------------------------------${widget.imagePath}");


    print("comment nameee here is coming");
    print(widget.commentPostImage);

    if(imageFileTypes.indexOf(widget.imagePath.path.split(".").last) == -1 ){
      getVideo();
      __controller =  VideoPlayerController.file(widget.imagePath);
      _future = initVideoPlayer();
    }

    super.initState();

    print("coming inside gallery button");
    print(widget.parentId);
    print(widget.parentUserId);
    print(widget.grandParentId);

    parentId = widget.parentId;
    parentUserId = widget.parentUserId;
    grandParentId = widget.grandParentId;

    // __controller =  VideoPlayerController.file(widget.imagePath)
    //   ..addListener(() => setState(() {}))
    //   ..initialize().then((_) =>{
    //     duration = _controller.value.duration,
    //   });

    // WidgetsBinding.instance.addPostFrameCallback((_)=> getVideoSizeAndPosition());

  }


  // getVideoSizeAndPosition(){
  //
  //   RenderBox _videoBox = _videoKeys.currentContext.findRenderObject();
  //   videoSize = _videoBox.size;
  //   videoPostion = _videoBox.localToGlobal(Offset.zero);
  //
  //   print("video size");
  //   print(videoSize);
  //   print(videoPostion);
  // }

  @override
  void dispose() {
    __controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  Future<void> initVideoPlayer() async{
    await __controller.initialize();
    setState(() {
      _chewieController = ChewieController(
          videoPlayerController: __controller,
          aspectRatio: __controller.value.aspectRatio,
          autoPlay: true,
          looping: true,
          allowMuting: false,
          allowPlaybackSpeedChanging: false,
          showControlsOnInitialize: false,
          placeholder: buildPlaceholderImage()
      );
    });
  }

  buildPlaceholderImage(){
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.blue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    print("valueeee for comment");
    print(widget.commentPostImage);

    return Scaffold(
      body: Center(
        child:

widget.commentPostImage == 'Crop' ?
Container(
    color: Colors.black,
    child:  imageFileTypes.indexOf(widget.imagePath.path.split('.').last)  != -1
        ?
   Consumer(
       builder: (context, watch, child){
         final postProviderRepo = watch(postProvider);
         return  Column(
           children: [
             Stack(
                 children : [
                   Container(
                     width: MediaQuery.of(context).size.width,
                     height: MediaQuery.of(context).size.height / 1.1,
                     decoration: BoxDecoration(
                         image: DecorationImage(
                           image: FileImage(widget.imagePath),)),
                   ),
                   Positioned(
                     bottom: 1,
                     left: 12,
                     right: 12,
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         RaisedButton(
                           shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(18.0),
                               side: BorderSide(color: Colors.transparent)),
                           onPressed: () {
                             AppNavigator.pop();
                           },
                           color: Colors.white,
                           textColor: Color(0xffD41B47),
                           child: Text("RETAKE",
                               style: TextStyle(
                                   fontSize: 14,
                                   letterSpacing: 2
                               )),
                         ),
                         SizedBox(
                           width: 53,
                         ),
                         RaisedButton(
                           onPressed: () async {
                             postProviderRepo.fetchingCropCamera(
                                 context, widget.imagePath,
                             );
                           },
                           shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(18.0),
                               side: BorderSide(color: Colors.transparent)),
                           color: Color(0xffD41B47),
                           textColor: Colors.white,
                           child: Text("USE",
                               style: TextStyle(
                                   fontSize: 14,
                                   letterSpacing: 2
                               )),
                         ),
                       ],
                     ),
                   ),
                 ]
             )
           ],
         );
       }
   )
        : Container(

      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: 10
            ),
            child: _chewieController != null &&
                _chewieController.videoPlayerController.value.initialized
                ?
            FutureBuilder(
              future: _future,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting) return buildPlaceholderImage();
                return Center(
                  child: Chewie(
                    controller: _chewieController,
                  ),
                );
              },
            )
                :

            FutureBuilder(
              future: _future,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting) return buildPlaceholderImage();
                return Center(
                  child: Chewie(
                    controller: _chewieController,
                  ),
                );
              },
            ),



            // FutureBuilder(
            //   future: _future,
            //   builder: (context, snapshot){
            //     if(snapshot.connectionState == ConnectionState.waiting) return buildPlaceholderImage();
            //     return Center(
            //      child: Chewie(
            //         controller: _chewieController,
            //       ),
            //     );
            //   },
            // ),
          ),
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.transparent)),
                  onPressed: () {
                    _controller.dispose();
                    AppNavigator.pop();
                  },
                  color: Colors.white,
                  textColor: Colors.red,
                  child: Text("RETAKE",
                      style: TextStyle(fontSize: 14)),
                ),
                // RaisedButton(
                //   onPressed: () {
                //     AppNavigator.pop();
                //   },
                //   textColor: Colors.blue,
                //   child: Container(
                //     decoration:
                //     BoxDecoration(color: Colors.transparent),
                //     child: Container(child: Text("Retake")),
                //   ),
                // ),
                SizedBox(
                  width: 53,
                ),
                RaisedButton(
                  onPressed: () {
                    _controller.dispose();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SubCommentPostReply(
                                // filePath: widget.imagePath,
                                // profilePicUser: widget.profilePicUser,
                                // adminPicUser: widget.adminPicUser,
                                // userNamePost: widget.userNamePost,
                                // textTyped: widget.commentPostImage,
                                // postId: widget.postId,
                                filePath: widget.imagePath,
                                commentPicUser: widget.profilePicUser,
                                userProfile: widget.adminPicUser,
                                // userNamePost: widget.userNamePost,
                                textTyped: widget.textTyped,
                                parentId: parentId,
                                parentUserId: parentUserId,
                                grandParentId: grandParentId,

                                // portraits: widget.portrait,
                              )),
                          (Route<dynamic> route) => false,
                    );
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.transparent)),
                  color: Colors.red,
                  textColor: Colors.white,
                  child: Text("USE bhxd",
                      style: TextStyle(fontSize: 14)),
                ),
              ],
            ),
          ),
        ],
      ),
    )
  // Column(
  //   children: [
  //     // Container(
  //     //     width: MediaQuery.of(context).size.width,
  //     //     height: MediaQuery.of(context).size.height / 1.1,
  //     //     child: ChewieListItem(
  //     //       videoPlayerController:
  //     //       VideoPlayerController
  //     //           .file(
  //     //           widget.imagePath
  //     //       ),
  //     //     )
  //     // ),
  //     FutureBuilder(
  //       future: _future,
  //       builder: (context, snapshot){
  //         if(snapshot.connectionState == ConnectionState.waiting) return buildPlaceholderImage();
  //
  //         return Center(
  //           child: Chewie(controller: _chewieController,),
  //         );
  //       },
  //     ),
  //     Positioned(
  //       bottom: 12,
  //       left: 12,
  //       right: 12,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           RaisedButton(
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(18.0),
  //                 side: BorderSide(color: Colors.transparent)),
  //             onPressed: () {
  //               AppNavigator.pop();
  //             },
  //             color: Colors.white,
  //             textColor: Colors.red,
  //             child: Text("RETAKE",
  //                 style: TextStyle(fontSize: 14)),
  //           ),
  //           // RaisedButton(
  //           //   onPressed: () {
  //           //     AppNavigator.pop();
  //           //   },
  //           //   textColor: Colors.blue,
  //           //   child: Container(
  //           //     decoration:
  //           //     BoxDecoration(color: Colors.transparent),
  //           //     child: Container(child: Text("Retake")),
  //           //   ),
  //           // ),
  //           SizedBox(
  //             width: 53,
  //           ),
  //           RaisedButton(
  //             onPressed: () {
  //               Navigator.pushAndRemoveUntil(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) =>
  //                         FarmPost(filePath: widget.imagePath,
  //                         duration: duration,
  //                         )),
  //                     (Route<dynamic> route) => false,
  //               );
  //             },
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(18.0),
  //                 side: BorderSide(color: Colors.transparent)),
  //             color: Colors.red,
  //             textColor: Colors.white,
  //             child: Text("USE",
  //                 style: TextStyle(fontSize: 14)),
  //           ),
  //         ],
  //       ),
  //     ),
  //   ],
  // )
  // Image.network(
  //         'https://picsum.photos/250?image=9',
  //       ),
)
    :
widget.commentPostImage == 'Cover' ? Container(
    color: Colors.black,
    child:  imageFileTypes.indexOf(widget.imagePath.path.split('.').last)  != -1
        ?
    Consumer(
    builder: (context, watch, child){
    final postProviderRepo = watch(postProvider);
    return Column(
      children: [
        Stack(
            children : [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.1,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(widget.imagePath),)),
              ),
              Positioned(
                bottom: 1,
                left: 12,
                right: 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.transparent)),
                      onPressed: () {
                        AppNavigator.pop();
                      },
                      color: Colors.white,
                      textColor: Color(0xffD41B47),
                      child: Text("RETAKE",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2
                          )),
                    ),
                    SizedBox(
                      width: 53,
                    ),
                    RaisedButton(
                      onPressed: () {
                        postProviderRepo.fetchingCropCoverCamera(
                          context, widget.imagePath,
                        );
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.transparent)),
                      color: Color(0xffD41B47),
                      textColor: Colors.white,
                      child: Text("USE",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2
                          )),
                    ),
                  ],
                ),
              ),
            ]
        ),
      ],
    );})
        : Container(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: 10
            ),
            child: _chewieController != null &&
                _chewieController.videoPlayerController.value.initialized
                ?
            FutureBuilder(
              future: _future,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting) return buildPlaceholderImage();
                return Center(
                  child: Chewie(
                    controller: _chewieController,
                  ),
                );
              },
            )
                :

            FutureBuilder(
              future: _future,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting) return buildPlaceholderImage();
                return Center(
                  child: Chewie(
                    controller: _chewieController,
                  ),
                );
              },
            ),



            // FutureBuilder(
            //   future: _future,
            //   builder: (context, snapshot){
            //     if(snapshot.connectionState == ConnectionState.waiting) return buildPlaceholderImage();
            //     return Center(
            //      child: Chewie(
            //         controller: _chewieController,
            //       ),
            //     );
            //   },
            // ),
          ),
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.transparent)),
                  onPressed: () {
                    _controller.dispose();
                    AppNavigator.pop();
                  },
                  color: Colors.white,
                  textColor: Colors.red,
                  child: Text("RETAKE",
                      style: TextStyle(fontSize: 14)),
                ),
                // RaisedButton(
                //   onPressed: () {
                //     AppNavigator.pop();
                //   },
                //   textColor: Colors.blue,
                //   child: Container(
                //     decoration:
                //     BoxDecoration(color: Colors.transparent),
                //     child: Container(child: Text("Retake")),
                //   ),
                // ),
                SizedBox(
                  width: 53,
                ),
                RaisedButton(
                  onPressed: () {
                    _controller.dispose();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SubCommentPostReply(
                                // filePath: widget.imagePath,
                                // profilePicUser: widget.profilePicUser,
                                // adminPicUser: widget.adminPicUser,
                                // userNamePost: widget.userNamePost,
                                // textTyped: widget.commentPostImage,
                                // postId: widget.postId,
                                filePath: widget.imagePath,
                                commentPicUser: widget.profilePicUser,
                                userProfile: widget.adminPicUser,
                                // userNamePost: widget.userNamePost,
                                textTyped: widget.textTyped,
                                parentId: parentId,
                                parentUserId: parentUserId,
                                grandParentId: grandParentId,

                                // portraits: widget.portrait,
                              )),
                          (Route<dynamic> route) => false,
                    );
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.transparent)),
                  color: Colors.red,
                  textColor: Colors.white,
                  child: Text("USE bhxd",
                      style: TextStyle(fontSize: 14)),
                ),
              ],
            ),
          ),
        ],
      ),
    )
  // Column(
  //   children: [
  //     // Container(
  //     //     width: MediaQuery.of(context).size.width,
  //     //     height: MediaQuery.of(context).size.height / 1.1,
  //     //     child: ChewieListItem(
  //     //       videoPlayerController:
  //     //       VideoPlayerController
  //     //           .file(
  //     //           widget.imagePath
  //     //       ),
  //     //     )
  //     // ),
  //     FutureBuilder(
  //       future: _future,
  //       builder: (context, snapshot){
  //         if(snapshot.connectionState == ConnectionState.waiting) return buildPlaceholderImage();
  //
  //         return Center(
  //           child: Chewie(controller: _chewieController,),
  //         );
  //       },
  //     ),
  //     Positioned(
  //       bottom: 12,
  //       left: 12,
  //       right: 12,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           RaisedButton(
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(18.0),
  //                 side: BorderSide(color: Colors.transparent)),
  //             onPressed: () {
  //               AppNavigator.pop();
  //             },
  //             color: Colors.white,
  //             textColor: Colors.red,
  //             child: Text("RETAKE",
  //                 style: TextStyle(fontSize: 14)),
  //           ),
  //           // RaisedButton(
  //           //   onPressed: () {
  //           //     AppNavigator.pop();
  //           //   },
  //           //   textColor: Colors.blue,
  //           //   child: Container(
  //           //     decoration:
  //           //     BoxDecoration(color: Colors.transparent),
  //           //     child: Container(child: Text("Retake")),
  //           //   ),
  //           // ),
  //           SizedBox(
  //             width: 53,
  //           ),
  //           RaisedButton(
  //             onPressed: () {
  //               Navigator.pushAndRemoveUntil(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) =>
  //                         FarmPost(filePath: widget.imagePath,
  //                         duration: duration,
  //                         )),
  //                     (Route<dynamic> route) => false,
  //               );
  //             },
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(18.0),
  //                 side: BorderSide(color: Colors.transparent)),
  //             color: Colors.red,
  //             textColor: Colors.white,
  //             child: Text("USE",
  //                 style: TextStyle(fontSize: 14)),
  //           ),
  //         ],
  //       ),
  //     ),
  //   ],
  // )
  // Image.network(
  //         'https://picsum.photos/250?image=9',
  //       ),
) :

widget.commentPostImage == 'SubComment Update' ?
Container(
    color: Colors.black,
    child:  imageFileTypes.indexOf(widget.imagePath.path.split('.').last)  != -1
        ?
    Column(
      children: [
        Stack(
            children : [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.1,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(widget.imagePath),)),
              ),
              Positioned(
                bottom: 1,
                left: 12,
                right: 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.transparent)),
                      onPressed: () {
                        AppNavigator.pop();
                      },
                      color: Colors.white,
                      textColor: Color(0xffD41B47),
                      child: Text("RETAKE",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2
                          )),
                    ),
                    SizedBox(
                      width: 53,
                    ),
                    RaisedButton(
                      onPressed: () {

                        print("coming inside for useeeeeeeeeeeeeeeeee");
                        print(widget.parentId);
                        print(widget.parentUserId);
                        print(widget.grandParentId);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SubCommentPostReply(
                                    filePath: widget.imagePath,
                                    commentPicUser: widget.profilePicUser,
                                    userProfile: widget.adminPicUser,
                                    // userNamePost: widget.userNamePost,
                                    textTyped: widget.textTyped,
                                    parentId: parentId,
                                    parentUserId: parentUserId,
                                    grandParentId: grandParentId,
                                    commentUpdate : widget.commentPostImage,
                                    // postId: widget.postId,

                                    // portraits: widget.portrait,
                                  )),
                              (Route<dynamic> route) => false,
                        );
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.transparent)),
                      color: Color(0xffD41B47),
                      textColor: Colors.white,
                      child: Text("USE",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2
                          )),
                    ),
                  ],
                ),
              ),
            ]
        ),
      ],
    )
        : Container(

      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: 10
            ),
            child: _chewieController != null &&
                _chewieController.videoPlayerController.value.initialized
                ?
            FutureBuilder(
              future: _future,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting) return buildPlaceholderImage();
                return Center(
                  child: Chewie(
                    controller: _chewieController,
                  ),
                );
              },
            )
                :

            FutureBuilder(
              future: _future,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting) return buildPlaceholderImage();
                return Center(
                  child: Chewie(
                    controller: _chewieController,
                  ),
                );
              },
            ),



            // FutureBuilder(
            //   future: _future,
            //   builder: (context, snapshot){
            //     if(snapshot.connectionState == ConnectionState.waiting) return buildPlaceholderImage();
            //     return Center(
            //      child: Chewie(
            //         controller: _chewieController,
            //       ),
            //     );
            //   },
            // ),
          ),
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.transparent)),
                  onPressed: () {
                    _controller.dispose();
                    AppNavigator.pop();
                  },
                  color: Colors.white,
                  textColor: Colors.red,
                  child: Text("RETAKE",
                      style: TextStyle(fontSize: 14)),
                ),
                // RaisedButton(
                //   onPressed: () {
                //     AppNavigator.pop();
                //   },
                //   textColor: Colors.blue,
                //   child: Container(
                //     decoration:
                //     BoxDecoration(color: Colors.transparent),
                //     child: Container(child: Text("Retake")),
                //   ),
                // ),
                SizedBox(
                  width: 53,
                ),
                RaisedButton(
                  onPressed: () {
                    _controller.dispose();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SubCommentPostReply(
                                // filePath: widget.imagePath,
                                // profilePicUser: widget.profilePicUser,
                                // adminPicUser: widget.adminPicUser,
                                // userNamePost: widget.userNamePost,
                                // textTyped: widget.commentPostImage,
                                // postId: widget.postId,
                                filePath: widget.imagePath,
                                commentPicUser: widget.profilePicUser,
                                userProfile: widget.adminPicUser,
                                // userNamePost: widget.userNamePost,
                                textTyped: widget.textTyped,
                                parentId: parentId,
                                parentUserId: parentUserId,
                                grandParentId: grandParentId,

                                // portraits: widget.portrait,
                              )),
                          (Route<dynamic> route) => false,
                    );
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.transparent)),
                  color: Colors.red,
                  textColor: Colors.white,
                  child: Text("USE bhxd",
                      style: TextStyle(fontSize: 14)),
                ),
              ],
            ),
          ),
        ],
      ),
    )
  // Column(
  //   children: [
  //     // Container(
  //     //     width: MediaQuery.of(context).size.width,
  //     //     height: MediaQuery.of(context).size.height / 1.1,
  //     //     child: ChewieListItem(
  //     //       videoPlayerController:
  //     //       VideoPlayerController
  //     //           .file(
  //     //           widget.imagePath
  //     //       ),
  //     //     )
  //     // ),
  //     FutureBuilder(
  //       future: _future,
  //       builder: (context, snapshot){
  //         if(snapshot.connectionState == ConnectionState.waiting) return buildPlaceholderImage();
  //
  //         return Center(
  //           child: Chewie(controller: _chewieController,),
  //         );
  //       },
  //     ),
  //     Positioned(
  //       bottom: 12,
  //       left: 12,
  //       right: 12,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           RaisedButton(
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(18.0),
  //                 side: BorderSide(color: Colors.transparent)),
  //             onPressed: () {
  //               AppNavigator.pop();
  //             },
  //             color: Colors.white,
  //             textColor: Colors.red,
  //             child: Text("RETAKE",
  //                 style: TextStyle(fontSize: 14)),
  //           ),
  //           // RaisedButton(
  //           //   onPressed: () {
  //           //     AppNavigator.pop();
  //           //   },
  //           //   textColor: Colors.blue,
  //           //   child: Container(
  //           //     decoration:
  //           //     BoxDecoration(color: Colors.transparent),
  //           //     child: Container(child: Text("Retake")),
  //           //   ),
  //           // ),
  //           SizedBox(
  //             width: 53,
  //           ),
  //           RaisedButton(
  //             onPressed: () {
  //               Navigator.pushAndRemoveUntil(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) =>
  //                         FarmPost(filePath: widget.imagePath,
  //                         duration: duration,
  //                         )),
  //                     (Route<dynamic> route) => false,
  //               );
  //             },
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(18.0),
  //                 side: BorderSide(color: Colors.transparent)),
  //             color: Colors.red,
  //             textColor: Colors.white,
  //             child: Text("USE",
  //                 style: TextStyle(fontSize: 14)),
  //           ),
  //         ],
  //       ),
  //     ),
  //   ],
  // )
  // Image.network(
  //         'https://picsum.photos/250?image=9',
  //       ),
)
    :
widget.commentPostImage == 'Post Update' ?
Container(
    color: Colors.black,
    child:  imageFileTypes.indexOf(widget.imagePath.path.split('.').last)  != -1
        ?
    Column(
      children: [
        Stack(
            children : [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.1,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(widget.imagePath),)),
              ),
              Positioned(
                bottom: 1,
                left: 12,
                right: 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.transparent)),
                      onPressed: () {
                        AppNavigator.pop();
                      },
                      color: Colors.white,
                      textColor: Color(0xffD41B47),
                      child: Text("RETAKE",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2
                          )),
                    ),
                    SizedBox(
                      width: 53,
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CommentForPost(
                                    filePath: widget.imagePath,
                                    profilePicUser: widget.profilePicUser,
                                    adminPicUser: widget.adminPicUser,
                                    userNamePost: widget.userNamePost,
                                    textTyped: widget.textTyped,
                                    postId: widget.postId,
                                    commentUpdate : widget.commentPostImage,
                                    postSecondaryName: widget.postSecondaryName,


                                    // portraits: widget.portrait,
                                  )),
                              (Route<dynamic> route) => false,
                        );
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.transparent)),
                      color: Color(0xffD41B47),
                      textColor: Colors.white,
                      child: Text("USE",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2
                          )),
                    ),
                  ],
                ),
              ),
            ]
        ),
      ],
    )
        : Container(

      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: 10
            ),
            child: _chewieController != null &&
                _chewieController.videoPlayerController.value.initialized
                ?
            FutureBuilder(
              future: _future,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting) return buildPlaceholderImage();
                return Center(
                  child: Chewie(
                    controller: _chewieController,
                  ),
                );
              },
            )
                :

            FutureBuilder(
              future: _future,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting) return buildPlaceholderImage();
                return Center(
                  child: Chewie(
                    controller: _chewieController,
                  ),
                );
              },
            ),



            // FutureBuilder(
            //   future: _future,
            //   builder: (context, snapshot){
            //     if(snapshot.connectionState == ConnectionState.waiting) return buildPlaceholderImage();
            //     return Center(
            //      child: Chewie(
            //         controller: _chewieController,
            //       ),
            //     );
            //   },
            // ),
          ),
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.transparent)),
                  onPressed: () {
                    _controller.dispose();
                    AppNavigator.pop();
                  },
                  color: Colors.white,
                  textColor: Colors.red,
                  child: Text("RETAKE",
                      style: TextStyle(fontSize: 14)),
                ),
                // RaisedButton(
                //   onPressed: () {
                //     AppNavigator.pop();
                //   },
                //   textColor: Colors.blue,
                //   child: Container(
                //     decoration:
                //     BoxDecoration(color: Colors.transparent),
                //     child: Container(child: Text("Retake")),
                //   ),
                // ),
                SizedBox(
                  width: 53,
                ),
                RaisedButton(
                  onPressed: () {
                    _controller.dispose();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CommentForPost(
                                filePath: widget.imagePath,
                                profilePicUser: widget.profilePicUser,
                                adminPicUser: widget.adminPicUser,
                                userNamePost: widget.userNamePost,
                                textTyped: widget.commentPostImage,
                                postId: widget.postId,

                                // portraits: widget.portrait,
                              )),
                          (Route<dynamic> route) => false,
                    );
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.transparent)),
                  color: Colors.red,
                  textColor: Colors.white,
                  child: Text("USE bhxd",
                      style: TextStyle(fontSize: 14)),
                ),
              ],
            ),
          ),
        ],
      ),
    )
  // Column(
  //   children: [
  //     // Container(
  //     //     width: MediaQuery.of(context).size.width,
  //     //     height: MediaQuery.of(context).size.height / 1.1,
  //     //     child: ChewieListItem(
  //     //       videoPlayerController:
  //     //       VideoPlayerController
  //     //           .file(
  //     //           widget.imagePath
  //     //       ),
  //     //     )
  //     // ),
  //     FutureBuilder(
  //       future: _future,
  //       builder: (context, snapshot){
  //         if(snapshot.connectionState == ConnectionState.waiting) return buildPlaceholderImage();
  //
  //         return Center(
  //           child: Chewie(controller: _chewieController,),
  //         );
  //       },
  //     ),
  //     Positioned(
  //       bottom: 12,
  //       left: 12,
  //       right: 12,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           RaisedButton(
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(18.0),
  //                 side: BorderSide(color: Colors.transparent)),
  //             onPressed: () {
  //               AppNavigator.pop();
  //             },
  //             color: Colors.white,
  //             textColor: Colors.red,
  //             child: Text("RETAKE",
  //                 style: TextStyle(fontSize: 14)),
  //           ),
  //           // RaisedButton(
  //           //   onPressed: () {
  //           //     AppNavigator.pop();
  //           //   },
  //           //   textColor: Colors.blue,
  //           //   child: Container(
  //           //     decoration:
  //           //     BoxDecoration(color: Colors.transparent),
  //           //     child: Container(child: Text("Retake")),
  //           //   ),
  //           // ),
  //           SizedBox(
  //             width: 53,
  //           ),
  //           RaisedButton(
  //             onPressed: () {
  //               Navigator.pushAndRemoveUntil(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) =>
  //                         FarmPost(filePath: widget.imagePath,
  //                         duration: duration,
  //                         )),
  //                     (Route<dynamic> route) => false,
  //               );
  //             },
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(18.0),
  //                 side: BorderSide(color: Colors.transparent)),
  //             color: Colors.red,
  //             textColor: Colors.white,
  //             child: Text("USE",
  //                 style: TextStyle(fontSize: 14)),
  //           ),
  //         ],
  //       ),
  //     ),
  //   ],
  // )
  // Image.network(
  //         'https://picsum.photos/250?image=9',
  //       ),
)
    :
widget.commentPostImage == 'message' ?
Container(
    color: Colors.black,
    child:  imageFileTypes.indexOf(widget.imagePath.path.split('.').last)  != -1
        ?
    Column(
      children: [
        Stack(
            children : [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.1,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(widget.imagePath),)),
              ),
              Positioned(
                bottom: 1,
                left: 12,
                right: 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.transparent)),
                      onPressed: () {
                        AppNavigator.pop();
                      },
                      color: Colors.white,
                      textColor: Color(0xffD41B47),
                      child: Text("RETAKE",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2
                          )),
                    ),
                    SizedBox(
                      width: 53,
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                            builder: (context) =>MessageListing(userId: widget.userId,conversationId: "",file: widget.imagePath,userName: widget.userName,)),(Route<dynamic> route) => false,);

                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.transparent)),
                      color: Color(0xffD41B47),
                      textColor: Colors.white,
                      child: Text("Send",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2
                          )),
                    ),
                  ],
                ),
              ),
            ]
        ),
      ],
    )
        : Container(

      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: 10
            ),
            child: _chewieController != null &&
                _chewieController.videoPlayerController.value.initialized
                ?
            FutureBuilder(
              future: _future,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting) return buildPlaceholderImage();
                return Center(
                  child: Chewie(
                    controller: _chewieController,
                  ),
                );
              },
            )
                :

            FutureBuilder(
              future: _future,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting) return buildPlaceholderImage();
                return Center(
                  child: Chewie(
                    controller: _chewieController,
                  ),
                );
              },
            ),

          ),
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.transparent)),
                  onPressed: () {
                    _controller.dispose();
                    AppNavigator.pop();
                  },
                  color: Colors.white,
                  textColor: Colors.red,
                  child: Text("RETAKE",
                      style: TextStyle(fontSize: 14)),
                ),

                SizedBox(
                  width: 53,
                ),
                RaisedButton(
                  onPressed: () {
                    _controller.dispose();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CommentForPost(
                                filePath: widget.imagePath,
                                profilePicUser: widget.profilePicUser,
                                adminPicUser: widget.adminPicUser,
                                userNamePost: widget.userNamePost,
                                textTyped: widget.commentPostImage,
                                postId: widget.postId,

                                // portraits: widget.portrait,
                              )),
                          (Route<dynamic> route) => false,
                    );
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.transparent)),
                  color: Colors.red,
                  textColor: Colors.white,
                  child: Text("Send",
                      style: TextStyle(fontSize: 14)),
                ),
              ],
            ),
          ),
        ],
      ),
    )
  // Column(
  //   children: [
  //     // Container(
  //     //     width: MediaQuery.of(context).size.width,
  //     //     height: MediaQuery.of(context).size.height / 1.1,
  //     //     child: ChewieListItem(
  //     //       videoPlayerController:
  //     //       VideoPlayerController
  //     //           .file(
  //     //           widget.imagePath
  //     //       ),
  //     //     )
  //     // ),
  //     FutureBuilder(
  //       future: _future,
  //       builder: (context, snapshot){
  //         if(snapshot.connectionState == ConnectionState.waiting) return buildPlaceholderImage();
  //
  //         return Center(
  //           child: Chewie(controller: _chewieController,),
  //         );
  //       },
  //     ),
  //     Positioned(
  //       bottom: 12,
  //       left: 12,
  //       right: 12,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           RaisedButton(
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(18.0),
  //                 side: BorderSide(color: Colors.transparent)),
  //             onPressed: () {
  //               AppNavigator.pop();
  //             },
  //             color: Colors.white,
  //             textColor: Colors.red,
  //             child: Text("RETAKE",
  //                 style: TextStyle(fontSize: 14)),
  //           ),
  //           // RaisedButton(
  //           //   onPressed: () {
  //           //     AppNavigator.pop();
  //           //   },
  //           //   textColor: Colors.blue,
  //           //   child: Container(
  //           //     decoration:
  //           //     BoxDecoration(color: Colors.transparent),
  //           //     child: Container(child: Text("Retake")),
  //           //   ),
  //           // ),
  //           SizedBox(
  //             width: 53,
  //           ),
  //           RaisedButton(
  //             onPressed: () {
  //               Navigator.pushAndRemoveUntil(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) =>
  //                         FarmPost(filePath: widget.imagePath,
  //                         duration: duration,
  //                         )),
  //                     (Route<dynamic> route) => false,
  //               );
  //             },
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(18.0),
  //                 side: BorderSide(color: Colors.transparent)),
  //             color: Colors.red,
  //             textColor: Colors.white,
  //             child: Text("USE",
  //                 style: TextStyle(fontSize: 14)),
  //           ),
  //         ],
  //       ),
  //     ),
  //   ],
  // )
  // Image.network(
  //         'https://picsum.photos/250?image=9',
  //       ),
)
    :

widget.commentPostImage == 'Comment Reply' ?
Container(
    color: Colors.black,
    child:  imageFileTypes.indexOf(widget.imagePath.path.split('.').last)  != -1
        ?
    Column(
      children: [
        Stack(
            children : [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.1,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(widget.imagePath),)),
              ),
              Positioned(
                bottom: 1,
                left: 12,
                right: 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.transparent)),
                      onPressed: () {
                        AppNavigator.pop();
                      },
                      color: Colors.white,
                      textColor: Color(0xffD41B47),
                      child: Text("RETAKE",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2
                          )),
                    ),
                    SizedBox(
                      width: 53,
                    ),
                    RaisedButton(
                      onPressed: () {

                        print("coming inside for useeeeeeeeeeeeeeeeee");
                        print(widget.parentId);
                        print(widget.parentUserId);
                        print(widget.grandParentId);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SubCommentPostReply(
                                    filePath: widget.imagePath,
                                    commentPicUser: widget.profilePicUser,
                                    userProfile: widget.adminPicUser,
                                    // userNamePost: widget.userNamePost,
                                    textTyped: widget.textTyped,
                                    parentId: parentId,
                                    parentUserId: parentUserId,
                                    grandParentId: grandParentId,
                                    replyingSecondaryName: widget.replyingSecondaryName,
                                    replyingUserName: widget.replyingUserName
                                    // postId: widget.postId,

                                    // portraits: widget.portrait,
                                  )),
                              (Route<dynamic> route) => false,
                        );
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.transparent)),
                      color: Color(0xffD41B47),
                      textColor: Colors.white,
                      child: Text("USE",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2
                          )),
                    ),
                  ],
                ),
              ),
            ]
        ),
      ],
    )
        : Container(

      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: 10
            ),
            child: _chewieController != null &&
                _chewieController.videoPlayerController.value.initialized
                ?
            FutureBuilder(
              future: _future,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting) return buildPlaceholderImage();
                return Center(
                  child: Chewie(
                    controller: _chewieController,
                  ),
                );
              },
            )
                :

            FutureBuilder(
              future: _future,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting) return buildPlaceholderImage();
                return Center(
                  child: Chewie(
                    controller: _chewieController,
                  ),
                );
              },
            ),



            // FutureBuilder(
            //   future: _future,
            //   builder: (context, snapshot){
            //     if(snapshot.connectionState == ConnectionState.waiting) return buildPlaceholderImage();
            //     return Center(
            //      child: Chewie(
            //         controller: _chewieController,
            //       ),
            //     );
            //   },
            // ),
          ),
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.transparent)),
                  onPressed: () {
                    _controller.dispose();
                    AppNavigator.pop();
                  },
                  color: Colors.white,
                  textColor: Colors.red,
                  child: Text("RETAKE",
                      style: TextStyle(fontSize: 14)),
                ),
                // RaisedButton(
                //   onPressed: () {
                //     AppNavigator.pop();
                //   },
                //   textColor: Colors.blue,
                //   child: Container(
                //     decoration:
                //     BoxDecoration(color: Colors.transparent),
                //     child: Container(child: Text("Retake")),
                //   ),
                // ),
                SizedBox(
                  width: 53,
                ),
                RaisedButton(
                  onPressed: () {
                    _controller.dispose();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SubCommentPostReply(
                                // filePath: widget.imagePath,
                                // profilePicUser: widget.profilePicUser,
                                // adminPicUser: widget.adminPicUser,
                                // userNamePost: widget.userNamePost,
                                // textTyped: widget.commentPostImage,
                                // postId: widget.postId,
                                filePath: widget.imagePath,
                                commentPicUser: widget.profilePicUser,
                                userProfile: widget.adminPicUser,
                                // userNamePost: widget.userNamePost,
                                textTyped: widget.textTyped,
                                parentId: parentId,
                                parentUserId: parentUserId,
                                grandParentId: grandParentId,

                                // portraits: widget.portrait,
                              )),
                          (Route<dynamic> route) => false,
                    );
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.transparent)),
                  color: Colors.red,
                  textColor: Colors.white,
                  child: Text("USE bhxd",
                      style: TextStyle(fontSize: 14)),
                ),
              ],
            ),
          ),
        ],
      ),
    )
  // Column(
  //   children: [
  //     // Container(
  //     //     width: MediaQuery.of(context).size.width,
  //     //     height: MediaQuery.of(context).size.height / 1.1,
  //     //     child: ChewieListItem(
  //     //       videoPlayerController:
  //     //       VideoPlayerController
  //     //           .file(
  //     //           widget.imagePath
  //     //       ),
  //     //     )
  //     // ),
  //     FutureBuilder(
  //       future: _future,
  //       builder: (context, snapshot){
  //         if(snapshot.connectionState == ConnectionState.waiting) return buildPlaceholderImage();
  //
  //         return Center(
  //           child: Chewie(controller: _chewieController,),
  //         );
  //       },
  //     ),
  //     Positioned(
  //       bottom: 12,
  //       left: 12,
  //       right: 12,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           RaisedButton(
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(18.0),
  //                 side: BorderSide(color: Colors.transparent)),
  //             onPressed: () {
  //               AppNavigator.pop();
  //             },
  //             color: Colors.white,
  //             textColor: Colors.red,
  //             child: Text("RETAKE",
  //                 style: TextStyle(fontSize: 14)),
  //           ),
  //           // RaisedButton(
  //           //   onPressed: () {
  //           //     AppNavigator.pop();
  //           //   },
  //           //   textColor: Colors.blue,
  //           //   child: Container(
  //           //     decoration:
  //           //     BoxDecoration(color: Colors.transparent),
  //           //     child: Container(child: Text("Retake")),
  //           //   ),
  //           // ),
  //           SizedBox(
  //             width: 53,
  //           ),
  //           RaisedButton(
  //             onPressed: () {
  //               Navigator.pushAndRemoveUntil(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) =>
  //                         FarmPost(filePath: widget.imagePath,
  //                         duration: duration,
  //                         )),
  //                     (Route<dynamic> route) => false,
  //               );
  //             },
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(18.0),
  //                 side: BorderSide(color: Colors.transparent)),
  //             color: Colors.red,
  //             textColor: Colors.white,
  //             child: Text("USE",
  //                 style: TextStyle(fontSize: 14)),
  //           ),
  //         ],
  //       ),
  //     ),
  //   ],
  // )
  // Image.network(
  //         'https://picsum.photos/250?image=9',
  //       ),
)
    : widget.commentPostImage == "Comment Post" ?
Container(
    color: Colors.black,
    child:  imageFileTypes.indexOf(widget.imagePath.path.split('.').last)  != -1
        ?
    Column(
      children: [
        Stack(
            children : [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.1,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(widget.imagePath),)),
              ),
              Positioned(
                bottom: 1,
                left: 12,
                right: 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.transparent)),
                      onPressed: () {
                        AppNavigator.pop();
                      },
                      color: Colors.white,
                      textColor: Color(0xffD41B47),
                      child: Text("RETAKE",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2
                          )),
                    ),
                    SizedBox(
                      width: 53,
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CommentForPost(
                                    filePath: widget.imagePath,
                                    profilePicUser: widget.profilePicUser,
                                    adminPicUser: widget.adminPicUser,
                                    userNamePost: widget.userNamePost,
                                    textTyped: widget.textTyped,
                                    postId: widget.postId,
                                      postSecondaryName: widget.postSecondaryName,

                                    // portraits: widget.portrait,
                                  )),
                              (Route<dynamic> route) => false,
                        );
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.transparent)),
                      color: Color(0xffD41B47),
                      textColor: Colors.white,
                      child: Text("USE",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2
                          )),
                    ),
                  ],
                ),
              ),
            ]
        ),
      ],
    )
        : Container(

      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: 10
            ),
            child: _chewieController != null &&
                _chewieController.videoPlayerController.value.initialized
                ?
            FutureBuilder(
              future: _future,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting) return buildPlaceholderImage();
                return Center(
                  child: Chewie(
                    controller: _chewieController,
                  ),
                );
              },
            )
                :

            FutureBuilder(
              future: _future,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting) return buildPlaceholderImage();
                return Center(
                  child: Chewie(
                    controller: _chewieController,
                  ),
                );
              },
            ),



            // FutureBuilder(
            //   future: _future,
            //   builder: (context, snapshot){
            //     if(snapshot.connectionState == ConnectionState.waiting) return buildPlaceholderImage();
            //     return Center(
            //      child: Chewie(
            //         controller: _chewieController,
            //       ),
            //     );
            //   },
            // ),
          ),
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.transparent)),
                  onPressed: () {
                    _controller.dispose();
                    AppNavigator.pop();
                  },
                  color: Colors.white,
                  textColor: Colors.red,
                  child: Text("RETAKE",
                      style: TextStyle(fontSize: 14)),
                ),
                // RaisedButton(
                //   onPressed: () {
                //     AppNavigator.pop();
                //   },
                //   textColor: Colors.blue,
                //   child: Container(
                //     decoration:
                //     BoxDecoration(color: Colors.transparent),
                //     child: Container(child: Text("Retake")),
                //   ),
                // ),
                SizedBox(
                  width: 53,
                ),
                RaisedButton(
                  onPressed: () {
                    _controller.dispose();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CommentForPost(
                                filePath: widget.imagePath,
                                profilePicUser: widget.profilePicUser,
                                adminPicUser: widget.adminPicUser,
                                userNamePost: widget.userNamePost,
                                textTyped: widget.commentPostImage,
                                postId: widget.postId,

                                // portraits: widget.portrait,
                              )),
                          (Route<dynamic> route) => false,
                    );
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.transparent)),
                  color: Colors.red,
                  textColor: Colors.white,
                  child: Text("USE bhxd",
                      style: TextStyle(fontSize: 14)),
                ),
              ],
            ),
          ),
        ],
      ),
    )
  // Column(
  //   children: [
  //     // Container(
  //     //     width: MediaQuery.of(context).size.width,
  //     //     height: MediaQuery.of(context).size.height / 1.1,
  //     //     child: ChewieListItem(
  //     //       videoPlayerController:
  //     //       VideoPlayerController
  //     //           .file(
  //     //           widget.imagePath
  //     //       ),
  //     //     )
  //     // ),
  //     FutureBuilder(
  //       future: _future,
  //       builder: (context, snapshot){
  //         if(snapshot.connectionState == ConnectionState.waiting) return buildPlaceholderImage();
  //
  //         return Center(
  //           child: Chewie(controller: _chewieController,),
  //         );
  //       },
  //     ),
  //     Positioned(
  //       bottom: 12,
  //       left: 12,
  //       right: 12,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           RaisedButton(
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(18.0),
  //                 side: BorderSide(color: Colors.transparent)),
  //             onPressed: () {
  //               AppNavigator.pop();
  //             },
  //             color: Colors.white,
  //             textColor: Colors.red,
  //             child: Text("RETAKE",
  //                 style: TextStyle(fontSize: 14)),
  //           ),
  //           // RaisedButton(
  //           //   onPressed: () {
  //           //     AppNavigator.pop();
  //           //   },
  //           //   textColor: Colors.blue,
  //           //   child: Container(
  //           //     decoration:
  //           //     BoxDecoration(color: Colors.transparent),
  //           //     child: Container(child: Text("Retake")),
  //           //   ),
  //           // ),
  //           SizedBox(
  //             width: 53,
  //           ),
  //           RaisedButton(
  //             onPressed: () {
  //               Navigator.pushAndRemoveUntil(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) =>
  //                         FarmPost(filePath: widget.imagePath,
  //                         duration: duration,
  //                         )),
  //                     (Route<dynamic> route) => false,
  //               );
  //             },
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(18.0),
  //                 side: BorderSide(color: Colors.transparent)),
  //             color: Colors.red,
  //             textColor: Colors.white,
  //             child: Text("USE",
  //                 style: TextStyle(fontSize: 14)),
  //           ),
  //         ],
  //       ),
  //     ),
  //   ],
  // )
  // Image.network(
  //         'https://picsum.photos/250?image=9',
  //       ),
)
    :Container(
    color: Colors.black,
    child:  imageFileTypes.indexOf(widget.imagePath.path.split('.').last)  != -1
        ?
    Column(
      children: [
        Stack(
            children : [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(widget.imagePath),)),
              ),
              Positioned(
                bottom: 1,
                left: 12,
                right: 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.transparent)),
                      onPressed: () {
                        AppNavigator.pop();
                      },
                      color: Colors.white,
                      textColor: Color(0xffD41B47),
                      child: Text("RETAKE",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2
                          )),
                    ),
                    // RaisedButton(
                    //   onPressed: () {
                    //     AppNavigator.pop();
                    //   },
                    //   textColor: Colors.blue,
                    //   child: Container(
                    //     decoration:
                    //     BoxDecoration(color: Colors.transparent),
                    //     child: Container(child: Text("Retake")),
                    //   ),
                    // ),
                    SizedBox(
                      width: 53,
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FarmPost(filePath: widget.imagePath,
                                    textTyped: widget.textTyped,
                                    id: widget.id,
                                    subCategory: widget.subCategory,
                                    subcategoryId: widget.subcategoryId,
                                    categoryId: widget.mainCategoryId,
                                    // portraits: widget.portrait,
                                  )),
                              (Route<dynamic> route) => false,
                        );
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.transparent)),
                      color: Color(0xffD41B47),
                      textColor: Colors.white,
                      child: Text("USE",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2
                          )),
                    ),
                    // RaisedButton(
                    //   onPressed: () {
                    //     Navigator.pushAndRemoveUntil(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) =>
                    //               FarmPost(filePath: imagePath)),
                    //           (Route<dynamic> route) => false,
                    //     );
                    //   },
                    //   textColor: Colors.blue,
                    //   child: Container(
                    //     decoration:
                    //     BoxDecoration(color: Colors.transparent),
                    //     child: Container(child: Text("Use Photo")),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ]
        ),

        // Stack(
        //   children: [
        //     Container(
        //       width: MediaQuery.of(context).size.width,
        //       decoration: BoxDecoration(
        //           image: DecorationImage(
        //               image: FileImage(imagePath), fit: BoxFit.fill)),
        //     ),
        //     Positioned(
        //       bottom: 12,
        //       left: 12,
        //       right: 12,
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           RaisedButton(
        //             onPressed: () {
        //               AppNavigator.pop();
        //             },
        //             textColor: Colors.blue,
        //             child: Container(
        //               decoration:
        //               BoxDecoration(color: Colors.transparent),
        //               child: Container(child: Text("Retake")),
        //             ),
        //           ),
        //           SizedBox(
        //             width: 53,
        //           ),
        //           RaisedButton(
        //             onPressed: () {
        //               Navigator.pushAndRemoveUntil(
        //                 context,
        //                 MaterialPageRoute(
        //                     builder: (context) =>
        //                         FarmPost(filePath: imagePath)),
        //                     (Route<dynamic> route) => false,
        //               );
        //             },
        //             textColor: Colors.blue,
        //             child: Container(
        //               decoration:
        //               BoxDecoration(color: Colors.transparent),
        //               child: Container(child: Text("Use Photo")),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // )
      ],
    )
        : Container(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: 10
            ),
            child: _chewieController != null &&
                _chewieController.videoPlayerController.value.initialized
                ?
            FutureBuilder(
              future: _future,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting) return buildPlaceholderImage();
                return Center(
                    child: Stack(
                      children: [
                        Chewie(
                          controller: _chewieController,
                        ),
                        GestureDetector(
                          onTap: (){
                            if ( _chewieController.videoPlayerController.value.isPlaying) {
                              print(_controller.value.duration);
                              _chewieController.pause();
                            } else {
                              print(_controller.value.duration);
                              _chewieController.play();
                            }
                          },
                          // child: Container(
                          //   alignment: Alignment.center,
                          //   padding: EdgeInsets.only(bottom: 50,left: 1),
                          //   child: Icon(
                          //     _controller.value.isPlaying
                          //         ? Icons.pause
                          //         : Icons.play_arrow,
                          //     color: Colors.blue,
                          //     size: 35,
                          //   ),
                          //   // child: Text('kjsbfkjbkbdfkb',
                          //   //   style: TextStyle(
                          //   //       fontSize: 32,
                          //   //       color: Colors.pink
                          //   //   ),
                          //   // ),
                          // ),
                        )
                      ],
                    )
                );
              },
            )

                :

            FutureBuilder(
              future: _future,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting) return buildPlaceholderImage();
                return Center(
                  child: Chewie(
                    controller: _chewieController,
                  ),
                );
              },
            ),



            // FutureBuilder(
            //   future: _future,
            //   builder: (context, snapshot){
            //     if(snapshot.connectionState == ConnectionState.waiting) return buildPlaceholderImage();
            //     return Center(
            //      child: Chewie(
            //         controller: _chewieController,
            //       ),
            //     );
            //   },
            // ),
          ),
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.transparent)),
                  onPressed: () {
                    _controller.dispose();
                    AppNavigator.pop();
                  },
                  color: Colors.white,
                  textColor: Colors.red,
                  child: Text("RETAKE",
                      style: TextStyle(fontSize: 14)),
                ),
                // RaisedButton(
                //   onPressed: () {
                //     AppNavigator.pop();
                //   },
                //   textColor: Colors.blue,
                //   child: Container(
                //     decoration:
                //     BoxDecoration(color: Colors.transparent),
                //     child: Container(child: Text("Retake")),
                //   ),
                // ),
                SizedBox(
                  width: 53,
                ),
                RaisedButton(
                  onPressed: () {
                    _controller.dispose();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FarmPost(
                                  filePath: widget.imagePath,
                                  duration: duration,
                                  textTyped: widget.textTyped,
                                  id: widget.id,
                                  subCategory: widget.subCategory,
                                  subcategoryId: widget.subcategoryId,
                                  categoryId: widget.mainCategoryId,
                              )),
                          (Route<dynamic> route) => false,
                    );
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.transparent)),
                  color: Colors.red,
                  textColor: Colors.white,
                  child: Text("USE",
                      style: TextStyle(fontSize: 14)),
                ),
              ],
            ),
          ),
        ],
      ),
    )
  // Column(
  //   children: [
  //     // Container(
  //     //     width: MediaQuery.of(context).size.width,
  //     //     height: MediaQuery.of(context).size.height / 1.1,
  //     //     child: ChewieListItem(
  //     //       videoPlayerController:
  //     //       VideoPlayerController
  //     //           .file(
  //     //           widget.imagePath
  //     //       ),
  //     //     )
  //     // ),
  //     FutureBuilder(
  //       future: _future,
  //       builder: (context, snapshot){
  //         if(snapshot.connectionState == ConnectionState.waiting) return buildPlaceholderImage();
  //
  //         return Center(
  //           child: Chewie(controller: _chewieController,),
  //         );
  //       },
  //     ),
  //     Positioned(
  //       bottom: 12,
  //       left: 12,
  //       right: 12,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           RaisedButton(
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(18.0),
  //                 side: BorderSide(color: Colors.transparent)),
  //             onPressed: () {
  //               AppNavigator.pop();
  //             },
  //             color: Colors.white,
  //             textColor: Colors.red,
  //             child: Text("RETAKE",
  //                 style: TextStyle(fontSize: 14)),
  //           ),
  //           // RaisedButton(
  //           //   onPressed: () {
  //           //     AppNavigator.pop();
  //           //   },
  //           //   textColor: Colors.blue,
  //           //   child: Container(
  //           //     decoration:
  //           //     BoxDecoration(color: Colors.transparent),
  //           //     child: Container(child: Text("Retake")),
  //           //   ),
  //           // ),
  //           SizedBox(
  //             width: 53,
  //           ),
  //           RaisedButton(
  //             onPressed: () {
  //               Navigator.pushAndRemoveUntil(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) =>
  //                         FarmPost(filePath: widget.imagePath,
  //                         duration: duration,
  //                         )),
  //                     (Route<dynamic> route) => false,
  //               );
  //             },
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(18.0),
  //                 side: BorderSide(color: Colors.transparent)),
  //             color: Colors.red,
  //             textColor: Colors.white,
  //             child: Text("USE",
  //                 style: TextStyle(fontSize: 14)),
  //           ),
  //         ],
  //       ),
  //     ),
  //   ],
  // )
  // Image.network(
  //         'https://picsum.photos/250?image=9',
  //       ),
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

  @override
  void initState() {
    super.initState();

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
      autoPlay: true,

      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },

    );
    // _videoPlayerController = widget.videoPlayerController;
    // _future = initVideoPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return
      //   FutureBuilder(
      //     future: _future,
      //     builder: (context, snapshot) {
      //       return new Center(
      //         child: _videoPlayerController.value.initialized
      //             ? AspectRatio(
      //           aspectRatio: _videoPlayerController.value.aspectRatio,
      //           child: Chewie(
      //             controller: _chewieController,
      //           ),
      //         )
      //             : new CircularProgressIndicator(),
      //       );
      //     }
      // );
      Padding(
        padding:  EdgeInsets.all(8.0),
        child: Container(
          child: Chewie(
            controller: _chewieController,
          ),
        ),
      );
  }

  @override
  void dispose() {
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
