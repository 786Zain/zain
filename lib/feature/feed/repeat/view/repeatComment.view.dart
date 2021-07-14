import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/farm_post/RepeatDetail/modal/repeatFullView.modal.dart';
import 'package:farm_system/feature/feed/models/getFeed.model.dart';
import 'package:farm_system/feature/feed/view/readmoretext.dart';
import 'package:farm_system/feature/profile_user/view/Likes/model/Like_model.dart' as like;
import 'package:farm_system/feature/profile_user/view/Likes/model/likeSubTab_model.dart';
import 'package:farm_system/feature/profile_user/view/Media/model/userMedia_model.dart' as media;
import 'package:farm_system/feature/profile_user/view/postReplies/modal/postReplies.modal.dart';
import 'package:farm_system/feature/profile_user/view/profile_tabs/farmpost/modal/profileSubCategoryIndividual.modal.dart';
import 'package:farm_system/feature/profile_user/view/profile_tabs/farmpost/modal/userProfileAllData.modal.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/screen/Discovery/discovery_model.dart' as dd;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:farm_system/feature/feed/models/ModelBasedonPostId.dart' as dis;

import '../../../../utils.dart';

class RepeatCommentPost extends StatefulWidget {

  final FeedDetail postDetails;
  final Post repeatPostDetails;
  final Datum allUserDetails;
  final Datums postProfileSubcategory;
  final PostReply profilePostRepliesDetails;
  final String adminPicUser;
  final dis.Post detailsPostPage;
  final dis.Comment postCommentListDetails;
  final dd.Feed discoverpostDetails;
  final media.Datum postDetailsMedia;
  final like.Datum postDetailsLike;
  final LikeSubTab  postDetailsSubLikeTab;

  const RepeatCommentPost({Key key, this.postDetails, this.repeatPostDetails,  this.allUserDetails,  this.postProfileSubcategory,  this.profilePostRepliesDetails,
  this.adminPicUser,this.detailsPostPage, this.postCommentListDetails,  this.discoverpostDetails,  this.postDetailsMedia,  this.postDetailsLike,  this.postDetailsSubLikeTab,
  }) : super(key: key);

  @override
  _RepeatCommentPostState createState() => _RepeatCommentPostState();
}

class _RepeatCommentPostState extends State<RepeatCommentPost> {

  final _captionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
       backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child:
          widget.postDetailsSubLikeTab != null ?
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer(builder: (context, watch, child){

                final repeatProviderRepo = watch(repeatFromPostProvider);
                final feedProviderRepo = watch(feedProvider);
                final postRepliesRepo = watch(postRepliesProvider);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
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
                            height: 89,
                            child: SvgPicture.asset(newLogoFarm,
                                height: 120, width: 120, fit: BoxFit.scaleDown)),
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red)),
                        onPressed: () async {

                          await repeatProviderRepo.repeatFromPost(context,widget.postDetailsSubLikeTab.id, _captionController.text);
                          // await   feedProviderRepo.getFeedList();
                        },
                        color: Colors.red,
                        textColor: Colors.white,
                        child: Text("Quote",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2
                            )),
                      )
                    ],
                  ),
                );

              }),
              Container(
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
                                    padding:  EdgeInsets.only(top: 2, right: 8, left: 4, bottom: 8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            // Padding(
                                            //   padding: EdgeInsets.all(8.0),
                                            //   child: ClipRRect(
                                            //       borderRadius:
                                            //       BorderRadius.all(Radius.circular(20)),
                                            //       child:
                                            //       CachedNetworkImage(
                                            //           fit: BoxFit.fill,
                                            //           height: 40,
                                            //           width: 40,
                                            //           imageUrl:  widget.discoverpostDetails.userPic)
                                            //   ),
                                            // ),
                                            // Padding(
                                            //   padding: EdgeInsets.only(left: 5, top: 10),
                                            //   child: Text(Utils.getCapitalizeName(widget.discoverpostDetails.userName),
                                            //       style: GoogleFonts.montserrat(
                                            //           fontSize: 14,
                                            //           fontWeight: FontWeight.bold,
                                            //           color: Colors.white
                                            //       )
                                            //   ),
                                            // ),
                                            // Padding(
                                            //   padding: EdgeInsets.only(left: 5, top: 10),
                                            //   child: Text('@${widget.postCommentListDetails.userName}',
                                            //       style:  GoogleFonts.montserrat(
                                            //           fontSize: 12,
                                            //           fontWeight: FontWeight.normal,
                                            //           color: Color(0xff666666)
                                            //       )
                                            //   ),
                                            // )
                                          ],
                                        ),
                                        widget.postDetailsSubLikeTab.caption != "" && widget.postDetailsSubLikeTab.caption != null ?
                                        Text(widget.postDetailsSubLikeTab.caption,
                                            style:GoogleFonts.montserrat(
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white54,
                                                letterSpacing: 0.5
                                            )
                                        ): Container(),

                                        Padding(
                                          padding: EdgeInsets.only(top:8.0, left: 8.0, right: 8.0, bottom: 10),
                                          child:
                                          widget.postDetailsSubLikeTab.postPhoto[0].location.length > 0 ?
                                          Container(
                                            height: 200,
                                            margin: EdgeInsets.only(top: 10),
                                            child:
                                            ClipRRect(
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(
                                                      12)),
                                              child: OverflowBox(
                                                  minWidth: 350,
                                                  minHeight: 220,
                                                  maxHeight: 400,
                                                  maxWidth:350,
                                                  child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      imageUrl: getImageUrl(
                                                          widget.postDetailsSubLikeTab.postPhoto[0].location))
                                              ),
                                            ),
                                          ): Container(),
                                        )
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
          )
         : widget.postDetailsLike != null ?
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer(builder: (context, watch, child){

                final repeatProviderRepo = watch(repeatFromPostProvider);
                final feedProviderRepo = watch(feedProvider);
                final postRepliesRepo = watch(postRepliesProvider);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
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
                            height: 89,
                            child: SvgPicture.asset(newLogoFarm,
                                height: 120, width: 120, fit: BoxFit.scaleDown)),
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red)),
                        onPressed: () async {

                          await repeatProviderRepo.repeatFromPost(context,widget.postDetailsLike.id, _captionController.text);
                          // await   feedProviderRepo.getFeedList();
                        },
                        color: Colors.red,
                        textColor: Colors.white,
                        child: Text("Quote",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2
                            )),
                      )
                    ],
                  ),
                );

              }),
              Container(
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
                                    padding:  EdgeInsets.only(top: 2, right: 8, left: 4, bottom: 8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            // Padding(
                                            //   padding: EdgeInsets.all(8.0),
                                            //   child: ClipRRect(
                                            //       borderRadius:
                                            //       BorderRadius.all(Radius.circular(20)),
                                            //       child:
                                            //       CachedNetworkImage(
                                            //           fit: BoxFit.fill,
                                            //           height: 40,
                                            //           width: 40,
                                            //           imageUrl:  widget.discoverpostDetails.userPic)
                                            //   ),
                                            // ),
                                            // Padding(
                                            //   padding: EdgeInsets.only(left: 5, top: 10),
                                            //   child: Text(Utils.getCapitalizeName(widget.discoverpostDetails.userName),
                                            //       style: GoogleFonts.montserrat(
                                            //           fontSize: 14,
                                            //           fontWeight: FontWeight.bold,
                                            //           color: Colors.white
                                            //       )
                                            //   ),
                                            // ),
                                            // Padding(
                                            //   padding: EdgeInsets.only(left: 5, top: 10),
                                            //   child: Text('@${widget.postCommentListDetails.userName}',
                                            //       style:  GoogleFonts.montserrat(
                                            //           fontSize: 12,
                                            //           fontWeight: FontWeight.normal,
                                            //           color: Color(0xff666666)
                                            //       )
                                            //   ),
                                            // )
                                          ],
                                        ),
                                        widget.postDetailsLike.caption != "" && widget.postDetailsLike.caption != null ?
                                        Text(widget.postDetailsLike.caption,
                                            style:GoogleFonts.montserrat(
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white54,
                                                letterSpacing: 0.5
                                            )
                                        ): Container(),

                                        Padding(
                                          padding: EdgeInsets.only(top:8.0, left: 8.0, right: 8.0, bottom: 10),
                                          child:
                                          widget.postDetailsLike.postPhoto[0].location.length > 0 ?
                                          Container(
                                            height: 200,
                                            margin: EdgeInsets.only(top: 10),
                                            child:
                                            ClipRRect(
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(
                                                      12)),
                                              child: OverflowBox(
                                                  minWidth: 350,
                                                  minHeight: 220,
                                                  maxHeight: 400,
                                                  maxWidth:350,
                                                  child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      imageUrl: getImageUrl(
                                                          widget.postDetailsLike.postPhoto[0].location))
                                              ),
                                            ),
                                          ): Container(),
                                        )
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
          ) :
        widget.postDetailsMedia != null ?
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer(builder: (context, watch, child){

              final repeatProviderRepo = watch(repeatFromPostProvider);
              final feedProviderRepo = watch(feedProvider);
              final postRepliesRepo = watch(postRepliesProvider);
              return Padding(
                padding: const EdgeInsets.all(8.0),
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
                          height: 89,
                          child: SvgPicture.asset(newLogoFarm,
                              height: 120, width: 120, fit: BoxFit.scaleDown)),
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)),
                      onPressed: () async {

                        await repeatProviderRepo.repeatFromPost(context,widget.postDetailsMedia.id, _captionController.text);
                       // await   feedProviderRepo.getFeedList();
                      },
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text("Quote",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2
                          )),
                    )
                  ],
                ),
              );

            }),
            Container(
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
                                  padding:  EdgeInsets.only(top: 2, right: 8, left: 4, bottom: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          // Padding(
                                          //   padding: EdgeInsets.all(8.0),
                                          //   child: ClipRRect(
                                          //       borderRadius:
                                          //       BorderRadius.all(Radius.circular(20)),
                                          //       child:
                                          //       CachedNetworkImage(
                                          //           fit: BoxFit.fill,
                                          //           height: 40,
                                          //           width: 40,
                                          //           imageUrl:  widget.discoverpostDetails.userPic)
                                          //   ),
                                          // ),
                                          // Padding(
                                          //   padding: EdgeInsets.only(left: 5, top: 10),
                                          //   child: Text(Utils.getCapitalizeName(widget.discoverpostDetails.userName),
                                          //       style: GoogleFonts.montserrat(
                                          //           fontSize: 14,
                                          //           fontWeight: FontWeight.bold,
                                          //           color: Colors.white
                                          //       )
                                          //   ),
                                          // ),
                                          // Padding(
                                          //   padding: EdgeInsets.only(left: 5, top: 10),
                                          //   child: Text('@${widget.postCommentListDetails.userName}',
                                          //       style:  GoogleFonts.montserrat(
                                          //           fontSize: 12,
                                          //           fontWeight: FontWeight.normal,
                                          //           color: Color(0xff666666)
                                          //       )
                                          //   ),
                                          // )
                                        ],
                                      ),
                                      widget.postDetailsMedia.caption != "" && widget.postDetailsMedia.caption != null ?
                                      Text(widget.postDetailsMedia.caption,
                                          style:GoogleFonts.montserrat(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.white54,
                                              letterSpacing: 0.5
                                          )
                                      ): Container(),

                                      Padding(
                                        padding: EdgeInsets.only(top:8.0, left: 8.0, right: 8.0, bottom: 10),
                                        child:
                                        widget.postDetailsMedia.postPhoto[0].location.length > 0 ?
                                        Container(
                                          height: 200,
                                          margin: EdgeInsets.only(top: 10),
                                          child:
                                          ClipRRect(
                                            borderRadius:
                                            BorderRadius.all(
                                                Radius.circular(
                                                    12)),
                                            child: OverflowBox(
                                                minWidth: 350,
                                                minHeight: 220,
                                                maxHeight: 400,
                                                maxWidth:350,
                                                child: CachedNetworkImage(
                                                    fit: BoxFit.cover,
                                                    imageUrl: getImageUrl(
                                                        widget.postDetailsMedia.postPhoto[0].location))
                                            ),
                                          ),
                                        ): Container(),
                                      )
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
        ) :
        widget.discoverpostDetails != null ?
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer(builder: (context, watch, child){

              final repeatProviderRepo = watch(repeatFromPostProvider);
              final feedProviderRepo = watch(feedProvider);
              final postRepliesRepo = watch(postRepliesProvider);
              return Padding(
                padding: const EdgeInsets.all(8.0),
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
                          height: 89,
                          child: SvgPicture.asset(newLogoFarm,
                              height: 120, width: 120, fit: BoxFit.scaleDown)),
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)),
                      onPressed: () async {

                        await repeatProviderRepo.repeatFromPost(context,widget.discoverpostDetails.id, _captionController.text);
                        await   feedProviderRepo.getFeedList();
                      },
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text("Quote",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2
                          )),
                    )
                  ],
                ),
              );

            }),
            Container(
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
                    // Padding(
                    //   padding: EdgeInsets.only(left: 10, right: 10, top: 4),
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Padding(
                    //         padding: EdgeInsets.all(8.0),
                    //         child: ClipRRect(
                    //             borderRadius:
                    //             BorderRadius.all(Radius.circular(25)),
                    //             child:
                    //             CachedNetworkImage(
                    //                 fit: BoxFit.fill,
                    //                 height: 52,
                    //                 width: 52,
                    //                 imageUrl: widget.adminPicUser)
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: Padding(
                    //           padding: EdgeInsets.only(left: 10, top: 15),
                    //           child: Container(
                    //             decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.all(
                    //                     Radius.circular(10.0)),
                    //                 color: Colors.white30),
                    //             child: TextFormField(
                    //               controller: _captionController,
                    //               style: TextStyle(color: Colors.white),
                    //               autofocus: true,
                    //               minLines: 1,
                    //               maxLines: null,
                    //               maxLengthEnforced: true,
                    //               cursorColor: Colors.white,
                    //
                    //               decoration: InputDecoration(
                    //                 border: InputBorder.none,
                    //                 contentPadding: EdgeInsets.only(left: 5, right: 2, bottom: 2),
                    //                 hintText: "What's happening?",
                    //                 hintStyle: GoogleFonts.poppins(
                    //                   fontWeight: FontWeight.w400,
                    //                   fontSize: 15,
                    //                   color: Colors.white,
                    //
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // )
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
                                  padding:  EdgeInsets.only(top: 2, right: 8, left: 4, bottom: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          // Padding(
                                          //   padding: EdgeInsets.all(8.0),
                                          //   child: ClipRRect(
                                          //       borderRadius:
                                          //       BorderRadius.all(Radius.circular(20)),
                                          //       child:
                                          //       CachedNetworkImage(
                                          //           fit: BoxFit.fill,
                                          //           height: 40,
                                          //           width: 40,
                                          //           imageUrl:  widget.discoverpostDetails.userPic)
                                          //   ),
                                          // ),
                                          // Padding(
                                          //   padding: EdgeInsets.only(left: 5, top: 10),
                                          //   child: Text(Utils.getCapitalizeName(widget.discoverpostDetails.userName),
                                          //       style: GoogleFonts.montserrat(
                                          //           fontSize: 14,
                                          //           fontWeight: FontWeight.bold,
                                          //           color: Colors.white
                                          //       )
                                          //   ),
                                          // ),
                                          // Padding(
                                          //   padding: EdgeInsets.only(left: 5, top: 10),
                                          //   child: Text('@${widget.postCommentListDetails.userName}',
                                          //       style:  GoogleFonts.montserrat(
                                          //           fontSize: 12,
                                          //           fontWeight: FontWeight.normal,
                                          //           color: Color(0xff666666)
                                          //       )
                                          //   ),
                                          // )
                                        ],
                                      ),
                                      widget.discoverpostDetails.caption != "" && widget.discoverpostDetails.caption != null ?
                                      Text(widget.discoverpostDetails.caption,
                                          style:GoogleFonts.montserrat(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.white54,
                                              letterSpacing: 0.5
                                          )
                                      ): Container(),

                                      Padding(
                                        padding: EdgeInsets.only(top:8.0, left: 8.0, right: 8.0, bottom: 10),
                                        child:
                                        widget.discoverpostDetails.postPhoto[0].location.length > 0 ?
                                        Container(
                                          height: 200,
                                          margin: EdgeInsets.only(top: 10),
                                          child:
                                          ClipRRect(
                                            borderRadius:
                                            BorderRadius.all(
                                                Radius.circular(
                                                    12)),
                                            child: OverflowBox(
                                                minWidth: 350,
                                                minHeight: 220,
                                                maxHeight: 400,
                                                maxWidth:350,
                                                child: CachedNetworkImage(
                                                    fit: BoxFit.cover,
                                                    imageUrl: getImageUrl(
                                                        widget.discoverpostDetails.postPhoto[0].location))
                                            ),
                                          ),
                                        ): Container(),
                                      )
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
        ) :
        widget.postCommentListDetails != null ?
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer(builder: (context, watch, child){

              final repeatProviderRepo = watch(repeatFromPostProvider);
              final feedProviderRepo = watch(feedProvider);
              final postRepliesRepo = watch(postRepliesProvider);
              return Padding(
                padding: const EdgeInsets.all(8.0),
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
                          height: 89,
                          child: SvgPicture.asset(newLogoFarm,
                              height: 120, width: 120, fit: BoxFit.scaleDown)),
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)),
                      onPressed: () async {

                        await repeatProviderRepo.repeatFromPost(context,widget.postCommentListDetails.id, _captionController.text);
                        await   feedProviderRepo.getFeedList();
                      },
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text("Quote",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2
                          )),
                    )
                  ],
                ),
              );

            }),
            Container(
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
                    // Padding(
                    //   padding: EdgeInsets.only(left: 10, right: 10, top: 4),
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Padding(
                    //         padding: EdgeInsets.all(8.0),
                    //         child: ClipRRect(
                    //             borderRadius:
                    //             BorderRadius.all(Radius.circular(25)),
                    //             child:
                    //             CachedNetworkImage(
                    //                 fit: BoxFit.fill,
                    //                 height: 52,
                    //                 width: 52,
                    //                 imageUrl: widget.adminPicUser)
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: Padding(
                    //           padding: EdgeInsets.only(left: 10, top: 15),
                    //           child: Container(
                    //             decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.all(
                    //                     Radius.circular(10.0)),
                    //                 color: Colors.white30),
                    //             child: TextFormField(
                    //               controller: _captionController,
                    //               style: TextStyle(color: Colors.white),
                    //               autofocus: true,
                    //               minLines: 1,
                    //               maxLines: null,
                    //               maxLengthEnforced: true,
                    //               cursorColor: Colors.white,
                    //
                    //               decoration: InputDecoration(
                    //                 border: InputBorder.none,
                    //                 contentPadding: EdgeInsets.only(left: 5, right: 2, bottom: 2),
                    //                 hintText: "What's happening?",
                    //                 hintStyle: GoogleFonts.poppins(
                    //                   fontWeight: FontWeight.w400,
                    //                   fontSize: 15,
                    //                   color: Colors.white,
                    //
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // )
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
                                  padding:  EdgeInsets.only(top: 2, right: 8, left: 4, bottom: 8),
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
                                                    imageUrl:  widget.postCommentListDetails.userPic)
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 5, top: 10),
                                            child: Text(Utils.getCapitalizeName(widget.postCommentListDetails.userName),
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white
                                                )
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 5, top: 10),
                                            child: Text('@${widget.postCommentListDetails.userName}',
                                                style:  GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.normal,
                                                    color: Color(0xff666666)
                                                )
                                            ),
                                          )
                                        ],
                                      ),
                                      widget.postCommentListDetails.commentMessage != "" && widget.postCommentListDetails.commentMessage != null ?
                                      Text(widget.postCommentListDetails.commentMessage,
                                          style:GoogleFonts.montserrat(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.white54,
                                              letterSpacing: 0.5
                                          )
                                      ): Container(),

                                      Padding(
                                        padding: EdgeInsets.only(top:8.0, left: 8.0, right: 8.0, bottom: 10),
                                        child:
                                        widget.postCommentListDetails.media.length > 0 ?
                                        Container(
                                          height: 200,
                                          margin: EdgeInsets.only(top: 10),
                                          child:
                                          ClipRRect(
                                            borderRadius:
                                            BorderRadius.all(
                                                Radius.circular(
                                                    12)),
                                            child: OverflowBox(
                                                minWidth: 350,
                                                minHeight: 220,
                                                maxHeight: 400,
                                                maxWidth:350,
                                                child: CachedNetworkImage(
                                                    fit: BoxFit.cover,
                                                    imageUrl: getImageUrl(
                                                        widget.postCommentListDetails.media))
                                            ),
                                          ),
                                        ): Container(),
                                      )
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
        )
        :
        widget.detailsPostPage !=null ?
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer(builder: (context, watch, child){

              final repeatProviderRepo = watch(repeatFromPostProvider);
              final feedProviderRepo = watch(feedProvider);
              final postRepliesRepo = watch(postRepliesProvider);
              return Padding(
                padding: const EdgeInsets.all(8.0),
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
                          height: 89,
                          child: SvgPicture.asset(newLogoFarm,
                              height: 120, width: 120, fit: BoxFit.scaleDown)),
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)),
                      onPressed: () async {

                        await repeatProviderRepo.repeatFromPost(context,widget.detailsPostPage.id, _captionController.text);
                        await   feedProviderRepo.getFeedList();
                      },
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text("Quote",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2
                          )),
                    )
                  ],
                ),
              );

            }),
            Container(
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
                    // Padding(
                    //   padding: EdgeInsets.only(left: 10, right: 10, top: 4),
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Padding(
                    //         padding: EdgeInsets.all(8.0),
                    //         child: ClipRRect(
                    //             borderRadius:
                    //             BorderRadius.all(Radius.circular(25)),
                    //             child:
                    //             CachedNetworkImage(
                    //                 fit: BoxFit.fill,
                    //                 height: 52,
                    //                 width: 52,
                    //                 imageUrl: widget.adminPicUser)
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: Padding(
                    //           padding: EdgeInsets.only(left: 10, top: 15),
                    //           child: Container(
                    //             decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.all(
                    //                     Radius.circular(10.0)),
                    //                 color: Colors.white30),
                    //             child: TextFormField(
                    //               controller: _captionController,
                    //               style: TextStyle(color: Colors.white),
                    //               autofocus: true,
                    //               minLines: 1,
                    //               maxLines: null,
                    //               maxLengthEnforced: true,
                    //               cursorColor: Colors.white,
                    //
                    //               decoration: InputDecoration(
                    //                 border: InputBorder.none,
                    //                 contentPadding: EdgeInsets.only(left: 5, right: 2, bottom: 2),
                    //                 hintText: "What's happening?",
                    //                 hintStyle: GoogleFonts.poppins(
                    //                   fontWeight: FontWeight.w400,
                    //                   fontSize: 15,
                    //                   color: Colors.white,
                    //
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // )
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
                                  padding:  EdgeInsets.only(top: 2, right: 8, left: 4, bottom: 8),
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
                                                    imageUrl:  widget.detailsPostPage.profilePic)
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 5, top: 10),
                                            child: Text(Utils.getCapitalizeName(widget.detailsPostPage.name),
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white
                                                )
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 5, top: 10),
                                            child: Text('@${widget.detailsPostPage.userName}',
                                                style:  GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.normal,
                                                    color: Color(0xff666666)
                                                )
                                            ),
                                          )
                                        ],
                                      ),
                                      widget.detailsPostPage.caption != "" && widget.detailsPostPage.caption != null ?
                                      Text(widget.detailsPostPage.caption,
                                          style:GoogleFonts.montserrat(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.white54,
                                              letterSpacing: 0.5
                                          )
                                      ): Container(),

                                      Padding(
                                        padding: EdgeInsets.only(top:8.0, left: 8.0, right: 8.0, bottom: 10),
                                        child:
                                        widget.detailsPostPage.postPhoto.length > 0 ?
                                        Container(
                                          height: 200,
                                          margin: EdgeInsets.only(top: 10),
                                          child:
                                          ClipRRect(
                                            borderRadius:
                                            BorderRadius.all(
                                                Radius.circular(
                                                    12)),
                                            child: OverflowBox(
                                                minWidth: 350,
                                                minHeight: 220,
                                                maxHeight: 400,
                                                maxWidth:350,
                                                child: CachedNetworkImage(
                                                    fit: BoxFit.cover,
                                                    imageUrl: getImageUrl(
                                                        widget.detailsPostPage.postPhoto[0].location))
                                            ),
                                          ),
                                        ): Container(),
                                      )
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
        )
        :
        widget.profilePostRepliesDetails != null ?
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer(builder: (context, watch, child){

              final repeatProviderRepo = watch(repeatFromPostProvider);
              final feedProviderRepo = watch(feedProvider);
              final postRepliesRepo = watch(postRepliesProvider);
              return Padding(
                padding: const EdgeInsets.all(8.0),
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
                      padding: EdgeInsets.only(left: 50),
                      child: Container(
                        //  width: 160,
                        //  height: 99,
                          child: SvgPicture.asset(
                            thenewFarm,
                            height: 100,
                            width: 100,
                          )
                      ),
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)),
                      onPressed: () async {

                        await repeatProviderRepo.repeatFromPost(context,widget.profilePostRepliesDetails.id, _captionController.text);
                        await   feedProviderRepo.getFeedList();
                      },
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text("Repeat",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2
                          )),
                    )
                  ],
                ),
              );

            }),
            Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Padding(
                          //   padding: EdgeInsets.all(8.0),
                          //   child: ClipRRect(
                          //       borderRadius:
                          //       BorderRadius.all(Radius.circular(20)),
                          //       child:
                          //       CachedNetworkImage(
                          //           fit: BoxFit.fill,
                          //           height: 58,
                          //           width: 58,
                          //           imageUrl: widget.profilePostRepliesDetails.userPic)
                          //   ),
                          // ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, top: 15),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0)),
                                    color: Colors.white30),
                                child: TextFormField(
                                  controller: _captionController,
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
                                    color: Colors.white30),
                                child: Padding(
                                  padding:  EdgeInsets.only(top: 2, right: 8, left: 4, bottom: 8),
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
                                                    imageUrl:  widget.profilePostRepliesDetails.userPic)
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 5, top: 10),
                                            child: Text(widget.profilePostRepliesDetails.userName,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.grey,
                                                )
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(widget.profilePostRepliesDetails.commentMessage,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white70,
                                          )
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
        )
        :
        widget.postProfileSubcategory  !=null?
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer(builder: (context, watch, child){

              final repeatProviderRepo = watch(repeatFromPostProvider);
              final feedProviderRepo = watch(feedProvider);

              return Padding(
                padding: const EdgeInsets.all(8.0),
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
                      padding: EdgeInsets.only(left: 50),
                      child: Container(
                        //  width: 160,
                        //  height: 99,
                          child: SvgPicture.asset(
                            thenewFarm,
                            height: 100,
                            width: 100,
                          )
                      ),
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)),
                      onPressed: () async {

                        await repeatProviderRepo.repeatFromPost(context,widget.postProfileSubcategory.id, _captionController.text);
                        await   feedProviderRepo.getFeedList();
                      },
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text("Repeat",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2
                          )),
                    )
                  ],
                ),
              );

            }),
            Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: ClipRRect(
                                borderRadius:
                                BorderRadius.all(Radius.circular(20)),
                                child:
                                CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    height: 58,
                                    width: 58,
                                    imageUrl: widget.postProfileSubcategory.profilePic)
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, top: 15),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0)),
                                    color: Colors.white30),
                                child: TextFormField(
                                  controller: _captionController,
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
                                    color: Colors.white30),
                                child: Padding(
                                  padding:  EdgeInsets.only(top: 2, right: 8, left: 4, bottom: 8),
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
                                                    imageUrl:  widget.postProfileSubcategory.profilePic)
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 5, top: 10),
                                            child: Text(widget.postProfileSubcategory.userName,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.grey,
                                                )
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(widget.postProfileSubcategory.caption,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white70,
                                          )
                                      ),

                                      Padding(
                                        padding: EdgeInsets.only(top:8.0, left: 20.0, right: 8.0, bottom: 10),
                                        child: Container(
                                          height: 200,
                                          margin: EdgeInsets.only(top: 10),
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              child:  Container(
                                                height: 450,
                                                width: 360,
                                                color: Colors.grey[900],
                                                child: OverflowBox(
                                                  minWidth: 360,
                                                  minHeight: 200,
                                                  maxHeight: 400,
                                                  maxWidth: 360,
                                                  child: CachedNetworkImage(
                                                      fit: BoxFit
                                                          .cover,
                                                      imageUrl: getImageUrl(
                                                          widget.postProfileSubcategory
                                                              .postPhoto[0]
                                                              .location)
                                                  ),
                                                ),
                                              )

                                          ),
                                        ),
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
        ):
        widget.allUserDetails !=null
            ?
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer(builder: (context, watch, child){

              final repeatProviderRepo = watch(repeatFromPostProvider);
              final feedProviderRepo = watch(feedProvider);

              return Padding(
                padding: const EdgeInsets.all(8.0),
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
                      padding: EdgeInsets.only(left: 50),
                      child: Container(
                        //  width: 160,
                        //  height: 99,
                          child: SvgPicture.asset(
                            thenewFarm,
                            height: 100,
                            width: 100,
                          )
                      ),
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)),
                      onPressed: () async {

                        await repeatProviderRepo.repeatFromPost(context,widget.allUserDetails.id, _captionController.text);
                        await   feedProviderRepo.getFeedList();
                      },
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text("Repeat",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2
                          )),
                    )
                  ],
                ),
              );

            }),
            Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: ClipRRect(
                                borderRadius:
                                BorderRadius.all(Radius.circular(20)),
                                child:
                                CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    height: 58,
                                    width: 58,
                                    imageUrl: widget.allUserDetails.profilePic)
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, top: 15),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0)),
                                    color: Colors.white30),
                                child: TextFormField(
                                  controller: _captionController,
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
                                    color: Colors.white30),
                                child: Padding(
                                  padding:  EdgeInsets.only(top: 2, right: 8, left: 4, bottom: 8),
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
                                                    imageUrl:  widget.allUserDetails.profilePic)
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 5, top: 10),
                                            child: Text(widget.allUserDetails.userName,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.grey,
                                                )
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(widget.allUserDetails.caption,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white70,
                                          )
                                      ),
                                      widget.allUserDetails.repeat.textFeed == false ?
                                      Container():
                                      widget.allUserDetails.textFeed == false ?
                                      Padding(
                                        padding: EdgeInsets.only(top:8.0, left: 20.0, right: 8.0, bottom: 10),
                                        child: Container(
                                          height: 200,
                                          margin: EdgeInsets.only(top: 10),
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              child:  Container(
                                                height: 450,
                                                width: 360,
                                                color: Colors.grey[900],
                                                child: OverflowBox(
                                                  minWidth: 360,
                                                  minHeight: 200,
                                                  maxHeight: 400,
                                                  maxWidth: 360,
                                                  child: CachedNetworkImage(
                                                      fit: BoxFit
                                                          .cover,
                                                      imageUrl: getImageUrl(
                                                          widget.allUserDetails
                                                              .postPhoto[0]
                                                              .location)
                                                  ),
                                                ),
                                              )

                                          ),
                                        ),
                                      )
                                          : Container(),
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
        )
            :
        widget.repeatPostDetails !=null ?
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer(builder: (context, watch, child){

              final repeatProviderRepo = watch(repeatFromPostProvider);
              final feedProviderRepo = watch(feedProvider);

              return Padding(
                padding: const EdgeInsets.all(8.0),
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
                      padding: EdgeInsets.only(left: 50),
                      child:Container(
                          height: 99,
                          child: SvgPicture.asset(newLogoFarm,
                              height: 120, width: 120, fit: BoxFit.scaleDown)),
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)),
                      onPressed: () async {

                        await repeatProviderRepo.repeatFromPost(context, widget.repeatPostDetails.id, _captionController.text);
                        await   feedProviderRepo.getFeedList();
                      },
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text("Repeat",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2
                          )),
                    )
                  ],
                ),
              );

            }),
            Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                    imageUrl:  widget.adminPicUser)
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, top: 15),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0)),
                                    color: Colors.white30),
                                child: TextFormField(
                                  controller: _captionController,
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
                                    color: Colors.white30),
                                child: Padding(
                                  padding:  EdgeInsets.only(top: 2, right: 8, left: 4, bottom: 8),
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
                                                    imageUrl:  widget.repeatPostDetails.profilePic)
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 5, top: 10),
                                            child: Text(widget.repeatPostDetails.name,
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff666666)
                                                )
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 5, top: 10),
                                            child: Text('@${widget.repeatPostDetails.userName}',
                                                style:  GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.normal,
                                                    color: Color(0xff666666)
                                                )
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(widget.repeatPostDetails.caption,
                                          style:  GoogleFonts.montserrat(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.white,
                                          )
                                      ),
                                      Container(
                                        height: 200,
                                        margin:
                                        EdgeInsets.only(top: 10),
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(
                                                  20)),
                                          child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              height: 176,
                                              width: 338,
                                              imageUrl: getImageUrl(widget.repeatPostDetails.postPhoto[0]))

                                        ),
                                      )

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
        )
            :
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer(builder: (context, watch, child){

              final repeatProviderRepo = watch(repeatFromPostProvider);
              final feedProviderRepo = watch(feedProvider);

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 68.0),
                      child: Container(
                          height: 99,
                          child: SvgPicture.asset(newLogoFarm,
                              height: 120, width: 120, fit: BoxFit.scaleDown)),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 50),
                    //   child: Container(
                    //     //  width: 160,
                    //     //  height: 99,
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

                        await repeatProviderRepo.repeatFromPost(context, widget.postDetails.id, _captionController.text);
                        await   feedProviderRepo.getFeedList();
                      },
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text("Quote",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2
                          )),
                    )
                  ],
                ),
              );

            }),
            Container(
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

                    // Padding(
                    //   padding: EdgeInsets.only(left: 10, right: 10, top: 4),
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Padding(
                    //         padding: EdgeInsets.only(left:8.0, right: 8.0),
                    //         child: ClipRRect(
                    //             borderRadius:
                    //             BorderRadius.all(Radius.circular(25)),
                    //             child:
                    //             CachedNetworkImage(
                    //                 fit: BoxFit.fill,
                    //                 height: 52,
                    //                 width: 52,
                    //                 imageUrl: widget.adminPicUser)
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: Padding(
                    //           padding: EdgeInsets.only(left: 10, top: 15),
                    //           child: Container(
                    //             decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.all(
                    //                     Radius.circular(10.0)),
                    //                 color: Colors.white30),
                    //             child: TextFormField(
                    //               controller: _captionController,
                    //               style: TextStyle(color: Colors.white),
                    //               autofocus: true,
                    //               minLines: 1,
                    //               maxLines: null,
                    //               maxLengthEnforced: true,
                    //               cursorColor: Colors.white,
                    //
                    //               decoration: InputDecoration(
                    //                 border: InputBorder.none,
                    //                 contentPadding: EdgeInsets.only(left: 5, right: 2, bottom: 2),
                    //                 hintText: "What's happening?",
                    //                 hintStyle: GoogleFonts.poppins(
                    //                   fontWeight: FontWeight.w400,
                    //                   fontSize: 15,
                    //                   color: Colors.white,
                    //
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // )
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
                                    border: Border.all(color: Color(0XFFDADADA)),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0)),
                                    color: Color(0xff222222)),
                                child: Padding(
                                  // padding:  EdgeInsets.only(top: 2, right: 8, left: 4, bottom: 8),
                                  padding: EdgeInsets.all(0.0),
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
                                                    height: 45,
                                                    width: 45,
                                                    imageUrl: widget.postDetails.profilePic)
                                            ),
                                          ),
                                         Expanded(
                                             child: Column(
                                               mainAxisAlignment: MainAxisAlignment.start,
                                               children: [
                                                 Padding(
                                                   padding: EdgeInsets.only(top: 0),
                                                   child: Row(
                                                     children: [
                                                       Padding(
                                                         padding: EdgeInsets.only(left: 0, top: 4),
                                                         child: Text(  Utils.getCapitalizeName(widget.postDetails.name),
                                                             style: TextStyle(
                                                               fontSize: 18,
                                                               fontWeight: FontWeight.w800,
                                                               color: Color(0xff666666),
                                                             )
                                                         ),
                                                       ),
                                                       Padding(
                                                         padding: EdgeInsets.only(left: 2, top: 4),
                                                         child: Text('@${widget.postDetails.userName}',
                                                             style: TextStyle(
                                                               fontSize: 12,
                                                                 fontWeight: FontWeight.normal,
                                                                 color: Color(0xff666666)
                                                             )
                                                         ),
                                                       )
                                                     ],
                                                   ),
                                                 ),
                                                 widget.postDetails.caption != "" && widget.postDetails.caption != null ?
                                                 Padding(
                                                   padding: EdgeInsets.only(right: 10, bottom: 4),
                                                   child: Container(
                                                     alignment: Alignment.topLeft,
                                                     child: Text(widget.postDetails.caption,
                                                         style:GoogleFonts.montserrat(
                                                             fontSize: 13,
                                                             fontWeight: FontWeight.normal,
                                                             color: Colors.white,
                                                             letterSpacing: 0.5
                                                         )
                                                     ),
                                                   ),
                                                 )
                                                     : Container(),
                                               ],
                                             )
                                         ),
                                        ],
                                      ),

                                      // widget.postDetails.textFeed == false ?
                                      // Padding(
                                      //   padding: EdgeInsets.only(top:8.0, left: 8.0, right: 8.0, bottom: 10),
                                      //   child:
                                      //     widget.postDetails
                                      //         .postPhoto.length > 0 ?
                                      //   Container(
                                      //     height: 200,
                                      //     margin: EdgeInsets.only(top: 10),
                                      //     child: ClipRRect(
                                      //       borderRadius: BorderRadius.all(
                                      //           Radius.circular(30)),
                                      //       child: OverflowBox(
                                      //         minWidth: 350,
                                      //         minHeight: 220,
                                      //         maxHeight: 400,
                                      //         maxWidth:350,
                                      //         child:
                                      //         CachedNetworkImage(
                                      //             fit: BoxFit.cover,
                                      //
                                      //             // memCacheHeight: 250,
                                      //             // memCacheWidth: 350,
                                      //                 imageUrl: getImageUrl(
                                      //                     widget.postDetails
                                      //                         .postPhoto[0]
                                      //                         .location))
                                      //       ),
                                      //     ),
                                      //   ): Container(),
                                      // )
                                      // : Container(),

                                      // widget.postDetails.repeat != null && widget.postDetails.userName !=null ?
                                      //     Container():

                                      widget.postDetails.repeat.textFeed == false ?
                                          Container():

                                      widget.postDetails.textFeed == false ?
                                      Padding(
                                        padding: EdgeInsets.only(top: 4.0, left: 20.0, right: 8.0, bottom: 10),
                                        child: Container(
                                          height: 200,
                                          margin: EdgeInsets.only(top: 0),
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              child:  Container(
                                                height: 450,
                                                width: 360,
                                                color: Colors.grey[900],
                                                child: OverflowBox(
                                                  minWidth: 360,
                                                  minHeight: 200,
                                                  maxHeight: 400,
                                                  maxWidth: 360,
                                                  child: CachedNetworkImage(
                                                      fit: BoxFit
                                                          .cover,
                                                                    imageUrl: getImageUrl(
                                                                        widget.postDetails
                                                                            .postPhoto[0]
                                                                            .location)
                                                  ),
                                                ),
                                              )

                                          ),
                                        ),
                                      )
                                      : Container(),



                                      // Padding(
                                      //   padding: EdgeInsets.all(8.0),
                                      //   child:
                                      //   widget.postDetails
                                      //       .postPhoto.length > 0 ?
                                      //   CachedNetworkImage(
                                      //     // memCacheHeight: 250,
                                      //     // memCacheWidth: 350,
                                      //       imageUrl: getImageUrl(
                                      //           widget.postDetails
                                      //               .postPhoto[0]
                                      //               .location))
                                      //   :
                                      //   Container(),
                                      // ),
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
        ),
        ),
      ),
    );
  }
}
