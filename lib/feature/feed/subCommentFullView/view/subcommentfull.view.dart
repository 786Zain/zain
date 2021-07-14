import 'package:async_loader/async_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/dashboard/deatailsPost.dart';
import 'package:farm_system/feature/farm_post/newVideoFullpage.dart';
import 'package:farm_system/feature/feed/comment/view/commentforpost.view.dart';
import 'package:farm_system/feature/feed/models/ModelBasedonPostId.dart';
import 'package:farm_system/feature/feed/repeatSubComment/view/repeatSubComment.view.dart';
import 'package:farm_system/feature/feed/subCommentFullView/model/nestedreplyview.modal.dart';
import 'package:farm_system/feature/feed/subCommentFullView/model/subcommentfullviewmodel.dart';
import 'package:farm_system/feature/feed/subCommentFullView/repeatInsideNestedComment/repeatInsideSubCommentNested.view.dart';
import 'package:farm_system/feature/feed/subCommentFullView/repeatSubComment/repeatInsideSubComment.view.dart';
import 'package:farm_system/feature/feed/subcommentPostReply/view/subcomment.view.dart';
import 'package:farm_system/feature/feed/view/fullpagepost.view.dart';
import 'package:farm_system/feature/feed/view/readmoretext.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:video_player/video_player.dart';

class SubCommentFullView extends StatefulWidget {
  final Comment userData;
  final String userReplyCommentId;
  final String userReplyName;
  final String userProfiePic;
  final DateTime userDateTime;
  final String userCaption;
  final String userMedia;
  final String forReply;
  final int userReplyCount;
  final List userLike;
  final int userNested;
  final int userCountrepost;
  final List userCommentCheck;

  const SubCommentFullView(
      {Key key,
      this.userData,
      this.userReplyCommentId,
      this.userReplyName,
      this.userProfiePic,
      this.userDateTime,
      this.userCaption,
      this.userMedia,
      this.forReply,
      this.userReplyCount,
      this.userLike,
      this.userNested,
      this.userCountrepost,
      this.userCommentCheck})
      : super(key: key);

  @override
  _SubCommentFullViewState createState() => _SubCommentFullViewState();
}

class _SubCommentFullViewState extends State<SubCommentFullView> {
  final _asyncKeyComment = GlobalKey<AsyncLoaderState>();
  final _asyncKeyCommentReply = GlobalKey<AsyncLoaderState>();

  String commentUpdate = 'SubComment Update';

  VideoPlayerController _controller;
  VoidCallback videoPlayerListener;


  var userId;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      userId = await StorageService.getUserId();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

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

  bool repostPostComment = false;
  bool repostSubComment = false;
  bool repostSubNewComment = false;

  var dataCheck = "Data Checks";

  @override
  Widget build(BuildContext context) {
    final _asyncLoader = Consumer(builder: (context, watch, child) {
      final subCommentProviderRepo = watch(subCommentFullPostViewProvider);
      final userDeatil = watch(subCommentFullPostViewProvider);
      return AsyncLoader(
          key: _asyncKeyComment,
          initState: () =>
              subCommentProviderRepo.getSubCommentView(widget.userData.id),
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
          padding: const EdgeInsets.only(top: 18.0),
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
                  Icons.arrow_back,
                  color: Colors.deepOrange,
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
    return widget.userReplyCommentId != null
        ? Column(
            children: [
              Consumer(builder: (context, watch, child) {
                final feedProviderRepo = watch(feedProvider);
                final subCommentProviderRepo =
                    watch(subCommentFullPostViewProvider);
                final dashBoardProviderRepo = watch(dashboardProvider);
                final nestedProviderRepo = watch(nestedProvider);

                var dt = new DateTime.now();
                var days = dt.difference(widget.userDateTime).inDays;
                if (widget.userMedia != null &&
                    imageFileTypes.indexOf(
                            getImageUrl(widget.userMedia).split('.').last) ==
                        -1) {
                }

                return Center(
                  child: Container(
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
                                  child: widget.userProfiePic == null
                                      ? Image.asset(dummyUser,
                                          fit: BoxFit.fill,
                                          height: 25,
                                          width: 25)
                                      : CachedNetworkImage(
                                          fit: BoxFit.fill,
                                          height: 52,
                                          width: 52,
                                          imageUrl: getImageUrl(
                                              widget.userProfiePic)),
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
                                        Expanded(
                                          child: Container(
                                            child: widget.userReplyName != "" &&
                                                    widget.userReplyName != null
                                                ? Text(
                                                    '${widget.userReplyName}',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                    ))
                                                : Text(" "),
                                          ),
                                          flex: 5,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(right: 4.0),
                                            child: Container(
                                                margin: EdgeInsets.only(
                                                    top: 0, left: 5),
                                                child: days < 7
                                                    ? Text(
                                                        getTime(widget
                                                            .userDateTime),
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Color(
                                                                0xff888888)))
                                                    : Text(DateFormat('dd-MMM')
                                                        .format(widget
                                                            .userDateTime))),
                                          ),
                                          flex: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 4.0),
                                    child: Visibility(
                                      visible: widget.userCaption != null,
                                      child: Container(
                                        alignment: Alignment.topLeft,
                                        child: ReadMoreText(
                                            widget.userCaption ?? '',
                                            style: TextStyle(
                                              fontSize: 15,
                                              letterSpacing: 0.5,
                                              color: Colors.white,
                                            )),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 0),
                                    child: widget.userMedia != null
                                        ? Container(
                                            height: 200,
                                            margin: EdgeInsets.only(top: 10),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              child: imageFileTypes.indexOf(
                                                          widget.userMedia
                                                              .split('.')
                                                              .last) !=
                                                      -1
                                                  ? CachedNetworkImage(
                                                      fit: BoxFit.fill,
                                                      height: 176,
                                                      width: 338,
                                                      imageUrl: getImageUrl(
                                                          widget.userMedia))
                                                  : _controller != null &&
                                                          _controller
                                                              .value.initialized
                                                      ? VideoWidget(
                                                          play: true,
                                                          url: widget.userMedia)
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
                                  // Padding(padding: EdgeInsets.only(left: 0),
                                  //   child: widget.userMedia.length !=null
                                  //       ? Container(
                                  //     height: 200,
                                  //     margin: EdgeInsets.only(top: 10),
                                  //     child: ClipRRect(
                                  //       borderRadius: BorderRadius.all(Radius.circular(20)),
                                  //       child:
                                  //       imageFileTypes.indexOf( widget.userMedia
                                  //           .split('.')
                                  //           .last)
                                  //
                                  //           != -1
                                  //           ? CachedNetworkImage(
                                  //           fit: BoxFit.fill,
                                  //           height: 176,
                                  //           width: 338,
                                  //           imageUrl: getImageUrl(widget.userMedia))
                                  //           : _controller != null &&
                                  //           _controller.value.initialized
                                  //           ?  VideoWidget(
                                  //           play: true,
                                  //           url:          widget.userMedia
                                  //       )
                                  //       // ChewieListItem(videoPlayerController:
                                  //       //   VideoPlayerController.network(
                                  //       //       feedProviderRepo
                                  //       //           .feedDetail.postPhoto[0].location),
                                  //       // )
                                  //       // VideoPlayer(_controller)
                                  //           : Container(),
                                  //     ),
                                  //   )
                                  //       : Container(),
                                  // ),
                                  // For newwww post
                                  widget.forReply == 'reply'
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                              left: 0,
                                              right: 0.0,
                                              top: 8.0,
                                              bottom: 8.0),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                // _getCommentReplyWidget(
                                                //     nestedProviderRepo
                                                //             .nestedComment[0]
                                                //             .like
                                                //             .contains(
                                                //                 dashBoardProviderRepo
                                                //                     .userId)
                                                //         ? Icons.favorite
                                                //         : Icons.favorite,
                                                //     nestedProviderRepo
                                                //         .nestedComment[0]
                                                //         .like
                                                //         .length
                                                //         .toString(),
                                                //     0,
                                                //     nestedProviderRepo
                                                //         .nestedComment[0],
                                                //     nestedProviderRepo,
                                                //     dashBoardProviderRepo
                                                //         .userProfilePic,
                                                //     nestedProviderRepo
                                                //         .nestedComment[0]
                                                //         .userPic),

                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                        onTap: () async {
                                                          final userId =
                                                              await StorageService
                                                                  .getUserId();
                                                          await nestedProviderRepo
                                                              .likeOrDislikeNestedComment(
                                                                  context,
                                                                  widget
                                                                      .userReplyCommentId,
                                                                  'fullView',
                                                                  widget
                                                                      .userLike);
                                                          await nestedProviderRepo
                                                              .getNestedReplyCommentView(
                                                                  widget
                                                                      .userReplyCommentId);
                                                          if (widget.userLike
                                                                  .contains(
                                                                      userId) ==
                                                              true) {
                                                            widget.userLike
                                                                .remove(userId);
                                                          } else {
                                                            widget.userLike
                                                                .add(userId);
                                                          }
                                                          // feedProviderRepo.likeOrDislike(
                                                          //     context,
                                                          //     widget.id,
                                                          //     feedProviderRepo
                                                          //         .likeCollection);
                                                          // print(feedProviderRepo
                                                          //     .feedList[0].like);
                                                          // feedProviderRepo
                                                          //     .getFeedUserInfo(widget.id);
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
                                                                  color: widget
                                                                              .userLike
                                                                              .length !=
                                                                          0
                                                                      ? Colors
                                                                          .red
                                                                      : Colors
                                                                          .grey),
                                                              Text(
                                                                "${widget.userLike.length}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            ])),
                                                  ],
                                                ),
                                                _getCommentReplyWidget(
                                                    //  commentIcon,
                                                    nestedProviderRepo
                                                                .nestedComment[
                                                                    0]
                                                                .commentCheck
                                                                .contains(
                                                                    userId) ==
                                                            true
                                                        ? commentRed
                                                        : commentIcon,
                                                    nestedProviderRepo
                                                        .nestedComment[0]
                                                        .replyCount,
                                                    1,
                                                    nestedProviderRepo
                                                        .nestedComment[0],
                                                    nestedProviderRepo,
                                                    dashBoardProviderRepo
                                                        .userProfilePic,
                                                    nestedProviderRepo
                                                        .nestedComment[0]
                                                        .userPic),
                                                Row(
                                                  children: [
                                                    _getCommentReplyWidget(
                                                        widget.userCountrepost >
                                                                0
                                                            ? repostColor
                                                            : repostNewImage,
                                                        widget.userCountrepost,
                                                        // nestedProviderRepo
                                                        //     .nestedComment[0].repost.length,
                                                        2,
                                                        nestedProviderRepo
                                                            .nestedComment[0],
                                                        nestedProviderRepo,
                                                        dashBoardProviderRepo
                                                            .userProfilePic,
                                                        nestedProviderRepo
                                                            .nestedComment[0]
                                                            .userPic)
                                                  ],
                                                ),
                                                // Row(
                                                //   children: [
                                                //     _getCommentReplyWidget(
                                                //         Icons.upload_file,
                                                //         "",
                                                //         2,
                                                //         nestedProviderRepo
                                                //             .nestedComment[0],
                                                //         nestedProviderRepo,
                                                //         dashBoardProviderRepo
                                                //             .userProfilePic,
                                                //         nestedProviderRepo
                                                //             .nestedComment[0]
                                                //             .userPic)
                                                //   ],
                                                // ),
                                              ]),
                                        )
                                      : Padding(
                                          padding: EdgeInsets.only(
                                              left: 0,
                                              right: 0.0,
                                              top: 8.0,
                                              bottom: 8.0),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                // _getCommentWidget(
                                                //     subCommentProviderRepo
                                                //             .subComment[0].like
                                                //             .contains(
                                                //                 dashBoardProviderRepo
                                                //                     .userId)
                                                //         ? Icons.favorite
                                                //         : Icons.favorite,
                                                //     subCommentProviderRepo
                                                //         .subComment[0]
                                                //         .like
                                                //         .length
                                                //         .toString(),
                                                //     0,
                                                //     subCommentProviderRepo
                                                //         .subComment[0],
                                                //     subCommentProviderRepo,
                                                //     dashBoardProviderRepo
                                                //         .userProfilePic,
                                                //     subCommentProviderRepo
                                                //         .subComment[0].userPic),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                        onTap: () async {
                                                          final userId =
                                                              await StorageService
                                                                  .getUserId();
                                                          await nestedProviderRepo
                                                              .likeOrDislikeNestedComment(
                                                                  context,
                                                                  widget
                                                                      .userReplyCommentId,
                                                                  'fullView',
                                                                  []);
                                                          await nestedProviderRepo
                                                              .getNestedReplyCommentView(
                                                                  widget
                                                                      .userReplyCommentId);
                                                          if (widget.userLike
                                                                  .contains(
                                                                      userId) ==
                                                              true) {
                                                            widget.userLike
                                                                .remove(userId);
                                                          } else {
                                                            widget.userLike
                                                                .add(userId);
                                                          }
                                                          // feedProviderRepo.likeOrDislike(
                                                          //     context,
                                                          //     widget.id,
                                                          //     feedProviderRepo
                                                          //         .likeCollection);
                                                          // print(feedProviderRepo
                                                          //     .feedList[0].like);
                                                          // feedProviderRepo
                                                          //     .getFeedUserInfo(widget.id);
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
                                                                  color: widget
                                                                              .userLike
                                                                              .length !=
                                                                          0
                                                                      ? Colors
                                                                          .red
                                                                      : Colors
                                                                          .grey),
                                                              Text(
                                                                "${widget.userLike.length}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            ])),
                                                  ],
                                                ),
                                                _getCommentNewOneWidget(
                                                    //commentIcon,
                                                    widget.userCommentCheck
                                                            .contains(userId)
                                                        ? commentRed
                                                        : commentIcon,
                                                    widget.userReplyCount !=
                                                            null
                                                        ? widget.userReplyCount
                                                        : 0,
                                                    // subCommentProviderRepo
                                                    //     .subComment[0].replyCount,
                                                    1,
                                                    subCommentProviderRepo
                                                        .subComment[0],
                                                    widget.userReplyCommentId,
                                                    widget.userProfiePic,
                                                    widget.userReplyName,
                                                    widget.userReplyName,
                                                    widget.userReplyName,
                                                    subCommentProviderRepo,
                                                    dashBoardProviderRepo
                                                        .userProfilePic,
                                                    subCommentProviderRepo
                                                        .subComment[0].userPic),
                                                Row(
                                                  children: [
                                                    _getCommentNewOneWidget(
                                                        subCommentProviderRepo
                                                                    .subComment[
                                                                        0]
                                                                    .repost
                                                                    .contains(
                                                                        userId) ==
                                                                true
                                                            ? repostColor
                                                            : repostNewImage,
                                                        subCommentProviderRepo
                                                            .subComment[0]
                                                            .repost
                                                            .length,
                                                        2,
                                                        subCommentProviderRepo
                                                            .subComment[0],
                                                        widget
                                                            .userReplyCommentId,
                                                        widget.userProfiePic,
                                                        widget.userReplyName,
                                                        widget.userReplyName,
                                                        widget.userReplyName,
                                                        subCommentProviderRepo,
                                                        dashBoardProviderRepo
                                                            .userProfilePic,
                                                        subCommentProviderRepo
                                                            .subComment[0]
                                                            .userPic)
                                                  ],
                                                ),
                                                // Row(
                                                //   children: [
                                                //     _getCommentWidget(
                                                //         Icons.upload_file,
                                                //         "",
                                                //         2,
                                                //         subCommentProviderRepo
                                                //             .subComment[0],
                                                //         subCommentProviderRepo,
                                                //         dashBoardProviderRepo
                                                //             .userProfilePic,
                                                //         subCommentProviderRepo
                                                //             .subComment[0]
                                                //             .userPic)
                                                //   ],
                                                // ),
                                              ]),
                                        )
                                ],
                              )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
              Consumer(builder: (context, watch, child) {
                final nestedProviderRepo = watch(nestedProvider);
                final dashBoardProviderRepo = watch(dashboardProvider);
                final userDeatil = watch(subCommentFullPostViewProvider);
                final subCommentProviderRepo =
                    watch(subCommentFullPostViewProvider);
                String forReplyData = 'reply';

                return AsyncLoader(
                  key: _asyncKeyCommentReply,
                  initState: () => nestedProviderRepo
                      .getNestedReplyCommentView(widget.userReplyCommentId),
                  renderLoad: () => SizedBox(),
                  renderError: ([err]) => Center(
                    child: Text("Error"),
                  ),
                  renderSuccess: ({data}) => Visibility(
                    visible: nestedProviderRepo.nestedComment != null,
                    child: InViewNotifierList(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        initialInViewIds: ['0'],
                        isInViewPortCondition: (double deltaTop,
                            double deltaBottom, double viewPortDimension) {
                          return deltaTop < (0.5 * viewPortDimension) &&
                              deltaBottom > (0.5 * viewPortDimension);
                        },
                        itemCount: nestedProviderRepo.nestedComment.length,
                        builder: (BuildContext context, int index) {
                          var dt = new DateTime.now();
                          var days = dt
                              .difference(nestedProviderRepo
                                  .nestedComment[index].createdAt)
                              .inDays;

                          return GestureDetector(
                            child: Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 4, left: 4, right: 4),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            child: nestedProviderRepo
                                                        .nestedComment[index]
                                                        .userPic ==
                                                    null
                                                ? Image.asset(dummyUser,
                                                    fit: BoxFit.fill,
                                                    height: 25,
                                                    width: 25)
                                                : CachedNetworkImage(
                                                    fit: BoxFit.fill,
                                                    height: 52,
                                                    width: 52,
                                                    imageUrl: getImageUrl(
                                                        nestedProviderRepo
                                                            .nestedComment[
                                                                index]
                                                            .userPic)),
                                          ),
                                        ),
                                        Expanded(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 4.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      child: nestedProviderRepo
                                                                      .nestedComment[
                                                                          index]
                                                                      .userName !=
                                                                  "" &&
                                                              nestedProviderRepo
                                                                      .nestedComment[
                                                                          index]
                                                                      .userName !=
                                                                  null
                                                          ? Text(
                                                              '${nestedProviderRepo.nestedComment[index].userName}',
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .white,
                                                              ))
                                                          : Text(" "),
                                                    ),
                                                    flex: 5,
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 4.0),
                                                      child: Container(
                                                          margin: EdgeInsets.only(
                                                              top: 0, left: 5),
                                                          child: days < 7
                                                              ? Text(
                                                                  getTime(nestedProviderRepo
                                                                      .nestedComment[
                                                                          index]
                                                                      .createdAt),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color: Color(
                                                                          0xff888888)))
                                                              : Text(DateFormat(
                                                                      'dd-MMM')
                                                                  .format(nestedProviderRepo.nestedComment[index].createdAt))),
                                                    ),
                                                    flex: 1,
                                                  ),
                                                  dashBoardProviderRepo
                                                              .userId ==
                                                          nestedProviderRepo
                                                              .nestedComment[
                                                                  index]
                                                              .userId
                                                      ? Expanded(
                                                          child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          4.0),
                                                              child: Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top: 0,
                                                                        left:
                                                                            5),
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () =>
                                                                      _modalBottomSheetNestedMenu(
                                                                    nestedProviderRepo
                                                                        .nestedComment[
                                                                            index]
                                                                        .id,
                                                                    nestedProviderRepo
                                                                            .nestedComment[
                                                                        index],
                                                                  ),
                                                                  child: Icon(
                                                                    Icons
                                                                        .more_vert,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              )),
                                                          flex: 1,
                                                        )
                                                      : Container(),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 0.0),
                                              child: Visibility(
                                                visible: nestedProviderRepo
                                                        .nestedComment[index]
                                                        .replyingUser1 !=
                                                    null,
                                                child: Container(
                                                  alignment: Alignment.topLeft,
                                                  child: RichText(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    text: TextSpan(
                                                        style:
                                                            DefaultTextStyle.of(
                                                                    context)
                                                                .style,
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                              text:
                                                                  "Replying to ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey)),
                                                          TextSpan(
                                                            text: nestedProviderRepo
                                                                .nestedComment[
                                                                    index]
                                                                .replyingUser1,
                                                            style: TextStyle(
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                        ]),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 4.0),
                                              child: Visibility(
                                                visible: nestedProviderRepo
                                                        .nestedComment[index]
                                                        .commentMessage !=
                                                    null,
                                                child: Container(
                                                  alignment: Alignment.topLeft,
                                                  child: ReadMoreText(
                                                      nestedProviderRepo
                                                              .nestedComment[
                                                                  index]
                                                              .commentMessage ??
                                                          '',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        letterSpacing: 0.5,
                                                        color: Colors.white,
                                                      )),
                                                ),
                                              ),
                                            ),
                                            //Image nestedComment

                                            Padding(
                                              padding: EdgeInsets.only(left: 0),
                                              child: nestedProviderRepo
                                                          .nestedComment[index]
                                                          .media !=
                                                      null
                                                  ? Container(
                                                      height: 200,
                                                      margin: EdgeInsets.only(
                                                          top: 10),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20)),
                                                        child: imageFileTypes.indexOf(
                                                                    nestedProviderRepo
                                                                        .nestedComment[
                                                                            index]
                                                                        .media
                                                                        .split(
                                                                            '.')
                                                                        .last) !=
                                                                -1
                                                            ? CachedNetworkImage(
                                                                fit:
                                                                    BoxFit.fill,
                                                                height: 176,
                                                                width: 338,
                                                                imageUrl: getImageUrl(
                                                                    nestedProviderRepo
                                                                        .nestedComment[
                                                                            index]
                                                                        .media))
                                                            : _controller !=
                                                                        null &&
                                                                    _controller
                                                                        .value
                                                                        .initialized
                                                                ? VideoWidget(
                                                                    play: true,
                                                                    url: nestedProviderRepo
                                                                        .nestedComment[index]
                                                                        .media)
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
                                                  children: [
                                                    // _getCommentReplyWidget(
                                                    //     nestedProviderRepo.nestedComment[index].like.contains(
                                                    //       dashBoardProviderRepo.userId)
                                                    //         ? Icons.favorite
                                                    //         : Icons.favorite,
                                                    //     nestedProviderRepo
                                                    //         .nestedComment[index].like.length.toString(),
                                                    //     0,
                                                    //     nestedProviderRepo.nestedComment[index],
                                                    //     nestedProviderRepo,
                                                    //     dashBoardProviderRepo.userProfilePic,
                                                    //     nestedProviderRepo.nestedComment[index].userPic
                                                    // ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        GestureDetector(
                                                            onTap: () async {
                                                              await nestedProviderRepo
                                                                  .likeOrDislikeNestedComment(
                                                                      context,
                                                                      nestedProviderRepo
                                                                          .nestedComment[
                                                                              index]
                                                                          .id,
                                                                      'listView',
                                                                      []);
                                                              await nestedProviderRepo
                                                                  .getNestedReplyCommentView(
                                                                      widget
                                                                          .userReplyCommentId);

                                                              // feedProviderRepo
                                                              //     .getFeedUserInfo(
                                                              //     feedProviderRepo.commentList[index].id);
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
                                                                      color: nestedProviderRepo.nestedComment[index].like.length != 0
                                                                          ? Colors
                                                                              .red
                                                                          : Colors
                                                                              .grey),
                                                                  Text(
                                                                    "${nestedProviderRepo.nestedComment[index].like.length}",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey,
                                                                        fontSize:
                                                                            15),
                                                                  ),
                                                                ])),
                                                      ],
                                                    ),
                                                    _getCommentReplyWidget(
                                                        // commentIcon,
                                                        nestedProviderRepo
                                                                    .nestedComment[
                                                                        0]
                                                                    .commentCheck
                                                                    .contains(
                                                                        userId) ==
                                                                true
                                                            ? commentRed
                                                            : commentIcon,
                                                        nestedProviderRepo
                                                            .nestedComment[0]
                                                            .replyCount,
                                                        1,
                                                        nestedProviderRepo
                                                                .nestedComment[
                                                            index],
                                                        nestedProviderRepo,
                                                        dashBoardProviderRepo
                                                            .userProfilePic,
                                                        nestedProviderRepo
                                                            .nestedComment[
                                                                index]
                                                            .userPic),
                                                    Row(
                                                      children: [
                                                        _getCommentReplyWidget(
                                                            // repostNewImage,
                                                            nestedProviderRepo
                                                                        .nestedComment[
                                                                            index]
                                                                        .repost
                                                                        .contains(
                                                                            userId) ==
                                                                    true
                                                                ? repostColor
                                                                : repostNewImage,
                                                            nestedProviderRepo
                                                                .nestedComment[
                                                                    index]
                                                                .repost
                                                                .length,
                                                            2,
                                                            nestedProviderRepo
                                                                    .nestedComment[
                                                                index],
                                                            nestedProviderRepo,
                                                            dashBoardProviderRepo
                                                                .userProfilePic,
                                                            nestedProviderRepo
                                                                .nestedComment[
                                                                    index]
                                                                .userPic)
                                                      ],
                                                    ),
                                                    // Row(
                                                    //   children: [
                                                    //     _getCommentReplyWidget(
                                                    //         Icons.upload_file,
                                                    //         "",
                                                    //         2,
                                                    //         nestedProviderRepo.nestedComment[index],
                                                    //         nestedProviderRepo,
                                                    //         dashBoardProviderRepo.userProfilePic,
                                                    //         nestedProviderRepo.nestedComment[index].userPic
                                                    //     )
                                                    //   ],
                                                    // ),
                                                  ]),
                                            )
                                          ],
                                        )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              userDeatil.setUserData(widget.userData);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SubCommentFullView(
                                            userData: widget.userData,
                                            userReplyCommentId:
                                                nestedProviderRepo
                                                    .nestedComment[index].id,
                                            userProfiePic: nestedProviderRepo
                                                .nestedComment[index].userPic,
                                            userReplyName: nestedProviderRepo
                                                .nestedComment[index].userName,
                                            userCaption: nestedProviderRepo
                                                .nestedComment[index]
                                                .commentMessage,
                                            userDateTime: nestedProviderRepo
                                                .nestedComment[index].createdAt,
                                            userMedia: nestedProviderRepo
                                                .nestedComment[index].media,
                                            forReply: forReplyData,
                                            userCountrepost: nestedProviderRepo
                                                .nestedComment[index]
                                                .repost
                                                .length,
                                            userReplyCount: nestedProviderRepo
                                                .nestedComment[index]
                                                .replyCount,
                                            userLike: nestedProviderRepo
                                                .nestedComment[index].like,
                                            userNested: index,
                                          )));
                            },
                          );
                        }),
                  ),
                );
              })
            ],
          )
        : Consumer(builder: (context, watch, child) {
            final feedProviderRepo = watch(feedProvider);
            final dashBoardProviderRepo = watch(dashboardProvider);

            var dt = new DateTime.now();
            var days = dt.difference(widget.userData.createdAt).inDays;
            if (widget.userData.media != null &&
                imageFileTypes.indexOf(
                        getImageUrl(widget.userData.media).split('.').last) ==
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
                                  child: widget.userData.userPic == null
                                      ? Image.asset(dummyUser,
                                          fit: BoxFit.fill,
                                          height: 25,
                                          width: 25)
                                      : CachedNetworkImage(
                                          fit: BoxFit.fill,
                                          height: 52,
                                          width: 52,
                                          imageUrl: getImageUrl(
                                              widget.userData.userPic)),
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
                                                '${widget.userData.userFullname}',
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        HexColor("#FFFFFF")))),
                                        SizedBox(width: 3),
                                        Expanded(
                                          child: Container(
                                              child: Text(
                                                  '@${widget.userData.userName.toString()}',
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: HexColor(
                                                          "#666666")))),
                                          flex: 4,
                                        ),
                                        Spacer(),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(right: 4.0),
                                            child: Container(
                                                margin: EdgeInsets.only(
                                                    top: 0, left: 5),
                                                child: days < 7
                                                    ? Text(
                                                        getTime(widget.userData
                                                            .createdAt),
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Color(
                                                                0xff888888)))
                                                    : Text(DateFormat('dd-MMM')
                                                        .format(widget.userData
                                                            .createdAt))),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 4.0),
                                    child: Visibility(
                                      visible: widget.userData.commentMessage !=
                                          null,
                                      child: Container(
                                        alignment: Alignment.topLeft,
                                        child: ReadMoreText(
                                            widget.userData.commentMessage ??
                                                '',
                                            style: TextStyle(
                                              fontSize: 15,
                                              letterSpacing: 0.5,
                                              color: Colors.white,
                                            )),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 0),
                                    child: widget.userData.media != null
                                        ? Container(
                                            height: 200,
                                            margin: EdgeInsets.only(top: 10),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              child: imageFileTypes.indexOf(
                                                          widget.userData.media
                                                              .split('.')
                                                              .last) !=
                                                      -1
                                                  ? CachedNetworkImage(
                                                      fit: BoxFit.fill,
                                                      height: 176,
                                                      width: 338,
                                                      imageUrl: getImageUrl(
                                                          widget
                                                              .userData.media))
                                                  : _controller != null &&
                                                          _controller
                                                              .value.initialized
                                                      ? VideoWidget(
                                                          play: true,
                                                          url: widget
                                                              .userData.media)
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
                                        // Row(
                                        //   children: [
                                        //     _getCommentPostWidget(
                                        //         Icons.favorite,
                                        //         feedProviderRepo.commentList[0].like.length
                                        //             .toString(),
                                        //         0,
                                        //         widget.userData,
                                        //         //feedProviderRepo.commentList[0],
                                        //         feedProviderRepo,
                                        //         dashBoardProviderRepo,
                                        //         feedProviderRepo.feedDetail.comments[0].userPic
                                        //     )
                                        //   ],
                                        // ),
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
                                                          widget.userData.id,
                                                          feedProviderRepo
                                                              .likeCollectionComment);
                                                  // feedProviderRepo.likeOrDislike(
                                                  //     context,
                                                  //     widget.id,
                                                  //     feedProviderRepo
                                                  //         .likeCollection);
                                                  // print(feedProviderRepo
                                                  //     .feedList[0].like);
                                                  // feedProviderRepo
                                                  //     .getFeedUserInfo(widget.id);
                                                },
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(Icons.favorite,
                                                          color: widget
                                                                      .userData
                                                                      .like
                                                                      .length !=
                                                                  0
                                                              ? Colors.red
                                                              : Colors.grey),
                                                      Text(
                                                        "${widget.userData.like.length}",
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
                                                // commentIcon,
                                                widget.userData.commentCheck
                                                        .contains(userId)
                                                    ? commentRed
                                                    : commentIcon,
                                                widget.userData.replyCount,
                                                1,
                                                widget.userData,
                                                // feedProviderRepo.commentList[0],
                                                feedProviderRepo,
                                                dashBoardProviderRepo
                                                    .userProfilePic,
                                                feedProviderRepo
                                                    .commentList[0].userPic)
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            _getCommentPostWidget(
                                                feedProviderRepo.commentList[0]
                                                            .repost
                                                            .contains(userId) ==
                                                        true
                                                    ? repostColor
                                                    : repostNewImage,
                                                feedProviderRepo.commentList[0]
                                                    .repost.length,
                                                2,
                                                widget.userData,
                                                //feedProviderRepo.commentList[0],
                                                feedProviderRepo,
                                                dashBoardProviderRepo
                                                    .userProfilePic,
                                                feedProviderRepo
                                                    .commentList[0].userPic)
                                          ],
                                        ),
                                        // Row(
                                        //   children: [
                                        //     _getCommentPostWidget(
                                        //         Icons.upload_file,
                                        //         "",
                                        //         2,
                                        //         feedProviderRepo.commentList[0],
                                        //         feedProviderRepo,
                                        //         dashBoardProviderRepo.userProfilePic,
                                        //         feedProviderRepo.commentList[0].userPic)
                                        //   ],
                                        // ),
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
                  Consumer(builder: (context, watch, child) {
                    final subCommentProviderRepo =
                        watch(subCommentFullPostViewProvider);
                    final dashBoardProviderRepo = watch(dashboardProvider);
                    final userDeatil = watch(subCommentFullPostViewProvider);

                    print("udate lengthhh");
                    print(subCommentProviderRepo.subComment.length);
                    print("khbdkh bhhbh");
                    return GestureDetector(
                      child: Visibility(
                          visible: subCommentProviderRepo.subComment != null,
                          child: InViewNotifierList(
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              initialInViewIds: ['0'],
                              isInViewPortCondition: (double deltaTop,
                                  double deltaBottom,
                                  double viewPortDimension) {
                                return deltaTop < (0.5 * viewPortDimension) &&
                                    deltaBottom > (0.5 * viewPortDimension);
                              },
                              itemCount:
                                  subCommentProviderRepo.subComment.length,
                              builder: (BuildContext context, int index) {
                                var dt = new DateTime.now();
                                var days = dt
                                    .difference(subCommentProviderRepo
                                        .subComment[index].createdAt)
                                    .inDays;

                                // print("comment media file");
                                // print(subCommentProviderRepo
                                //     .subComment[index].media);
                                if (subCommentProviderRepo
                                            .subComment[index].media !=
                                        null &&
                                    imageFileTypes.indexOf(getImageUrl(
                                                subCommentProviderRepo
                                                    .subComment[index].media[0])
                                            .split('.')
                                            .last) ==
                                        -1) {
                                }

                                return GestureDetector(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 4, left: 4, right: 4),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(25)),
                                                  child: subCommentProviderRepo
                                                              .subComment[index]
                                                              .userPic ==
                                                          null
                                                      ? Image.asset(dummyUser,
                                                          fit: BoxFit.fill,
                                                          height: 25,
                                                          width: 25)
                                                      : CachedNetworkImage(
                                                          fit: BoxFit.fill,
                                                          height: 52,
                                                          width: 52,
                                                          imageUrl: getImageUrl(
                                                              subCommentProviderRepo
                                                                  .subComment[
                                                                      index]
                                                                  .userPic)),
                                                ),
                                              ),
                                              Expanded(
                                                  child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 4.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            child: subCommentProviderRepo
                                                                            .subComment[
                                                                                index]
                                                                            .userName !=
                                                                        "" &&
                                                                    subCommentProviderRepo
                                                                            .subComment[
                                                                                index]
                                                                            .userName !=
                                                                        null
                                                                ? Text(
                                                                    '${subCommentProviderRepo.subComment[index].userName}',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .white,
                                                                    ))
                                                                : Text(" "),
                                                          ),
                                                          flex: 5,
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 4.0),
                                                            child: Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top: 0,
                                                                        left:
                                                                            5),
                                                                child: days < 7
                                                                    ? Text(getTime(subCommentProviderRepo.subComment[index].createdAt),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15,
                                                                            color: Color(
                                                                                0xff888888)))
                                                                    : Text(DateFormat('dd-MMM').format(subCommentProviderRepo
                                                                        .subComment[
                                                                            index]
                                                                        .createdAt))),
                                                          ),
                                                          flex: 1,
                                                        ),
                                                        dashBoardProviderRepo
                                                                    .userId ==
                                                                subCommentProviderRepo
                                                                    .subComment[
                                                                        index]
                                                                    .userId
                                                            ? Expanded(
                                                                child: Padding(
                                                                    padding: EdgeInsets.only(
                                                                        right:
                                                                            4.0),
                                                                    child:
                                                                        Container(
                                                                      margin: EdgeInsets.only(
                                                                          top:
                                                                              0,
                                                                          left:
                                                                              5),
                                                                      child:
                                                                          GestureDetector(
                                                                        onTap: () =>
                                                                            _modalBottomSheetMenu(
                                                                          subCommentProviderRepo
                                                                              .subComment[index]
                                                                              .id,
                                                                          subCommentProviderRepo
                                                                              .subComment[index],
                                                                        ),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .more_vert,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    )),
                                                                flex: 1,
                                                              )
                                                            : Container(),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 0.0),
                                                    child: Visibility(
                                                      visible:
                                                          subCommentProviderRepo
                                                                  .subComment[
                                                                      index]
                                                                  .replyingUser1 !=
                                                              null,
                                                      child: Container(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: RichText(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          text: TextSpan(
                                                              style: DefaultTextStyle
                                                                      .of(
                                                                          context)
                                                                  .style,
                                                              children: <
                                                                  TextSpan>[
                                                                TextSpan(
                                                                    text:
                                                                        "Replying to ",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey)),
                                                                TextSpan(
                                                                  text:
                                                                      '${subCommentProviderRepo.subComment[index].replyingUser1} and ${subCommentProviderRepo.subComment[index].replyingUser2}',
                                                                  style: TextStyle(
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .normal,
                                                                      color: Colors
                                                                          .red),
                                                                ),
                                                              ]),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 4.0),
                                                    child: Visibility(
                                                      visible:
                                                          subCommentProviderRepo
                                                                  .subComment[
                                                                      index]
                                                                  .commentMessage !=
                                                              null,
                                                      child: Container(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: ReadMoreText(
                                                            subCommentProviderRepo
                                                                    .subComment[
                                                                        index]
                                                                    .commentMessage ??
                                                                '',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              letterSpacing:
                                                                  0.5,
                                                              color:
                                                                  Colors.white,
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 0),
                                                    child:
                                                        subCommentProviderRepo
                                                                    .subComment[
                                                                        index]
                                                                    .media !=
                                                                null
                                                            ? Container(
                                                                height: 200,
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            10),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20)),
                                                                  child: imageFileTypes.indexOf(subCommentProviderRepo
                                                                              .subComment[
                                                                                  index]
                                                                              .media
                                                                              .split(
                                                                                  '.')
                                                                              .last) !=
                                                                          -1
                                                                      ? GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => FullPagePostView(filePaths: subCommentProviderRepo.subComment[index].media)));
                                                                          },
                                                                          child: CachedNetworkImage(
                                                                              fit: BoxFit.fill,
                                                                              height: 176,
                                                                              width: 338,
                                                                              imageUrl: getImageUrl(subCommentProviderRepo.subComment[index].media))
                                                                          //     OverflowBox(
                                                                          //   minWidth:
                                                                          //       0.0,
                                                                          //   minHeight:
                                                                          //       0.0,
                                                                          //   maxWidth:
                                                                          //       double.infinity,
                                                                          //   maxHeight:
                                                                          //       double.infinity,
                                                                          //   child:
                                                                          //       Hero(
                                                                          //     tag: 'd ${subCommentProviderRepo.subComment[index].media}',
                                                                          //     child: CachedNetworkImage(imageUrl: getImageUrl(subCommentProviderRepo.subComment[index].media)),
                                                                          //   ),
                                                                          // ),
                                                                          )
                                                                      : _controller != null && _controller.value.initialized
                                                                          ? Stack(
                                                                              children: [
                                                                                GestureDetector(
                                                                                  onTap: () {
                                                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlayerNew(filePaths: subCommentProviderRepo.subComment[index].media)));
                                                                                  },
                                                                                  child: LayoutBuilder(
                                                                                    builder: (BuildContext context, BoxConstraints constraints) {
                                                                                      return InViewNotifierWidget(
                                                                                        id: '$index',
                                                                                        builder: (BuildContext context, bool isInView, Widget child) {
                                                                                          return VideoWidget(
                                                                                              play: isInView,
                                                                                              url:
                                                                                                  //'https://sfo2.digitaloceanspaces.com/peoplepedia/1607424784883_sample-mp4-file.mp4'
                                                                                                  subCommentProviderRepo.subComment[index].media
                                                                                              // 'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4'

                                                                                              );
                                                                                        },
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                                Positioned(
                                                                                    top: 90,
                                                                                    left: 160,
                                                                                    child: ClipOval(
                                                                                      child: Material(
                                                                                        color: Colors.blue,
                                                                                        // button color
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
                                                                              ],
                                                                            )

                                                                          //Do Not delete this data below
                                                                          // VideoPlayer(_controller)
                                                                          : Container(),
                                                                ),
                                                              )
                                                            : Container(),
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
                                                        children: [
                                                          // _getCommentWidget(
                                                          //     subCommentProviderRepo
                                                          //             .subComment[
                                                          //                 index]
                                                          //             .like
                                                          //             .contains(
                                                          //                 dashBoardProviderRepo
                                                          //                     .userId)
                                                          //         ? Icons
                                                          //             .favorite
                                                          //         : Icons
                                                          //             .favorite,
                                                          //     subCommentProviderRepo
                                                          //         .subComment[
                                                          //             index]
                                                          //         .like
                                                          //         .length
                                                          //         .toString(),
                                                          //     0,
                                                          //     subCommentProviderRepo
                                                          //             .subComment[
                                                          //         index],
                                                          //     subCommentProviderRepo,
                                                          //     dashBoardProviderRepo
                                                          //         .userProfilePic,
                                                          //     subCommentProviderRepo
                                                          //         .subComment[
                                                          //             index]
                                                          //         .userPic),
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
                                                                    subCommentProviderRepo.likeOrDislikeSubComment(
                                                                        context,
                                                                        subCommentProviderRepo
                                                                            .subComment[
                                                                                index]
                                                                            .id,
                                                                        widget
                                                                            .userReplyCommentId);

                                                                    // feedProviderRepo
                                                                    //     .getFeedUserInfo(
                                                                    //     feedProviderRepo.commentList[index].id);
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
                                                                            color: subCommentProviderRepo.subComment[index].like.length != 0
                                                                                ? Colors.red
                                                                                : Colors.grey),
                                                                        Text(
                                                                          "${subCommentProviderRepo.subComment[index].like.length}",
                                                                          style: TextStyle(
                                                                              color: Colors.grey,
                                                                              fontSize: 15),
                                                                        ),
                                                                      ])),
                                                            ],
                                                          ),
                                                          _getCommentWidget(
                                                              // commentIcon,
                                                              subCommentProviderRepo
                                                                          .subComment[
                                                                              index]
                                                                          .commentCheck
                                                                          .contains(
                                                                              userId) ==
                                                                      true
                                                                  ? commentRed
                                                                  : commentIcon,
                                                              subCommentProviderRepo
                                                                  .subComment[
                                                                      index]
                                                                  .replyCount,
                                                              1,
                                                              subCommentProviderRepo
                                                                      .subComment[
                                                                  index],
                                                              subCommentProviderRepo,
                                                              dashBoardProviderRepo
                                                                  .userProfilePic,
                                                              subCommentProviderRepo
                                                                  .subComment[
                                                                      index]
                                                                  .userPic),
                                                          Row(
                                                            children: [
                                                              _getCommentWidget(
                                                                  subCommentProviderRepo.subComment[index].repost.contains(
                                                                              userId) ==
                                                                          true
                                                                      ? repostColor
                                                                      : repostNewImage,
                                                                  subCommentProviderRepo
                                                                      .subComment[
                                                                          index]
                                                                      .repost
                                                                      .length,
                                                                  2,
                                                                  subCommentProviderRepo
                                                                          .subComment[
                                                                      index],
                                                                  subCommentProviderRepo,
                                                                  dashBoardProviderRepo
                                                                      .userProfilePic,
                                                                  subCommentProviderRepo
                                                                      .subComment[
                                                                          index]
                                                                      .userPic)
                                                            ],
                                                          ),
                                                          // Row(
                                                          //   children: [
                                                          //     _getCommentWidget(
                                                          //         Icons.upload_file,
                                                          //         "",
                                                          //         2,
                                                          //         subCommentProviderRepo
                                                          //                 .subComment[
                                                          //             index],
                                                          //         subCommentProviderRepo,
                                                          //         dashBoardProviderRepo
                                                          //             .userProfilePic,
                                                          //         subCommentProviderRepo
                                                          //             .subComment[
                                                          //                 index]
                                                          //             .userPic)
                                                          //   ],
                                                          // ),
                                                        ]),
                                                  )
                                                ],
                                              )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    userDeatil.setUserData(widget.userData);
                                    // print("id-------------------");
                                    // print(subCommentProviderRepo
                                    //     .subComment[index].id);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SubCommentFullView(
                                                  userData: widget.userData,
                                                  userReplyCommentId:
                                                      subCommentProviderRepo
                                                          .subComment[index].id,
                                                  userReplyName:
                                                      subCommentProviderRepo
                                                          .subComment[index]
                                                          .userName,
                                                  userProfiePic:
                                                      subCommentProviderRepo
                                                          .subComment[index]
                                                          .userPic,
                                                  userDateTime:
                                                      subCommentProviderRepo
                                                          .subComment[index]
                                                          .createdAt,
                                                  userCaption:
                                                      subCommentProviderRepo
                                                          .subComment[index]
                                                          .commentMessage,
                                                  userMedia:
                                                      subCommentProviderRepo
                                                          .subComment[index]
                                                          .media,
                                                  userReplyCount:
                                                      subCommentProviderRepo
                                                          .subComment[index]
                                                          .replyCount,
                                                  userLike:
                                                      subCommentProviderRepo
                                                          .subComment[index]
                                                          .like,
                                                  userCommentCheck:
                                                      subCommentProviderRepo
                                                          .subComment[index]
                                                          .commentCheck,
                                                )));
                                  },
                                );
                              })),
                      onTap: () {},
                    );
                  }),
                ],
              ),
            );
          });
  }

  //Nested
  void _modalBottomSheetNestedMenu(String id, DatumModel nestedComment) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        context: context,
        builder: (builder) {
          return SingleChildScrollView(child: Consumer(
            builder: (context, watch, child) {
              final deletCommentRepo = watch(deleteCommentProvider);
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
                                  onTap: () {
                                    // print('tap on delete');

                                    deletCommentRepo.deletePostComment(id);
                                  },
                                  child: Text(
                                    "Delete",
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
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SubCommentPostReply(
                                                commentUpdate: commentUpdate,
                                                parentId: nestedComment.id,
                                                //   postId: subComment.id,
                                                textTyped: nestedComment
                                                    .commentMessage,
                                                userProfile:
                                                    nestedComment.userPic,
                                                replyingName:
                                                    nestedComment.replyingUser1,

                                                //   userNamePost: subComment.replyingUser1,
                                                //replyingName: postDetails.userName
                                                // profilepic: postDetails.postPhoto,
                                              )),
                                    );
                                  },
                                  child: Text(
                                    "Edit",
                                    style: TextStyle(
                                        fontSize: 15,
                                        // color: HexColor("666666"),
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            ),
                          ]),
                    ),
                  ]));
            },
          ));
        });
  }

  //Delete And Edit

  void _modalBottomSheetMenu(String id, Datum subComment) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        context: context,
        builder: (builder) {
          return SingleChildScrollView(child: Consumer(
            builder: (context, watch, child) {
              final deletCommentRepo = watch(deleteCommentProvider);
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
                                  onTap: () {
                                    print('tap on delete');

                                    deletCommentRepo.deletePostComment(id);
                                  },
                                  child: Text(
                                    "Delete",
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
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SubCommentPostReply(
                                                commentUpdate: commentUpdate,
                                                parentId: subComment.id,
                                                //   postId: subComment.id,
                                                textTyped:
                                                    subComment.commentMessage,
                                                userProfile: subComment.userPic,
                                                replyingName:
                                                    subComment.replyingUser1,
                                                userMedia: subComment.media,

                                                //   userNamePost: subComment.replyingUser1,
                                                //replyingName: postDetails.userName
                                                // profilepic: postDetails.postPhoto,
                                              )),
                                    );
                                  },
                                  child: Text(
                                    "Edit",
                                    style: TextStyle(
                                        fontSize: 15,
                                        // color: HexColor("666666"),
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            ),
                          ]),
                    ),
                  ]));
            },
          ));
        });
  }

  //for Post Reply

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

  //Repeat and Repost For Post in Nested Comment
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

  //For Reply
  _getCommentReplyWidget(iconData, text1, i, DatumModel postDetails,
      feedProviderRepo, dashBoardProviderRepo, userReplyProfile) {
    return GestureDetector(
      onTap: () {
        // print("Sub Comment Comment");
        // print(postDetails.id);

        _handleReplyOnTap(i, postDetails, feedProviderRepo,
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

  _handleReplyOnTap(int i, DatumModel postDetails, feedProviderRepo,
      String profilePic, userReplyProfile) {
    if (i == 0) {
      print("like");
    } else if (i == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SubCommentPostReply(
                  parentId: postDetails.id,
                  parentUserId: postDetails.userId,
                  grandParentId: postDetails.parentId,
                  replying: postDetails.replyingUser2,
                  commentPicUser: postDetails.userPic,
                  userProfile: profilePic,
                  replyingSecondaryName: postDetails.userName,
                  replyingUserName: postDetails.userFullname,
                  // profilepic: postDetails.postPhoto,
                )),
      );
    } else {
      print("Share");
      _modalBottomInsideRepeatForSubCommentInNested(i, postDetails);
    }
  }

  void _modalBottomInsideRepeatForSubCommentInNested(
      int i, DatumModel postDetails) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        context: context,
        builder: (builder) {
          return SingleChildScrollView(child: Consumer(
            builder: (context, watch, child) {
              final repostProvider = watch(feedProvider);
              final nestedProviderRepo = watch(nestedProvider);
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
                                      if (repostSubComment == true) {
                                        repostSubComment = false;
                                      } else {
                                        repostSubComment = true;
                                      }
                                    });

                                    // await  repostProvider.repostSubCommentPost(postDetails.id, postDetails.repost);

                                    await nestedProviderRepo
                                        .repostNestedLoopCommentPost(
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
                                          builder: (context) =>
                                              RepeatInsideSubCommentNested(
                                                insideSubCommentNestedDetails:
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

  _getCommentWidget(iconData, text1, i, Datum postDetails, feedProviderRepo,
      dashBoardProviderRepo, userReplyProfile) {
    return GestureDetector(
      onTap: () {
        // print("Sub Comment Comment");
        // print(postDetails.id);

        _handleOnTap(i, postDetails, feedProviderRepo, dashBoardProviderRepo,
            userReplyProfile);
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

  _handleOnTap(int i, Datum postDetails, feedProviderRepo, String profilePic,
      userReplyProfile) {
    if (i == 0) {
      print("like");
    } else if (i == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SubCommentPostReply(
                  parentId: postDetails.id,
                  parentUserId: postDetails.userId,
                  grandParentId: postDetails.parentId,
                  replying: postDetails.replyingUser2,
                  commentPicUser: postDetails.userPic,
                  userProfile: profilePic,
                  replyingSecondaryName: postDetails.userName,
                  replyingUserName: postDetails.userFullname,
                  dataCheck: dataCheck,

                  // profilepic: postDetails.postPhoto,
                )),
      );
    } else {
      print("Share");
      _modalBottomRepeatForSubCommentInNested(i, postDetails);
    }
  }

  //Repeat and Repost For SubComment in Nested Comment
  void _modalBottomRepeatForSubCommentInNested(int i, Datum postDetails) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        context: context,
        builder: (builder) {
          return SingleChildScrollView(child: Consumer(
            builder: (context, watch, child) {
              final repostProvider = watch(feedProvider);
              final subCommentProviderRepo =
                  watch(subCommentFullPostViewProvider);
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
                                      if (repostSubNewComment == true) {
                                        repostSubNewComment = false;
                                      } else {
                                        repostSubNewComment = true;
                                      }
                                    });

                                    // await  repostProvider.repostSubCommentPost(postDetails.id, postDetails.repost);
                                    await subCommentProviderRepo
                                        .repostNestedCommentPost(
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
                                          builder: (context) =>
                                              RepeatInsideSubComment(
                                                insideSubCommentPostDetails:
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

  //New one
  //New For Post
  _getCommentNewOneWidget(
      iconData,
      text1,
      i,
      Datum postDetails,
      postDetailss,
      userpic,
      onename,
      twoname,
      threename,
      feedProviderRepo,
      dashBoardProviderRepo,
      userReplyProfile) {
    return GestureDetector(
      onTap: () {
        // print("Sub Comment Comment");
        // print(postDetails.id);

        _handleOnNewOneTap(
            i,
            postDetails,
            postDetailss,
            userpic,
            onename,
            twoname,
            threename,
            feedProviderRepo,
            dashBoardProviderRepo,
            userReplyProfile);
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

  _handleOnNewOneTap(
      int i,
      Datum postDetails,
      postDetailss,
      userpic,
      onename,
      twoname,
      threename,
      feedProviderRepo,
      String profilePic,
      userReplyProfile) {
    if (i == 0) {
      print("like");
    } else if (i == 1) {
      print("dsfjkndkjfbkjbkdbfbkdbkfbkdb");
      print(postDetails);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SubCommentPostReply(
                  parentId: postDetailss,
                  parentUserId: postDetails.userId,
                  grandParentId: postDetails.parentId,
                  replying: onename,
                  commentPicUser: userpic,
                  userProfile: profilePic,
                  replyingSecondaryName: twoname,
                  replyingUserName: threename,
                  dataCheck: dataCheck,

                  // profilepic: postDetails.postPhoto,
                )),
      );
    } else {
      print("Share");
      _modalBottomNewOne(i, postDetails);
    }
  }

  //Repeat and Repost For SubComment in Nested Comment
  void _modalBottomNewOne(int i, postDetails) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        context: context,
        builder: (builder) {
          return SingleChildScrollView(child: Consumer(
            builder: (context, watch, child) {
              final repostProvider = watch(feedProvider);
              final subCommentProviderRepo =
                  watch(subCommentFullPostViewProvider);
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
                                      if (repostSubNewComment == true) {
                                        repostSubNewComment = false;
                                      } else {
                                        repostSubNewComment = true;
                                      }
                                    });

                                    // await  repostProvider.repostSubCommentPost(postDetails.id, postDetails.repost);
                                    await subCommentProviderRepo
                                        .repostNestedCommentPost(
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
                                          builder: (context) =>
                                              RepeatInsideSubComment(
                                                insideSubCommentPostDetails:
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
