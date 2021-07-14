import 'package:async_loader/async_loader.dart';
import 'package:farm_system/feature/profile_user/view/profiletab.dart';
import 'package:farm_system/screen/Discovery/all_element.dart';
import 'package:farm_system/utils.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:video_player/video_player.dart';
import 'package:farm_system/feature/feed/subCommentFullView/view/subcommentfull.view.dart';
import 'package:farm_system/feature/feed/subcommentPostReply/view/subcomment.view.dart';
import 'package:farm_system/feature/feed/view/fullpagepost.view.dart';
import 'package:farm_system/feature/feed/view/readmoretext.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/feature/feed/comment/view/commentforpost.view.dart';
import 'package:farm_system/feature/feed/repeat/view/repeatComment.view.dart';
import 'package:farm_system/feature/feed/repeatSubComment/view/repeatSubComment.view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/farm_post/RepeatDetail/modal/repeatFullView.modal.dart';

import '../../newVideoFullpage.dart';

class RepeatPostFullView extends StatefulWidget {
  final String id;

  const RepeatPostFullView({Key key, this.id}) : super(key: key);

  @override
  _RepeatPostFullViewState createState() => _RepeatPostFullViewState();
}

class _RepeatPostFullViewState extends State<RepeatPostFullView> {
  final _asyncKeyRepeat = GlobalKey<AsyncLoaderState>();
  bool favorite = false;
  VideoPlayerController _controller;
  VoidCallback videoPlayerListener;

  // void getVideoFile(fileUrl) async {
  //   try {
  //     final VideoPlayerController vcontroller =
  //         VideoPlayerController.network(fileUrl);
  //     videoPlayerListener = () {
  //       if (_controller != null && _controller.value.size != null) {
  //         if (mounted) setState(() {});
  //         _controller.removeListener(videoPlayerListener);
  //       }
  //     };
  //     vcontroller.addListener(videoPlayerListener);
  //     await vcontroller.setLooping(false);
  //     await vcontroller.initialize();
  //     //await _controller?.dispose();
  //     if (mounted) {
  //       setState(() {
  //         _controller = vcontroller;
  //       });
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

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

  String commentUpdate = 'Post Update';
  bool repost = false;
  bool repostSubComment = false;

  @override
  Widget build(BuildContext context) {
    final _asyncLoader = Consumer(builder: (context, watch, child) {
      final repeatProviderRepo = watch(repeatPostProvider);
      return AsyncLoader(
          key: _asyncKeyRepeat,
          initState: () =>
              repeatProviderRepo.repeatPostFullView(context, widget.id),
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
        title: Container(
            height: 99,
            child: SvgPicture.asset(newLogoFarm,
                height: 120, width: 120, fit: BoxFit.scaleDown)),
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
    return SingleChildScrollView(
      child: Column(
        children: [
          Consumer(
            builder: (context, watch, child) {
              final feedProviderRepo = watch(feedProvider);
              final dashBoardProviderRepo = watch(dashboardProvider);
              final repeatProviderRepo = watch(repeatPostProvider);
              // var dt = new DateTime.now();
              // var days= dt.difference(feedProviderRepo.feedDetail.post[0].createdAt).inDays;
              // if (feedProviderRepo.feedDetail.post[0].postPhoto.length > 0  &&
              //     imageFileTypes.indexOf(getImageUrl(feedProviderRepo.feedDetail.post[0].postPhoto[0].location).split('.').last)  == -1 )
              // {
              //   getVideoFile(
              //       getImageUrl(feedProviderRepo.feedDetail.post[0].postPhoto[0].location));
              // }

              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: repeatProviderRepo.postsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var dt = new DateTime.now();
                    var days = dt
                        .difference(
                            repeatProviderRepo.postsList[index].createdAt)
                        .inDays;

                    if (repeatProviderRepo.postsList[index].postPhoto.length >
                            0 &&
                        imageFileTypes.indexOf(getImageUrl(repeatProviderRepo
                                    .postsList[index].postPhoto[0].location)
                                .split('.')
                                .last) ==
                            -1) {
                      // getVideoFile(getImageUrl(
                      //     repeatProviderRepo.postsList[index].postPhoto[0]));
                    }

                    return GestureDetector(
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
                                    child: InkWell(
                                      onTap: (){
                                        navigationToScreen(
                                            context,
                                            ProfileTab(
                                                userId: repeatProviderRepo.postsList[index].profileId),
                                            false);
                                      },
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(25)),
                                        child: repeatProviderRepo.postsList[index]
                                                    .profilePic ==
                                                null
                                            ? Image.asset(dummyUser,
                                                fit: BoxFit.cover,
                                                height: 25,
                                                width: 25)
                                            : CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                height: 52,
                                                width: 52,
                                                imageUrl: getImageUrl(
                                                    repeatProviderRepo
                                                        .postsList[index]
                                                        .profilePic)),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 4.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                    child: Container(
                                                      child: repeatProviderRepo
                                                                      .postsList[
                                                                          index]
                                                                      .name !=
                                                                  "" &&
                                                              repeatProviderRepo
                                                                      .postsList[
                                                                          index]
                                                                      .name !=
                                                                  null
                                                          ? Text(
                                                              Utils.getCapitalizeName(
                                                                  '${repeatProviderRepo.postsList[index].name}'),
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white))
                                                          : Text(" "),
                                                    ),
                                                    onTap: (){
                                                      navigationToScreen(
                                                          context,
                                                          ProfileTab(
                                                              userId: repeatProviderRepo.postsList[index].profileId),
                                                          false);
                                                    },
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 4.0),
                                                    child: InkWell(
                                                      child: Container(
                                                        child: repeatProviderRepo
                                                                        .postsList[
                                                                            index]
                                                                        .userName !=
                                                                    "" &&
                                                                repeatProviderRepo
                                                                        .postsList[
                                                                            index]
                                                                        .userName !=
                                                                    null
                                                            ? Text(
                                                                '@${repeatProviderRepo.postsList[index].userName}',
                                                                style: GoogleFonts.montserrat(
                                                                    fontSize: 13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Color(
                                                                        0xff666666)))
                                                            : Text(" "),
                                                      ),
                                                      onTap: (){
                                                        navigationToScreen(
                                                            context,
                                                            ProfileTab(
                                                                userId: repeatProviderRepo.postsList[index].profileId),
                                                            false);
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              flex: 5,
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 4.0),
                                              child: Container(
                                                  margin: EdgeInsets.only(
                                                      top: 0, left: 5),
                                                  child: days < 7
                                                      ? Text(getTime(repeatProviderRepo.postsList[index].createdAt),
                                                          style: GoogleFonts.montserrat(
                                                              fontSize: 9,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Color(
                                                                  0xff888888)))
                                                      : Text(DateFormat(
                                                              'dd-MMM')
                                                          .format(repeatProviderRepo
                                                              .postsList[index]
                                                              .createdAt),
                                                      style: GoogleFonts.montserrat(
                                                          fontSize: 9,
                                                          fontWeight:
                                                          FontWeight
                                                              .normal,
                                                          color: Color(
                                                              0xff888888))
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 4.0),
                                        child: Visibility(
                                          visible: repeatProviderRepo
                                                  .postsList[index].caption !=
                                              null,
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            child: ReadMoreText(
                                                repeatProviderRepo
                                                        .postsList[index]
                                                        .caption ??
                                                    '',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  letterSpacing: 0.5,
                                                  color: Colors.white,
                                                )),
                                          ),
                                        ),
                                      ),
                                      //-------------------------------------------------------------------------------------------------------------------------------------------

                                      Padding(
                                        padding: EdgeInsets.only(left: 0),
                                        child: repeatProviderRepo
                                                    .postsList[index]
                                                    .postPhoto
                                                    .length >
                                                0
                                            ? repeatProviderRepo.postsList[index].textFeed == false ?
                                        GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            FullPagePostView(
                                                          filePaths:
                                                              repeatProviderRepo
                                                                  .postsList[
                                                                      index]
                                                                  .postPhoto[0].location,
                                                          postData:
                                                              feedProviderRepo
                                                                      .feedList[
                                                                  index],
                                                        ),
                                                      ));
                                                },
                                                child: Container(
                                                  height: 200,
                                                  margin:
                                                      EdgeInsets.only(top: 10),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                    child: imageFileTypes.indexOf(
                                                                repeatProviderRepo
                                                                    .postsList[
                                                                        index]
                                                                    .postPhoto[
                                                                        0].location
                                                                    .split('.')
                                                                    .last) !=
                                                            -1
                                                        ? CachedNetworkImage(
                                                            fit: BoxFit.cover,
                                                            height: 176,
                                                            width: 338,
                                                            imageUrl: getImageUrl(
                                                                repeatProviderRepo
                                                                    .postsList[
                                                                        index]
                                                                    .postPhoto[0].location))
                                                        : Stack(
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              VideoPlayerNew(filePaths: repeatProviderRepo.postsList[index].postPhoto[0].location)));
                                                                },
                                                                child:
                                                                    LayoutBuilder(
                                                                  builder: (BuildContext
                                                                          context,
                                                                      BoxConstraints
                                                                          constraints) {
                                                                    return Container(
                                                                      height:
                                                                          450,
                                                                      width:
                                                                          320,
                                                                      child:
                                                                          OverflowBox(
                                                                        minWidth:
                                                                            320,
                                                                        minHeight:
                                                                            200,
                                                                        maxHeight:
                                                                            400,
                                                                        maxWidth:
                                                                            320,
                                                                        child: CachedNetworkImage(
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            imageUrl: getImageUrl(repeatProviderRepo.postsList[index].postPhoto[0].thumbnailUrl
                                                                            )),
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                              Positioned(
                                                                  top: 80,
                                                                  left: 135,
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => VideoPlayerNew(filePaths: repeatProviderRepo.postsList[index].postPhoto[0].location)));
                                                                    },
                                                                    child:
                                                                        ClipOval(
                                                                      child:
                                                                          Material(
                                                                        color: Colors
                                                                            .blue,
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
                                                                    ),
                                                                  )),
                                                            ],
                                                          ),
                                                  ),
                                                ),
                                              )
                                            : Container() : Container()
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
                                            _getCommentPostWidget(
                                                repeatProviderRepo
                                                        .postsList[index].like
                                                        .contains(
                                                            dashBoardProviderRepo
                                                                .userId)
                                                    ? Icons.favorite
                                                    : Icons.favorite,
                                                repeatProviderRepo
                                                    .postsList[index]
                                                    .like
                                                    .length
                                                    .toString(),
                                                0,
                                                repeatProviderRepo
                                                    .postsList[index],
                                                repeatProviderRepo,
                                                dashBoardProviderRepo,
                                                repeatProviderRepo
                                                    .postsList[index]
                                                    .profilePic),
                                            _getCommentPostWidget(
                                                commentIcon,
                                                repeatProviderRepo
                                                    .postsList[index]
                                                    .commentCount,
                                                1,
                                                repeatProviderRepo
                                                    .postsList[index],
                                                repeatProviderRepo,
                                                dashBoardProviderRepo,
                                                repeatProviderRepo
                                                    .postsList[index]
                                                    .profilePic),
                                            _getCommentPostWidget(
                                                repostNewImage,
                                                repeatProviderRepo
                                                    .postsList[index]
                                                    .repost
                                                    .length,
                                                2,
                                                repeatProviderRepo
                                                    .postsList[index],
                                                repeatProviderRepo,
                                                dashBoardProviderRepo,
                                                repeatProviderRepo
                                                    .postsList[index]
                                                    .profilePic),
                                            // _getCommentPostWidget(
                                            //     Icons.upload_file,
                                            //     "",
                                            //     2,
                                            //     repeatProviderRepo
                                            //         .postsList[index],
                                            //     repeatProviderRepo,
                                            //     dashBoardProviderRepo,
                                            //     repeatProviderRepo
                                            //         .postsList[index]
                                            //         .profilePic),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
          ),
          Consumer(builder: (context, watch, child) {
            // final feedProviderRepo = watch(feedProvider);
            final repeatProviderRepo = watch(repeatPostProvider);
            final dashBoardProviderRepo = watch(dashboardProvider);
            return Visibility(
                visible: repeatProviderRepo.commentList != null,
                child: InViewNotifierList(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    initialInViewIds: ['0'],
                    isInViewPortCondition: (double deltaTop, double deltaBottom,
                        double viewPortDimension) {
                      return deltaTop < (0.5 * viewPortDimension) &&
                          deltaBottom > (0.5 * viewPortDimension);
                    },
                    itemCount: repeatProviderRepo.commentList.length,
                    builder: (BuildContext context, int index) {
                      var dt = new DateTime.now();
                      var days = dt
                          .difference(
                              repeatProviderRepo.commentList[index].createdAt)
                          .inDays;

                      // print(repeatProviderRepo.commentList[index].media);
                      // if (repeatProviderRepo.commentList[index].media !=null &&
                      //
                      //     imageFileTypes.indexOf(
                      //         getImageUrl(
                      //             feedProviderRepo
                      //                 .commentList[index].media[0])
                      //             .split('.')
                      //             .last
                      //     )  == -1
                      // ) {
                      //   getVideoFile(getImageUrl(feedProviderRepo
                      //       .commentList[index].media));
                      // }
                      //
                      // print("user id");
                      // print( dashBoardProviderRepo.userName);
                      //
                      // print("comment List id");
                      // print (feedProviderRepo.feedDetail.post[0].id);
                      // print (feedProviderRepo.commentList[index].userName);
                      if (dashBoardProviderRepo.userId ==
                          repeatProviderRepo.commentList[index].userId) {
                        print("find ");
                      } else {
                        print("not find");
                      }

                      return GestureDetector(
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 4, left: 4, right: 4),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25)),
                                        child: repeatProviderRepo
                                                    .commentList[index]
                                                    .userPic ==
                                                null
                                            ? Image.asset(dummyUser,
                                                fit: BoxFit.cover,
                                                height: 25,
                                                width: 25)
                                            : CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                height: 52,
                                                width: 52,
                                                imageUrl: getImageUrl(
                                                    repeatProviderRepo
                                                        .commentList[index]
                                                        .userPic)),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(top: 4.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Expanded(
                                                  child: Container(
                                                    child: repeatProviderRepo
                                                                    .commentList[
                                                                        index]
                                                                    .userName !=
                                                                "" &&
                                                            repeatProviderRepo
                                                                    .commentList[
                                                                        index]
                                                                    .userName !=
                                                                null
                                                        ? Text(
                                                            '${repeatProviderRepo.commentList[index].userName}',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.white,
                                                            ))
                                                        : Text(" "),

                                                    //     RichText(
                                                    //   text: TextSpan(
                                                    //       children: [
                                                    //         TextSpan(text:"dfknkdbkhfb",style: TextStyle(fontSize: 16.0, color: Colors.grey))
                                                    //       ]
                                                    //   ),overflow: TextOverflow.ellipsis,
                                                    // )
                                                  ),
                                                  flex: 5,
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 4.0),
                                                    child: Container(
                                                        margin: EdgeInsets.only(
                                                            top: 16, left: 5),
                                                        child: days < 7
                                                            ? Text(
                                                                getTime(repeatProviderRepo
                                                                    .commentList[
                                                                        index]
                                                                    .createdAt),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: Colors
                                                                        .white))
                                                            : Text(DateFormat('dd-MMM').format(repeatProviderRepo
                                                                .commentList[index]
                                                                .createdAt))),
                                                  ),
                                                  flex: 1,
                                                ),
                                                dashBoardProviderRepo.userId ==
                                                        repeatProviderRepo
                                                            .commentList[index]
                                                            .userId
                                                    ? Expanded(
                                                        child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 4.0),
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 16,
                                                                      left: 5),
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  // _modalBottomSheetMenu(
                                                                  //   feedProviderRepo.commentList[index].id,
                                                                  //   feedProviderRepo.commentList[index],
                                                                  // );
                                                                },
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
                                              visible: repeatProviderRepo
                                                      .commentList[index]
                                                      .replying !=
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
                                                            text: "Replying to",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey)),
                                                        TextSpan(
                                                            text: " @",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .red)),
                                                        TextSpan(
                                                          text:
                                                              repeatProviderRepo
                                                                  .commentList[
                                                                      index]
                                                                  .replying,
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
                                              visible: repeatProviderRepo
                                                      .commentList[index]
                                                      .commentMessage !=
                                                  null,
                                              child: Container(
                                                alignment: Alignment.topLeft,
                                                child: ReadMoreText(
                                                    repeatProviderRepo
                                                            .commentList[index]
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
                                          // Padding(
                                          //   padding: EdgeInsets.only(left: 0),
                                          //   child: repeatProviderRepo.commentList[index].media !=null
                                          //       ? Container(
                                          //     height: 200,
                                          //     margin: EdgeInsets.only(top: 10),
                                          //     child: ClipRRect(
                                          //       borderRadius:
                                          //       BorderRadius.all(Radius.circular(20)),
                                          //       child:
                                          //
                                          //       imageFileTypes.indexOf( feedProviderRepo.commentList[index].media
                                          //           .split('.')
                                          //           .last)
                                          //
                                          //           != -1
                                          //           ? GestureDetector(
                                          //         onTap: () {
                                          //           Navigator.push(context,
                                          //               MaterialPageRoute(
                                          //                   builder: (context) =>
                                          //                       FullPagePostView(
                                          //                           filePaths:
                                          //                           feedProviderRepo.commentList[index].media)
                                          //               )
                                          //           );
                                          //         },
                                          //         child: OverflowBox(
                                          //           minWidth: 0.0,
                                          //           minHeight: 0.0,
                                          //           maxWidth: double.infinity,
                                          //           maxHeight: double.infinity,
                                          //           child: Hero(
                                          //             tag: 'd ${  feedProviderRepo.commentList[index].media}',
                                          //             child: CachedNetworkImage(
                                          //                 imageUrl: getImageUrl(
                                          //                     feedProviderRepo.commentList[index].media)),
                                          //           ),
                                          //         ),
                                          //       )
                                          //           : _controller != null &&
                                          //           _controller.value.initialized
                                          //           ?
                                          //       Stack(
                                          //         children: [
                                          //           GestureDetector(
                                          //             onTap: () {
                                          //               Navigator.push(context,
                                          //                   MaterialPageRoute(
                                          //                       builder: (context) =>
                                          //                           VideoFullPage(
                                          //                               filePaths:
                                          //                               feedProviderRepo.commentList[index].media)
                                          //                   )
                                          //               );
                                          //             },
                                          //             child: LayoutBuilder(
                                          //               builder: (BuildContext context, BoxConstraints constraints) {
                                          //                 return InViewNotifierWidget(
                                          //                   id: '$index',
                                          //                   builder:
                                          //                       (BuildContext context, bool isInView, Widget child) {
                                          //                     return VideoWidget(
                                          //                         play: isInView,
                                          //                         url:
                                          //                         //'https://sfo2.digitaloceanspaces.com/peoplepedia/1607424784883_sample-mp4-file.mp4'
                                          //                         feedProviderRepo.commentList[index].media
                                          //                       // 'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4'
                                          //
                                          //                     );
                                          //                   },
                                          //                 );
                                          //               },
                                          //             ),
                                          //           ),
                                          //           Positioned(
                                          //               top: 90,
                                          //               left: 160,
                                          //               child: ClipOval(
                                          //                 child: Material(
                                          //                   color: Colors.blue, // button color
                                          //                   child: SizedBox(
                                          //                       width: 46,
                                          //                       height: 46,
                                          //                       child: Icon(Icons.play_arrow,
                                          //                         color: Colors.white,
                                          //                         size: 30,
                                          //                       )),
                                          //                 ),
                                          //               )
                                          //           ),
                                          //         ],
                                          //       )
                                          //
                                          //       //Do Not delete this data below
                                          //       // VideoPlayer(_controller)
                                          //           : Container(),
                                          //     ),
                                          //   )
                                          //       : Container(),
                                          // ),
                                          // Padding(
                                          //   padding: EdgeInsets.only(left: 0, right:0.0, top: 8.0, bottom: 8.0),
                                          //   child: Row(
                                          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          //       children: [
                                          //         _getCommentWidget(
                                          //             feedProviderRepo.commentList[index].like
                                          //                 .contains(dashBoardProviderRepo
                                          //                 .userId)
                                          //                 ?  Icons.favorite
                                          //                 :   Icons.favorite,
                                          //             feedProviderRepo.commentList[index].like.length
                                          //                 .toString(),
                                          //             0,
                                          //             feedProviderRepo.commentList[index],
                                          //             feedProviderRepo,
                                          //             dashBoardProviderRepo.userProfilePic,
                                          //             feedProviderRepo.commentList[index].userPic
                                          //         ),
                                          //         _getCommentWidget(
                                          //             commentIcon,
                                          //             feedProviderRepo.commentList[index].replyCount,
                                          //             1,
                                          //             feedProviderRepo.commentList[index],
                                          //             feedProviderRepo,
                                          //             dashBoardProviderRepo.userProfilePic,
                                          //             feedProviderRepo.commentList[index].userPic
                                          //         ),
                                          //         Row(
                                          //           children: [
                                          //             _getCommentWidget(
                                          //                 Icons.autorenew_rounded,
                                          //                 feedProviderRepo.commentList[index].repost.length,
                                          //                 2,
                                          //                 feedProviderRepo.commentList[index],
                                          //                 feedProviderRepo,
                                          //                 dashBoardProviderRepo.userProfilePic,
                                          //                 feedProviderRepo.feedDetail.comments[index].userPic
                                          //             )
                                          //           ],
                                          //         ),
                                          //         Row(
                                          //           children: [
                                          //             _getCommentWidget(
                                          //                 Icons.upload_file,
                                          //                 "",
                                          //                 2,
                                          //                 feedProviderRepo.commentList[index],
                                          //                 feedProviderRepo,
                                          //                 dashBoardProviderRepo.userProfilePic,
                                          //                 feedProviderRepo.feedDetail.comments[index].userPic
                                          //             )
                                          //           ],
                                          //         ),
                                          //       ]),
                                          // )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                thickness: 0.5,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          print("id-------------------");
                          print(repeatProviderRepo.commentList[index].id);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SubCommentFullView(
                                      //  userData: repeatProviderRepo.commentList[index],
                                      )));
                        },
                      );

                      // Column(
                      //   children: [
                      //     GestureDetector(
                      //       child: Container(
                      //         child: Column(
                      //           children: [
                      //             Padding(
                      //               padding: EdgeInsets.all(4.0),
                      //               child: Row(
                      //                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                 children: [
                      //                   Padding(
                      //                     padding: EdgeInsets.all(8.0),
                      //                     child:  ClipRRect(
                      //                       borderRadius:
                      //                       BorderRadius.all(Radius.circular(20)),
                      //                       child: feedProviderRepo.commentList[index].userPic ==
                      //                           null
                      //                           ? Image.asset(dummyUser,
                      //                           fit: BoxFit.fill, height: 25, width: 25)
                      //                           : CachedNetworkImage(
                      //                           fit: BoxFit.fill,
                      //                           height: 52,
                      //                           width: 52,
                      //                           imageUrl: getImageUrl(feedProviderRepo.commentList[index].userPic)),
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     )
                      //   ],
                      // );
                    }));
          })
        ],
      ),
    );
  }

  //For Post Reply

  _getCommentPostWidget(iconData, text1, i, Post postDetails, feedProviderRepo,
      dashBoardProviderRepo, userReplyProfile) {
    return GestureDetector(
      onTap: () => {
        _handleOnCommentPostTap(i, postDetails, feedProviderRepo,
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

  _handleOnCommentPostTap(int i, Post postDetails, feedProviderRepo,
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
                adminPicUser: dashBoardProviderRepo.userProfilePic
                // profilepic: postDetails.postPhoto,
                )),
      );
      print("Comment");
    } else {
      print("Share");
      _modalBottomRepeatForPost(i, postDetails);
    }
  }

  //Repeat Bottom Modal
  void _modalBottomRepeatForPost(int i, Post postDetails) {
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
                                                repeatPostDetails: postDetails,
                                                adminPicUser:
                                                    dashBoardProviderRepo
                                                        .userProfilePic,
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

// _getCommentWidget(iconData, text1, i, Comment postDetails, feedProviderRepo,  dashBoardProviderRepo, userReplyProfile) {
//   return GestureDetector(
//
//
//     onTap: () {
//
//       _handleOnTap(i, postDetails, feedProviderRepo,  dashBoardProviderRepo, userReplyProfile);
//     },
//     child: Container(
//       padding: EdgeInsets.only(bottom: 10, left: 15, top: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           i == 0 || i == 2 || i == 3 ?   Icon(iconData,
//               color: i == 0
//                   ? postDetails.like.length > 0
//                   ? Colors.red
//                   : Colors.grey
//                   : Colors.grey) : SvgPicture.asset(iconData, fit: BoxFit.none),
//           // Icon(iconData,
//           //     color: i == 0
//           //         ? postDetails.like.length > 0
//           //             ? Colors.red
//           //             : Colors.grey
//           //         : Colors.grey),
//           Container(
//             margin: EdgeInsets.only(left: 08, right: 15),
//             child: Text(
//               text1.toString(),
//               style: TextStyle(color: Colors.grey, fontSize: 15),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
//
// _handleOnTap(int i, Comment postDetails, feedProviderRepo,  String profilePic, userReplyProfile) {
//   if (i == 0) {
//     print("like");
//   } else if (i == 1) {
//
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => SubCommentPostReply(
//         parentId : postDetails.id,
//         parentUserId: postDetails.userId,
//         grandParentId: postDetails.parentId,
//         replying: postDetails.replying,
//         commentPicUser: postDetails.userPic,
//         userProfile: profilePic,
//         //replyingName: postDetails.userName
//         // profilepic: postDetails.postPhoto,
//       )),
//     );
//   } else {
//     print("Share");
//     _modalBottomRepeatForSubComment(i, postDetails);
//   }
// }
//
//
// //Repeat For Sub Comment
// void _modalBottomRepeatForSubComment(int i, Comment postDetails) {
//   showModalBottomSheet(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//       context: context,
//       builder: (builder) {
//         return SingleChildScrollView(
//             child: Consumer(
//               builder: (context, watch, child){
//
//                 final repostProvider = watch(feedProvider);
//                 return Container(
//                     decoration: BoxDecoration(
//                       color: Color(0xFF222222),
//                     ),
//                     child:  Column(children: [
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(0, 60, 0, 40),
//                         child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
//                           Row(
//                             children: [
//                               Icon(Icons.delete,
//                                 color: Colors.red,
//                               ),
//                               Padding(
//                                   padding: EdgeInsets.only(right: 15)
//                               ),
//                               GestureDetector(
//                                 onTap: () async {
//
//                                   setState(() {
//                                     if (repostSubComment == true) {
//                                       repostSubComment = false;
//                                     } else {
//                                       repostSubComment = true;
//                                     }
//                                   });
//
//                                   print('Comment Repost Value here');
//                                   print(repostSubComment);
//                                   await  repostProvider.repostSubCommentPost(postDetails.id, postDetails.repost);
//
//
//                                   Navigator.pop(context);
//
//                                 },
//                                 child: Text(
//                                   "Repost",
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       // color: HexColor("666666"),
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Icon(Icons.edit,
//                                 color: Colors.red,
//                               )  ,
//                               Padding(
//                                   padding: EdgeInsets.only(right: 15)
//                               ),
//                               GestureDetector(
//                                 onTap: () async{
//                                   await  Navigator.push(
//                                     context,
//                                     MaterialPageRoute(builder: (context) => RepeatSubCommentPost(
//                                       subCommentPostDetails: postDetails,
//                                     )),
//                                   );
//
//                                   Navigator.pop(context);
//                                 },
//                                 child: Text(
//                                   "Repeat",
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       // color: HexColor("666666"),
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ]),
//                       ),
//                     ]));
//               },
//             )
//         );
//       });
// }
//
//
// void _modalBottomSheetMenu(String id, Comment commentList) {
//   showModalBottomSheet(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//       context: context,
//       builder: (builder) {
//         return SingleChildScrollView(
//             child: Consumer(
//               builder: (context, watch, child){
//
//                 final deletCommentRepo = watch(deleteCommentProvider);
//                 return Container(
//                     decoration: BoxDecoration(
//                       color: Color(0xFF222222),
//                     ),
//                     child:  Column(children: [
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(0, 60, 0, 40),
//                         child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
//                           Row(
//                             children: [
//                               Icon(Icons.delete,
//                                 color: Colors.red,
//                               ),
//                               Padding(
//                                   padding: EdgeInsets.only(right: 15)
//                               ),
//                               GestureDetector(
//                                 onTap: (){
//                                   deletCommentRepo.deletePostComment(id);
//                                 },
//                                 child: Text(
//                                   "Delete",
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       // color: HexColor("666666"),
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Icon(Icons.edit,
//                                 color: Colors.red,
//                               )  ,
//                               Padding(
//                                   padding: EdgeInsets.only(right: 15)
//                               ),
//                               GestureDetector(
//                                 onTap: (){
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(builder: (context) => CommentForPost(
//                                       commentUpdate: commentUpdate,
//                                       postId: commentList.id,
//                                       textTyped: commentList.commentMessage,
//                                       adminPicUser: commentList.userPic,
//                                       userNamePost: commentList.replying,
//                                       userFile: commentList.media,
//                                       //replyingName: postDetails.userName
//                                       // profilepic: postDetails.postPhoto,
//                                     )),
//                                   );
//
//                                 },
//                                 child: Text(
//                                   "Edit",
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       // color: HexColor("666666"),
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ]),
//                       ),
//                     ]));
//               },
//             )
//         );
//       });
// }

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

class VideoWidget extends StatefulWidget {
  final String url;
  final bool play;

  const VideoWidget({Key key, @required this.url, @required this.play})
      : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    print("widget url");
    print(widget.url);
    super.initState();
    _controller = VideoPlayerController.network(widget.url);
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});
    });

    if (widget.play) {
      _controller.play();
      _controller.setLooping(true);
    }
  }

  @override
  void didUpdateWidget(VideoWidget oldWidget) {
    if (oldWidget.play != widget.play) {
      if (widget.play) {
        _controller.play();
        _controller.setLooping(true);
      } else {
        _controller.pause();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return VideoPlayer(_controller);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
