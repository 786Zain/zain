import 'dart:io';
import 'package:farm_system/camera/video.dart';
import 'package:farm_system/feature/farm_post/farm_post.dart';
import 'package:farm_system/feature/feed/comment/view/commentforpost.view.dart';
import 'package:farm_system/feature/feed/subcommentPostReply/view/subcomment.view.dart';
import 'package:farm_system/navigator.dart';
import 'package:farm_system/post_tweet/post_tweet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart' as PackagageVideoPlayer;

class PlayRecordedVideo extends StatefulWidget {
  final String path;
  final bool portraits;
  final String textTyped;
  final String id;
  final String subCategory;
  final String commentPostImage;
  final String profilePicUser;
  final String adminPicUser;
  final String userNamePost;
  final String postId;
  final String parentId, parentUserId, grandParentId;

  PlayRecordedVideo(
      {@required this.path,
      this.portraits,
      this.textTyped,
      this.id,
      this.subCategory,
      this.commentPostImage,
      this.profilePicUser,
      this.adminPicUser,
      this.userNamePost,
      this.postId,
      this.parentId,
      this.parentUserId,
      this.grandParentId});
  @override
  _PlayRecordedVideoState createState() => _PlayRecordedVideoState();
}

class _PlayRecordedVideoState extends State<PlayRecordedVideo> {
  FlutterFFmpeg fFmpeg;
  PackagageVideoPlayer.VideoPlayerController _controller;

  bool play;

  File fileInfo;
  Duration duration;
  final spinkit = SpinKitChasingDots(
    color: Colors.white,
    size: 50.0,
  );
  void getVideo() async {
    fileInfo = File(widget.path);
    _controller = PackagageVideoPlayer.VideoPlayerController.file(fileInfo)
      ..initialize().then((_) {
        duration = _controller.value.duration;
        setState(() {
          // _controller.play();
          _controller.setLooping(true);
        });
      });
  }

  @override
  void initState() {
    super.initState();
    getVideo();
    fFmpeg = new FlutterFFmpeg();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("for videoooooooooooo");
    print(widget.textTyped);

    return Container(
      height: double.infinity,
      child: _controller == null
          ? spinkit
          : widget.portraits
              ? _controller.value.initialized
                  ? GestureDetector(
                      onTap: () {
                        if (_controller.value.isPlaying) {
                          print(_controller.value.duration);
                          _controller.pause();
                        } else {
                          print(_controller.value.duration);
                          _controller.play();
                        }
                      },
                      child: widget.commentPostImage == "Comment Reply"
                          ? Stack(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height / 1.1,
                                  child: PackagageVideoPlayer.VideoPlayer(
                                    _controller,
                                  ),
                                ),
                                Positioned(
                                  bottom: 11,
                                  left: MediaQuery.of(context).size.width / 36,
                                  right: MediaQuery.of(context).size.width / 36,
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              side: BorderSide(
                                                  color: Colors.transparent)),
                                          onPressed: () {
                                            // AppNavigator.pop();
                                            // setState(() {
                                            //   _controller.dispose();
                                            // });
                                            _controller.pause();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Video(
                                                        textTyped:
                                                            widget.textTyped,
                                                        id: widget.id,
                                                        subCategory:
                                                            widget.subCategory,
                                                      )),
                                            );
                                          },
                                          color: Colors.white,
                                          textColor: Color(0xffD41B47),
                                          child: Text("RETAKE",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  letterSpacing: 2)),
                                        ),
                                        RaisedButton(
                                          color: Color(0xffD41B47),
                                          textColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              side: BorderSide(
                                                  color: Colors.transparent)),
                                          onPressed: () async {
                                            final Directory extDir =
                                                await getApplicationDocumentsDirectory();
                                            final String dirPath =
                                                '${extDir.path}/Oyindori/Filtered';
                                            await Directory(dirPath)
                                                .create(recursive: true);
                                            final String filePath =
                                                '$dirPath/${DateTime.now().millisecondsSinceEpoch.toString()}';
                                            await fFmpeg.execute('-i ' +
                                                widget.path +
                                                ' -vf hue=s=0 ' +
                                                filePath +
                                                '-output.mp4');
                                            _controller = PackagageVideoPlayer
                                                    .VideoPlayerController
                                                .file(File(
                                                    filePath + '-output.mp4'))
                                              ..initialize().then((_) {
                                                setState(() {
                                                  _controller.play();
                                                  _controller.setLooping(true);
                                                });
                                              });
                                          },
                                          child: GestureDetector(
                                              onTap: () => {
                                                    _controller.setVolume(0),
                                                    Navigator
                                                        .pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              SubCommentPostReply(
                                                                  filePath:
                                                                      fileInfo,
                                                                  commentPicUser:
                                                                      widget
                                                                          .profilePicUser,
                                                                  userProfile:
                                                                      widget
                                                                          .adminPicUser,
                                                                  // userNamePost: widget.userNamePost,
                                                                  textTyped: widget
                                                                      .textTyped,
                                                                  // postId: widget.postId,
                                                                  parentId: widget
                                                                      .parentId,
                                                                  parentUserId:
                                                                      widget
                                                                          .parentUserId,
                                                                  grandParentId:
                                                                      widget
                                                                          .grandParentId
                                                                  // portraits: widget.portrait,
                                                                  )
                                                          // CommentForPost(
                                                          //   filePath: fileInfo,
                                                          //   profilePicUser: widget.profilePicUser,
                                                          //   adminPicUser: widget.adminPicUser,
                                                          //   userNamePost: widget.userNamePost,
                                                          //   textTyped: widget.textTyped,
                                                          //   postId: widget.postId,
                                                          //   // portraits: widget.portrait,
                                                          // )
                                                          ),
                                                      (Route<dynamic> route) =>
                                                          false,
                                                    )
                                                  },
                                              child: Text(
                                                "USE",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    letterSpacing: 2),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : widget.commentPostImage == "Comment Post"
                              ? Stack(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.1,
                                      child: PackagageVideoPlayer.VideoPlayer(
                                        _controller,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 11,
                                      left: MediaQuery.of(context).size.width /
                                          36,
                                      right: MediaQuery.of(context).size.width /
                                          36,
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0),
                                                  side: BorderSide(
                                                      color:
                                                          Colors.transparent)),
                                              onPressed: () {
                                                // AppNavigator.pop();
                                                // setState(() {
                                                //   _controller.dispose();
                                                // });
                                                _controller.pause();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Video(
                                                            textTyped: widget
                                                                .textTyped,
                                                            id: widget.id,
                                                            subCategory: widget
                                                                .subCategory,
                                                          )),
                                                );
                                              },
                                              color: Colors.white,
                                              textColor: Color(0xffD41B47),
                                              child: Text("RETAKE",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      letterSpacing: 2)),
                                            ),
                                            RaisedButton(
                                              color: Color(0xffD41B47),
                                              textColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0),
                                                  side: BorderSide(
                                                      color:
                                                          Colors.transparent)),
                                              onPressed: () async {
                                                final Directory extDir =
                                                    await getApplicationDocumentsDirectory();
                                                final String dirPath =
                                                    '${extDir.path}/Oyindori/Filtered';
                                                await Directory(dirPath)
                                                    .create(recursive: true);
                                                final String filePath =
                                                    '$dirPath/${DateTime.now().millisecondsSinceEpoch.toString()}';
                                                await fFmpeg.execute('-i ' +
                                                    widget.path +
                                                    ' -vf hue=s=0 ' +
                                                    filePath +
                                                    '-output.mp4');
                                                _controller = PackagageVideoPlayer
                                                        .VideoPlayerController
                                                    .file(File(filePath +
                                                        '-output.mp4'))
                                                  ..initialize().then((_) {
                                                    setState(() {
                                                      _controller.play();
                                                      _controller
                                                          .setLooping(true);
                                                    });
                                                  });
                                              },
                                              child: GestureDetector(
                                                  onTap: () => {
                                                        _controller
                                                            .setVolume(0),
                                                        //  AppNavigator.push(PostTweetPage())
                                                        // Navigator.popAndPushNamed(context,PostTweetPage)
                                                        // Navigator.pushAndRemoveUntil(
                                                        //   context,
                                                        //   MaterialPageRoute(
                                                        //       builder: (context) =>
                                                        //           PostTweetPage(
                                                        //             filePath: fileInfo,
                                                        //             isImage: false,
                                                        //           )),
                                                        //       (Route<dynamic> route) => false,
                                                        // hereeeeee
                                                        // )
                                                        Navigator
                                                            .pushAndRemoveUntil(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  CommentForPost(
                                                                    filePath:
                                                                        fileInfo,
                                                                    profilePicUser:
                                                                        widget
                                                                            .profilePicUser,
                                                                    adminPicUser:
                                                                        widget
                                                                            .adminPicUser,
                                                                    userNamePost:
                                                                        widget
                                                                            .userNamePost,
                                                                    textTyped:
                                                                        widget
                                                                            .textTyped,
                                                                    postId: widget
                                                                        .postId,
                                                                    // portraits: widget.portrait,
                                                                  )),
                                                          (Route<dynamic>
                                                                  route) =>
                                                              false,
                                                        )
                                                      },
                                                  child: Text(
                                                    "USE",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        letterSpacing: 2),
                                                  )),
                                            ),
                                            // RaisedButton(
                                            //   onPressed: () {
                                            //     AppNavigator.pop();
                                            //   },
                                            //   textColor: Colors.blue,
                                            //   child: Container(
                                            //     decoration: BoxDecoration(
                                            //         color: Colors.transparent),
                                            //     child: Container(child: Text("Retake")),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Stack(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.1,
                                      child: PackagageVideoPlayer.VideoPlayer(
                                        _controller,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: ClipOval(
                                        child: Material(
                                      color: Colors.blue, // button color
                                      child: SizedBox(
                                          width: 46,
                                          height: 46,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (_controller
                                                    .value.isPlaying) {
                                                  _controller.pause();
                                                } else {
                                                  _controller.play();
                                                }
                                              });
                                            },
                                            child: Icon(
                                              _controller.value.isPlaying
                                                  ? Icons.pause
                                                  : Icons.play_arrow,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          )),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 11,
                                      left: MediaQuery.of(context).size.width /
                                          36,
                                      right: MediaQuery.of(context).size.width /
                                          36,
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0),
                                                  side: BorderSide(
                                                      color:
                                                          Colors.transparent)),
                                              onPressed: () {
                                                // AppNavigator.pop();
                                                // setState(() {
                                                //   _controller.dispose();
                                                // });
                                                _controller.pause();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Video(
                                                            textTyped: widget
                                                                .textTyped,
                                                            id: widget.id,
                                                            subCategory: widget
                                                                .subCategory,
                                                          )),
                                                );
                                              },
                                              color: Colors.white,
                                              textColor: Color(0xffD41B47),
                                              child: Text("RETAKE",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      letterSpacing: 2)),
                                            ),
                                            RaisedButton(
                                              color: Color(0xffD41B47),
                                              textColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0),
                                                  side: BorderSide(
                                                      color:
                                                          Colors.transparent)),
                                              onPressed: () async {
                                                final Directory extDir =
                                                    await getApplicationDocumentsDirectory();
                                                final String dirPath =
                                                    '${extDir.path}/Oyindori/Filtered';
                                                await Directory(dirPath)
                                                    .create(recursive: true);
                                                final String filePath =
                                                    '$dirPath/${DateTime.now().millisecondsSinceEpoch.toString()}';
                                                await fFmpeg.execute('-i ' +
                                                    widget.path +
                                                    ' -vf hue=s=0 ' +
                                                    filePath +
                                                    '-output.mp4');
                                                _controller = PackagageVideoPlayer
                                                        .VideoPlayerController
                                                    .file(File(filePath +
                                                        '-output.mp4'))
                                                  ..initialize().then((_) {
                                                    setState(() {
                                                      _controller.play();
                                                      _controller
                                                          .setLooping(true);
                                                    });
                                                  });
                                              },
                                              child: GestureDetector(
                                                  onTap: () => {
                                                        _controller
                                                            .setVolume(0),
                                                        //  AppNavigator.push(PostTweetPage())
                                                        // Navigator.popAndPushNamed(context,PostTweetPage)
                                                        // Navigator.pushAndRemoveUntil(
                                                        //   context,
                                                        //   MaterialPageRoute(
                                                        //       builder: (context) =>
                                                        //           PostTweetPage(
                                                        //             filePath: fileInfo,
                                                        //             isImage: false,
                                                        //           )),
                                                        //       (Route<dynamic> route) => false,
                                                        // hereeeeee
                                                        // )
                                                        Navigator
                                                            .pushAndRemoveUntil(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      FarmPost(
                                                                        filePath:
                                                                            fileInfo,
                                                                        duration:
                                                                            duration,
                                                                        portraits:
                                                                            widget.portraits,
                                                                        textTyped:
                                                                            widget.textTyped,
                                                                        id: widget
                                                                            .id,
                                                                        subCategory:
                                                                            widget.subCategory,
                                                                      )),
                                                          (Route<dynamic>
                                                                  route) =>
                                                              false,
                                                        )
                                                      },
                                                  child: Text(
                                                    "USE",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        letterSpacing: 2),
                                                  )),
                                            ),
                                            // RaisedButton(
                                            //   onPressed: () {
                                            //     AppNavigator.pop();
                                            //   },
                                            //   textColor: Colors.blue,
                                            //   child: Container(
                                            //     decoration: BoxDecoration(
                                            //         color: Colors.transparent),
                                            //     child: Container(child: Text("Retake")),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                      // Container(
                      //   width: MediaQuery.of(context).size.width,
                      //   height: MediaQuery.of(context).size.height,
                      //   child: Stack(
                      //     children: [
                      //       PackagageVideoPlayer.VideoPlayer(
                      //         _controller,
                      //       ),
                      //       SizedBox(
                      //         height: MediaQuery.of(context).size.height / 4,
                      //       ),
                      //       // GestureDetector(
                      //       //     onTap: () => {
                      //       //       _controller.setVolume(0)
                      //
                      //       //       },
                      //       //     child: Icon(
                      //       //       Icons.volume_mute,
                      //       //       color: Colors.white,
                      //       //     )),
                      //       // SizedBox(
                      //       //   height: MediaQuery.of(context).size.height / 4,
                      //       // ),
                      //       Positioned(
                      //         bottom: 11,
                      //         left: MediaQuery.of(context).size.width / 36,
                      //         right: MediaQuery.of(context).size.width / 36,
                      //         child: Container(
                      //           // width: MediaQuery.of(context).size.width,
                      //           child: Row(
                      //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //             children: [
                      //               RaisedButton(
                      //                 color: Colors.blue,
                      //                 textColor: Colors.white,
                      //                 onPressed: () async {
                      //                   final Directory extDir =
                      //                       await getApplicationDocumentsDirectory();
                      //                   final String dirPath =
                      //                       '${extDir.path}/Oyindori/Filtered';
                      //                   await Directory(dirPath)
                      //                       .create(recursive: true);
                      //                   final String filePath =
                      //                       '$dirPath/${DateTime.now().millisecondsSinceEpoch.toString()}';
                      //                   await fFmpeg.execute('-i ' +
                      //                       widget.path +
                      //                       ' -vf hue=s=0 ' +
                      //                       filePath +
                      //                       '-output.mp4');
                      //                   _controller = PackagageVideoPlayer
                      //                           .VideoPlayerController
                      //                       .file(File(filePath + '-output.mp4'))
                      //                     ..initialize().then((_) {
                      //                       setState(() {
                      //                         _controller.play();
                      //                         _controller.setLooping(true);
                      //                       });
                      //                     });
                      //                 },
                      //                 child: Container(
                      //                   decoration: BoxDecoration(
                      //                       color: Colors.blue,
                      //                       borderRadius: BorderRadius.circular(5)),
                      //                   child: GestureDetector(
                      //                       onTap: () => {
                      //                             _controller.setVolume(0),
                      //                             //  AppNavigator.push(PostTweetPage())
                      //                             // Navigator.popAndPushNamed(context,PostTweetPage)
                      //                             Navigator.pushAndRemoveUntil(
                      //                               context,
                      //                               MaterialPageRoute(
                      //                                   builder: (context) =>
                      //                                       PostTweetPage(
                      //                                         filePath: fileInfo,
                      //                                         isImage: false,
                      //                                       )),
                      //                               (Route<dynamic> route) => false,
                      //                             )
                      //                           },
                      //                       child: Container(
                      //                           child: Text(
                      //                         "Use Video",
                      //                         style: TextStyle(color: Colors.white),
                      //                       ))),
                      //                 ),
                      //               ),
                      //               RaisedButton(
                      //                 onPressed: () {
                      //                   AppNavigator.pop();
                      //                 },
                      //                 textColor: Colors.blue,
                      //                 child: Container(
                      //                   decoration: BoxDecoration(
                      //                       color: Colors.transparent),
                      //                   child: Container(child: Text("Retake")),
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      )
                  : spinkit
              : _controller.value.initialized
                  ? GestureDetector(
                      onTap: () {
                        if (_controller.value.isPlaying) {
                          print(_controller.value.duration);
                          _controller.pause();
                        } else {
                          print(_controller.value.duration);
                          _controller.play();
                        }
                      },
        child: Stack(
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height:
                MediaQuery.of(context).size.height / 1.9,
                child: PackagageVideoPlayer.VideoPlayer(
                  _controller,
                ),
              ),
            ),
            Positioned(
              bottom: 11,
              left: MediaQuery.of(context).size.width / 36,
              right: MediaQuery.of(context).size.width / 36,
              child: Container(
                // width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(18.0),
                          side: BorderSide(
                              color: Colors.transparent)),
                      onPressed: () {
                        // AppNavigator.pop();
                        // setState(() {
                        //   _controller.dispose();
                        // });
                        _controller.pause();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Video()),
                        );
                      },
                      color: Colors.white,
                      textColor: Color(0xffD41B47),
                      child: Text("RETAKE",
                          style: TextStyle(
                              fontSize: 14, letterSpacing: 2)),
                    ),
                    RaisedButton(
                      color: Color(0xffD41B47),
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(18.0),
                          side: BorderSide(
                              color: Colors.transparent)),
                      onPressed: () async {
                        final Directory extDir =
                        await getApplicationDocumentsDirectory();
                        final String dirPath =
                            '${extDir.path}/Oyindori/Filtered';
                        await Directory(dirPath)
                            .create(recursive: true);
                        final String filePath =
                            '$dirPath/${DateTime.now().millisecondsSinceEpoch.toString()}';
                        await fFmpeg.execute('-i ' +
                            widget.path +
                            ' -vf hue=s=0 ' +
                            filePath +
                            '-output.mp4');
                        _controller = PackagageVideoPlayer
                            .VideoPlayerController
                            .file(
                            File(filePath + '-output.mp4'))
                          ..initialize().then((_) {
                            setState(() {
                              _controller.play();
                              _controller.setLooping(true);
                            });
                          });
                      },
                      child: GestureDetector(
                          onTap: () => {
                            _controller.setVolume(0),
                            _controller.pause(),
                            //  AppNavigator.push(PostTweetPage())
                            // Navigator.popAndPushNamed(context,PostTweetPage)
                            // Navigator.pushAndRemoveUntil(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) =>
                            //           PostTweetPage(
                            //             filePath: fileInfo,
                            //             isImage: false,
                            //           )),
                            //       (Route<dynamic> route) => false,
                            // )
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      FarmPost(
                                        filePath: fileInfo,
                                        duration: duration,
                                        portraits: widget
                                            .portraits,
                                      )),
                                  (Route<dynamic> route) =>
                              false,
                            )
                          },
                          child: Text(
                            "USE",
                            style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 2),
                          )),
                    ),
                    // RaisedButton(
                    //   onPressed: () {
                    //     AppNavigator.pop();
                    //   },
                    //   textColor: Colors.blue,
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //         color: Colors.transparent),
                    //     child: Container(child: Text("Retake")),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: ClipOval(
                child: Material(
                  color: Colors.blue, // button color
                  child: SizedBox(
                      width: 46,
                      height: 46,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_controller
                                .value.isPlaying) {
                              _controller.pause();
                            } else {
                              _controller.play();
                            }
                          });
                        },
                        child: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                          size: 30,
                        ),
                      )),
                ),
              ),
            ),

          ],
        ),
                      // child: Column(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Expanded(
                      //       child: Center(
                      //         child: Container(
                      //           width: MediaQuery.of(context).size.width,
                      //           height:
                      //               MediaQuery.of(context).size.height / 1.9,
                      //           child: PackagageVideoPlayer.VideoPlayer(
                      //             _controller,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     Padding(
                      //       padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                      //       child: Positioned(
                      //         bottom: 11,
                      //         left: MediaQuery.of(context).size.width / 36,
                      //         right: MediaQuery.of(context).size.width / 36,
                      //         child: Container(
                      //           // width: MediaQuery.of(context).size.width,
                      //           child: Row(
                      //             mainAxisAlignment:
                      //                 MainAxisAlignment.spaceBetween,
                      //             children: [
                      //               RaisedButton(
                      //                 shape: RoundedRectangleBorder(
                      //                     borderRadius:
                      //                         BorderRadius.circular(18.0),
                      //                     side: BorderSide(
                      //                         color: Colors.transparent)),
                      //                 onPressed: () {
                      //                   // AppNavigator.pop();
                      //                   // setState(() {
                      //                   //   _controller.dispose();
                      //                   // });
                      //                   _controller.pause();
                      //                   Navigator.push(
                      //                     context,
                      //                     MaterialPageRoute(
                      //                         builder: (context) => Video()),
                      //                   );
                      //                 },
                      //                 color: Colors.white,
                      //                 textColor: Color(0xffD41B47),
                      //                 child: Text("RETAKE",
                      //                     style: TextStyle(
                      //                         fontSize: 14, letterSpacing: 2)),
                      //               ),
                      //               RaisedButton(
                      //                 color: Color(0xffD41B47),
                      //                 textColor: Colors.white,
                      //                 shape: RoundedRectangleBorder(
                      //                     borderRadius:
                      //                         BorderRadius.circular(18.0),
                      //                     side: BorderSide(
                      //                         color: Colors.transparent)),
                      //                 onPressed: () async {
                      //                   final Directory extDir =
                      //                       await getApplicationDocumentsDirectory();
                      //                   final String dirPath =
                      //                       '${extDir.path}/Oyindori/Filtered';
                      //                   await Directory(dirPath)
                      //                       .create(recursive: true);
                      //                   final String filePath =
                      //                       '$dirPath/${DateTime.now().millisecondsSinceEpoch.toString()}';
                      //                   await fFmpeg.execute('-i ' +
                      //                       widget.path +
                      //                       ' -vf hue=s=0 ' +
                      //                       filePath +
                      //                       '-output.mp4');
                      //                   _controller = PackagageVideoPlayer
                      //                           .VideoPlayerController
                      //                       .file(
                      //                           File(filePath + '-output.mp4'))
                      //                     ..initialize().then((_) {
                      //                       setState(() {
                      //                         _controller.play();
                      //                         _controller.setLooping(true);
                      //                       });
                      //                     });
                      //                 },
                      //                 child: GestureDetector(
                      //                     onTap: () => {
                      //                           _controller.setVolume(0),
                      //                           _controller.pause(),
                      //                           //  AppNavigator.push(PostTweetPage())
                      //                           // Navigator.popAndPushNamed(context,PostTweetPage)
                      //                           // Navigator.pushAndRemoveUntil(
                      //                           //   context,
                      //                           //   MaterialPageRoute(
                      //                           //       builder: (context) =>
                      //                           //           PostTweetPage(
                      //                           //             filePath: fileInfo,
                      //                           //             isImage: false,
                      //                           //           )),
                      //                           //       (Route<dynamic> route) => false,
                      //                           // )
                      //                           Navigator.pushAndRemoveUntil(
                      //                             context,
                      //                             MaterialPageRoute(
                      //                                 builder: (context) =>
                      //                                     FarmPost(
                      //                                       filePath: fileInfo,
                      //                                       duration: duration,
                      //                                       portraits: widget
                      //                                           .portraits,
                      //                                     )),
                      //                             (Route<dynamic> route) =>
                      //                                 false,
                      //                           )
                      //                         },
                      //                     child: Text(
                      //                       "USE",
                      //                       style: TextStyle(
                      //                           color: Colors.white,
                      //                           letterSpacing: 2),
                      //                     )),
                      //               ),
                      //               // RaisedButton(
                      //               //   onPressed: () {
                      //               //     AppNavigator.pop();
                      //               //   },
                      //               //   textColor: Colors.blue,
                      //               //   child: Container(
                      //               //     decoration: BoxDecoration(
                      //               //         color: Colors.transparent),
                      //               //     child: Container(child: Text("Retake")),
                      //               //   ),
                      //               // ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // )
                      // Container(
                      //   width: MediaQuery.of(context).size.width,
                      //   height: MediaQuery.of(context).size.height,
                      //   child: Stack(
                      //     children: [
                      //       PackagageVideoPlayer.VideoPlayer(
                      //         _controller,
                      //       ),
                      //       SizedBox(
                      //         height: MediaQuery.of(context).size.height / 4,
                      //       ),
                      //       // GestureDetector(
                      //       //     onTap: () => {
                      //       //       _controller.setVolume(0)
                      //
                      //       //       },
                      //       //     child: Icon(
                      //       //       Icons.volume_mute,
                      //       //       color: Colors.white,
                      //       //     )),
                      //       // SizedBox(
                      //       //   height: MediaQuery.of(context).size.height / 4,
                      //       // ),
                      //       Positioned(
                      //         bottom: 11,
                      //         left: MediaQuery.of(context).size.width / 36,
                      //         right: MediaQuery.of(context).size.width / 36,
                      //         child: Container(
                      //           // width: MediaQuery.of(context).size.width,
                      //           child: Row(
                      //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //             children: [
                      //               RaisedButton(
                      //                 color: Colors.blue,
                      //                 textColor: Colors.white,
                      //                 onPressed: () async {
                      //                   final Directory extDir =
                      //                       await getApplicationDocumentsDirectory();
                      //                   final String dirPath =
                      //                       '${extDir.path}/Oyindori/Filtered';
                      //                   await Directory(dirPath)
                      //                       .create(recursive: true);
                      //                   final String filePath =
                      //                       '$dirPath/${DateTime.now().millisecondsSinceEpoch.toString()}';
                      //                   await fFmpeg.execute('-i ' +
                      //                       widget.path +
                      //                       ' -vf hue=s=0 ' +
                      //                       filePath +
                      //                       '-output.mp4');
                      //                   _controller = PackagageVideoPlayer
                      //                           .VideoPlayerController
                      //                       .file(File(filePath + '-output.mp4'))
                      //                     ..initialize().then((_) {
                      //                       setState(() {
                      //                         _controller.play();
                      //                         _controller.setLooping(true);
                      //                       });
                      //                     });
                      //                 },
                      //                 child: Container(
                      //                   decoration: BoxDecoration(
                      //                       color: Colors.blue,
                      //                       borderRadius: BorderRadius.circular(5)),
                      //                   child: GestureDetector(
                      //                       onTap: () => {
                      //                             _controller.setVolume(0),
                      //                             //  AppNavigator.push(PostTweetPage())
                      //                             // Navigator.popAndPushNamed(context,PostTweetPage)
                      //                             Navigator.pushAndRemoveUntil(
                      //                               context,
                      //                               MaterialPageRoute(
                      //                                   builder: (context) =>
                      //                                       PostTweetPage(
                      //                                         filePath: fileInfo,
                      //                                         isImage: false,
                      //                                       )),
                      //                               (Route<dynamic> route) => false,
                      //                             )
                      //                           },
                      //                       child: Container(
                      //                           child: Text(
                      //                         "Use Video",
                      //                         style: TextStyle(color: Colors.white),
                      //                       ))),
                      //                 ),
                      //               ),
                      //               RaisedButton(
                      //                 onPressed: () {
                      //                   AppNavigator.pop();
                      //                 },
                      //                 textColor: Colors.blue,
                      //                 child: Container(
                      //                   decoration: BoxDecoration(
                      //                       color: Colors.transparent),
                      //                   child: Container(child: Text("Retake")),
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      )
                  : spinkit,
    );
  }
}

// void main() {
//   String a = "0:00:00.4556";
//   List<String> b = a.split(".")[0].split(":");
//   b.removeAt(0);
//   print(b.join(":"));
// }

//
// void main() {
//   String a = "0:00:00.4556";
//   var b = a.split(".");
//   print("b------------------------$b-----type-----${b.runtimeType}");
//   print("b[0]------------------------${b[0]}-----type----${b[0].runtimeType}");
//   var c = b[0].split(":");
//   print("c------------------------${c}-----type-------${c.runtimeType}");
//
//   c.removeAt(0);
//   var d = c.join(":");
//
//   print("d------------------------${d}-----type-------${d.runtimeType}");
// }
