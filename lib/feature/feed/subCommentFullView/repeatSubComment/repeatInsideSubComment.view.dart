import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/feed/subCommentFullView/model/subcommentfullviewmodel.dart';
import 'package:farm_system/feature/profile_user/view/Likes/model/Like_model.dart' as like;
import 'package:farm_system/feature/profile_user/view/Likes/model/likeSubTab_model.dart';
import 'package:farm_system/feature/profile_user/view/Media/model/userMedia_model.dart' as mediaAll;
import 'package:farm_system/feature/profile_user/view/postReplies/modal/postReplies.modal.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';


class RepeatInsideSubComment extends StatefulWidget {

  final Datum insideSubCommentPostDetails;
  final mediaAll.Datum mediaAllTabProfile;
  final like.Datum likeAllTabProfile;
  final LikeSubTab likeSubTabProfile;
  final PostReply postReplySubTabProfile;
  const RepeatInsideSubComment({Key key, this.insideSubCommentPostDetails,  this.mediaAllTabProfile,  this.likeAllTabProfile, String adminPicUser,  this.likeSubTabProfile,  this.postReplySubTabProfile}) : super(key: key);

  @override
  _RepeatInsideSubCommentState createState() => _RepeatInsideSubCommentState();
}

class _RepeatInsideSubCommentState extends State<RepeatInsideSubComment> {


  final _captionControllerInsideSubComment = TextEditingController();

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
          child:
        widget.postReplySubTabProfile != null ?
        Consumer(
                builder: (context, watch, child){

                  final dashBoardProviderRepo = watch(dashboardProvider);
                  final repeatSubCommentProviderRepo = watch(repeatSubCommentPostProvider);



                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left:10.0, right:10.0),
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
                              padding: EdgeInsets.only(top: 18.0,left: 50),
                              child: Container(
                                  height: 89,
                                  child: SvgPicture.asset(newLogoFarm,
                                      height: 120, width: 120, fit: BoxFit.scaleDown)),
                            ),
                            // Padding(
                            //   padding: EdgeInsets.only(left: 50),
                            //   child: Container(
                            //       // width: 160,
                            //       // height: 80,
                            //       child: SvgPicture.asset(
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

                                await repeatSubCommentProviderRepo.repeatSubCommentPost(context, widget.postReplySubTabProfile.parentId, _captionControllerInsideSubComment.text);
                              },
                              color: Colors.red,
                              textColor: Colors.white,
                              child: Text("Quote hbw",
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
                                padding: EdgeInsets.all(4),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left:8.0, right:8.0),
                                      child: Visibility(
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
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10,),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  new Radius.circular(10.0)),
                                              color: Colors.white30),
                                          child: TextFormField(
                                            controller: _captionControllerInsideSubComment,
                                            style: TextStyle(color: Colors.white),
                                            autofocus: true,
                                            minLines: 1,
                                            maxLines: null,
                                            maxLengthEnforced: true,
                                            cursorColor: Colors.white,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.only(left: 5, right: 2, bottom: 2),
                                              hintText: "What's happening?",
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
                                                          BorderRadius.all(Radius.circular(20)),
                                                          child:
                                                          CachedNetworkImage(
                                                              fit: BoxFit.fill,
                                                              height: 40,
                                                              width: 40,
                                                              imageUrl: widget.postReplySubTabProfile.userPic)
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: 10, top: 10),
                                                      child: Text(  Utils.getCapitalizeName(widget.postReplySubTabProfile.userFullname),
                                                          style:  GoogleFonts.montserrat(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.white
                                                          )
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: 10, top: 10),
                                                      child: Text( '@${widget.postReplySubTabProfile.userName}',
                                                          style: GoogleFonts.montserrat(
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.normal,
                                                              color: Color(0xff666666)
                                                          )
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Text(widget.postReplySubTabProfile.commentMessage,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white70,
                                                    )
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 0),
                                                  child: widget.postReplySubTabProfile.commentMedia != null
                                                      ? Container(
                                                    height: 200,
                                                    margin: EdgeInsets.only(top: 10),
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(20)),
                                                      child: imageFileTypes.indexOf(
                                                          widget.postReplySubTabProfile.commentMedia[0]
                                                              .split('.')
                                                              .last) !=
                                                          -1
                                                          ? CachedNetworkImage(
                                                          fit: BoxFit.fill,
                                                          height: 176,
                                                          width: 338,
                                                          imageUrl: getImageUrl(
                                                              widget.postReplySubTabProfile.commentMedia[0]))
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
              )
        : widget.likeSubTabProfile != null ?
        Consumer(
                builder: (context, watch, child){

                  final dashBoardProviderRepo = watch(dashboardProvider);
                  final repeatSubCommentProviderRepo = watch(repeatSubCommentPostProvider);



                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left:10.0, right:10.0),
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
                              padding: EdgeInsets.only(top: 18.0,left: 50),
                              child: Container(
                                  height: 89,
                                  child: SvgPicture.asset(newLogoFarm,
                                      height: 120, width: 120, fit: BoxFit.scaleDown)),
                            ),
                            // Padding(
                            //   padding: EdgeInsets.only(left: 50),
                            //   child: Container(
                            //       // width: 160,
                            //       // height: 80,
                            //       child: SvgPicture.asset(
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

                                await repeatSubCommentProviderRepo.repeatSubCommentPost(context, widget.likeSubTabProfile.id, _captionControllerInsideSubComment.text);
                              },
                              color: Colors.red,
                              textColor: Colors.white,
                              child: Text("Quote hbw",
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
                                padding: EdgeInsets.all(4),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left:8.0, right:8.0),
                                      child: Visibility(
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
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10,),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  new Radius.circular(10.0)),
                                              color: Colors.white30),
                                          child: TextFormField(
                                            controller: _captionControllerInsideSubComment,
                                            style: TextStyle(color: Colors.white),
                                            autofocus: true,
                                            minLines: 1,
                                            maxLines: null,
                                            maxLengthEnforced: true,
                                            cursorColor: Colors.white,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.only(left: 5, right: 2, bottom: 2),
                                              hintText: "What's happening?",
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
                                                          BorderRadius.all(Radius.circular(20)),
                                                          child:
                                                          CachedNetworkImage(
                                                              fit: BoxFit.fill,
                                                              height: 40,
                                                              width: 40,
                                                              imageUrl: widget.likeSubTabProfile.profilePic)
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: 10, top: 10),
                                                      child: Text(  Utils.getCapitalizeName(widget.likeSubTabProfile.name),
                                                          style:  GoogleFonts.montserrat(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.white
                                                          )
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: 10, top: 10),
                                                      child: Text( '@${widget.likeSubTabProfile.userName}',
                                                          style: GoogleFonts.montserrat(
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.normal,
                                                              color: Color(0xff666666)
                                                          )
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Text(widget.likeSubTabProfile.caption,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white70,
                                                    )
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 0),
                                                  child: widget.likeSubTabProfile.postPhoto != null
                                                      ? Container(
                                                    height: 200,
                                                    margin: EdgeInsets.only(top: 10),
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(20)),
                                                      child: imageFileTypes.indexOf(
                                                          widget.likeSubTabProfile.postPhoto[0].location
                                                              .split('.')
                                                              .last) !=
                                                          -1
                                                          ? CachedNetworkImage(
                                                          fit: BoxFit.fill,
                                                          height: 176,
                                                          width: 338,
                                                          imageUrl: getImageUrl(
                                                              widget.likeSubTabProfile.postPhoto[0].location))
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
              )
        : widget.likeAllTabProfile != null ?

         Consumer(
           builder: (context, watch, child){

             final dashBoardProviderRepo = watch(dashboardProvider);
             final repeatSubCommentProviderRepo = watch(repeatSubCommentPostProvider);



             return Column(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Padding(
                   padding: EdgeInsets.only(left:10.0, right:10.0),
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
                         padding: EdgeInsets.only(top: 18.0,left: 50),
                         child: Container(
                             height: 89,
                             child: SvgPicture.asset(newLogoFarm,
                                 height: 120, width: 120, fit: BoxFit.scaleDown)),
                       ),
                       // Padding(
                       //   padding: EdgeInsets.only(left: 50),
                       //   child: Container(
                       //       // width: 160,
                       //       // height: 80,
                       //       child: SvgPicture.asset(
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

                           await repeatSubCommentProviderRepo.repeatSubCommentPost(context, widget.likeAllTabProfile.id, _captionControllerInsideSubComment.text);
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
                           padding: EdgeInsets.all(4),
                           child: Row(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Padding(
                                 padding: EdgeInsets.only(left:8.0, right:8.0),
                                 child: Visibility(
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
                               ),
                               Expanded(
                                 child: Padding(
                                   padding: EdgeInsets.only(left: 10,),
                                   child: Container(
                                     decoration: BoxDecoration(
                                         borderRadius: BorderRadius.all(
                                             new Radius.circular(10.0)),
                                         color: Colors.white30),
                                     child: TextFormField(
                                       controller: _captionControllerInsideSubComment,
                                       style: TextStyle(color: Colors.white),
                                       autofocus: true,
                                       minLines: 1,
                                       maxLines: null,
                                       maxLengthEnforced: true,
                                       cursorColor: Colors.white,
                                       decoration: InputDecoration(
                                         border: InputBorder.none,
                                         contentPadding: EdgeInsets.only(left: 5, right: 2, bottom: 2),
                                         hintText: "What's happening?",
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
                                                     BorderRadius.all(Radius.circular(20)),
                                                     child:
                                                     CachedNetworkImage(
                                                         fit: BoxFit.fill,
                                                         height: 40,
                                                         width: 40,
                                                         imageUrl: widget.likeAllTabProfile.profilePic)
                                                 ),
                                               ),
                                               Padding(
                                                 padding: EdgeInsets.only(left: 10, top: 10),
                                                 child: Text(  Utils.getCapitalizeName(widget.likeAllTabProfile.name),
                                                     style:  GoogleFonts.montserrat(
                                                         fontSize: 14,
                                                         fontWeight: FontWeight.bold,
                                                         color: Colors.white
                                                     )
                                                 ),
                                               ),
                                               Padding(
                                                 padding: EdgeInsets.only(left: 10, top: 10),
                                                 child: Text( '@${widget.likeAllTabProfile.userName}',
                                                     style: GoogleFonts.montserrat(
                                                         fontSize: 12,
                                                         fontWeight: FontWeight.normal,
                                                         color: Color(0xff666666)
                                                     )
                                                 ),
                                               )
                                             ],
                                           ),
                                           Text(widget.likeAllTabProfile.caption,
                                               style: TextStyle(
                                                 fontSize: 15,
                                                 color: Colors.white70,
                                               )
                                           ),
                                           Padding(
                                             padding: EdgeInsets.only(left: 0),
                                             child: widget.likeAllTabProfile.postPhoto != null
                                                 ? Container(
                                               height: 200,
                                               margin: EdgeInsets.only(top: 10),
                                               child: ClipRRect(
                                                 borderRadius: BorderRadius.all(
                                                     Radius.circular(20)),
                                                 child: imageFileTypes.indexOf(
                                                     widget.likeAllTabProfile.postPhoto[0].location
                                                         .split('.')
                                                         .last) !=
                                                     -1
                                                     ? CachedNetworkImage(
                                                     fit: BoxFit.fill,
                                                     height: 176,
                                                     width: 338,
                                                     imageUrl: getImageUrl(
                                                         widget.likeAllTabProfile.postPhoto[0].location))
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
         ) :

          widget.mediaAllTabProfile != null ?
          Consumer(
            builder: (context, watch, child){

              final dashBoardProviderRepo = watch(dashboardProvider);
              final repeatSubCommentProviderRepo = watch(repeatSubCommentPostProvider);

              if (widget.mediaAllTabProfile.postPhoto[0].location != null &&
                  imageFileTypes.indexOf(
                      getImageUrl(widget.mediaAllTabProfile.postPhoto[0].location).split('.').last) ==
                      -1) {
                getVideoFile(getImageUrl(widget.mediaAllTabProfile.postPhoto[0].location));
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left:10.0, right:10.0),
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
                          padding: EdgeInsets.only(top: 18.0,left: 50),
                          child: Container(
                              height: 89,
                              child: SvgPicture.asset(newLogoFarm,
                                  height: 120, width: 120, fit: BoxFit.scaleDown)),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(left: 50),
                        //   child: Container(
                        //       // width: 160,
                        //       // height: 80,
                        //       child: SvgPicture.asset(
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

                            await repeatSubCommentProviderRepo.repeatSubCommentPost(context, widget.mediaAllTabProfile.parentId, _captionControllerInsideSubComment.text);
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
                            padding: EdgeInsets.all(4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left:8.0, right:8.0),
                                  child: Visibility(
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
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10,),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              new Radius.circular(10.0)),
                                          color: Colors.white30),
                                      child: TextFormField(
                                        controller: _captionControllerInsideSubComment,
                                        style: TextStyle(color: Colors.white),
                                        autofocus: true,
                                        minLines: 1,
                                        maxLines: null,
                                        maxLengthEnforced: true,
                                        cursorColor: Colors.white,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(left: 5, right: 2, bottom: 2),
                                          hintText: "What's happening?",
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
                                                      BorderRadius.all(Radius.circular(20)),
                                                      child:
                                                      CachedNetworkImage(
                                                          fit: BoxFit.fill,
                                                          height: 40,
                                                          width: 40,
                                                          imageUrl: widget.mediaAllTabProfile.profilePic)
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 10, top: 10),
                                                  child: Text(  Utils.getCapitalizeName(widget.mediaAllTabProfile.name),
                                                      style:  GoogleFonts.montserrat(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white
                                                      )
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 10, top: 10),
                                                  child: Text( '@${widget.mediaAllTabProfile.userName}',
                                                      style: GoogleFonts.montserrat(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.normal,
                                                          color: Color(0xff666666)
                                                      )
                                                  ),
                                                )
                                              ],
                                            ),
                                            Text(widget.mediaAllTabProfile.caption,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white70,
                                                )
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 0),
                                              child: widget.mediaAllTabProfile.postPhoto != null
                                                  ? Container(
                                                height: 200,
                                                margin: EdgeInsets.only(top: 10),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(20)),
                                                  child: imageFileTypes.indexOf(
                                                      widget.mediaAllTabProfile.postPhoto[0].location
                                                          .split('.')
                                                          .last) !=
                                                      -1
                                                      ? CachedNetworkImage(
                                                      fit: BoxFit.fill,
                                                      height: 176,
                                                      width: 338,
                                                      imageUrl: getImageUrl(
                                                          widget.mediaAllTabProfile.postPhoto[0].location))
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
          )
          : Consumer(
            builder: (context, watch, child){

              final dashBoardProviderRepo = watch(dashboardProvider);
              final repeatSubCommentProviderRepo = watch(repeatSubCommentPostProvider);

              if (widget.insideSubCommentPostDetails.media != null &&
                  imageFileTypes.indexOf(
                      getImageUrl(widget.insideSubCommentPostDetails.media).split('.').last) ==
                      -1) {
                getVideoFile(getImageUrl(widget.insideSubCommentPostDetails.media));
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left:10.0, right:10.0),
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
                          padding: EdgeInsets.only(top: 18.0,left: 50),
                          child: Container(
                              height: 89,
                              child: SvgPicture.asset(newLogoFarm,
                                  height: 120, width: 120, fit: BoxFit.scaleDown)),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(left: 50),
                        //   child: Container(
                        //       // width: 160,
                        //       // height: 80,
                        //       child: SvgPicture.asset(
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

                            await repeatSubCommentProviderRepo.repeatSubCommentPost(context, widget.insideSubCommentPostDetails.id, _captionControllerInsideSubComment.text);
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
                            padding: EdgeInsets.all(4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left:8.0, right:8.0),
                                  child: Visibility(
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
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10,),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            new Radius.circular(10.0)),
                                        color: Colors.white30),
                                    child: TextFormField(
                                      controller: _captionControllerInsideSubComment,
                                      style: TextStyle(color: Colors.white),
                                      autofocus: true,
                                      minLines: 1,
                                      maxLines: null,
                                      maxLengthEnforced: true,
                                      cursorColor: Colors.white,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(left: 5, right: 2, bottom: 2),
                                        hintText: "What's happening?",
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
                                                      BorderRadius.all(Radius.circular(20)),
                                                      child:
                                                      CachedNetworkImage(
                                                          fit: BoxFit.fill,
                                                          height: 40,
                                                          width: 40,
                                                          imageUrl: widget.insideSubCommentPostDetails.userPic)
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 10, top: 10),
                                                  child: Text(  Utils.getCapitalizeName(widget.insideSubCommentPostDetails.userFullname),
                                                      style:  GoogleFonts.montserrat(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white
                                                      )
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 10, top: 10),
                                                  child: Text( '@${widget.insideSubCommentPostDetails.userName}',
                                                      style: GoogleFonts.montserrat(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.normal,
                                                          color: Color(0xff666666)
                                                      )
                                                  ),
                                                )
                                              ],
                                            ),
                                            Text(widget.insideSubCommentPostDetails.commentMessage,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white70,
                                                )
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 0),
                                              child: widget.insideSubCommentPostDetails.media != null
                                                  ? Container(
                                                height: 200,
                                                margin: EdgeInsets.only(top: 10),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(20)),
                                                  child: imageFileTypes.indexOf(
                                                      widget.insideSubCommentPostDetails.media
                                                          .split('.')
                                                          .last) !=
                                                      -1
                                                      ? CachedNetworkImage(
                                                      fit: BoxFit.fill,
                                                      height: 176,
                                                      width: 338,
                                                      imageUrl: getImageUrl(
                                                          widget
                                                              .insideSubCommentPostDetails.media))
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
