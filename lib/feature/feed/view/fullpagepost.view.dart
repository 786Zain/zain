import 'package:farm_system/feature/feed/models/ModelBasedonPostId.dart'
    as newData;
import 'package:farm_system/feature/profile_user/view/Likes/model/likeSubTab_model.dart';
import 'package:farm_system/feature/profile_user/view/Media/model/userMedia_model.dart'
    as mediasubtabs;
import 'package:farm_system/feature/profile_user/view/Likes/model/Like_model.dart'
    as likesmaintab;
import 'package:farm_system/feature/profile_user/view/profile_tabs/farmpost/modal/profileSubCategoryIndividual.modal.dart';
import 'package:farm_system/screen/Discovery/discovery_model.dart';
import 'package:farm_system/storage.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:farm_system/feature/feed/comment/view/commentforpost.view.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/feed/models/getFeed.model.dart';
import 'package:farm_system/feature/feed/repeat/view/repeatComment.view.dart';
import 'package:farm_system/riverpod/riverpods.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:farm_system/feature/profile_user/view/profile_tabs/farmpost/modal/userProfileAllData.modal.dart';
import 'package:farm_system/models/sub_category_models.dart' as newdis;

class FullPagePostView extends StatefulWidget {
  final String filePaths;
  final FeedDetail postData;
  final Feed discoveryData;
  final Datum postProfileAllData;
  final Datums subCategoryProfileData;
  final newData.Comment commentList;
  final newdis.PostFeed discoverySeeAll;
  final newData.Post postDetailsNew;
  final mediasubtabs.Datum postProfilesubtabsData;
  final mediasubtabs.Datum postProfileMainTabData;
  final likesmaintab.Datum likesMainTabData;
  final LikeSubTab likesSubTabData;

  const FullPagePostView(
      {Key key,
      this.filePaths,
      this.postData,
      this.discoveryData,
      this.postProfileAllData,
      this.subCategoryProfileData,
      this.commentList,
      this.discoverySeeAll,
      this.postDetailsNew,
      this.postProfilesubtabsData,
      this.postProfileMainTabData,
      this.likesMainTabData,
      this.likesSubTabData})
      : super(key: key);

  @override
  _FullPagePostViewState createState() => _FullPagePostViewState();
}

class _FullPagePostViewState extends State<FullPagePostView> {
  // var imageFileTypes = ["png", "jpg", "jpeg", "gif", "HEIC"];
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

  bool favorite = false;
  bool repost = false;
  var userId;

  @override
  void initState() {
    context.read(dashboardProvider).fetchUserDetail();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      userId = await StorageService.getUserId();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("----------------------------------- file path ");

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              child: Icon(Icons.close),
            ),
          ),
          actions: [
            // Padding(
            //   padding: EdgeInsets.only(top: 15, right: 10),
            //   child: Container(
            //     child: Text("SAVE"),
            //   ),
            // )
          ],
        ),
        body: SingleChildScrollView(
          child:
              // widget.postProfileSubAllData != null ?
              // Consumer(
              //   builder: (context, watch, child) {
              //     final feedProviderRepo = watch(feedProvider);
              //     final dashBoardProviderRepo = watch(dashboardProvider);
              //     final userProfileAllRepo = watch(userAllProvider);
              //
              //
              //
              //     return Column(
              //       children: [
              //         Container(
              //           child: CachedNetworkImage(
              //               height: MediaQuery.of(context).size.height - 200,
              //               width: MediaQuery.of(context).size.width,
              //               imageUrl: getImageUrl( widget.postProfileSubAllData.postPhoto[0].location)),
              //           // imageUrl: getImageUrl(
              //           //     widget.discoveryData.postPhoto[0].location)),
              //         ),
              //         Padding(
              //           padding: EdgeInsets.only(
              //               left: 0, right: 0.0, top: 8.0, bottom: 8.0),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //             children: <Widget>[
              //               Padding(
              //                 padding: EdgeInsets.only(
              //                     left: 0, right: 0.0, top: 8.0, bottom: 8.0),
              //                 child: Row(
              //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //                   children: <Widget>[
              //                     // _getCommentProfileAllWidget(
              //                     //     widget.postProfileAllData.like.contains(
              //                     //         dashBoardProviderRepo.userId)
              //                     //         ? Icons.favorite
              //                     //         : Icons.favorite,
              //                     //     widget.postProfileAllData.like.length.toString(),
              //                     //     0,
              //                     //     widget.postProfileAllData,
              //                     //     userProfileAllRepo,
              //                     //     dashBoardProviderRepo,
              //                     //     widget.postProfileAllData.profilePic),
              //                     _getCommentProfileSubCategoryWidget(
              //                         widget.postProfileSubAllData.like.contains(
              //                             dashBoardProviderRepo.userId)
              //                             ? commentIcon
              //                             : commentIcon,
              //                         widget.postProfileSubAllData.commentCount,
              //                         1,
              //                         widget.postProfileSubAllData,
              //                         userProfileAllRepo,
              //                         dashBoardProviderRepo,
              //                         widget.pp),
              //                     _getCommentProfileSubCategoryWidget(
              //                         Icons.autorenew_rounded,
              //                         widget.postProfileSubAllData.repost.length,
              //                         2,
              //                         widget.postProfileSubAllData,
              //                         userProfileAllRepo,
              //                         dashBoardProviderRepo,
              //                         widget.pp),
              //                     // _getCommentProfileAllWidget(
              //                     //     Icons.upload_file,
              //                     //     "",
              //                     //     2,
              //                     //     widget.postData,
              //                     //     widget.postData,
              //                     //     dashBoardProviderRepo,
              //                     //     widget.postData.profilePic),
              //                   ],
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ],
              //     );
              //   },
              // )
              // :
              widget.likesSubTabData != null
                  ? Consumer(
                      builder: (context, watch, child) {
                        final feedProviderRepo = watch(feedProvider);
                        final dashBoardProviderRepo = watch(dashboardProvider);
                        final userProfileAllRepo = watch(userAllProvider);
                        return Column(
                          children: [
                            Container(
                                child: widget.likesSubTabData.repeat.post != null
                                    ? CachedNetworkImage(
                                        height:
                                            MediaQuery.of(context).size.height -
                                                200,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        imageUrl: getImageUrl(
                                            widget.likesSubTabData.repeat.post))
                                    : CachedNetworkImage(
                                        height:
                                            MediaQuery.of(context).size.height -
                                                200,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        imageUrl: getImageUrl(widget
                                            .likesSubTabData
                                            .postPhoto[0]
                                            .location))),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 0, right: 0.0, top: 8.0, bottom: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  _getCommentLikeSubTabWidget(
                                      widget.likesSubTabData.like.contains(
                                              dashBoardProviderRepo.userId)
                                          ? Icons.favorite
                                          : Icons.favorite,
                                      widget.likesSubTabData.like.length
                                          .toString(),
                                      0,
                                      widget.likesSubTabData,
                                      userProfileAllRepo,
                                      dashBoardProviderRepo,
                                      widget.likesSubTabData.profilePic),
                                  _getCommentLikeSubTabWidget(
                                      widget.likesSubTabData.like.contains(
                                              dashBoardProviderRepo.userId)
                                          ? commentIcon
                                          : commentIcon,
                                      widget.likesSubTabData.commentCount,
                                      1,
                                      widget.likesSubTabData,
                                      userProfileAllRepo,
                                      dashBoardProviderRepo,
                                      widget.likesSubTabData.profilePic),
                                  _getCommentLikeSubTabWidget(
                                      repostNewImage,
                                      // Icons.autorenew_rounded,
                                      widget.likesSubTabData.repost.length,
                                      2,
                                      widget.likesSubTabData,
                                      userProfileAllRepo,
                                      dashBoardProviderRepo,
                                      widget.likesSubTabData.profilePic),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    )
                  : widget.likesMainTabData != null
                      ? Consumer(
                          builder: (context, watch, child) {
                            final feedProviderRepo = watch(feedProvider);
                            final dashBoardProviderRepo =
                                watch(dashboardProvider);
                            final userProfileAllRepo = watch(userAllProvider);
                            return Column(
                              children: [
                                Container(
                                    child: widget.likesMainTabData.repeat.post !=
                                            null
                                        ? CachedNetworkImage(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height -
                                                200,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            imageUrl: getImageUrl(widget
                                                .likesMainTabData.repeat.post))
                                        : CachedNetworkImage(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height -
                                                200,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            imageUrl: getImageUrl(widget
                                                .likesMainTabData
                                                .postPhoto[0]
                                                .location))),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 0,
                                      right: 0.0,
                                      top: 8.0,
                                      bottom: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      _getCommentLikesTabWidget(
                                          widget.likesMainTabData.like.contains(
                                                  dashBoardProviderRepo.userId)
                                              ? Icons.favorite
                                              : Icons.favorite,
                                          widget.likesMainTabData.like.length
                                              .toString(),
                                          0,
                                          widget.likesMainTabData,
                                          userProfileAllRepo,
                                          dashBoardProviderRepo,
                                          widget.likesMainTabData.profilePic),
                                      _getCommentLikesTabWidget(
                                          widget.likesMainTabData.like.contains(
                                                  dashBoardProviderRepo.userId)
                                              ? commentIcon
                                              : commentIcon,
                                          widget.likesMainTabData.commentCount,
                                          1,
                                          widget.likesMainTabData,
                                          userProfileAllRepo,
                                          dashBoardProviderRepo,
                                          widget.likesMainTabData.profilePic),
                                      _getCommentLikesTabWidget(
                                          repostNewImage,
                                          // Icons.autorenew_rounded,
                                          widget.likesMainTabData.repost.length,
                                          2,
                                          widget.likesMainTabData,
                                          userProfileAllRepo,
                                          dashBoardProviderRepo,
                                          widget.likesMainTabData.profilePic),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        )
                      : widget.postProfileMainTabData != null
                          ? Consumer(
                              builder: (context, watch, child) {
                                final feedProviderRepo = watch(feedProvider);
                                final dashBoardProviderRepo =
                                    watch(dashboardProvider);
                                final userProfileAllRepo =
                                    watch(userAllProvider);

                                return Column(
                                  children: [
                                    Container(
                                      child: CachedNetworkImage(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height -
                                              200,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          imageUrl: getImageUrl(widget
                                              .postProfileMainTabData
                                              .postPhoto[0]
                                              .location)),
                                      // imageUrl: getImageUrl(
                                      //     widget.discoveryData.postPhoto[0].location)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 0,
                                          right: 0.0,
                                          top: 8.0,
                                          bottom: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          _getCommentProfileSubTabWidget(
                                              widget.postProfileMainTabData.like
                                                      .contains(
                                                          dashBoardProviderRepo
                                                              .userId)
                                                  ? Icons.favorite
                                                  : Icons.favorite,
                                              widget.postProfileMainTabData.like
                                                  .length
                                                  .toString(),
                                              0,
                                              widget.postProfileMainTabData,
                                              userProfileAllRepo,
                                              dashBoardProviderRepo,
                                              widget.postProfileMainTabData
                                                  .profilePic),
                                          _getCommentProfileSubTabWidget(
                                              widget.postProfileMainTabData.like
                                                      .contains(
                                                          dashBoardProviderRepo
                                                              .userId)
                                                  ? commentIcon
                                                  : commentIcon,
                                              widget.postProfileMainTabData
                                                  .commentCount,
                                              1,
                                              widget.postProfileMainTabData,
                                              userProfileAllRepo,
                                              dashBoardProviderRepo,
                                              widget.postProfileMainTabData
                                                  .profilePic),
                                          _getCommentProfileSubTabWidget(
                                              repostNewImage,
                                              // Icons.autorenew_rounded,
                                              widget.postProfileMainTabData
                                                  .repost.length,
                                              2,
                                              widget.postProfileMainTabData,
                                              userProfileAllRepo,
                                              dashBoardProviderRepo,
                                              widget.postProfileMainTabData
                                                  .profilePic),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            )
                          : widget.postProfilesubtabsData != null
                              ? Consumer(
                                  builder: (context, watch, child) {
                                    final feedProviderRepo =
                                        watch(feedProvider);
                                    final dashBoardProviderRepo =
                                        watch(dashboardProvider);
                                    final userProfileAllRepo =
                                        watch(userAllProvider);

                                    return Column(
                                      children: [
                                        Container(
                                          child: CachedNetworkImage(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height -
                                                  200,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              imageUrl: getImageUrl(widget
                                                  .postProfilesubtabsData
                                                  .postPhoto[0]
                                                  .location)),
                                          // imageUrl: getImageUrl(
                                          //     widget.discoveryData.postPhoto[0].location)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 0,
                                              right: 0.0,
                                              top: 8.0,
                                              bottom: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              _getCommentProfileSubTabWidget(
                                                  widget.postProfilesubtabsData
                                                          .like
                                                          .contains(
                                                              dashBoardProviderRepo
                                                                  .userId)
                                                      ? Icons.favorite
                                                      : Icons.favorite,
                                                  widget.postProfilesubtabsData
                                                      .like.length
                                                      .toString(),
                                                  0,
                                                  widget.postProfilesubtabsData,
                                                  userProfileAllRepo,
                                                  dashBoardProviderRepo,
                                                  widget.postProfilesubtabsData
                                                      .profilePic),
                                              _getCommentProfileSubTabWidget(
                                                  widget.postProfilesubtabsData
                                                          .like
                                                          .contains(
                                                              dashBoardProviderRepo
                                                                  .userId)
                                                      ? commentIcon
                                                      : commentIcon,
                                                  widget.postProfilesubtabsData
                                                      .commentCount,
                                                  1,
                                                  widget.postProfilesubtabsData,
                                                  userProfileAllRepo,
                                                  dashBoardProviderRepo,
                                                  widget.postProfilesubtabsData
                                                      .profilePic),
                                              _getCommentProfileSubTabWidget(
                                                  repostNewImage,
                                                  // Icons.autorenew_rounded,
                                                  widget.postProfilesubtabsData
                                                      .repost.length,
                                                  2,
                                                  widget.postProfilesubtabsData,
                                                  userProfileAllRepo,
                                                  dashBoardProviderRepo,
                                                  widget.postProfilesubtabsData
                                                      .profilePic),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                )
                              : widget.postDetailsNew != null
                                  ? Consumer(
                                      builder: (context, watch, child) {
                                        final feedProviderRepo =
                                            watch(feedProvider);
                                        final dashBoardProviderRepo =
                                            watch(dashboardProvider);

                                        return Column(
                                          children: [
                                            Container(
                                              child: feedProviderRepo
                                                          .feedDetail
                                                          .post[0]
                                                          .repeat
                                                          .post !=
                                                      null
                                                  ? CachedNetworkImage(
                                                      height: MediaQuery.of(context)
                                                              .size
                                                              .height -
                                                          200,
                                                      width: MediaQuery.of(context)
                                                          .size
                                                          .width,
                                                      imageUrl: getImageUrl(
                                                          feedProviderRepo
                                                              .feedDetail
                                                              .post[0]
                                                              .repeat
                                                              .post))
                                                  : CachedNetworkImage(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height -
                                                              200,
                                                      width: MediaQuery.of(context).size.width,
                                                      imageUrl: getImageUrl(feedProviderRepo.feedDetail.post[0].postPhoto[0].location)),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 0,
                                                  right: 0.0,
                                                  top: 8.0,
                                                  bottom: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  // _getDiscoverCommentWidget(
                                                  //     feedProviderRepo.feedDetail.post[0].like
                                                  //             .contains(feedProviderRepo
                                                  //                 .feedDetail.post[0].id)
                                                  //         ? Icons.favorite
                                                  //         : Icons.favorite,
                                                  //     feedProviderRepo
                                                  //         .feedDetail.post[0].like.length
                                                  //         .toString(),
                                                  //     0,
                                                  //     feedProviderRepo.feedDetail.post,
                                                  //     // // widget.postData,
                                                  //     //   feedProviderRepo.feedDetail,
                                                  //     // // widget.postData,
                                                  //     // dashBoardProviderRepo,

                                                  //     feedProviderRepo
                                                  //         .feedDetail.post[0].profilePic),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () {
                                                            feedProviderRepo.likeOrDislike(
                                                                context,
                                                                widget
                                                                    .postDetailsNew
                                                                    .id,
                                                                feedProviderRepo
                                                                    .likeCollection);
                                                            print(
                                                                feedProviderRepo
                                                                    .feedList[0]
                                                                    .like);
                                                            feedProviderRepo
                                                                .getFeedUserInfo(
                                                                    widget
                                                                        .postDetailsNew
                                                                        .id);
                                                          },
                                                          child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                feedProviderRepo.feedDetail.post[0].like.contains(
                                                                            userId) ==
                                                                        true
                                                                    ? Icon(
                                                                        Icons
                                                                            .favorite,
                                                                        color: Colors
                                                                            .red)
                                                                    : Icon(
                                                                        Icons
                                                                            .favorite,
                                                                        color: Colors
                                                                            .grey),
                                                                // Icon(
                                                                //     Icons.favorite,
                                                                //     color: feedProviderRepo.likeCollection.length != 0
                                                                //         ? Colors.red
                                                                //         : Colors.grey
                                                                // ),
                                                                Text(
                                                                  "${feedProviderRepo.likeCollection.length}",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          15),
                                                                ),
                                                              ])),
                                                    ],
                                                  ),
                                                  // Row(
                                                  //   mainAxisAlignment:
                                                  //   MainAxisAlignment.start,
                                                  //   crossAxisAlignment:
                                                  //   CrossAxisAlignment.center,
                                                  //   children: [
                                                  //     GestureDetector(
                                                  //         onTap: () {
                                                  //           feedProviderRepo
                                                  //               .likeOrDislike(
                                                  //               context,
                                                  //               widget.postData.id,
                                                  //               widget
                                                  //                   .postData.like);
                                                  //           print(feedProviderRepo
                                                  //               .feedList[0].like);
                                                  //           feedProviderRepo
                                                  //               .getFeedUserInfo(
                                                  //               widget.postData.id);
                                                  //         },
                                                  //         child: Row(
                                                  //             mainAxisAlignment:
                                                  //             MainAxisAlignment
                                                  //                 .start,
                                                  //             crossAxisAlignment:
                                                  //             CrossAxisAlignment
                                                  //                 .center,
                                                  //             children: [
                                                  //               SvgPicture.asset(
                                                  //                 commentIcon,
                                                  //                 color: Colors.grey,
                                                  //               ),
                                                  //               // Icon,
                                                  //               //     color: feedProviderRepo
                                                  //               //                 .likeCollection
                                                  //               //                 .length !=
                                                  //               //             0
                                                  //               //         ? Colors.red
                                                  //               //         : Colors.grey),
                                                  //               Text(
                                                  //                 "0",
                                                  //
                                                  //                 // "${feedProviderRepo.feedDetail.post[0].like.length}",
                                                  //                 style: TextStyle(
                                                  //                     color:
                                                  //                     Colors.grey,
                                                  //                     fontSize: 15),
                                                  //               ),
                                                  //             ])),
                                                  //   ],
                                                  // ),
                                                  // Row(
                                                  //   mainAxisAlignment:
                                                  //   MainAxisAlignment.start,
                                                  //   crossAxisAlignment:
                                                  //   CrossAxisAlignment.center,
                                                  //   children: [
                                                  //     GestureDetector(
                                                  //         onTap: () {
                                                  //           feedProviderRepo
                                                  //               .likeOrDislike(
                                                  //               context,
                                                  //               widget.postData.id,
                                                  //               widget
                                                  //                   .postData.like);
                                                  //           print(feedProviderRepo
                                                  //               .feedList[0].like);
                                                  //           feedProviderRepo
                                                  //               .getFeedUserInfo(
                                                  //               widget.postData.id);
                                                  //         },
                                                  //         child: Row(
                                                  //             mainAxisAlignment:
                                                  //             MainAxisAlignment
                                                  //                 .start,
                                                  //             crossAxisAlignment:
                                                  //             CrossAxisAlignment
                                                  //                 .center,
                                                  //             children: [
                                                  //               SvgPicture.asset(
                                                  //                 repostNewImage,
                                                  //                 color: Colors.grey,
                                                  //               ),
                                                  //               Text(
                                                  //                 "0",
                                                  //                 // "${feedProviderRepo.feedDetail.post[0].like.length}",
                                                  //                 style: TextStyle(
                                                  //                     color:
                                                  //                     Colors.grey,
                                                  //                     fontSize: 15),
                                                  //               ),
                                                  //             ])),
                                                  //   ],
                                                  // ),
                                                  // Row(
                                                  //   mainAxisAlignment:
                                                  //   MainAxisAlignment.start,
                                                  //   crossAxisAlignment:
                                                  //   CrossAxisAlignment.center,
                                                  //   children: [
                                                  //     GestureDetector(
                                                  //         onTap: () {
                                                  //           feedProviderRepo
                                                  //               .likeOrDislike(
                                                  //               context,
                                                  //               widget.postData.id,
                                                  //               widget
                                                  //                   .postData.like);
                                                  //           print(feedProviderRepo
                                                  //               .feedList[0].like);
                                                  //           feedProviderRepo
                                                  //               .getFeedUserInfo(
                                                  //               widget.postData.id);
                                                  //         },
                                                  //         child: Row(
                                                  //             mainAxisAlignment:
                                                  //             MainAxisAlignment
                                                  //                 .start,
                                                  //             crossAxisAlignment:
                                                  //             CrossAxisAlignment
                                                  //                 .center,
                                                  //             children: [
                                                  //               Icon(Icons.upload_file,
                                                  //                   color: feedProviderRepo
                                                  //                       .likeCollection
                                                  //                       .length !=
                                                  //                       0
                                                  //                       ? Colors.red
                                                  //                       : Colors.grey),
                                                  //               Text(
                                                  //                 "1",
                                                  //                 // "${feedProviderRepo.feedDetail.post[0].like.length}",
                                                  //                 style: TextStyle(
                                                  //                     color:
                                                  //                     Colors.grey,
                                                  //                     fontSize: 15),
                                                  //               ),
                                                  //             ])),
                                                  //   ],
                                                  // ),

                                                  _getCommentSeeAllWidget(
                                                      commentIcon,
                                                      // widget.postDetailsNew.commentCount,
                                                      feedProviderRepo
                                                          .feedDetail
                                                          .post[0]
                                                          .commentCount,
                                                      1,
                                                      widget.postDetailsNew,
                                                      widget.postDetailsNew,
                                                      dashBoardProviderRepo,
                                                      widget.postDetailsNew
                                                          .profilePic),
                                                  _getCommentSeeAllWidget(
                                                      feedProviderRepo
                                                                  .feedDetail
                                                                  .post[0]
                                                                  .repost
                                                                  .contains(
                                                                      userId) ==
                                                              true
                                                          ? repostColor
                                                          : repostNewImage,
                                                      // widget.postDetailsNew.repost.length,
                                                      feedProviderRepo
                                                          .feedDetail
                                                          .post[0]
                                                          .repost
                                                          .length,
                                                      2,
                                                      widget.postDetailsNew,
                                                      widget.postDetailsNew,
                                                      dashBoardProviderRepo,
                                                      widget.postDetailsNew
                                                          .profilePic),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    )
                                  : widget.discoverySeeAll != null
                                      ? Consumer(
                                          builder: (context, watch, child) {
                                            final feedProviderRepo =
                                                watch(feedProvider);
                                            final dashBoardProviderRepo =
                                                watch(dashboardProvider);

                                            return Column(
                                              children: [
                                                Container(
                                                  child: CachedNetworkImage(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height -
                                                              200,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      imageUrl: getImageUrl(
                                                          feedProviderRepo
                                                              .feedDetail
                                                              .post[0]
                                                              .postPhoto[0]
                                                              .location)),
                                                  // imageUrl: getImageUrl(
                                                  //     widget.discoveryData.postPhoto[0].location)),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 0,
                                                      right: 0.0,
                                                      top: 8.0,
                                                      bottom: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                      // _getDiscoverCommentWidget(
                                                      //     feedProviderRepo.feedDetail.post[0].like
                                                      //             .contains(feedProviderRepo
                                                      //                 .feedDetail.post[0].id)
                                                      //         ? Icons.favorite
                                                      //         : Icons.favorite,
                                                      //     feedProviderRepo
                                                      //         .feedDetail.post[0].like.length
                                                      //         .toString(),
                                                      //     0,
                                                      //     feedProviderRepo.feedDetail.post,
                                                      //     // // widget.postData,
                                                      //     //   feedProviderRepo.feedDetail,
                                                      //     // // widget.postData,
                                                      //     // dashBoardProviderRepo,

                                                      //     feedProviderRepo
                                                      //         .feedDetail.post[0].profilePic),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          GestureDetector(
                                                              onTap: () {
                                                                feedProviderRepo.likeOrDislike(
                                                                    context,
                                                                    widget
                                                                        .discoverySeeAll
                                                                        .id,
                                                                    feedProviderRepo
                                                                        .likeCollection);
                                                                feedProviderRepo
                                                                    .getFeedUserInfo(
                                                                        widget
                                                                            .postData
                                                                            .id);
                                                              },
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(
                                                                        Icons
                                                                            .favorite,
                                                                        color: feedProviderRepo.likeCollection.length !=
                                                                                0
                                                                            ? Colors.red
                                                                            : Colors.grey),
                                                                    Text(
                                                                      "${feedProviderRepo.likeCollection.length}",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  ])),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        )
                                      : widget.commentList != null
                                          ? Consumer(
                                              builder: (context, watch, child) {
                                              // final profileSubTabRepo = watch(profileSubTabProvider);
                                              final dashBoardProviderRepo =
                                                  watch(dashboardProvider);
                                              final feedProviderRepo =
                                                  watch(feedProvider);
                                              return Column(
                                                children: [
                                                  Container(
                                                    child: CachedNetworkImage(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height -
                                                            200,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        imageUrl: getImageUrl(
                                                            widget.commentList
                                                                .media)),
                                                    // imageUrl: getImageUrl(
                                                    //     widget.discoveryData.postPhoto[0].location)),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 0,
                                                        right: 0.0,
                                                        top: 8.0,
                                                        bottom: 8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: <Widget>[
                                                        // _getCommentListWidget(
                                                        //     widget.commentList.like.contains(
                                                        //         dashBoardProviderRepo.userId)
                                                        //         ? Icons.favorite
                                                        //         : Icons.favorite,
                                                        //     widget.commentList.like.length
                                                        //         .toString(),
                                                        //     0,
                                                        //     widget.commentList,
                                                        //     profileSubTabRepo,
                                                        //     dashBoardProviderRepo,
                                                        //     widget.commentList.userPic),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            GestureDetector(
                                                                onTap: () {
                                                                  feedProviderRepo.likeOrDislikeComment(
                                                                      context,
                                                                      widget
                                                                          .commentList
                                                                          .id,
                                                                      feedProviderRepo
                                                                          .likeCollectionComment);
                                                                },
                                                                child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(
                                                                          Icons
                                                                              .favorite,
                                                                          color: widget.commentList.like.length != 0
                                                                              ? Colors.red
                                                                              : Colors.grey),
                                                                      Text(
                                                                        "${widget.commentList.like.length}",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey,
                                                                            fontSize: 15),
                                                                      ),
                                                                    ])),
                                                          ],
                                                        ),
                                                        _getCommentListWidget(
                                                            widget.commentList
                                                                    .like
                                                                    .contains(
                                                                        dashBoardProviderRepo
                                                                            .userId)
                                                                ? commentIcon
                                                                : commentIcon,
                                                            widget.commentList
                                                                .replyCount,
                                                            1,
                                                            widget.commentList,
                                                            feedProviderRepo,
                                                            dashBoardProviderRepo,
                                                            widget.commentList
                                                                .userPic),
                                                        _getCommentListWidget(
                                                            repostNewImage,
                                                            widget.commentList
                                                                .repost.length,
                                                            2,
                                                            widget.commentList,
                                                            feedProviderRepo,
                                                            dashBoardProviderRepo,
                                                            widget.commentList
                                                                .userPic),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            })
                                          : widget.subCategoryProfileData !=
                                                  null
                                              ? Consumer(builder:
                                                  (context, watch, child) {
                                                  final profileSubTabRepo =
                                                      watch(
                                                          profileSubTabProvider);
                                                  final dashBoardProviderRepo =
                                                      watch(dashboardProvider);
                                                  return Column(
                                                    children: [
                                                      Container(
                                                        child: CachedNetworkImage(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height -
                                                                200,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            imageUrl: getImageUrl(
                                                                widget
                                                                    .subCategoryProfileData
                                                                    .postPhoto[
                                                                        0]
                                                                    .location)),
                                                        // imageUrl: getImageUrl(
                                                        //     widget.discoveryData.postPhoto[0].location)),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 0,
                                                                right: 0.0,
                                                                top: 8.0,
                                                                bottom: 8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: <Widget>[
                                                            _getCommentProfileSubCategoryWidget(
                                                                widget.subCategoryProfileData
                                                                        .like
                                                                        .contains(dashBoardProviderRepo
                                                                            .userId)
                                                                    ? Icons
                                                                        .favorite
                                                                    : Icons
                                                                        .favorite,
                                                                widget
                                                                    .subCategoryProfileData
                                                                    .like
                                                                    .length
                                                                    .toString(),
                                                                0,
                                                                widget
                                                                    .subCategoryProfileData,
                                                                profileSubTabRepo,
                                                                dashBoardProviderRepo,
                                                                widget
                                                                    .subCategoryProfileData
                                                                    .profilePic),
                                                            _getCommentProfileSubCategoryWidget(
                                                                widget.subCategoryProfileData
                                                                        .like
                                                                        .contains(dashBoardProviderRepo
                                                                            .userId)
                                                                    ? commentIcon
                                                                    : commentIcon,
                                                                widget
                                                                    .subCategoryProfileData
                                                                    .commentCount,
                                                                1,
                                                                widget
                                                                    .subCategoryProfileData,
                                                                profileSubTabRepo,
                                                                dashBoardProviderRepo,
                                                                widget
                                                                    .subCategoryProfileData
                                                                    .profilePic),
                                                            _getCommentProfileSubCategoryWidget(
                                                                Icons
                                                                    .autorenew_rounded,
                                                                widget
                                                                    .subCategoryProfileData
                                                                    .repost
                                                                    .length,
                                                                2,
                                                                widget
                                                                    .subCategoryProfileData,
                                                                profileSubTabRepo,
                                                                dashBoardProviderRepo,
                                                                widget
                                                                    .subCategoryProfileData
                                                                    .profilePic),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                })
                                              : widget.postProfileAllData !=
                                                      null
                                                  ? Consumer(
                                                      builder: (context, watch,
                                                          child) {
                                                        final feedProviderRepo =
                                                            watch(feedProvider);
                                                        final dashBoardProviderRepo =
                                                            watch(
                                                                dashboardProvider);
                                                        final userProfileAllRepo =
                                                            watch(
                                                                userAllProvider);

                                                        return Column(
                                                          children: [
                                                            Container(
                                                                child: widget
                                                                            .postProfileAllData
                                                                            .repeat
                                                                            .post !=
                                                                        null
                                                                    ? CachedNetworkImage(
                                                                        height: MediaQuery.of(context).size.height -
                                                                            200,
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width,
                                                                        imageUrl: getImageUrl(widget
                                                                            .postProfileAllData
                                                                            .repeat
                                                                            .post))
                                                                    : CachedNetworkImage(
                                                                        height: MediaQuery.of(context).size.height -
                                                                            200,
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width,
                                                                        imageUrl:
                                                                            getImageUrl(widget.postProfileAllData.postPhoto[0].location))),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 0,
                                                                      right:
                                                                          0.0,
                                                                      top: 8.0,
                                                                      bottom:
                                                                          8.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: <
                                                                    Widget>[
                                                                  _getCommentProfileAllWidget(
                                                                      widget.postProfileAllData.like.contains(dashBoardProviderRepo
                                                                              .userId)
                                                                          ? Icons
                                                                              .favorite
                                                                          : Icons
                                                                              .favorite,
                                                                      widget
                                                                          .postProfileAllData
                                                                          .like
                                                                          .length
                                                                          .toString(),
                                                                      0,
                                                                      widget
                                                                          .postProfileAllData,
                                                                      userProfileAllRepo,
                                                                      dashBoardProviderRepo,
                                                                      widget
                                                                          .postProfileAllData
                                                                          .profilePic),
                                                                  _getCommentProfileAllWidget(
                                                                      widget.postProfileAllData.like.contains(dashBoardProviderRepo
                                                                              .userId)
                                                                          ? commentIcon
                                                                          : commentIcon,
                                                                      widget
                                                                          .postProfileAllData
                                                                          .commentCount,
                                                                      1,
                                                                      widget
                                                                          .postProfileAllData,
                                                                      userProfileAllRepo,
                                                                      dashBoardProviderRepo,
                                                                      widget
                                                                          .postProfileAllData
                                                                          .profilePic),
                                                                  _getCommentProfileAllWidget(
                                                                      Icons
                                                                          .autorenew_rounded,
                                                                      widget
                                                                          .postProfileAllData
                                                                          .repost
                                                                          .length,
                                                                      2,
                                                                      widget
                                                                          .postProfileAllData,
                                                                      userProfileAllRepo,
                                                                      dashBoardProviderRepo,
                                                                      widget
                                                                          .postProfileAllData
                                                                          .profilePic),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    )
                                                  //     : widget.discoveryData != null
                                                  //     ? Consumer(
                                                  //   builder: (context, watch, child) {
                                                  //     final feedProviderRepo = watch(feedProvider);
                                                  //     final dashBoardProviderRepo =
                                                  //     watch(dashboardProvider);
                                                  //
                                                  //     return Column(
                                                  //       children: [
                                                  //         Container(
                                                  //           child: CachedNetworkImage(
                                                  //               height: MediaQuery.of(context)
                                                  //                   .size
                                                  //                   .height -
                                                  //                   200,
                                                  //               width:
                                                  //               MediaQuery.of(context).size.width,
                                                  //               imageUrl: getImageUrl(feedProviderRepo
                                                  //                   .feedDetail
                                                  //                   .post[0]
                                                  //                   .postPhoto[0]
                                                  //                   .location)),
                                                  //           // imageUrl: getImageUrl(
                                                  //           //     widget.discoveryData.postPhoto[0].location)),
                                                  //         ),
                                                  //         Padding(
                                                  //           padding: EdgeInsets.only(
                                                  //               left: 0,
                                                  //               right: 0.0,
                                                  //               top: 8.0,
                                                  //               bottom: 8.0),
                                                  //           child: Row(
                                                  //             mainAxisAlignment:
                                                  //             MainAxisAlignment.spaceEvenly,
                                                  //             children: <Widget>[
                                                  //               Row(
                                                  //                 mainAxisAlignment:
                                                  //                 MainAxisAlignment.start,
                                                  //                 crossAxisAlignment:
                                                  //                 CrossAxisAlignment.center,
                                                  //                 children: [
                                                  //                   GestureDetector(
                                                  //                       onTap: () {
                                                  //                         feedProviderRepo
                                                  //                             .likeOrDislike(
                                                  //                             context,
                                                  //                             widget.discoveryData
                                                  //                                 .id,
                                                  //                             feedProviderRepo
                                                  //                                 .likeCollection);
                                                  //                         print(feedProviderRepo
                                                  //                             .feedList[0].like);
                                                  //                         feedProviderRepo
                                                  //                             .getFeedUserInfo(
                                                  //                             widget.postData.id);
                                                  //                       },
                                                  //                       child: Row(
                                                  //                           mainAxisAlignment:
                                                  //                           MainAxisAlignment
                                                  //                               .start,
                                                  //                           crossAxisAlignment:
                                                  //                           CrossAxisAlignment
                                                  //                               .center,
                                                  //                           children: [
                                                  //                             Icon(Icons.favorite,
                                                  //                                 color: feedProviderRepo
                                                  //                                     .likeCollection
                                                  //                                     .length !=
                                                  //                                     0
                                                  //                                     ? Colors.red
                                                  //                                     : Colors.grey),
                                                  //                             Text(
                                                  //                               "${feedProviderRepo.likeCollection.length}",
                                                  //                               style: TextStyle(
                                                  //                                   color:
                                                  //                                   Colors.grey,
                                                  //                                   fontSize: 15),
                                                  //                             ),
                                                  //                           ])),
                                                  //                 ],
                                                  //               ),
                                                  //               _getCommentDiscoverWidget(
                                                  //                   commentIcon,
                                                  //                   feedProviderRepo
                                                  //                       .feedDetail
                                                  //                       .post[0].commentCount,
                                                  //                   1,
                                                  //                   widget.discoveryData,
                                                  //                   widget.discoveryData,
                                                  //                   dashBoardProviderRepo,
                                                  //                   feedProviderRepo
                                                  //                       .feedDetail
                                                  //                       .post[0].profilePic),
                                                  //               _getCommentDiscoverWidget(
                                                  //                   repostNewImage,
                                                  //                   feedProviderRepo
                                                  //                       .feedDetail
                                                  //                       .post[0].repost.length,
                                                  //                   2,
                                                  //                   widget.discoveryData,
                                                  //                   widget.discoveryData,
                                                  //                   dashBoardProviderRepo,
                                                  //                   feedProviderRepo
                                                  //                       .feedDetail
                                                  //                       .post[0].profilePic),
                                                  //             ],
                                                  //           ),
                                                  //         ),
                                                  //       ],
                                                  //     );
                                                  //   },
                                                  // )
                                                  : Consumer(
                                                      builder: (context, watch,
                                                          child) {
                                                        final dashBoardProviderRepo =
                                                            watch(
                                                                dashboardProvider);
                                                        final feedProviderRepo =
                                                            watch(feedProvider);
                                                        return Column(
                                                          children: [
                                                            Container(
                                                              child: CachedNetworkImage(
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height -
                                                                      200,
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  imageUrl:
                                                                      getImageUrl(
                                                                          widget
                                                                              .filePaths)),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 0,
                                                                      right:
                                                                          0.0,
                                                                      top: 8.0,
                                                                      bottom:
                                                                          8.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: <
                                                                    Widget>[
                                                                  // _getCommentWidget(
                                                                  //     widget.postData.like.contains(
                                                                  //             dashBoardProviderRepo.userId)
                                                                  //         ? Icons.favorite
                                                                  //         : Icons.favorite,
                                                                  //     widget.postData.like.length.toString(),
                                                                  //     0,
                                                                  //     widget.postData,
                                                                  //     widget.postData,
                                                                  //     dashBoardProviderRepo,
                                                                  //     widget.postData.profilePic),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            feedProviderRepo.likeOrDislike(
                                                                                context,
                                                                                widget.postData.id,
                                                                                widget.postData.like);
                                                                            print(feedProviderRepo.feedList[0].like);
                                                                            feedProviderRepo.getFeedUserInfo(widget.postData.id);
                                                                          },
                                                                          child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                widget.postData.like.contains(userId) == true ? Icon(Icons.favorite, color: Colors.red) : Icon(Icons.favorite, color: Colors.grey),
                                                                                // Icon(Icons.favorite,
                                                                                //     color: feedProviderRepo
                                                                                //         .likeCollection
                                                                                //         .length !=
                                                                                //         0
                                                                                //         ? Colors.red
                                                                                //         : Colors.grey),
                                                                                Text(
                                                                                  "${widget.postData.like.length}",
                                                                                  style: TextStyle(color: Colors.grey, fontSize: 15),
                                                                                ),
                                                                              ])),
                                                                    ],
                                                                  ),
                                                                  _getCommentWidget(
                                                                      widget.postData.like.contains(dashBoardProviderRepo
                                                                              .userId)
                                                                          ? commentIcon
                                                                          : commentIcon,
                                                                      widget
                                                                          .postData
                                                                          .commentCount,
                                                                      1,
                                                                      widget
                                                                          .postData,
                                                                      widget
                                                                          .postData,
                                                                      dashBoardProviderRepo,
                                                                      widget
                                                                          .postData
                                                                          .profilePic),
                                                                  _getCommentWidget(
                                                                      repostNewImage,
                                                                      widget
                                                                          .postData
                                                                          .repost
                                                                          .length,
                                                                      2,
                                                                      widget
                                                                          .postData,
                                                                      widget
                                                                          .postData,
                                                                      dashBoardProviderRepo,
                                                                      widget
                                                                          .postData
                                                                          .profilePic),
                                                                  // _getCommentWidget(
                                                                  //     Icons.upload_file,
                                                                  //     "",
                                                                  //     2,
                                                                  //     widget.postData,
                                                                  //     widget.postData,
                                                                  //     dashBoardProviderRepo,
                                                                  //     widget.postData.profilePic),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    ),
        ));
  }

  _getCommentWidget(iconData, text1, i, FeedDetail postDetails,
      feedProviderRepo, dashBoardProviderRepo, userReplyProfile) {
    return GestureDetector(
      onTap: () => {
        _handleOnTap(i, postDetails, feedProviderRepo, dashBoardProviderRepo,
            userReplyProfile)
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 0, left: 10, top: 5),
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
//            Icon(iconData,
//                color: i == 0
//                    ? postDetails.like.length > 0
//                        ? Colors.red
//                        : Colors.grey
//                    : Colors.grey),
            Container(
                margin: EdgeInsets.only(left: 08, right: 15),
                child: Row(
                  children: [
                    Text(
                      text1.toString(),
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  _getDiscoverCommentWidget(iconData, text1, feedProviderRepo,
      dashBoardProviderRepo, userReplyProfile) {
    return GestureDetector(
      onTap: () => {
        // _handleOnTap(i, postDetails, feedProviderRepo, dashBoardProviderRepo,
        //     userReplyProfile)
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 0, left: 10, top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(iconData, color: Colors.red),
            // i == 0 || i == 2 || i == 3
            //     ? Icon(iconData,
            //         color: i == 0
            //             ? postDetails.like.length > 0
            //                 ? Colors.red
            //                 : Colors.grey
            //             : Colors.grey)
            //     : SvgPicture.asset(iconData, fit: BoxFit.none),
//            Icon(iconData,
//                color: i == 0
//                    ? postDetails.like.length > 0
//                        ? Colors.red
//                        : Colors.grey
//                    : Colors.grey),
            Container(
                margin: EdgeInsets.only(left: 08, right: 15),
                child: Row(
                  children: [
                    Text(
                      "df",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  _handleOnTap(int i, FeedDetail postDetails, feedProviderRepo,
      dashBoardProviderRepo, userReplyProfile) {
    if (i == 0) {
      setState(() {
        if (favorite == true) {
          favorite = false;
        } else {
          favorite = true;
        }
      });
      feedProviderRepo.likeOrDislike(postDetails.id, postDetails.like);
    } else if (i == 1) {
      print("${postDetails.postPhoto}");
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CommentForPost(
                  postId: postDetails.id,
                  post: postDetails.userName,
                  // profilePicUser: postDetails.postPhoto.length!=0 &&  postDetails.postPhoto[0].location !=null ? postDetails.postPhoto[0].location : '',
                  profilePicUser: userReplyProfile,
                  adminPicUser: dashBoardProviderRepo.userProfilePic,
                  postSecondaryName: postDetails.name,
                  // profilepic: postDetails.postPhoto,
                )),
      );
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) =>
      //           CommentPostFeedPage()
      //   ),
      //       (Route<dynamic> route) => false,
      // );
      print("Comment");
    } else {
      _modalBottomSheetMenu(i, postDetails);
    }
  }

  void _modalBottomSheetMenu(int i, FeedDetail postDetails) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        context: context,
        builder: (builder) {
          return SingleChildScrollView(child: Consumer(
            builder: (context, watch, child) {
              final repostProvider = watch(feedProvider);
              final dashBoardProviderRepo = watch(dashboardProvider);
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
                                      if (repost == true) {
                                        repost = false;
                                      } else {
                                        repost = true;
                                      }
                                    });
                                    await repostProvider.repostFeedPost(
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
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RepeatCommentPost(
                                              postDetails: postDetails,
                                              adminPicUser:
                                                  dashBoardProviderRepo
                                                      .userProfilePic
                                              // postDetailsUserPic: postDetails.profilePic
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

  _getCommentProfileAllWidget(iconData, text1, i, Datum postDetails,
      userProfileAllRepo, dashBoardProviderRepo, userReplyProfile) {
    return GestureDetector(
      onTap: () => {
        _handleOnProfileAllTap(i, postDetails, userProfileAllRepo,
            dashBoardProviderRepo, userReplyProfile)
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 0, left: 10, top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            i == 0 || i == 2 || i == 3
                ? Icon(iconData,
                    color: i == 0
                        ? postDetails.like.length > 0
                            ? Colors.red
                            : Colors.grey
                        : Colors.grey)
                : SvgPicture.asset(iconData, fit: BoxFit.none),
//            Icon(iconData,
//                color: i == 0
//                    ? postDetails.like.length > 0
//                        ? Colors.red
//                        : Colors.grey
//                    : Colors.grey),
            Container(
                margin: EdgeInsets.only(left: 08, right: 15),
                child: Row(
                  children: [
                    Text(
                      text1.toString(),
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  _handleOnProfileAllTap(int i, Datum postDetails, userProfileAllRepo,
      dashBoardProviderRepo, userReplyProfile) {
    if (i == 0) {
      setState(() {
        if (favorite == true) {
          favorite = false;
        } else {
          favorite = true;
        }
      });
      userProfileAllRepo.likeOrDislikes(postDetails.id, postDetails.like);
    } else if (i == 1) {
      print("${postDetails.postPhoto}");
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CommentForPost(
                postId: postDetails.id,
                post: postDetails.userName,
                // profilePicUser: postDetails.postPhoto.length!=0 &&  postDetails.postPhoto[0].location !=null ? postDetails.postPhoto[0].location : '',
                profilePicUser: userReplyProfile,
                adminPicUser: dashBoardProviderRepo.userProfilePic
                // profilepic: postDetails.postPhoto,
                )),
      );
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) =>
      //           CommentPostFeedPage()
      //   ),
      //       (Route<dynamic> route) => false,
      // );
      print("Comment");
    } else {
      _modalBottomSheetProfileAll(i, postDetails);
    }
  }

  void _modalBottomSheetProfileAll(int i, Datum postDetails) {
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
                                Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                Padding(padding: EdgeInsets.only(right: 15)),
                                GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      if (repost == true) {
                                        repost = false;
                                      } else {
                                        repost = true;
                                      }
                                    });
                                    await repostProvider.repostFeedPost(
                                        postDetails.id, postDetails.repost);

                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Repost",
                                    style: TextStyle(
                                        fontSize: 15,
                                        // color: HexColor("666666"),
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: Colors.red,
                                ),
                                Padding(padding: EdgeInsets.only(right: 15)),
                                GestureDetector(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RepeatCommentPost(
                                                allUserDetails: postDetails,
                                                // postDetailsUserPic: postDetails.profilePic
                                              )),
                                    );

                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Repeat",
                                    style: TextStyle(
                                        fontSize: 15,
                                        // color: HexColor("666666"),
                                        color: Colors.white,
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

  //SubCategory
  _getCommentProfileSubCategoryWidget(iconData, text1, i, Datums postDetails,
      profileSubTabRepo, dashBoardProviderRepo, userReplyProfile) {
    return GestureDetector(
      onTap: () => {
        _handleOnProfileSubCategoryTap(i, postDetails, profileSubTabRepo,
            dashBoardProviderRepo, userReplyProfile)
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 0, left: 10, top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            i == 0 || i == 2 || i == 3
                ? Icon(iconData,
                    color: i == 0
                        ? postDetails.like.length > 0
                            ? Colors.red
                            : Colors.grey
                        : Colors.grey)
                : SvgPicture.asset(iconData, fit: BoxFit.none),
//            Icon(iconData,
//                color: i == 0
//                    ? postDetails.like.length > 0
//                        ? Colors.red
//                        : Colors.grey
//                    : Colors.grey),
            Container(
                margin: EdgeInsets.only(left: 08, right: 15),
                child: Row(
                  children: [
                    Text(
                      text1.toString(),
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  _handleOnProfileSubCategoryTap(int i, Datums postDetails, profileSubTabRepo,
      dashBoardProviderRepo, userReplyProfile) {
    if (i == 0) {
      setState(() {
        if (favorite == true) {
          favorite = false;
        } else {
          favorite = true;
        }
      });
      profileSubTabRepo.likeOrDislikeSubCategoryIndividual(
          context, postDetails.id, postDetails.like);
    } else if (i == 1) {
      print("${postDetails.postPhoto}");
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CommentForPost(
                postId: postDetails.id,
                post: postDetails.userName,
                // profilePicUser: postDetails.postPhoto.length!=0 &&  postDetails.postPhoto[0].location !=null ? postDetails.postPhoto[0].location : '',
                profilePicUser: userReplyProfile,
                adminPicUser: dashBoardProviderRepo.userProfilePic
                // profilepic: postDetails.postPhoto,
                )),
      );
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) =>
      //           CommentPostFeedPage()
      //   ),
      //       (Route<dynamic> route) => false,
      // );
      print("Comment");
    } else {
      _modalBottomSheetProfileSubCategoryT(i, postDetails);
    }
  }

  void _modalBottomSheetProfileSubCategoryT(int i, Datums postDetails) {
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
                                Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                Padding(padding: EdgeInsets.only(right: 15)),
                                GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      if (repost == true) {
                                        repost = false;
                                      } else {
                                        repost = true;
                                      }
                                    });
                                    await repostProvider.repostFeedPost(
                                        postDetails.id, postDetails.repost);

                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Repost",
                                    style: TextStyle(
                                        fontSize: 15,
                                        // color: HexColor("666666"),
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: Colors.red,
                                ),
                                Padding(padding: EdgeInsets.only(right: 15)),
                                GestureDetector(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RepeatCommentPost(
                                                postProfileSubcategory:
                                                    postDetails,
                                                // postDetailsUserPic: postDetails.profilePic
                                              )),
                                    );

                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Repeat",
                                    style: TextStyle(
                                        fontSize: 15,
                                        // color: HexColor("666666"),
                                        color: Colors.white,
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

  // For comment List

  _getCommentListWidget(iconData, text1, i, newData.Comment postDetails,
      feedProviderRepo, dashBoardProviderRepo, userReplyProfile) {
    return GestureDetector(
      onTap: () => {
        _handleOnCommentListTap(i, postDetails, feedProviderRepo,
            dashBoardProviderRepo, userReplyProfile)
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 0, left: 10, top: 5),
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
//            Icon(iconData,
//                color: i == 0
//                    ? postDetails.like.length > 0
//                        ? Colors.red
//                        : Colors.grey
//                    : Colors.grey),
            Container(
                margin: EdgeInsets.only(left: 08, right: 15),
                child: Row(
                  children: [
                    Text(
                      text1.toString(),
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  _handleOnCommentListTap(int i, newData.Comment postDetails, feedProviderRepo,
      dashBoardProviderRepo, userReplyProfile) {
    if (i == 0) {
      setState(() {
        if (favorite == true) {
          favorite = false;
        } else {
          favorite = true;
        }
      });
      feedProviderRepo.likeOrDislike(postDetails.id, postDetails.like);
    } else if (i == 1) {
      print("${postDetails.userPic}");
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CommentForPost(
                  postId: postDetails.id,
                  post: postDetails.userName,
                  // profilePicUser: postDetails.postPhoto.length!=0 &&  postDetails.postPhoto[0].location !=null ? postDetails.postPhoto[0].location : '',
                  profilePicUser: userReplyProfile,
                  adminPicUser: dashBoardProviderRepo.userProfilePic,
                  postSecondaryName: postDetails.userName,
                  // profilepic: postDetails.postPhoto,
                )),
      );
      print("Comment");
    } else {
      _modalBottomSheetMenuCommentList(i, postDetails);
    }
  }

  void _modalBottomSheetMenuCommentList(int i, newData.Comment postDetails) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        context: context,
        builder: (builder) {
          return SingleChildScrollView(child: Consumer(
            builder: (context, watch, child) {
              final repostProvider = watch(feedProvider);
              final dashBoardProviderRepo = watch(dashboardProvider);
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
                                      if (repost == true) {
                                        repost = false;
                                      } else {
                                        repost = true;
                                      }
                                    });
                                    await repostProvider.repostFeedPost(
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
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RepeatCommentPost(
                                              postCommentListDetails:
                                                  postDetails,
                                              adminPicUser:
                                                  dashBoardProviderRepo
                                                      .userProfilePic
                                              // postDetailsUserPic: postDetails.profilePic
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

  //For Discover
  _getCommentDiscoverWidget(iconData, text1, i, Feed postDetails,
      feedProviderRepo, dashBoardProviderRepo, userReplyProfile) {
    return GestureDetector(
      onTap: () => {
        _handleOnDiscoverTap(i, postDetails, feedProviderRepo,
            dashBoardProviderRepo, userReplyProfile)
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 0, left: 10, top: 5),
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
//            Icon(iconData,
//                color: i == 0
//                    ? postDetails.like.length > 0
//                        ? Colors.red
//                        : Colors.grey
//                    : Colors.grey),
            Container(
                margin: EdgeInsets.only(left: 08, right: 15),
                child: Row(
                  children: [
                    Text(
                      text1.toString(),
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  _handleOnDiscoverTap(int i, Feed postDetails, feedProviderRepo,
      dashBoardProviderRepo, userReplyProfile) {
    if (i == 0) {
      setState(() {
        if (favorite == true) {
          favorite = false;
        } else {
          favorite = true;
        }
      });
      feedProviderRepo.likeOrDislike(postDetails.id, postDetails.like);
    } else if (i == 1) {
      print("${postDetails.postPhoto}");
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CommentForPost(
                  postId: postDetails.id,
                  post: 'jjjjj',
                  // profilePicUser: postDetails.postPhoto.length!=0 &&  postDetails.postPhoto[0].location !=null ? postDetails.postPhoto[0].location : '',
                  profilePicUser: userReplyProfile,
                  adminPicUser: dashBoardProviderRepo.userProfilePic,
                  postSecondaryName: 'pppp',
                  // profilepic: postDetails.postPhoto,
                )),
      );
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) =>
      //           CommentPostFeedPage()
      //   ),
      //       (Route<dynamic> route) => false,
      // );
      print("Comment");
    } else {
      _modalBottomSheetDiscoverMenu(i, postDetails);
    }
  }

  void _modalBottomSheetDiscoverMenu(int i, Feed postDetails) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        context: context,
        builder: (builder) {
          return SingleChildScrollView(child: Consumer(
            builder: (context, watch, child) {
              final repostProvider = watch(feedProvider);
              final dashBoardProviderRepo = watch(dashboardProvider);
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
                                      if (repost == true) {
                                        repost = false;
                                      } else {
                                        repost = true;
                                      }
                                    });
                                    await repostProvider.repostFeedPost(
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
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RepeatCommentPost(
                                              discoverpostDetails: postDetails,
                                              adminPicUser:
                                                  dashBoardProviderRepo
                                                      .userProfilePic
                                              // postDetailsUserPic: postDetails.profilePic
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

  //for seeAll
  _getCommentSeeAllWidget(iconData, text1, i, newData.Post postDetails,
      feedProviderRepo, dashBoardProviderRepo, userReplyProfile) {
    return GestureDetector(
      onTap: () => {
        _handleOnSeeAllTap(i, postDetails, feedProviderRepo,
            dashBoardProviderRepo, userReplyProfile)
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 0, left: 10, top: 5),
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
//            Icon(iconData,
//                color: i == 0
//                    ? postDetails.like.length > 0
//                        ? Colors.red
//                        : Colors.grey
//                    : Colors.grey),
            Container(
                margin: EdgeInsets.only(left: 08, right: 15),
                child: Row(
                  children: [
                    Text(
                      text1.toString(),
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  _handleOnSeeAllTap(int i, newData.Post postDetails, feedProviderRepo,
      dashBoardProviderRepo, userReplyProfile) {
    if (i == 0) {
      setState(() {
        if (favorite == true) {
          favorite = false;
        } else {
          favorite = true;
        }
      });
      feedProviderRepo.likeOrDislike(postDetails.id, postDetails.like);
    } else if (i == 1) {
      print("${postDetails.profilePic}");
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CommentForPost(
                  postId: postDetails.id,
                  post: postDetails.userName,
                  // profilePicUser: postDetails.postPhoto.length!=0 &&  postDetails.postPhoto[0].location !=null ? postDetails.postPhoto[0].location : '',
                  profilePicUser: userReplyProfile,
                  adminPicUser: dashBoardProviderRepo.userProfilePic,
                  postSecondaryName: postDetails.userName,
                  // profilepic: postDetails.postPhoto,
                )),
      );
      print("Comment");
    } else {
      _modalBottomSheetMenuSeeAll(i, postDetails);
    }
  }

  void _modalBottomSheetMenuSeeAll(int i, newData.Post postDetails) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        context: context,
        builder: (builder) {
          return SingleChildScrollView(child: Consumer(
            builder: (context, watch, child) {
              final repostProvider = watch(feedProvider);
              final dashBoardProviderRepo = watch(dashboardProvider);
              final feedProviderRepo = watch(feedProvider);
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
                                      if (repost == true) {
                                        repost = false;
                                      } else {
                                        repost = true;
                                      }
                                    });
                                    print('popopop');
                                    print(feedProviderRepo.feedDetail.post[0]);
                                    await repostProvider.repostFeedPost(
                                        postDetails.id,
                                        // postDetails.repost
                                        feedProviderRepo
                                            .feedDetail.post[0].repost);

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
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RepeatCommentPost(
                                                  //  postCommentListDetails: postDetails,
                                                  adminPicUser:
                                                      dashBoardProviderRepo
                                                          .userProfilePic
                                                  // postDetailsUserPic: postDetails.profilePic
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

  //For DiscoverSeeAll
//   _getCommentDiscoverSeeAllWidget(iconData, text1, i, newdis.PostFeed postDetails,
//       feedProviderRepo, dashBoardProviderRepo, userReplyProfile) {
//     return GestureDetector(
//       onTap: () => {
//         _handleOnDiscoverSeeAllTap(i, postDetails, feedProviderRepo, dashBoardProviderRepo,
//             userReplyProfile)
//       },
//       child: Container(
//         padding: EdgeInsets.only(bottom: 0, left: 10, top: 5),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             i == 0 || i == 3
//                 ? i == 2
//                 ? Container()
//                 : Icon(iconData,
//                 color: i == 0
//                     ? postDetails.like.length > 0
//                     ? Colors.red
//                     : Colors.grey
//                     : Colors.grey)
//                 : SvgPicture.asset(iconData, fit: BoxFit.none),
// //            Icon(iconData,
// //                color: i == 0
// //                    ? postDetails.like.length > 0
// //                        ? Colors.red
// //                        : Colors.grey
// //                    : Colors.grey),
//             Container(
//                 margin: EdgeInsets.only(left: 08, right: 15),
//                 child: Row(
//                   children: [
//                     Text(
//                       text1.toString(),
//                       style: TextStyle(color: Colors.grey, fontSize: 15),
//                     ),
//                   ],
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//   _handleOnDiscoverSeeAllTap(int i, newdis.PostFeed postDetails, feedProviderRepo,
//       dashBoardProviderRepo, userReplyProfile) {
//     if (i == 0) {
//       setState(() {
//         if (favorite == true) {
//           favorite = false;
//         } else {
//           favorite = true;
//         }
//       });
//      // feedProviderRepo.likeOrDislike(postDetails.id, po);
//     } else if (i == 1) {
//       print("${postDetails.postPhoto}");
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) => CommentForPost(
//               postId: postDetails.id,
//               post: 'jjjjj',
//               // profilePicUser: postDetails.postPhoto.length!=0 &&  postDetails.postPhoto[0].location !=null ? postDetails.postPhoto[0].location : '',
//               profilePicUser: userReplyProfile,
//               adminPicUser: dashBoardProviderRepo.userProfilePic,
//               postSecondaryName: 'pppp',
//               // profilepic: postDetails.postPhoto,
//             )),
//       );
//       // Navigator.pushAndRemoveUntil(
//       //   context,
//       //   MaterialPageRoute(
//       //       builder: (context) =>
//       //           CommentPostFeedPage()
//       //   ),
//       //       (Route<dynamic> route) => false,
//       // );
//       print("Comment");
//     } else {
//       _modalBottomSheetDiscoverSeeAllMenu(i, postDetails);
//     }
//   }
//
//   void _modalBottomSheetDiscoverSeeAllMenu(int i, newdis.PostFeed postDetails) {
//     showModalBottomSheet(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15.0),
//         ),
//         context: context,
//         builder: (builder) {
//           return SingleChildScrollView(child: Consumer(
//             builder: (context, watch, child) {
//               final repostProvider = watch(feedProvider);
//               final dashBoardProviderRepo = watch(dashboardProvider);
//               return Container(
//                   decoration: BoxDecoration(
//                     color: Color(0xFF222222),
//                   ),
//                   child: Column(children: [
//                     Padding(
//                       padding: EdgeInsets.fromLTRB(0, 60, 0, 40),
//                       child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Row(
//                               children: [
//                                 SvgPicture.asset(repostBottom,
//                                     fit: BoxFit.scaleDown),
//                                 Padding(padding: EdgeInsets.only(right: 15)),
//                                 GestureDetector(
//                                   onTap: () async {
//                                     setState(() {
//                                       if (repost == true) {
//                                         repost = false;
//                                       } else {
//                                         repost = true;
//                                       }
//                                     });
//                                     // await repostProvider.repostFeedPost(
//                                     //     postDetails.id, postDetails.repost);
//
//                                     Navigator.pop(context);
//                                   },
//                                   child: Text(
//                                     "Repost",
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         // color: HexColor("666666"),
//                                         color: Color(0xff888888),
//                                         fontWeight: FontWeight.w600),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 SvgPicture.asset(repeatIocn,
//                                     height: 10,
//                                     width: 10,
//                                     fit: BoxFit.scaleDown),
//                                 Padding(padding: EdgeInsets.only(right: 15)),
//                                 GestureDetector(
//                                   onTap: () async {
//                                     await Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               RepeatCommentPost(
//                                                 //  discoverpostDetails: postDetails,
//                                                   adminPicUser: dashBoardProviderRepo.userProfilePic
//                                                 // postDetailsUserPic: postDetails.profilePic
//                                               )),
//                                     );
//
//                                     Navigator.pop(context);
//                                   },
//                                   child: Text(
//                                     "Quote",
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         // color: HexColor("666666"),
//                                         color: Color(0xff888888),
//                                         fontWeight: FontWeight.w600),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ]),
//                     ),
//                   ]));
//             },
//           ));
//         });
//   }
//The Below data is for expand the image of the MEDIA MAIN N SUB CATEGORY in the PROFILE
  _getCommentProfileSubTabWidget(
      iconData,
      text1,
      i,
      mediasubtabs.Datum postDetails,
      feedProviderRepo,
      dashBoardProviderRepo,
      userReplyProfile) {
    return GestureDetector(
      onTap: () => {
        _handleOnSubTabsTap(i, postDetails, feedProviderRepo,
            dashBoardProviderRepo, userReplyProfile)
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 0, left: 10, top: 5),
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
//            Icon(iconData,
//                color: i == 0
//                    ? postDetails.like.length > 0
//                        ? Colors.red
//                        : Colors.grey
//                    : Colors.grey),
            Container(
                margin: EdgeInsets.only(left: 08, right: 15),
                child: Row(
                  children: [
                    Text(
                      text1.toString(),
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  _handleOnSubTabsTap(int i, mediasubtabs.Datum postDetails, feedProviderRepo,
      dashBoardProviderRepo, userReplyProfile) {
    if (i == 0) {
      setState(() {
        if (favorite == true) {
          favorite = false;
        } else {
          favorite = true;
        }
      });
      feedProviderRepo.likeOrDislike(postDetails.id, postDetails.like);
    } else if (i == 1) {
      print("${postDetails.profilePic}");
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CommentForPost(
                  postId: postDetails.id,
                  post: postDetails.userName,
                  // profilePicUser: postDetails.postPhoto.length!=0 &&  postDetails.postPhoto[0].location !=null ? postDetails.postPhoto[0].location : '',
                  profilePicUser: userReplyProfile,
                  adminPicUser: dashBoardProviderRepo.userProfilePic,
                  postSecondaryName: postDetails.userName,
                  // profilepic: postDetails.postPhoto,
                )),
      );
      print("Comment");
    } else {
      _modalBottomSheetMenuSubtabs(i, postDetails);
    }
  }

  void _modalBottomSheetMenuSubtabs(int i, mediasubtabs.Datum postDetails) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        context: context,
        builder: (builder) {
          return SingleChildScrollView(child: Consumer(
            builder: (context, watch, child) {
              final repostProvider = watch(feedProvider);
              final dashBoardProviderRepo = watch(dashboardProvider);
              final feedProviderRepo = watch(feedProvider);
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
                                      if (repost == true) {
                                        repost = false;
                                      } else {
                                        repost = true;
                                      }
                                    });
                                    print('popopop');
                                    print(feedProviderRepo.feedDetail.post[0]);
                                    await repostProvider.repostFeedPost(
                                        postDetails.id,
                                        // postDetails.repost
                                        feedProviderRepo
                                            .feedDetail.post[0].repost);

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
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RepeatCommentPost(
                                                  //  postCommentListDetails: postDetails,
                                                  adminPicUser:
                                                      dashBoardProviderRepo
                                                          .userProfilePic
                                                  // postDetailsUserPic: postDetails.profilePic
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

  //The Below data is for expand the image of the LIKE MAIN ALL CATEGORY in the PROFILE
  _getCommentLikesTabWidget(iconData, text1, i, likesmaintab.Datum postDetails,
      feedProviderRepo, dashBoardProviderRepo, userReplyProfile) {
    return GestureDetector(
      onTap: () => {
        _handleOnLikeMainTabsTap(i, postDetails, feedProviderRepo,
            dashBoardProviderRepo, userReplyProfile)
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 0, left: 10, top: 5),
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
//            Icon(iconData,
//                color: i == 0
//                    ? postDetails.like.length > 0
//                        ? Colors.red
//                        : Colors.grey
//                    : Colors.grey),
            Container(
                margin: EdgeInsets.only(left: 08, right: 15),
                child: Row(
                  children: [
                    Text(
                      text1.toString(),
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  _handleOnLikeMainTabsTap(int i, likesmaintab.Datum postDetails,
      feedProviderRepo, dashBoardProviderRepo, userReplyProfile) {
    if (i == 0) {
      setState(() {
        if (favorite == true) {
          favorite = false;
        } else {
          favorite = true;
        }
      });
      feedProviderRepo.likeOrDislike(postDetails.id, postDetails.like);
    } else if (i == 1) {
      print("${postDetails.profilePic}");
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CommentForPost(
                  postId: postDetails.id,
                  post: postDetails.userName,
                  // profilePicUser: postDetails.postPhoto.length!=0 &&  postDetails.postPhoto[0].location !=null ? postDetails.postPhoto[0].location : '',
                  profilePicUser: userReplyProfile,
                  adminPicUser: dashBoardProviderRepo.userProfilePic,
                  postSecondaryName: postDetails.userName,
                  // profilepic: postDetails.postPhoto,
                )),
      );
      print("Comment");
    } else {
      _modalBottomSheetMenuLikeMaintabs(i, postDetails);
    }
  }

  void _modalBottomSheetMenuLikeMaintabs(
      int i, likesmaintab.Datum postDetails) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        context: context,
        builder: (builder) {
          return SingleChildScrollView(child: Consumer(
            builder: (context, watch, child) {
              final repostProvider = watch(feedProvider);
              final dashBoardProviderRepo = watch(dashboardProvider);
              final feedProviderRepo = watch(feedProvider);
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
                                      if (repost == true) {
                                        repost = false;
                                      } else {
                                        repost = true;
                                      }
                                    });
                                    print('popopop');
                                    print(feedProviderRepo.feedDetail.post[0]);
                                    await repostProvider.repostFeedPost(
                                        postDetails.id,
                                        // postDetails.repost
                                        feedProviderRepo
                                            .feedDetail.post[0].repost);

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
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RepeatCommentPost(
                                                  //  postCommentListDetails: postDetails,
                                                  adminPicUser:
                                                      dashBoardProviderRepo
                                                          .userProfilePic
                                                  // postDetailsUserPic: postDetails.profilePic
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

//The Below data is for expand the image of the LIKE SUB CATEGORY in the PROFILE
  _getCommentLikeSubTabWidget(iconData, text1, i, LikeSubTab postDetails,
      feedProviderRepo, dashBoardProviderRepo, userReplyProfile) {
    return GestureDetector(
      onTap: () => {
        _handleOnLikeSubTabsTap(i, postDetails, feedProviderRepo,
            dashBoardProviderRepo, userReplyProfile)
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 0, left: 10, top: 5),
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
//            Icon(iconData,
//                color: i == 0
//                    ? postDetails.like.length > 0
//                        ? Colors.red
//                        : Colors.grey
//                    : Colors.grey),
            Container(
                margin: EdgeInsets.only(left: 08, right: 15),
                child: Row(
                  children: [
                    Text(
                      text1.toString(),
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  _handleOnLikeSubTabsTap(int i, LikeSubTab postDetails, feedProviderRepo,
      dashBoardProviderRepo, userReplyProfile) {
    if (i == 0) {
      setState(() {
        if (favorite == true) {
          favorite = false;
        } else {
          favorite = true;
        }
      });
      feedProviderRepo.likeOrDislike(postDetails.id, postDetails.like);
    } else if (i == 1) {
      print("${postDetails.profilePic}");
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CommentForPost(
                  postId: postDetails.id,
                  post: postDetails.userName,
                  // profilePicUser: postDetails.postPhoto.length!=0 &&  postDetails.postPhoto[0].location !=null ? postDetails.postPhoto[0].location : '',
                  profilePicUser: userReplyProfile,
                  adminPicUser: dashBoardProviderRepo.userProfilePic,
                  postSecondaryName: postDetails.userName,
                  // profilepic: postDetails.postPhoto,
                )),
      );
      print("Comment");
    } else {
      _modalBottomSheetMenuLikeSubtabs(i, postDetails);
    }
  }

  void _modalBottomSheetMenuLikeSubtabs(int i, LikeSubTab postDetails) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        context: context,
        builder: (builder) {
          return SingleChildScrollView(child: Consumer(
            builder: (context, watch, child) {
              final repostProvider = watch(feedProvider);
              final dashBoardProviderRepo = watch(dashboardProvider);
              final feedProviderRepo = watch(feedProvider);
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
                                      if (repost == true) {
                                        repost = false;
                                      } else {
                                        repost = true;
                                      }
                                    });
                                    print('popopop');
                                    print(feedProviderRepo.feedDetail.post[0]);
                                    await repostProvider.repostFeedPost(
                                        postDetails.id,
                                        // postDetails.repost
                                        feedProviderRepo
                                            .feedDetail.post[0].repost);

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
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RepeatCommentPost(
                                                  //  postCommentListDetails: postDetails,
                                                  adminPicUser:
                                                      dashBoardProviderRepo
                                                          .userProfilePic
                                                  // postDetailsUserPic: postDetails.profilePic
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
