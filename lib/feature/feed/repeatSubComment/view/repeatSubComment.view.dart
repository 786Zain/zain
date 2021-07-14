import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/feed/models/ModelBasedonPostId.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class RepeatSubCommentPost extends StatefulWidget {

  final Comment subCommentPostDetails;

  const RepeatSubCommentPost({Key key, this.subCommentPostDetails}) : super(key: key);

  @override
  _RepeatSubCommentPostState createState() => _RepeatSubCommentPostState();
}

class _RepeatSubCommentPostState extends State<RepeatSubCommentPost> {

  final _captionControllerSubComment = TextEditingController();

  List<String> imageFileTypes = [
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

  VideoPlayerController _controller;
  VoidCallback videoPlayerListener;
  void getVideoFile(fileUrl) async {
    try {
      final VideoPlayerController vcontroller =
      VideoPlayerController.network(fileUrl);
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Consumer(
            builder: (context, watch, child){

              final dashBoardProviderRepo = watch(dashboardProvider);
              final repeatSubCommentProviderRepo = watch(repeatSubCommentPostProvider);
              final feedProviderRepo = watch(feedProvider);

              if (widget.subCommentPostDetails.media != null &&
                  imageFileTypes.indexOf(
                      getImageUrl(widget.subCommentPostDetails.media).split('.').last) ==
                      -1) {
                getVideoFile(getImageUrl(widget.subCommentPostDetails.media));
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left:10.0, right:10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            child: Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 18.0),
                          child: Container(
                              height: 99,
                              child: SvgPicture.asset(newLogoFarm,
                                  height: 100, width: 100, fit: BoxFit.scaleDown)),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(left: 50),
                        //   child: Container(
                        //       // width: 160,
                        //       // height: 80,
                        //       child:SvgPicture.asset(
                        //         thenewFarm,
                        //         height: 100,
                        //         width: 100,
                        //       )
                        //   ),
                        // ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red)),
                          onPressed: () async {

                             await repeatSubCommentProviderRepo.repeatSubCommentPost(context, widget.subCommentPostDetails.id, _captionControllerSubComment.text);

                             await   feedProviderRepo.getFeedList();
                          },
                          color: Colors.red,
                          textColor: Colors.white,
                          child: Text("Quote",
                              style: TextStyle(fontSize: 14, letterSpacing: 2)),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 10, top: 4),
                            child: Row(
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
                                                image:  NetworkImage(
                                                    getImageUrl(
                                                        dashBoardProviderRepo
                                                            .userProfilePic) ??
                                                        ''))))),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10, top: 4),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              new Radius.circular(10.0)),
                                          color: Colors.white30),
                                      child: TextFormField(
                                        controller: _captionControllerSubComment,
                                        style: TextStyle(color: Colors.white),
                                        autofocus: true,
                                        minLines: 1,
                                        maxLines: null,
                                        maxLengthEnforced: true,
                                        cursorColor: Colors.white,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "What's happening?",
                                          contentPadding: EdgeInsets.only(left: 5, right: 2, bottom: 2),
                                          hintStyle: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          color: Color(0xff222222)),
                                      child: Padding(
                                        padding:  EdgeInsets.only(top: 2, right: 8, left: 8, bottom: 8),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: ClipRRect(
                                                      borderRadius:
                                                      BorderRadius.all(Radius.circular(25)),
                                                      child:
                                                      CachedNetworkImage(
                                                          fit: BoxFit.fill,
                                                          height: 52,
                                                          width: 52,
                                                          imageUrl: widget.subCommentPostDetails.userPic)
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 5, top: 10),
                                                  child:
                                                  Text(
                                                      Utils.getCapitalizeName(
                                                          '${widget.subCommentPostDetails.userFullname}'),
                                                      style: GoogleFonts.montserrat(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white
                                                      ))
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 5, top: 10),
                                                  child: Text( '@${widget.subCommentPostDetails.userName}',
                                                      style:  GoogleFonts.montserrat(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.normal,
                                                          color: Color(0xff666666)
                                                      )
                                                  ),
                                                ),

                                              ],
                                            ),
                                            Text(widget.subCommentPostDetails.commentMessage,
                                                style:GoogleFonts.montserrat(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.white54,
                                                    letterSpacing: 0.5
                                                )
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 0),
                                              child: widget.subCommentPostDetails.media != null
                                                  ? Container(
                                                height: 200,
                                                margin: EdgeInsets.only(top: 10),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(20)),
                                                  child: imageFileTypes.indexOf(
                                                      widget.subCommentPostDetails.media
                                                          .split('.')
                                                          .last) !=
                                                      -1
                                                      ? CachedNetworkImage(
                                                      fit: BoxFit.fill,
                                                      height: 176,
                                                      width: 338,
                                                      imageUrl: getImageUrl(
                                                          widget
                                                              .subCommentPostDetails.media))
                                                      : _controller != null &&
                                                      _controller
                                                          .value.initialized
                                                      ? Container()
                                                  // VideoWidget(
                                                  //     play: true,
                                                  //     url: widget
                                                  //         .userData.media)
                                                  // ChewieListItem(videoPlayerController:
                                                  //   VideoPlayerController.network(
                                                  //       feedProviderRepo
                                                  //           .feedDetail.postPhoto[0].location),
                                                  // )
                                                  // VideoPlayer(_controller)
                                                      : Container(),
                                                ),
                                              )
                                                  : Container(),
                                            ),
                                          ],
                                        ),
                                      )
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );

            },
          ),
        ),
      ),
    );
  }
}
