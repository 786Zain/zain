import 'dart:convert';

import 'package:async_loader/async_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_system/animation/animation.dart';
import 'package:farm_system/common/app_bar.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/dashboard/deatailsPost.dart';
import 'package:farm_system/dashboard/drawerPage.dart';
import 'package:farm_system/feature/farm_post/RepeatDetail/view/repeatPostFull.view.dart';
import 'package:farm_system/feature/farm_post/newVideoFullpage.dart';
import 'package:farm_system/feature/feed/comment/view/commentforpost.view.dart';
import 'package:farm_system/feature/feed/models/ModelBasedonPostId.dart';
import 'package:farm_system/feature/feed/models/getFeed.model.dart';
import 'package:farm_system/feature/feed/repeat/view/repeatComment.view.dart';
import 'package:farm_system/feature/feed/repo/feedRepo.dart';
import 'package:farm_system/feature/feed/view/feedLoaderShimmer.dart';
import 'package:farm_system/feature/feed/view/fullpagepost.view.dart';
import 'package:farm_system/feature/feed/view/readmoretext.dart';
import 'package:farm_system/feature/profile_user/view/profiletab.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/screen/Discovery/all_element.dart';
import 'package:farm_system/services/socket.dart';
import 'package:farm_system/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:video_player/video_player.dart';
import 'package:farm_system/storage.dart';
import 'package:farm_system/feature/first_screen/repo/NotificationModel.dart';

class NewsFeedPage extends StatefulWidget {
  final String id;

  const NewsFeedPage({Key key, this.id}) : super(key: key);

  @override
  _NewsFeedPageState createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage> {
  bool favorite = false;
  bool repost = false;
  final _asyncKey = GlobalKey<AsyncLoaderState>();
  VideoPlayerController _controller;
  VoidCallback videoPlayerListener;

  var userId;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      userId = await StorageService.getUserId();
      SocketIO socketIO = SocketLibrary.getSocket();
      socketIO.subscribe('notificationCount', (data) {
        var wholeData = json.decode(data);
        if (wholeData['userId'] == userId) {
          context
              .read(feedProvider)
              .setNotificationCount(wholeData['NotificationCount']);
        }
      });
      context.read(dashboardProvider).fetchUserDetail();
    });
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

  @override
  Widget build(BuildContext context) {
    print('jrj krjbg');
    print(userId);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: Consumer(builder: (context, watch, child) {
              final feedProviderRepo = watch(feedProvider);
              return AsyncLoader(
                key: _asyncKey,
                // ignore: missing_return
                initState: () async {
                  await feedProviderRepo.getFeedList();
                },
                renderLoad: () => Center(child: FeedLoaderShimmer()),
                renderError: ([err]) => Text('There was a error'),
                renderSuccess: ({data}) => _generateUI(),
              );
            }),
          ),
        ],
      ),
    );
  }

  Consumer _generateUI() {
    // var userId;
    //
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //    userId = await StorageService.getUserId();
    // });

    return Consumer(builder: (context, watch, child) {
      final feedProviderRepo = watch(feedProvider);
      final dashBoardProviderRepo = watch(dashboardProvider);

      return Visibility(
        visible: feedProviderRepo.feedList.length > 0,
        child: InViewNotifierList(
          // physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          initialInViewIds: ['0'],
          isInViewPortCondition:
              (double deltaTop, double deltaBottom, double viewPortDimension) {
            return deltaTop < (0.5 * viewPortDimension) &&
                deltaBottom > (0.5 * viewPortDimension);
          },
          itemCount: feedProviderRepo.feedList.length,
          builder: (BuildContext context, int index) {
            var dt = new DateTime.now();
            var days = dt
                .difference(feedProviderRepo.feedList[index].createdAt)
                .inDays;
            if (feedProviderRepo.feedList[index].postPhoto.length > 0 &&
                imageFileTypes.indexOf(getImageUrl(feedProviderRepo
                            .feedList[index].postPhoto[0].location)
                        .split('.')
                        .last) ==
                    -1) {
              // getVideoFile(getImageUrl(
              //     feedProviderRepo.feedList[index].postPhoto[0].location));
            }

            print('valu');
            // print(  feedProviderRepo.feedList[index]
            //     .commentCheck.contains(repost)
            //     );
            print('neww');
            return GestureDetector(
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 4.0, right: 4.0, bottom: 4.0, top: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 8.0, right: 8.0, bottom: 8.0, top: 4),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              child: feedProviderRepo
                                          .feedList[index].profilePic ==
                                      null
                                  ? Image.asset(dummyUser,
                                      fit: BoxFit.fill, height: 52, width: 52)
                                  : InkWell(
                                      onTap: () {
                                        navigationToScreen(
                                            context,
                                            ProfileTab(
                                                userId: feedProviderRepo
                                                    .feedList[index].profileId),
                                            false);
                                      },
                                      child: CachedNetworkImage(
                                          fit: BoxFit.fill,
                                          height: 52,
                                          width: 52,
                                          imageUrl: getImageUrl(feedProviderRepo
                                              .feedList[index].profilePic)),
                                    ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 4.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          navigationToScreen(
                                              context,
                                              ProfileTab(
                                                  userId: feedProviderRepo
                                                      .feedList[index]
                                                      .profileId),
                                              false);
                                        },
                                        child: Container(
                                          child: feedProviderRepo
                                                          .feedList[index]
                                                          .userName !=
                                                      "" &&
                                                  feedProviderRepo
                                                          .feedList[index]
                                                          .userName !=
                                                      null
                                              ? Text(
                                                  Utils.getCapitalizeName(
                                                      '${feedProviderRepo.feedList[index].name}'),
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white))
                                              : Text(" "),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.0,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          navigationToScreen(
                                              context,
                                              ProfileTab(
                                                  userId: feedProviderRepo
                                                      .feedList[index]
                                                      .profileId),
                                              false);
                                        },
                                        child: Container(
                                          child: feedProviderRepo
                                                          .feedList[index]
                                                          .userName !=
                                                      "" &&
                                                  feedProviderRepo
                                                          .feedList[index]
                                                          .userName !=
                                                      null
                                              ? Text(
                                                  '@${feedProviderRepo.feedList[index].userName}',
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Color(0xff666666)))
                                              : Text(" "),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: EdgeInsets.only(right: 4.0),
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                top: 0, left: 5),
                                            child: days < 7
                                                ? Text(getTime(feedProviderRepo.feedList[index].createdAt),
                                                    style: GoogleFonts.montserrat(
                                                        fontSize: 9,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color:
                                                            Color(0xff888888)))
                                                : Text(
                                                    DateFormat('dd-MMM').format(
                                                        feedProviderRepo
                                                            .feedList[index]
                                                            .createdAt),
                                                    style: GoogleFonts.montserrat(
                                                        fontSize: 9,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color:
                                                            Color(0xff888888)))),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  // padding: EdgeInsets.only(top: 4.0, bottom: 4.0, right: 9),
                                  padding: EdgeInsets.only(top: 1.0, bottom: 5),
                                  child: Visibility(
                                    visible: feedProviderRepo
                                            .feedList[index].caption !=
                                        null,
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      child: ReadMoreText(
                                          feedProviderRepo
                                                  .feedList[index].caption ??
                                              '',
                                          colorClickableText: Colors.grey,
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white,
                                          )),
                                    ),
                                  ),
                                ),
                                feedProviderRepo.feedList[index].textFeed ==
                                        false
                                    ? Padding(
                                        padding: EdgeInsets.only(left: 0),
                                        child:
                                            feedProviderRepo.feedList[index]
                                                        .postPhoto.length >
                                                    0
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
                                                                    feedProviderRepo
                                                                        .feedList[
                                                                            index]
                                                                        .postPhoto[
                                                                            0]
                                                                        .location
                                                                        .split(
                                                                            '.')
                                                                        .last) !=
                                                                -1
                                                            ? GestureDetector(
                                                                onTap: () {
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              FullPagePostView(
                                                                        filePaths: feedProviderRepo
                                                                            .feedList[index]
                                                                            .postPhoto[0]
                                                                            .location,
                                                                        postData:
                                                                            feedProviderRepo.feedList[index],
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 450,
                                                                  width: 320,
                                                                  color: Colors
                                                                          .grey[
                                                                      900],
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
                                                                    child: Hero(
                                                                      tag:
                                                                          'fee ${feedProviderRepo.feedList[index].postPhoto[0].location}',
                                                                      child: CachedNetworkImage(
                                                                          fit: BoxFit.cover,
                                                                          imageUrl: getImageUrl(feedProviderRepo
                                                                              .feedList[index]
                                                                              .postPhoto[0]
                                                                              .location)),
                                                                    ),
                                                                  ),
                                                                ),
                                                                // CachedNetworkImage(
                                                                //     fit: BoxFit.fill,
                                                                //     height: 176,
                                                                //     width: 338,
                                                                //     imageUrl: getImageUrl(
                                                                //         feedProviderRepo.feedList[index]
                                                                //             .postPhoto[0].location)),
                                                              )
                                                            : Stack(
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => VideoPlayerNew(filePaths: feedProviderRepo.feedList[index].postPhoto[0].location)));
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
                                                                            child:
                                                                                CachedNetworkImage(fit: BoxFit.cover, imageUrl: getImageUrl(feedProviderRepo.feedList[index].postPhoto[0].thumbnailUrl)),
                                                                          ),
                                                                        );
                                                                        //   InViewNotifierWidget(
                                                                        //   id: '$index',
                                                                        //   builder: (BuildContext
                                                                        //           context,
                                                                        //       bool
                                                                        //           isInView,
                                                                        //       Widget
                                                                        //           child) {
                                                                        //     if (isInView ==
                                                                        //         true) {
                                                                        //       print(
                                                                        //           "playing video");
                                                                        //     } else {
                                                                        //       print(
                                                                        //           "not playing videooooo");
                                                                        //     }
                                                                        //     return CachedNetworkImage(
                                                                        //         fit: BoxFit
                                                                        //             .cover,
                                                                        //         imageUrl: getImageUrl(feedProviderRepo
                                                                        //             .feedList[
                                                                        //         index]
                                                                        //             .postPhoto[
                                                                        //         0]
                                                                        //             .thumbnailUrl));
                                                                        //       // VideoWidget(
                                                                        //       //   play:
                                                                        //       //       isInView,
                                                                        //       //   url:
                                                                        //       //       //'https://sfo2.digitaloceanspaces.com/peoplepedia/1607424784883_sample-mp4-file.mp4'
                                                                        //       //       feedProviderRepo.feedList[index].postPhoto[0].location
                                                                        //       //   // 'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4'
                                                                        //       //
                                                                        //       //   );
                                                                        //   },
                                                                        // );
                                                                      },
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                      top: 80,
                                                                      left: 135,
                                                                      child:
                                                                          GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(builder: (context) => VideoPlayerNew(filePaths: feedProviderRepo.feedList[index].postPhoto[0].location)));
                                                                        },
                                                                        child:
                                                                            ClipOval(
                                                                          child:
                                                                              Material(
                                                                            color:
                                                                            HexColor(
                                                                                "D41B47"),
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
                                                              )

                                                        //Do Not delete this data below
                                                        // VideoPlayer(_controller)

                                                        ),
                                                  )
                                                : Container(),
                                      )
                                    : Container(),
                                feedProviderRepo
                                            .feedList[index].repeat.userName !=
                                        null
                                    ? GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RepeatPostFullView(
                                                        id: feedProviderRepo
                                                            .feedList[index]
                                                            .repeat
                                                            .repeatingId,
                                                      )));
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 0,
                                              right: 20.0,
                                              top: 3.0,
                                              bottom: 3.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color(0XFFDADADA)),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                color: Colors.transparent),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                feedProviderRepo.feedList[index]
                                                            .repeat.textFeed ==
                                                        false
                                                    ? Container(
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(0.0),
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        top:
                                                                            4.0,
                                                                        left: 8,
                                                                        right:
                                                                            8,
                                                                        bottom:
                                                                            4),
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        navigationToScreen(
                                                                            context,
                                                                            ProfileTab(userId: feedProviderRepo.feedList[index].repeat.profileId),
                                                                            false);
                                                                      },
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(25)),
                                                                        child: feedProviderRepo.feedList[index].repeat.profilePic ==
                                                                                null
                                                                            ? Container(
                                                                                width: 60.0,
                                                                                height: 60.0,
                                                                                decoration: BoxDecoration(
                                                                                  image: DecorationImage(
                                                                                    fit: BoxFit.cover,
                                                                                    image: NetworkImage("https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"),
                                                                                  ),
                                                                                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                                  color: Colors.redAccent,
                                                                                ),
                                                                              )
                                                                            : CachedNetworkImage(
                                                                                fit: BoxFit.cover,
                                                                                height: 45,
                                                                                width: 45,
                                                                                imageUrl: getImageUrl(feedProviderRepo.feedList[index].repeat.profilePic)),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                      child:
                                                                          Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(top: 0),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsets.only(left: 0, top: 4),
                                                                              child: feedProviderRepo.feedList[index].repeat.name != "" && feedProviderRepo.feedList[index].repeat.name != null
                                                                                  ? InkWell(
                                                                                      onTap: () {
                                                                                        navigationToScreen(context, ProfileTab(userId: feedProviderRepo.feedList[index].repeat.profileId), false);
                                                                                      },
                                                                                      child: Text(Utils.getCapitalizeName('${feedProviderRepo.feedList[index].repeat.name}'), style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff666666))),
                                                                                    )
                                                                                  : Text(" "),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsets.only(left: 2, top: 4),
                                                                              child: feedProviderRepo.feedList[index].repeat.userName != "" && feedProviderRepo.feedList[index].repeat.userName != null
                                                                                  ? InkWell(
                                                                                      onTap: () {
                                                                                        navigationToScreen(context, ProfileTab(userId: feedProviderRepo.feedList[index].repeat.profileId), false);
                                                                                      },
                                                                                      child: Text('@${feedProviderRepo.feedList[index].repeat.userName}', style: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.normal, color: Color(0xff666666))),
                                                                                    )
                                                                                  : Text(" "),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(right: 10),
                                                                        child:
                                                                            Container(
                                                                          alignment:
                                                                              Alignment.topLeft,
                                                                          child: ReadMoreText(
                                                                              feedProviderRepo.feedList[index].repeat.message ?? '',
                                                                              style: GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.normal, color: Colors.white, letterSpacing: 0.5)),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : Padding(
                                                        padding:
                                                            EdgeInsets.all(0.0),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(top: 4.0, left: 8, right: 8, bottom: 4),
                                                              child: ClipRRect(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            25)),
                                                                child: feedProviderRepo
                                                                            .feedList[index]
                                                                            .repeat
                                                                            .profilePic ==
                                                                        null
                                                                    ? Container(
                                                                        width:
                                                                            60.0,
                                                                        height:
                                                                            60.0,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          image:
                                                                              DecorationImage(
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            image:
                                                                                NetworkImage("https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"),
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(25.0)),
                                                                          color:
                                                                              Colors.redAccent,
                                                                        ),
                                                                      )
                                                                    : InkWell(
                                                                        onTap:
                                                                            () {
                                                                          navigationToScreen(
                                                                              context,
                                                                              ProfileTab(userId: feedProviderRepo.feedList[index].repeat.profileId),
                                                                              false);
                                                                        },
                                                                        child: CachedNetworkImage(
                                                                            fit: BoxFit
                                                                                .fill,
                                                                            height:
                                                                                45,
                                                                            width:
                                                                                45,
                                                                            imageUrl:
                                                                                getImageUrl(feedProviderRepo.feedList[index].repeat.profilePic)),
                                                                      ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                                child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                  Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                4.0),
                                                                    child: Row(
                                                                      children: [
                                                                        Padding(
                                                                            padding: EdgeInsets.only(
                                                                                left: 1, top: 0
                                                                            ),
                                                                            child:
                                                                                InkWell(
                                                                              onTap:
                                                                                  () {
                                                                                navigationToScreen(context, ProfileTab(userId: feedProviderRepo.feedList[index].repeat.profileId), false);
                                                                              },
                                                                              child: Container(
                                                                                child: feedProviderRepo.feedList[index].repeat.userName != "" && feedProviderRepo.feedList[index].repeat.userName != null
                                                                                    ? Text(Utils.getCapitalizeName('${feedProviderRepo.feedList[index].repeat.name}'),
                                                                                        style: GoogleFonts.montserrat(
                                                                                          fontSize: 18,
                                                                                          fontWeight: FontWeight.bold,
                                                                                          color: HexColor('#666666'),
                                                                                          // color: Color(
                                                                                          //     0xff666666)
                                                                                        ))
                                                                                    : Text(" "),
                                                                              ),
                                                                            )),
                                                                        // SizedBox(
                                                                        //   width:
                                                                        //       5.0,
                                                                        // ),
                                                                        Padding(
                                                                          padding: EdgeInsets.only(
                                                                              left: 0,
                                                                              top: 1),
                                                                          child:
                                                                              InkWell(
                                                                            onTap:
                                                                                () {
                                                                              navigationToScreen(context, ProfileTab(userId: feedProviderRepo.feedList[index].repeat.profileId), false);
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              child: feedProviderRepo.feedList[index].repeat.userName != "" && feedProviderRepo.feedList[index].repeat.userName != null ? Text('@${feedProviderRepo.feedList[index].repeat.userName}', style: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.normal, color: Color(0xff666666))) : Text(" "),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        top: 1,
                                                                        bottom:
                                                                            5),
                                                                    child:
                                                                        Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child: ReadMoreText(
                                                                          feedProviderRepo.feedList[index].repeat.message ??
                                                                              '',
                                                                          style: GoogleFonts.montserrat(
                                                                              fontSize: 13,
                                                                              fontWeight: FontWeight.normal,
                                                                              color: Colors.white,
                                                                              letterSpacing: 0.5)),
                                                                    ),
                                                                  )
                                                                ])),
                                                          ],
                                                        ),
                                                      ),
                                                feedProviderRepo.feedList[index]
                                                            .repeat.textFeed ==
                                                        false
                                                    ? feedProviderRepo
                                                                .feedList[index]
                                                                .repeat
                                                                .post !=
                                                            null
                                                        ? Container(
                                                            height: 200,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 0),
                                                            child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius.all(
                                                                        Radius.circular(
                                                                            20)),
                                                                child: imageFileTypes
                                                                            .indexOf(feedProviderRepo.feedList[index].repeat.post.split('.').last) !=
                                                                        -1
                                                                    ? Padding(
                                                                        padding: EdgeInsets.only(
                                                                            top:
                                                                                0.0,
                                                                            left:
                                                                                8.0,
                                                                            right:
                                                                                8.0,
                                                                            bottom:
                                                                                10),
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              200,
                                                                          margin:
                                                                              EdgeInsets.only(top: 5),
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(12)),
                                                                            child:
                                                                                OverflowBox(
                                                                              minWidth: 350,
                                                                              minHeight: 220,
                                                                              maxHeight: 400,
                                                                              maxWidth: 350,
                                                                              child: InkWell(
                                                                                onTap: () {
                                                                                  Navigator.push(
                                                                                    context,
                                                                                    MaterialPageRoute(
                                                                                      builder: (context) => FullPagePostView(
                                                                                        filePaths: feedProviderRepo.feedList[index].repeat.post,
                                                                                        postData: feedProviderRepo.feedList[index],
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                },
                                                                                child: CachedNetworkImage(fit: BoxFit.cover, imageUrl: getImageUrl(feedProviderRepo.feedList[index].repeat.post)),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : Stack(
                                                                        children: [
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlayerNew(filePaths: feedProviderRepo.feedList[index].repeat.post)));
                                                                            },
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 10),
                                                                              child: LayoutBuilder(
                                                                                builder: (BuildContext context, BoxConstraints constraints) {
                                                                                  return Container(
                                                                                    height: 200,
                                                                                    // width: 320,
                                                                                    child: ClipRRect(
                                                                                      borderRadius: BorderRadius.all(Radius.circular(12)),
                                                                                      child: OverflowBox(
                                                                                        minWidth: 320,
                                                                                        minHeight: 200,
                                                                                        maxHeight: 400,
                                                                                        maxWidth: 320,
                                                                                        child: CachedNetworkImage(fit: BoxFit.cover, imageUrl: getImageUrl(feedProviderRepo.feedList[index].repeat.thumbnailUrl)),
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Positioned(
                                                                              top: 80,
                                                                              left: 135,
                                                                              child: GestureDetector(
                                                                                onTap: () {
                                                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlayerNew(filePaths: feedProviderRepo.feedList[index].repeat.post)));
                                                                                },
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
                                                                                ),
                                                                              )),
                                                                        ],
                                                                      )))
                                                        : Container()
                                                    : Container()
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                                // feedProviderRepo.feedList[index].repeat.userName !=null ?
                                // Container(
                                //     decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.all(
                                //             Radius.circular(10.0)),
                                //         color: Colors.white30),
                                //     child: Padding(
                                //       padding:  EdgeInsets.only(top: 2, right: 8, left: 8, bottom: 8),
                                //       child: Column(
                                //         crossAxisAlignment: CrossAxisAlignment.start,
                                //         mainAxisAlignment: MainAxisAlignment.start,
                                //         children: [
                                //           Row(
                                //             crossAxisAlignment: CrossAxisAlignment.start,
                                //             mainAxisAlignment: MainAxisAlignment.start,
                                //             children: [
                                //               Padding(
                                //                 padding: EdgeInsets.all(8.0),
                                //                 child: ClipRRect(
                                //                     borderRadius:
                                //                     BorderRadius.all(Radius.circular(20)),
                                //                     child:
                                //                     CachedNetworkImage(
                                //                         fit: BoxFit.fill,
                                //                         height: 40,
                                //                         width: 40,
                                //                         imageUrl: feedProviderRepo
                                //                             .feedList[index].repeat.profilePic)
                                //                 ),
                                //               ),
                                //               Padding(
                                //                 padding: EdgeInsets.only(left: 10, top: 10),
                                //                        child: feedProviderRepo
                                //                            .feedList[index].repeat.userName !=
                                //                            "" &&
                                //                            feedProviderRepo
                                //                                .feedList[index].repeat.userName !=
                                //                                null
                                //                            ? Text(
                                //                            '${feedProviderRepo.feedList[index].repeat.userName}',
                                //                            style: TextStyle(
                                //                              fontSize: 15,
                                //                              color: Colors.white,
                                //                            ))
                                //                            : Text(" "),
                                //               )
                                //             ],
                                //           ),
                                //           Container(
                                //             alignment: Alignment.topLeft,
                                //             child:
                                //             ReadMoreText(
                                //                 feedProviderRepo.feedList[index].repeat.message ?? '',
                                //                 style: TextStyle(
                                //                   fontSize: 15,
                                //                   letterSpacing: 0.5,
                                //                   color: Colors.white,
                                //                 )),
                                //           ),
                                //         ],
                                //       ),
                                //     )
                                // )
                                // : Container(),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 5,
                                      left: 10,
                                      right: 10.0,
                                      bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      // _getCommentWidget(
                                      //     feedProviderRepo.feedList[index].like
                                      //         .contains(dashBoardProviderRepo
                                      //         .userId)
                                      //         ?  Icons.favorite
                                      //         :   Icons.favorite,
                                      //     feedProviderRepo
                                      //         .feedList[index].like.length
                                      //         .toString(),
                                      //     0,
                                      //     feedProviderRepo.feedList[index],
                                      //     feedProviderRepo,
                                      //     dashBoardProviderRepo,
                                      //     feedProviderRepo.feedList[index].profilePic
                                      // ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                print('printinggg');
                                                print(userId);
                                                print(feedProviderRepo
                                                    .feedList[index].like
                                                    .contains(userId));
                                                feedProviderRepo.likeOrDislike(
                                                    context,
                                                    feedProviderRepo
                                                        .feedList[index].id,
                                                    feedProviderRepo
                                                        .likeCollection);

                                                feedProviderRepo
                                                    .getFeedUserInfo(
                                                        feedProviderRepo
                                                            .feedList[index]
                                                            .id);
                                              },
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    feedProviderRepo
                                                                .feedList[index]
                                                                .like
                                                                .contains(
                                                                    userId) ==
                                                            true
                                                        ? Icon(Icons.favorite,
                                                            color: Colors.red)
                                                        : Icon(Icons.favorite,
                                                            color: Colors.grey),
                                                    // Icon(Icons.favorite,
                                                    //     color: feedProviderRepo.feedList[index].like.contains(userId)
                                                    //         ? Colors.red
                                                    //         : Colors.grey),
                                                    Text(
                                                      "${feedProviderRepo.feedList[index].like.length}",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 15),
                                                    ),
                                                  ])),
                                        ],
                                      ),
                                      feedProviderRepo.feedList[index].type ==
                                              "repeat"
                                          ? _getCommentWidget(
                                              // feedProviderRepo.feedList[index].like
                                              //         .contains(
                                              //             dashBoardProviderRepo
                                              //                 .userId)
                                              //     ? commentIcon
                                              //     : commentIcon,pod clean
                                              //   feedProviderRepo.feedList[index]
                                              //       .commentCheck
                                              //       .contains(userId) ==
                                              //       true
                                              //       ? commentRed
                                              //       : commentIcon,
                                              commentIcon,
                                              feedProviderRepo
                                                  .feedList[index].commentCount,
                                              1,
                                              feedProviderRepo.feedList[index],
                                              feedProviderRepo,
                                              dashBoardProviderRepo,
                                              feedProviderRepo
                                                  .feedList[index].profilePic)
                                          : _getCommentWidget(
                                              // feedProviderRepo.feedList[index].like
                                              //         .contains(
                                              //             dashBoardProviderRepo
                                              //                 .userId)
                                              //     ? commentIcon
                                              //     : commentIcon,pod clean
                                              feedProviderRepo.feedList[index]
                                                          .commentCheck
                                                          .contains(userId) ==
                                                      true
                                                  ? commentRed
                                                  : commentIcon,
                                              // commentIcon,

                                              feedProviderRepo
                                                  .feedList[index].commentCount,
                                              1,
                                              feedProviderRepo.feedList[index],
                                              feedProviderRepo,
                                              dashBoardProviderRepo,
                                              feedProviderRepo
                                                  .feedList[index].profilePic),
                                      _getCommentWidget(
                                          feedProviderRepo
                                                      .feedList[index].repost
                                                      .contains(userId) ==
                                                  true
                                              ? repostColor
                                              : repostNewImage,
                                          feedProviderRepo
                                              .feedList[index].repost.length,
                                          2,
                                          feedProviderRepo.feedList[index],
                                          feedProviderRepo,
                                          dashBoardProviderRepo,
                                          feedProviderRepo
                                              .feedList[index].profilePic),
                                      // _getCommentWidget(
                                      //     Icons.upload_file,
                                      //     "",
                                      //     2,
                                      //     feedProviderRepo.feedList[index],
                                      //     feedProviderRepo,
                                      //   dashBoardProviderRepo,
                                      //     feedProviderRepo.feedList[index].profilePic
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 0.5,
                      color: Color(0xff666666),
                    ),
                  ],
                ),
              ),
              onTap: () {
                print('sahasra');
                print("id-------------------");
                print(feedProviderRepo.feedList[index].id);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailsPost(
                              hideImage:
                                  feedProviderRepo.feedList[index].textFeed ==
                                          false
                                      ? false
                                      : true,
                              id: feedProviderRepo.feedList[index].id,
                              repeatDetails: feedProviderRepo.feedList[index],
                            )));
              },
            );
          },
        ),
      );
      // return Container(
      //     color: Colors.black,
      //     child: Visibility(
      //         visible: feedProviderRepo.feedList.length > 0,
      //         child: InViewNotifierList(
      //           scrollDirection: Axis.vertical,
      //           initialInViewIds: ['0'],
      //           isInViewPortCondition:
      //               (double deltaTop, double deltaBottom, double viewPortDimension) {
      //             return deltaTop < (0.5 * viewPortDimension) &&
      //                 deltaBottom > (0.5 * viewPortDimension);
      //           },
      //           itemCount: feedProviderRepo.feedList.length,
      //           builder: (BuildContext context, int index) {
      //             var dt = new DateTime.now();
      //             var days= dt.difference(feedProviderRepo
      //                 .feedList[index].createdAt).inDays;
      //             if (feedProviderRepo.feedList[index].postPhoto.length > 0 &&
      //
      //                 imageFileTypes.indexOf(
      //                     getImageUrl(
      //                         feedProviderRepo
      //                             .feedList[index].postPhoto[0].location)
      //                         .split('.')
      //                         .last
      //                 )  == -1
      //             ) {
      //               getVideoFile(getImageUrl(feedProviderRepo
      //                   .feedList[index].postPhoto[0].location));
      //             }
      //             return GestureDetector(
      //               child: Container(
      //                 padding: EdgeInsets.only(left: 0, right: 15, bottom: 15),
      //                 child: Column(
      //                   children: [
      //                     ListTile(
      //                       leading: Container(
      //                         margin: EdgeInsets.only(top: 10),
      //                         child: ClipRRect(
      //                           borderRadius:
      //                           BorderRadius.all(Radius.circular(20)),
      //                           child: feedProviderRepo
      //                               .feedList[index].profilePic ==
      //                               null
      //                               ? Image.asset(dummyUser,
      //                               fit: BoxFit.fill, height: 25, width: 25)
      //                               : CachedNetworkImage(
      //                               fit: BoxFit.fill,
      //                               height: 52,
      //                               width: 52,
      //                               imageUrl: getImageUrl(feedProviderRepo
      //                                   .feedList[index].profilePic)),
      //                         ),
      //                       ),
      //                       title: Row(
      //                         children: [
      //                           Container(
      //                             margin: EdgeInsets.only(top: 16),
      //                             child: feedProviderRepo
      //                                 .feedList[index].userName !=
      //                                 "" &&
      //                                 feedProviderRepo
      //                                     .feedList[index].userName !=
      //                                     null
      //                                 ? Text(
      //                                 '${feedProviderRepo.feedList[index].userName}',
      //                                 style: TextStyle(
      //                                   fontSize: 15,
      //                                   color: Colors.white,
      //                                 ))
      //                                 : Text(" "),
      //                           ),
      //                           // Padding(
      //                           //   padding: EdgeInsets.only(top: 6, left: 3),
      //                           //     child: Text('.')
      //                           // ),
      //                           // Container(
      //                           //     margin: EdgeInsets.only(top: 16, left: 5),
      //                           //     child:  days < 7 ? Text(
      //                           //         getTime(feedProviderRepo
      //                           //             .feedList[index].createdAt),
      //                           //         style: TextStyle(fontSize: 15, color: Colors.white)): Text(DateFormat('dd-MMM').format(feedProviderRepo
      //                           //         .feedList[index].createdAt)) ),
      //                         ],
      //                       ),
      //                       trailing:
      //                       Container(
      //                           margin: EdgeInsets.only(top: 16, left: 5),
      //                           child:  days < 7 ? Text(
      //                               ' ${ getTime(feedProviderRepo
      //                                   .feedList[index].createdAt)}'
      //                               ,
      //                               style: TextStyle(fontSize: 15, color: Colors.white)): Text(DateFormat('dd-MMM').format(feedProviderRepo
      //                               .feedList[index].createdAt)) ),
      //                     ),
      //                     Container(
      //                       padding: EdgeInsets.only(left: 55),
      //                       child: Column(
      //                         children: [
      //                           Visibility(
      //                             visible: feedProviderRepo
      //                                 .feedList[index].caption != null,
      //                             child: Container(
      //                               alignment: Alignment.topLeft,
      //                               padding:
      //                               EdgeInsets.only(left: 29, right: 29, top: 09),
      //                               child:
      //                               ReadMoreText(
      //                                   feedProviderRepo.feedList[index].caption ?? '',
      //                                   style: TextStyle(
      //                                     fontSize: 15,
      //                                     letterSpacing: 0.5,
      //                                     color: Colors.white,
      //                                   )),
      //                             ),
      //                           ),
      //                           feedProviderRepo.feedList[index].postPhoto.length > 0
      //                               ? Container(
      //                             height: 200,
      //                             margin: EdgeInsets.only(top: 10),
      //                             child: ClipRRect(
      //                               borderRadius:
      //                               BorderRadius.all(Radius.circular(20)),
      //                               child:
      //
      //                               imageFileTypes.indexOf( feedProviderRepo.feedList[index]
      //                                   .postPhoto[0].location
      //                                   .split('.')
      //                                   .last)
      //
      //                                   != -1
      //                                   ? GestureDetector(
      //                                 onTap: () {
      //                                   Navigator.push(context,
      //                                       MaterialPageRoute(
      //                                           builder: (context) =>
      //                                               FullPagePostView(
      //                                                   filePaths:
      //                                                   feedProviderRepo
      //                                                       .feedList[
      //                                                   index]
      //                                                       .postPhoto[0]
      //                                                       .location)
      //                                       )
      //                                   );
      //                                 },
      //                                 child: OverflowBox(
      //                                   minWidth: 0.0,
      //                                   minHeight: 0.0,
      //                                   maxWidth: double.infinity,
      //                                   maxHeight: double.infinity,
      //                                   child: Hero(
      //                                     tag: 'd ${  feedProviderRepo
      //                                         .feedList[
      //                                     index]
      //                                         .postPhoto[0]
      //                                         .location}',
      //                                     child: CachedNetworkImage(
      //                                       // memCacheHeight: 250,
      //                                       // memCacheWidth: 350,
      //                                         imageUrl: getImageUrl(
      //                                             feedProviderRepo
      //                                                 .feedList[index]
      //                                                 .postPhoto[0]
      //                                                 .location)),
      //                                   ),
      //                                 ),
      //                                 // CachedNetworkImage(
      //                                 //     fit: BoxFit.fill,
      //                                 //     height: 176,
      //                                 //     width: 338,
      //                                 //     imageUrl: getImageUrl(
      //                                 //         feedProviderRepo.feedList[index]
      //                                 //             .postPhoto[0].location)),
      //                               )
      //                                   : _controller != null &&
      //                                   _controller.value.initialized
      //                                   ?
      //                               Stack(
      //                                 children: [
      //                                   GestureDetector(
      //                                     onTap: () {
      //                                       Navigator.push(context,
      //                                           MaterialPageRoute(
      //                                               builder: (context) =>
      //                                                   VideoFullPage(
      //                                                       filePaths:
      //                                                       feedProviderRepo
      //                                                           .feedList[
      //                                                       index]
      //                                                           .postPhoto[0]
      //                                                           .location)
      //                                           )
      //                                       );
      //                                     },
      //                                     child: LayoutBuilder(
      //                                       builder: (BuildContext context, BoxConstraints constraints) {
      //                                         return InViewNotifierWidget(
      //                                           id: '$index',
      //                                           builder:
      //                                               (BuildContext context, bool isInView, Widget child) {
      //                                             if(isInView == true){
      //                                               print("playinhg video");
      //                                             }else{
      //                                               print("not playing videooooo");
      //                                             }
      //                                             return VideoWidget(
      //                                                 play: isInView,
      //                                                 url:
      //                                                 //'https://sfo2.digitaloceanspaces.com/peoplepedia/1607424784883_sample-mp4-file.mp4'
      //                                                 feedProviderRepo.feedList[index]
      //                                                     .postPhoto[0].location
      //                                               // 'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4'
      //
      //                                             );
      //                                           },
      //                                         );
      //                                       },
      //                                     ),
      //                                   ),
      //                                   Positioned(
      //                                       top: 90,
      //                                       left: 160,
      //                                       child: ClipOval(
      //                                         child: Material(
      //                                           color: Colors.blue, // button color
      //                                           child: SizedBox(
      //                                               width: 46,
      //                                               height: 46,
      //                                               child: Icon(Icons.play_arrow,
      //                                                 color: Colors.white,
      //                                                 size: 30,
      //                                               )),
      //                                         ),
      //                                       )
      //                                   ),
      //                                 ],
      //                               )
      //
      //                               //Do Not delete this data below
      //                               // VideoPlayer(_controller)
      //                                   : Container(),
      //                             ),
      //                           )
      //                               : Container(),
      //                           Container(
      //                             margin:
      //                             EdgeInsets.only(left: 02, right: 01, top: 10),
      //                             child: Row(
      //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                               crossAxisAlignment: CrossAxisAlignment.start,
      //                               children: [
      //                                 Row(
      //                                   children: [
      //                                     _getCommentWidget(
      //                                         feedProviderRepo.feedList[index].like
      //                                             .contains(dashBoardProviderRepo
      //                                             .userId)
      //                                             ?  Icons.favorite
      //                                             :   Icons.favorite,
      //                                         feedProviderRepo
      //                                             .feedList[index].like.length
      //                                             .toString(),
      //                                         0,
      //                                         feedProviderRepo.feedList[index],
      //                                         feedProviderRepo)
      //                                   ],
      //                                 ),
      //                                 Row(
      //                                   children: [
      //                                     _getCommentWidget(
      //                                         commentIcon,
      //                                         "3k",
      //                                         1,
      //                                         feedProviderRepo.feedList[index],
      //                                         feedProviderRepo)
      //                                   ],
      //                                 ),
      //
      //                                 Row(
      //                                   children: [
      //                                     _getCommentWidget(
      //                                         Icons.arrow_downward_rounded,
      //                                         "2k",
      //                                         2,
      //                                         feedProviderRepo.feedList[index],
      //                                         feedProviderRepo)
      //                                   ],
      //                                 ),
      //                                 Row(
      //                                   children: [
      //                                     _getCommentWidget(
      //                                         Icons.bookmark_border,
      //                                         "",
      //                                         2,
      //                                         feedProviderRepo.feedList[index],
      //                                         feedProviderRepo)
      //                                   ],
      //                                 ),
      //                               ],
      //                             ),
      //                           ),
      //                           Padding(
      //                             padding: EdgeInsets.only(top: 10),
      //                             child: Divider(
      //                               height: 1,
      //                               thickness: 0.5,
      //                               color: Colors.grey,
      //                             ),
      //                           )
      //                         ],
      //                       ),
      //                     )
      //                   ],
      //                 ),
      //               ),
      //               onTap: () {
      //                 print("id-------------------");
      //                 print(feedProviderRepo.feedList[index].id);
      //                 Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (context) => DetailsPost(
      //                           id: feedProviderRepo.feedList[index].id,
      //                         )));
      //               },
      //             );
      //
      //           },
      //         )));
    });
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

      print('dbfibihbidhbfighbihdbf');
      print(postDetails.like);

      feedProviderRepo.likeOrDislike(context, postDetails.id, postDetails.like);
    } else if (i == 1) {
      print("${postDetails.postPhoto}");
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CommentForPost(
                postId: postDetails.id,
                post: postDetails.userName,
                postSecondaryName: postDetails.name,
                // profilePicUser: postDetails.postPhoto.length!=0 &&  postDetails.postPhoto[0].location !=null ? postDetails.postPhoto[0].location : '',
                profilePicUser: userReplyProfile,
                adminPicUser: dashBoardProviderRepo.userProfilePic,
                catId: postDetails.category,
                subcateId: postDetails.subCategory
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
                                // Icon(Icons.edit,
                                //   color: Colors.red,
                                // )  ,
                                Padding(padding: EdgeInsets.only(right: 15)),
                                GestureDetector(
                                  onTap: () async {
                                    print("repeattttttttt ksfbdhb");
                                    print(postDetails.toJson());
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RepeatCommentPost(
                                                  postDetails: postDetails,
                                                  adminPicUser:
                                                      dashBoardProviderRepo
                                                          .userProfilePic)),
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
