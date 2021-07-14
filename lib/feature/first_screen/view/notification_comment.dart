import 'package:async_loader/async_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/feed/models/ModelBasedonPostId.dart';
import 'package:farm_system/feature/feed/repeatSubComment/view/repeatSubComment.view.dart';
import 'package:farm_system/feature/feed/subcommentPostReply/view/subcomment.view.dart';
import 'package:farm_system/feature/feed/view/readmoretext.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class NotificationCommentPage extends StatefulWidget {
  final String commentId;
  final Comment userData;
  const NotificationCommentPage({Key key, this.commentId, this.userData}) : super(key: key);

  @override
  _NotificationCommentPageState createState() => _NotificationCommentPageState();
}

class _NotificationCommentPageState extends State<NotificationCommentPage> {
  final _asyncKeyComment = GlobalKey<AsyncLoaderState>();

  bool repostPostComment = false;
  bool repostSubComment = false;
  bool repostSubNewComment = false;

  @override
    Widget build(BuildContext context) {
      final _asyncLoader = Consumer(builder: (context, watch, child) {
        print('bshdsbdghsdh');
        print(widget.commentId);
        // ignore: non_constant_identifier_names
        final NotificationRepo = watch(notificationList);
        final userDeatil = watch(notificationList);
       return AsyncLoader(
            initState: () => NotificationRepo.notificationComment(widget.commentId),
            renderLoad: () => SizedBox(),
            renderError: ([err]) => Center(
              child: Text("Error"),
            ),
            renderSuccess: ({data}) => _generateView());
      });
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Padding(
            padding: const EdgeInsets.only(top: 18.0,right: 35),
            child: Container(
                height: 99,
                child: Center(
                    child: SvgPicture.asset(newLogoFarm,
                        height: 120, width: 120, fit: BoxFit.scaleDown)
                )),
          ),
          centerTitle: true,
          leading: GestureDetector(
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: null),
              onTap: () {
                Navigator.of(context).pop();
              }),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_asyncLoader],
          ),
        ),
      );
    }

  _generateView() {
  return Consumer(builder: (context, watch, child) {
     final NotificationRepo = watch(notificationList);
      final feedProviderRepo = watch(feedProvider);
      final dashBoardProviderRepo = watch(dashboardProvider);
      var dt = new DateTime.now();
      var days = dt.difference(NotificationRepo.commentList[0].createdAt).inDays;
      if (NotificationRepo.commentList[0].userPic != null &&
          imageFileTypes.indexOf(
              getImageUrl(NotificationRepo.commentList[0].userPic).split('.').last) ==
              -1) {
      }
      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius:
                            BorderRadius.all(Radius.circular(25)),
                            child: NotificationRepo.commentList[0].userPic == null
                                ? Image.asset(dummyUser,
                                fit: BoxFit.fill,
                                height: 25,
                                width: 25)
                                : CachedNetworkImage(
                                fit: BoxFit.fill,
                                height: 52,
                                width: 52,
                                imageUrl: getImageUrl(
                                    NotificationRepo.commentList[0].userPic)),
                          ),
                        ),
                        Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 4.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          child: Text(
                                              '${NotificationRepo.commentList[0].userFullname}',
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                  HexColor("#FFFFFF")))),
                                      SizedBox(width: 3),
                                      Expanded(
                                        child: Container(
                                            child: Text(
                                                '@${NotificationRepo.commentList[0].userName.toString()}',
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    fontWeight:
                                                    FontWeight.normal,
                                                    color: HexColor(
                                                        "#666666")))),

                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: EdgeInsets.only(right: 4.0),
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                top: 0, left: 5),
                                            child: days < 7
                                                ? Text(
                                                getTime(NotificationRepo.commentList[0]
                                                    .createdAt),
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.normal,
                                                    color:
                                                    Color(0xff888888)))
                                                : Text(DateFormat('dd-MMM')
                                                .format(NotificationRepo.commentList[0]
                                                .createdAt))),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                  EdgeInsets.symmetric(vertical: 4.0),
                                  child: Visibility(
                                    visible: NotificationRepo.commentList[0].commentMessage !=
                                        null,
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      child: ReadMoreText(
                                          NotificationRepo.commentList[0].commentMessage ??
                                              '',
                                          style: TextStyle(
                                            fontSize: 15,
                                            letterSpacing: 0.5,
                                            color: Colors.white,
                                          )),
                                    ),
                                  ),
                                ),
                                // Padding(
                                //   padding: EdgeInsets.only(left: 0),
                                //   child: NotificationRepo.commentList[0].userPic != null
                                //       ? Container(
                                //     height: 200,
                                //     margin: EdgeInsets.only(top: 10),
                                //     child: ClipRRect(
                                //       borderRadius: BorderRadius.all(
                                //           Radius.circular(20)),
                                //       child: imageFileTypes.indexOf(
                                //           NotificationRepo.commentList[0].userPic
                                //               .split('.')
                                //               .last) !=
                                //           -1
                                //           ? CachedNetworkImage(
                                //           fit: BoxFit.fill,
                                //           height: 176,
                                //           width: 338,
                                //           imageUrl: getImageUrl(
                                //               NotificationRepo.commentList[0].userPic))
                                //           : Container(),
                                //     ),
                                //   )
                                //       : Container(),
                                // ),
                                // Padding(
                                //   padding: EdgeInsets.only(
                                //       left: 0,
                                //       right: 0.0,
                                //       top: 8.0,
                                //       bottom: 8.0),
                                //   child: Row(
                                //     mainAxisAlignment:
                                //     MainAxisAlignment.spaceEvenly,
                                //     children: [
                                //       Row(
                                //         mainAxisAlignment:
                                //         MainAxisAlignment.start,
                                //         crossAxisAlignment:
                                //         CrossAxisAlignment.center,
                                //         children: [
                                //           GestureDetector(
                                //               onTap: () {
                                //                 feedProviderRepo
                                //                     .likeOrDislikeComment(
                                //                     context,
                                //                     NotificationRepo.commentList[0].id,
                                //                     feedProviderRepo
                                //                         .likeCollectionComment);
                                //               },
                                //               child: Row(
                                //                   mainAxisAlignment:
                                //                   MainAxisAlignment.start,
                                //                   crossAxisAlignment:
                                //                   CrossAxisAlignment
                                //                       .center,
                                //                   children: [
                                //                     Icon(Icons.favorite,
                                //                         color: NotificationRepo.commentList[0]
                                //                             .like
                                //                             .length !=
                                //                             0
                                //                             ? Colors.red
                                //                             : Colors.grey),
                                //                     Text(
                                //                       "${NotificationRepo.commentList[0].like.length}",
                                //                       style: TextStyle(
                                //                           color: Colors.grey,
                                //                           fontSize: 15),
                                //                     ),
                                //                   ])),
                                //         ],
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 0,
                                      right: 0.0,
                                      top: 8.0,
                                      bottom: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                feedProviderRepo
                                                    .likeOrDislikeComment(
                                                    context,
                                                    NotificationRepo.commentList[0].id,
                                                    feedProviderRepo
                                                        .likeCollectionComment);
                                              },
                                              child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .center,
                                                  children: [
                                                    Icon(Icons.favorite,
                                                        color: NotificationRepo.commentList[0]
                                                            .like
                                                            .length !=
                                                            0
                                                            ? Colors.red
                                                            : Colors.grey),
                                                    Text(
                                                      "${NotificationRepo.commentList[0].like.length}",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 15),
                                                    ),
                                                  ])),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          _getCommentPostWidget(
                                              NotificationRepo.commentList[0].commentCheck
                                                  .contains(userId)
                                                  ? commentRed
                                                  : commentIcon,
                                              NotificationRepo.commentList[0].replyCount,
                                              1,
                                              widget.userData,
                                              feedProviderRepo,
                                              dashBoardProviderRepo
                                                  .userProfilePic,
                                              NotificationRepo.commentList[0].userPic)
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          _getCommentPostWidget(
                                              NotificationRepo.commentList[0]
                                                  .repost
                                                  .contains(userId) ==
                                                  true
                                                  ? repostColor
                                                  : repostNewImage,
                                              NotificationRepo.commentList[0]
                                                  .repost.length,
                                              2,
                                              widget.userData,
                                              feedProviderRepo,
                                              dashBoardProviderRepo
                                                  .userProfilePic,
                                              NotificationRepo.commentList[0].userPic)
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
  _getCommentPostWidget(iconData, text1, i, Comment postDetails,
      feedProviderRepo, dashBoardProviderRepo, userReplyProfile) {
    return GestureDetector(
      onTap: () {
        _handleOnPostTap(i, postDetails, feedProviderRepo,
            dashBoardProviderRepo, userReplyProfile);
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 10, left: 15, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            i == 0 || i == 3
                ? i == 2
                ? Container()
                : Icon(iconData,
                color: i == 0
                    ? postDetails.like.length > 0
                    ? Colors.red
                    : Colors.grey
                    : Colors.grey)
                : SvgPicture.asset(iconData, fit: BoxFit.none),
            // i == 0 || i == 2 || i == 3
            //     ? Icon(iconData,
            //         color: i == 0
            //             ? postDetails.like.length > 0
            //                 ? Colors.red
            //                 : Colors.grey
            //             : Colors.grey)
            //     : SvgPicture.asset(iconData, fit: BoxFit.none),
            // Icon(iconData,
            //     color: i == 0
            //         ? postDetails.like.length > 0
            //             ? Colors.red
            //             : Colors.grey
            //         : Colors.grey),
            Container(
              margin: EdgeInsets.only(left: 08, right: 15),
              child: Text(
                text1.toString(),
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _handleOnPostTap(int i, Comment postDetails, feedProviderRepo,
      String profilePic, userReplyProfile) {
    if (i == 0) {
      // print("like");
    } else if (i == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SubCommentPostReply(
              parentId: postDetails.id,
              parentUserId: postDetails.userId,
              grandParentId: postDetails.parentId,
              replying: postDetails.replying,
              commentPicUser: postDetails.userPic,
              userProfile: profilePic,
              replyingSecondaryName: postDetails.userName,
              replyingName: postDetails.userFullname,
              // profilepic: postDetails.postPhoto,
            )),
      );
    } else {
      print("Share");
      _modalBottomRepeatForPostInNested(i, postDetails);
    }
  }

  void _modalBottomRepeatForPostInNested(int i, Comment postDetails) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        context: context,
        builder: (builder) {
          return SingleChildScrollView(child: Consumer(
            builder: (context, watch, child) {
              final repostProvider = watch(feedProvider);
              return Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF222222),
                  ),
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 60, 0, 40),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(repostBottom,
                                    fit: BoxFit.scaleDown),
                                Padding(padding: EdgeInsets.only(right: 15)),
                                GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      if (repostPostComment == true) {
                                        repostPostComment = false;
                                      } else {
                                        repostPostComment = true;
                                      }
                                    });

                                    await repostProvider.repostSubCommentPost(
                                        postDetails.id, postDetails.repost);

                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Repost",
                                    style: TextStyle(
                                        fontSize: 15,
                                        // color: HexColor("666666"),
                                        color: Color(0xff888888),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(repeatIocn,
                                    height: 10,
                                    width: 10,
                                    fit: BoxFit.scaleDown),
                                Padding(padding: EdgeInsets.only(right: 15)),
                                GestureDetector(
                                  onTap: () async {
                                    print('For subcomment');
                                    print(postDetails.toJson());
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RepeatSubCommentPost(
                                                subCommentPostDetails:
                                                postDetails,
                                              )),
                                    );

                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Quote",
                                    style: TextStyle(
                                        fontSize: 15,
                                        // color: HexColor("666666"),
                                        color: Color(0xff888888),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ]));
            },
          ));
        });
  }
}
