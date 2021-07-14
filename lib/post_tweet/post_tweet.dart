import 'dart:io';
import 'package:custom_switch_button/custom_switch_button.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/navigator.dart';
import 'package:farm_system/post_tweet/repo/post_tweet.repo.dart';
import 'package:farm_system/routes/router.gr.dart';
import 'package:farm_system/ui/open_tweetpage_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tweet_ui/embedded_tweet_view.dart';
import 'package:video_player/video_player.dart';

class PostTweetPage extends StatefulWidget {
  final File filePath;
  final bool isImage;

  const PostTweetPage({Key key, this.filePath, this.isImage}) : super(key: key);
  @override
  _PostTweetPageState createState() => _PostTweetPageState();
}

class _PostTweetPageState extends State<PostTweetPage> {
  final captions = TextEditingController();
  bool autoLogin = false;
  bool autoLogin2 = false;
  VideoPlayerController _controller;
  VoidCallback videoPlayerListener;

  void getVideoFile() async {
    try {
      final VideoPlayerController vcontroller =
          VideoPlayerController.file(widget.filePath);
      videoPlayerListener = () {
        if (_controller != null && _controller.value.size != null) {
          if (mounted) setState(() {});
          _controller.removeListener(videoPlayerListener);
        }
      };
      vcontroller.addListener(videoPlayerListener);
      await vcontroller.setLooping(false);
      await vcontroller.initialize();
      //await _controller?.dispose();
      if (mounted) {
        setState(() {
          _controller = vcontroller;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!widget.isImage) {
      getVideoFile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        margin: EdgeInsets.fromLTRB(10, 40, 10, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => AppNavigator.push(Routes.dashBoard),
                  child: Container(
                      child: Text("CANCEL",
                          //style: TextStyle(fontSize: 10,letterSpacing: 2),
                          style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              wordSpacing: 2,
                              letterSpacing: 2))),
                ),
                GestureDetector(
                  child: Container(
                      child: Text("NEW POST",
                          //style: TextStyle(fontSize: 10,letterSpacing: 2),
                          style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              wordSpacing: 2,
                              letterSpacing: 2))),
                ),
                GestureDetector(
                  child: Container(
                      child: Text("POST",
                          //style: TextStyle(fontSize: 10,letterSpacing: 2),
                          style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              wordSpacing: 2,
                              letterSpacing: 2))),
                  onTap: () async {
//                    await PostRepo.createPost(
//                        widget.filePath, captions.text.trim());
//                    AppNavigator.push(Routes.dashBoard);
                  },
                )
              ],
            ),
            Container(
              child: Divider(
                thickness: 2,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    widget.filePath != null && widget.isImage
                        ? Container(
                            height: 121,
                            width: 168,
                            // decoration: BoxDecoration(
                            //     color: Colors.black,
                            //     borderRadius: BorderRadius.circular(10.0)),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: FileImage(widget.filePath),
                                      fit: BoxFit.fill),
                                  borderRadius: BorderRadius.circular(0.0)),
                            ),
                            // child: Image.network(
                            //     'https://homepages.cae.wisc.edu/~ece533/images/watch.png')
                          )
                        : _controller != null && _controller.value.initialized
                            ? Container(
                                height: 121,
                                width: 168,
                                // decoration: BoxDecoration(
                                //     color: Colors.black,
                                //     borderRadius: BorderRadius.circular(10.0)),
                                child: AspectRatio(
                                  aspectRatio: _controller.value.aspectRatio,
                                  child: VideoPlayer(_controller),
                                ),
                                // child: Image.network(
                                //     'https://homepages.cae.wisc.edu/~ece533/images/watch.png')
                              )
                            : Container(),

//
//                    Container(
//                            height: 121,
//                            width: 168,
//                            // decoration: BoxDecoration(
//                            //     color: Colors.black,
//                            //     borderRadius: BorderRadius.circular(10.0)),
//                            child: Container(
//                              width: MediaQuery.of(context).size.width,
//                              margin: EdgeInsets.symmetric(horizontal: 5.0),
//                              decoration: BoxDecoration(
//                                  image: DecorationImage(
//                                      image: FileImage(widget.filePath),
//                                      fit: BoxFit.fill),
//                                  borderRadius: BorderRadius.circular(0.0)),
//                            ),
//                            // child: Image.network(
//                            //     'https://homepages.cae.wisc.edu/~ece533/images/watch.png')
//                          ),
                    Container(
                        height: 121,
                        width: 180,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: TextField(
                          controller: captions,
                          maxLines: 4,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Write Captions...'),
                          textAlign: TextAlign.start,
                        ))
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.,
                //   children: [Container(child: Text("manish"))],
                // )
                // OpenTweetPageButton(
                //   title: "Video",
                //   tweetPath: 'assets/tweet_examples/tweet_video_shiv.json',
                //   // quoteTweetPath:
                //   //     'assets/tweet_examples/tweet_quote_video.json',
                // ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Divider(
                thickness: 2,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Container(
                      child: Text("Select Catagory Of post",
                          //style: TextStyle(fontSize: 10,letterSpacing: 2),
                          style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              wordSpacing: 2,
                              letterSpacing: 2))),
                ),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
            Container(
              child: Divider(
                thickness: 2,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Container(
                      child: Text("Twitter",
                          //style: TextStyle(fontSize: 10,letterSpacing: 2),
                          style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              wordSpacing: 2,
                              letterSpacing: 2))),
                ),
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    // margin: EdgeInsets.only( top: 20, left: 40),
                    child: CustomSwitchButton(
                      backgroundColor: Colors.blueGrey,
                      unCheckedColor: Colors.white,
                      buttonWidth: 35,
                      animationDuration: Duration(milliseconds: 400),
                      checkedColor: Colors.blue,
                      checked: autoLogin,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      autoLogin = !autoLogin;
                    });
                  },
                ),
              ],
            ),
            Container(
              child: Divider(
                thickness: 2,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Container(
                      child: Text("INSTAGRAM",
                          //style: TextStyle(fontSize: 10,letterSpacing: 2),
                          style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              wordSpacing: 2,
                              letterSpacing: 2))),
                ),
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    // margin: EdgeInsets.only( top: 20, left: 40),
                    child: CustomSwitchButton(
                      backgroundColor: Colors.blueGrey,
                      unCheckedColor: Colors.white,
                      buttonWidth: 35,
                      animationDuration: Duration(milliseconds: 400),
                      checkedColor: Colors.blue,
                      checked: autoLogin2,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      autoLogin2 = !autoLogin2;
                    });
                  },
                ),
              ],
            ),
            Container(
              child: Divider(
                thickness: 2,
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  child: Container(
                      child: Text("FACEBOOK",
                          //style: TextStyle(fontSize: 10,letterSpacing: 2),
                          style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              wordSpacing: 2,
                              letterSpacing: 2))),
                ),
              ],
            ),
            Container(
              child: Divider(
                thickness: 2,
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  child: Container(
                      child: Text("LINKEDIN",
                          //style: TextStyle(fontSize: 10,letterSpacing: 2),
                          style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              wordSpacing: 2,
                              letterSpacing: 2))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
