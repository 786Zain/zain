import 'package:async_loader/async_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_system/animation/animation.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/dashboard/deatailsPost.dart';
import 'package:farm_system/feature/farm_plus_setup/farm_plus_model/farm_plus_model.dart';
import 'package:farm_system/feature/farm_post/RepeatDetail/view/repeatPostFull.view.dart';
import 'package:farm_system/feature/farm_post/newVideoFullpage.dart';
import 'package:farm_system/feature/feed/comment/view/commentforpost.view.dart';
import 'package:farm_system/feature/feed/models/ModelBasedonPostId.dart';
import 'package:farm_system/feature/feed/models/getFeed.model.dart';
import 'package:farm_system/feature/feed/repeat/view/repeatComment.view.dart';
import 'package:farm_system/feature/feed/repo/feedRepo.dart';
import 'package:farm_system/feature/feed/subCommentFullView/repeatSubComment/repeatInsideSubComment.view.dart';
import 'package:farm_system/feature/feed/subcommentPostReply/view/subcomment.view.dart';
import 'package:farm_system/feature/feed/view/fullpagepost.view.dart';
import 'package:farm_system/feature/feed/view/readmoretext.dart';
import 'package:farm_system/feature/profile_user/view/Likes/repo/likesubtab_reepo.dart';
import 'package:farm_system/feature/profile_user/view/profile_tabs/farmpost/view/profileSubTabDetailsShimmer.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:video_player/video_player.dart';
import 'package:farm_system/feature/profile_user/view/Likes/model/Like_model.dart';

import '../../../../../utils.dart';
import 'package:hexcolor/hexcolor.dart';

class Likes extends StatefulWidget {
  final String id;
  final String userId;

  const Likes({Key key, this.id, this.userId}) : super(key: key);
  @override
  _LikesState createState() => _LikesState();
}

class _LikesState extends State<Likes> {
  bool favorite = false;
  bool repost = false;
  final _asyncKeyLike = GlobalKey<AsyncLoaderState>();
  VideoPlayerController _controller;
  VoidCallback videoPlayerListener;

  // @override
  // void initState() {
  //   context.read(dashboardProvider).fetchUserDetail();
  //   super.initState();
  // }

  var userId;

  @override
  void initState() {
    context.read(dashboardProvider).fetchUserDetail();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      userId = await StorageService.getUserId();
    });
    super.initState();
  }

  var dataLikeAll = "dataLikeAll";
  var dataLikeMain = "dataLikeMain";

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  // var imageFileTypes = ["png", "jpg", "jpeg", "gif"];
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

    print('USER id');
    print(widget.userId);
    return SafeArea(
      top:false,
      bottom:false,
      child: Container(
        padding: EdgeInsets.only(top:10),
        color: Colors.black,
            child: Consumer(builder: (context, watch, child) {
              final userAllLikes = watch(userLikes);
              return AsyncLoader(
                key: _asyncKeyLike,
                initState: () => userAllLikes.getUserLikes(widget.userId),
                renderLoad: () => ProfileSubTabDetailsShimmer(),
                renderError: ([err]) => Text('There was a error'),
                renderSuccess: ({data}) => _generateUINew(),
              );
            }),
          ),
    );
  }

  _generateUINew() {
    return Consumer(builder: (context, watch, child) {
      final userAllLikes = watch(userLikes);
      final dashBoardProviderRepo = watch(dashboardProvider);
      return  Builder(
        builder: (BuildContext context) {
          return CustomScrollView(
            key: PageStorageKey<String>("hello"),
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          var dt = new DateTime.now();
                          var days = dt
                              .difference(userAllLikes.userLikesAll[index].createdAt)
                              .inDays;
                          if (userAllLikes.userLikesAll[index].postPhoto.length > 0 &&
                              imageFileTypes.indexOf(getImageUrl(userAllLikes
                                  .userLikesAll[index].postPhoto[0].location)
                                  .split('.')
                                  .last) ==
                                  -1) {
                          }
                          return GestureDetector(
                            child: Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0, top: 12),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0, top: 4),
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.all(
                                                Radius.circular(25)),
                                            child: userAllLikes.userLikesAll[index].profilePic ==
                                                null
                                                ? Image.asset(
                                                dummyUser,
                                                fit: BoxFit.fill,
                                                height: 52,
                                                width: 52
                                            )
                                                : CachedNetworkImage(
                                                fit: BoxFit.fill,
                                                height: 52,
                                                width: 52,
                                                imageUrl: getImageUrl(
                                                    userAllLikes.userLikesAll[index]
                                                        .profilePic)),
                                          ),
                                        ),
                                        Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(top: 4.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Container(
                                                        child: userAllLikes.userLikesAll[index]
                                                            .name !=
                                                            "" &&
                                                            userAllLikes.userLikesAll[index]
                                                                .name !=
                                                                null
                                                            ? Text(
                                                            '${userAllLikes.userLikesAll[index]
                                                                .name}',
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight: FontWeight.bold,
                                                                color: HexColor("#FFFFFF")
                                                            ))
                                                            : Text(" "),
                                                      ),
                                                      SizedBox(width: 2),
                                                      Container(
                                                        child: userAllLikes.userLikesAll[index]
                                                            .userName !=
                                                            "" &&
                                                            userAllLikes.userLikesAll[index]
                                                                .userName !=
                                                                null
                                                            ? Text(
                                                            '@' +
                                                                '${userAllLikes.userLikesAll[index]
                                                                    .userName}',
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight: FontWeight.bold,
                                                                color: HexColor("#666666")
                                                            ))
                                                            : Text(" "),

                                                      ),
                                                      SizedBox(
                                                        width: 5.0,
                                                      ),
                                                      Spacer(),
                                                      Padding(
                                                        padding: EdgeInsets.only(right: 4.0),
                                                        child: Container(
                                                          margin: EdgeInsets.only(top: 0, left: 5),
                                                          child: days < 7
                                                              ? Text(
                                                              getTime(
                                                                  userAllLikes.userLikesAll[index]
                                                                      .createdAt),
                                                              style: TextStyle(
                                                                  fontSize: 9,
                                                                  fontWeight: FontWeight.bold,
                                                                  color: HexColor("#666666")))
                                                              : Text(
                                                              DateFormat(
                                                                  'dd-MMM')
                                                                  .format(
                                                                  userAllLikes.userLikesAll[index]
                                                                      .createdAt),
                                                              style: TextStyle(
                                                                  fontSize: 9,
                                                                  fontWeight: FontWeight.bold,
                                                                  color: HexColor("#666666")
                                                              )),
                                                        ),
                                                      )
                                                    ],

                                                  ),

                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: 1.0, bottom: 5, ),
                                                  child: Visibility(
                                                    visible: userAllLikes.userLikesAll[index].caption != null,
                                                    child: Container(
                                                      alignment: Alignment.topLeft,
                                                      child: ReadMoreText(
                                                          userAllLikes.userLikesAll[index].caption ?? '',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.normal,
                                                              color:HexColor('#FFFFFF')
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                                userAllLikes.userLikesAll[index].textFeed == false
                                                    ? Padding(
                                                  padding: EdgeInsets.only(left: 0),
                                                  child: userAllLikes.userLikesAll[index].postPhoto.length > 0 ?
                                                  Container(
                                                      height: 200,
                                                      margin: EdgeInsets.only(bottom: 2),
                                                      child: ClipRRect(
                                                          borderRadius:
                                                          BorderRadius.all(Radius.circular(20)),
                                                          child: imageFileTypes.indexOf(userAllLikes.userLikesAll[index]
                                                              .postPhoto[0]
                                                              .location
                                                              .split('.')
                                                              .last) !=
                                                              -1
                                                              ? GestureDetector(
                                                            onTap: () {
                                                              print('likes images');
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        FullPagePostView(
                                                                      filePaths:
                                                                      userAllLikes.userLikesAll[index]
                                                                          .postPhoto[0]
                                                                          .location,
                                                                          likesMainTabData:userAllLikes.userLikesAll[index],
                                                                    ),
                                                                  ));
                                                            },
                                                            child: Container(
                                                              height: 450,
                                                              width: 320,
                                                              color: Colors.grey[900],
                                                              child: OverflowBox(
                                                                minWidth: 320,
                                                                minHeight: 200,
                                                                maxHeight: 400,
                                                                maxWidth: 320,
                                                                child: Hero(
                                                                  tag:
                                                                  'op ${userAllLikes.userLikesAll[index].postPhoto[0].location}',
                                                                  child: CachedNetworkImage(
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      imageUrl: getImageUrl(userAllLikes.userLikesAll[index]
                                                                          .postPhoto[0]
                                                                          .location)),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                              : Stack(
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) => VideoPlayerNew(
                                                                              filePaths: userAllLikes.userLikesAll[index]
                                                                                  .postPhoto[
                                                                              0]
                                                                                  .location)));
                                                                },
                                                                child: LayoutBuilder(
                                                                  builder: (BuildContext
                                                                  context,
                                                                      BoxConstraints
                                                                      constraints) {
                                                                    return Container(
                                                                      height: 450,
                                                                      width: 320,
                                                                      child: OverflowBox(
                                                                        minWidth: 320,
                                                                        minHeight: 200,
                                                                        maxHeight: 400,
                                                                        maxWidth: 320,
                                                                        child: CachedNetworkImage(
                                                                            fit: BoxFit
                                                                                .cover,
                                                                            imageUrl: getImageUrl(userAllLikes.userLikesAll[index]
                                                                                .postPhoto[
                                                                            0]
                                                                                .thumbnailUrl)),
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                              Positioned(
                                                                  top: 70,
                                                                  left: 130,
                                                                  child: GestureDetector(
                                                                    onTap: () {
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => VideoPlayerNew(
                                                                                  filePaths: userAllLikes.userLikesAll[index]
                                                                                      .postPhoto[0]
                                                                                      .location)));
                                                                    },
                                                                    child: ClipOval(
                                                                      child: Material(
                                                                        color:
                                                                        HexColor(
                                                                            "D41B47"),
                                                                        child: SizedBox(
                                                                            width: 46,
                                                                            height: 46,
                                                                            child: Icon(
                                                                              Icons
                                                                                  .play_arrow,
                                                                              color: Colors
                                                                                  .white,
                                                                              size: 30,
                                                                            )),
                                                                      ),
                                                                    ),
                                                                  )),
                                                            ],
                                                          )

                                                        //Do Not delete this data below
                                                        // VideoPlayer(_controller)
                                                        // : Container(),
                                                      )):Container(),
                                                ):Container(),

                                                userAllLikes.userLikesAll[index].repeat
                                                    .profilePic !=
                                                    null
                                                    ? GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                RepeatPostFullView(
                                                                  id: userAllLikes.userLikesAll[index].repeat.repeatingId
                                                                )));
                                                  },
                                                  child: Padding(
                                                      padding: EdgeInsets.only(left: 0, right: 20.0, top: 3.0, bottom: 3.0),
                                                      child:userAllLikes.userLikesAll[index].repeat.post !=
                                                          null ?
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(color: Color(0XFFDADADA)),
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(10.0)),
                                                            color: Colors.transparent),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.all(0.0),
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment.start,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.only(top: 4.0, left: 8, right: 8, bottom: 4),
                                                                    child: ClipRRect(
                                                                      borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              25)),
                                                                      child:userAllLikes.userLikesAll[index]
                                                                          .repeat
                                                                          .profilePic ==
                                                                          null
                                                                          ? Container(
                                                                        width: 40.0,
                                                                        height: 40.0,
                                                                        decoration:
                                                                        BoxDecoration(
                                                                          image:
                                                                          DecorationImage(
                                                                            fit: BoxFit
                                                                                .cover,
                                                                            image: NetworkImage(
                                                                                "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"),
                                                                          ),
                                                                          borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(
                                                                                  30.0)),
                                                                          color: Colors
                                                                              .redAccent,
                                                                        ),
                                                                      )

                                                                          : CachedNetworkImage(
                                                                          fit:
                                                                          BoxFit.fill,
                                                                          height: 45,
                                                                          width: 45,
                                                                          imageUrl: getImageUrl(
                                                                              userAllLikes.userLikesAll[index]
                                                                                  .repeat
                                                                                  .profilePic)),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                      child: Column(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Padding(
                                                                              padding: EdgeInsets.only(top: 4),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsets.only(left: 2, top: 0),
                                                                                    child: userAllLikes.userLikesAll[index]
                                                                                        .repeat
                                                                                        .userName !=
                                                                                        "" &&
                                                                                        userAllLikes.userLikesAll[index]
                                                                                            .repeat
                                                                                            .userName !=
                                                                                            null
                                                                                        ? Text(
                                                                                        Utils.getCapitalizeName(
                                                                                            '${userAllLikes.userLikesAll[index].repeat.name}'),
                                                                                        style: GoogleFonts.montserrat(
                                                                                            fontSize: 18,
                                                                                            letterSpacing: 0.5,
                                                                                            fontWeight:
                                                                                            FontWeight
                                                                                                .bold,
                                                                                            color: HexColor("#666666")
                                                                                        ))
                                                                                        : Text(" "),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 5.0,
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: EdgeInsets.only(left: 1, top: 0),
                                                                                    child: Container(
                                                                                      child: userAllLikes.userLikesAll[index].repeat.userName != "" &&
                                                                                          userAllLikes.userLikesAll[index].repeat.userName != null
                                                                                          ? Text(
                                                                                          '@${userAllLikes.userLikesAll[index].repeat.userName}',
                                                                                          style: GoogleFonts.montserrat(
                                                                                              fontSize: 13,
                                                                                              fontWeight: FontWeight.normal,
                                                                                              letterSpacing: 0.5,
                                                                                              color: HexColor("#666666")
                                                                                          )

                                                                                      )
                                                                                          : Text(" "),

                                                                                    ),
                                                                                  ),
                                                                                  Spacer(),
                                                                                ],
                                                                              ),
                                                                          ),
                                                                          userAllLikes.userLikesAll[index].repeat.message !=null?
                                                                          Padding(
                                                                            padding: EdgeInsets.only(top: 1.0, bottom: 2),
                                                                            child: Container(
                                                                              alignment: Alignment.topLeft,
                                                                              child: ReadMoreText(
                                                                                  userAllLikes.userLikesAll[index].repeat.message ?? '',
                                                                                  style: GoogleFonts.montserrat(
                                                                                      fontSize: 13,
                                                                                      fontWeight: FontWeight.normal,
                                                                                      color: HexColor("#FFFFFF"),
                                                                                      letterSpacing:
                                                                                      0.5)),
                                                                            ),
                                                                          )
                                                                          : Container(),
                                                                        ],
                                                                      )
                                                                  ),
                                                                ],
                                                              ),
                                                            ),


                                                            userAllLikes.userLikesAll[index].repeat.textFeed ==
                                                                false
                                                                ?

                                                            userAllLikes.userLikesAll[index].repeat.post !=
                                                                null
                                                                ?

                                                            Container(
                                                                height: 200,
                                                                margin:
                                                                EdgeInsets.only(top: 0),
                                                                child: ClipRRect(
                                                                    borderRadius:
                                                                    BorderRadius.all(
                                                                        Radius.circular(
                                                                            20)),
                                                                    child:
                                                                    imageFileTypes.indexOf(userAllLikes.userLikesAll[index]
                                                                        .repeat
                                                                        .post
                                                                        .split('.')
                                                                        .last) !=
                                                                        -1
                                                                        ? Padding(
                                                                      padding: EdgeInsets.only(
                                                                          top: 2.0,
                                                                          left: 8.0,
                                                                          right: 8.0,
                                                                          bottom: 10),
                                                                      child:
                                                                      Container(
                                                                        height:
                                                                        200,
                                                                        margin:
                                                                        EdgeInsets.only(top: 5),
                                                                        child:
                                                                        ClipRRect(
                                                                          borderRadius: BorderRadius.all(Radius.circular(12)),
                                                                          child: OverflowBox(
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
                                                                                      filePaths: userAllLikes.userLikesAll[index].repeat.post,
                                                                                      likesMainTabData: userAllLikes.userLikesAll[index],
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                              child: CachedNetworkImage(fit: BoxFit.cover, imageUrl: getImageUrl(userAllLikes.userLikesAll[index].repeat.post)),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                        : Stack(
                                                                      children: [
                                                                        GestureDetector(
                                                                          onTap: () {
                                                                            Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlayerNew(filePaths: userAllLikes.userLikesAll[index].repeat.post)));
                                                                          },
                                                                          child: LayoutBuilder(
                                                                            builder: (BuildContext context, BoxConstraints constraints) {
                                                                              return Container(
                                                                                height: 450,
                                                                                width: 320,
                                                                                child: OverflowBox(
                                                                                  minWidth: 320,
                                                                                  minHeight: 200,
                                                                                  maxHeight: 400,
                                                                                  maxWidth: 320,
                                                                                  child: CachedNetworkImage(fit: BoxFit.cover, imageUrl: getImageUrl(userAllLikes.userLikesAll[index].repeat.thumbnailUrl)),
                                                                                ),
                                                                              );
                                                                            },
                                                                          ),
                                                                        ),
                                                                        Positioned(
                                                                            top: 80,
                                                                            left: 135,
                                                                            child: GestureDetector(
                                                                              onTap: () {
                                                                                Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlayerNew(filePaths: userAllLikes.userLikesAll[index].repeat.post)));
                                                                              },
                                                                              child: ClipOval(
                                                                                child: Material(
                                                                                  color: HexColor(
                                                                                      "D41B47"),
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
                                                                : Container(),



                                                          ],
                                                        ),
                                                      ):Container()
                                                  ),
                                                )
                                                    : Container(),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 5,
                                                      left: 10,
                                                      right: 10.0,
                                                      bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceEvenly,
                                                    children: <Widget>[
                                                      // _getCommentWidget(
                                                      //     mediaSubTabRepo.userMediaAll[index]
                                                      //         .like
                                                      //         .contains(
                                                      //         dashBoardProviderRepo
                                                      //             .userId)
                                                      //         ? Icons.favorite
                                                      //         : Icons.favorite,
                                                      //     mediaSubTabRepo
                                                      //         .userMediaAll[index]
                                                      //         .like.length
                                                      //         .toString(),
                                                      //     0,
                                                      //     mediaSubTabRepo
                                                      //         .userMediaAll[index].profilePic.toString(),
                                                      //     mediaSubTabRepo,
                                                      //     dashBoardProviderRepo,
                                                      //     mediaSubTabRepo
                                                      //         .userMediaAll[index]
                                                      //         .profilePic
                                                      // ),
                                                      userAllLikes.userLikesAll[index].type == "posts" || userAllLikes.userLikesAll[index].type == "repeat"
                                                          ?  GestureDetector(
                                                          onTap: () {
                                                            // print('printinggg');
                                                            // print(userId);
                                                            // print(feedProviderRepo
                                                            //     .feedList[index].like
                                                            //     .contains(userId));
                                                            userAllLikes.likeOrDislikeTabLike(
                                                                context,
                                                                userAllLikes.userLikesAll[index].id,
                                                                userAllLikes.likeCollection);

                                                            // feedProviderRepo
                                                            //     .getFeedUserInfo(
                                                            //     feedProviderRepo
                                                            //         .feedList[index]
                                                            //         .id);
                                                          },
                                                          child: Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.start,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment.center,
                                                              children: [
                                                                userAllLikes.userLikesAll[index]
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
                                                                  "${userAllLikes.userLikesAll[index].like.length}",
                                                                  style: TextStyle(
                                                                      color: Colors.grey,
                                                                      fontSize: 15),
                                                                ),
                                                              ]))
                                                          :  GestureDetector(
                                                          onTap: () {
                                                            // print('printinggg');
                                                            // print(userId);
                                                            // print(feedProviderRepo
                                                            //     .feedList[index].like
                                                            //     .contains(userId));
                                                            userAllLikes.likeOrDislikeTabLikeComment(
                                                                context,
                                                                userAllLikes.userLikesAll[index].id,
                                                                userAllLikes.likeCollection);

                                                            // feedProviderRepo
                                                            //     .getFeedUserInfo(
                                                            //     feedProviderRepo
                                                            //         .feedList[index]
                                                            //         .id);
                                                          },
                                                          child: Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.start,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment.center,
                                                              children: [
                                                                userAllLikes.userLikesAll[index]
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
                                                                  "${userAllLikes.userLikesAll[index].like.length}",
                                                                  style: TextStyle(
                                                                      color: Colors.grey,
                                                                      fontSize: 15),
                                                                ),
                                                              ])),
                                                      _getCommentLikeTabWidget(
                                                        userAllLikes.userLikesAll[index].commentCheck.contains(userId) !=null ? commentRed : commentIcon,
                                                        // commentIcon,
                                                        userAllLikes.userLikesAll[index].commentCount,
                                                        1,
                                                        userAllLikes.userLikesAll[index],
                                                        userAllLikes,
                                                        dashBoardProviderRepo,
                                                        userAllLikes.userLikesAll[index].profilePic,
                                                        //mediaSubTabRepo.mediaCategoryIdnId,
                                                      ),
                                                      _getCommentLikeTabWidget(
                                                        repostNewImage,
                                                        userAllLikes.userLikesAll[index].repost.length,
                                                        2,
                                                        userAllLikes.userLikesAll[index],
                                                        userAllLikes,
                                                        dashBoardProviderRepo,
                                                        userAllLikes.userLikesAll[index].profilePic,
                                                        //mediaSubTabRepo.mediaCategoryIdnId,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                      ],
                                    ),
                                  ),
                                Divider(
                                  height: 1,
                                  thickness: 0.5,
                                  color: Colors.grey,
                                ),
                              ])),
                              onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailsPost(
                                          id: userAllLikes.userLikesAll[index].id,
                                          likesrepeatdetails: userAllLikes.userLikesAll[index],
                                        )));
                          },
                          );
                                  // :Container()):Container();
                    },
                    childCount: userAllLikes.userLikesAll.length,
                  ),
                ),
              ),
            ],
          );
        },
      );
    });
  }


  _getCommentLikeTabWidget(iconData, text1, i, Datum postDetails,
      userAllLikes, dashBoardProviderRepo, userReplyProfile) {
    return GestureDetector(
      onTap: () => {
        _handleOnLikeTabTap(i, postDetails, userAllLikes, dashBoardProviderRepo,
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

  _handleOnLikeTabTap(int i, Datum postDetails, userAllLikes,
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

      userAllLikes.likeOrDislike(context, postDetails.id, postDetails.like);
    } else if (i == 1) {
      print("${postDetails.postPhoto}");
      // postDetails.type == "post" ?
      postDetails.type == "posts" || postDetails.type == "repeat" ?
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
              dataLikeMain: dataLikeMain,
              dataLikeId: widget.userId,
              catId: postDetails.category,
              subcateId: postDetails.subCategory,

              // profilepic: postDetails.postPhoto,
            )),
      )
          :
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SubCommentPostReply(
              parentId: postDetails.id,
              parentUserId: postDetails.profileId,
              grandParentId: postDetails.parentId,
              //replying: postDetails.replyingUser2,
              commentPicUser: postDetails.profilePic,
              userProfile: userReplyProfile,
              replyingSecondaryName: postDetails.userName,
              replyingUserName:postDetails.name ,
              // dataMedia : dataCheck,
              dataLikeId: widget.userId,
              dataLikeAll: dataLikeAll,

              // profilepic: postDetails.postPhoto,
            )),

      );
      //     : Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) => SubCommentPostReply(
      //         parentId: postDetails.id,
      //         // parentUserId: postDetails.,
      //         grandParentId: postDetails.parentId,
      //         replying: postDetails.userName,
      //         commentPicUser: postDetails.profilePic,
      //         userProfile: userReplyProfile,
      //         replyingSecondaryName: postDetails.name,
      //         replyingUserName: postDetails.userName,
      //         //replyingName: postDetails.userName
      //         // profilepic: postDetails.postPhoto,
      //       )),
      // );
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
      _modalBottomSheetLikeTabMenu(i, postDetails);
    }
  }

  void _modalBottomSheetLikeTabMenu(int i, Datum postDetails) {
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
                                postDetails.type == "posts" || postDetails.type == "repeat" ?
                                GestureDetector(
                                  onTap: () async {
                                    print("repeattttttttt ksfbdhb");
                                    print(postDetails.toJson());
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RepeatCommentPost(
                                                 postDetailsLike: postDetails,
                                                  adminPicUser:
                                                  dashBoardProviderRepo
                                                      .userProfilePic)
                                      ),
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
                                )
                                    :  GestureDetector(
                                  onTap: () async{
                                    await  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => RepeatInsideSubComment(
                                        likeAllTabProfile: postDetails,
                                          adminPicUser:
                                          dashBoardProviderRepo
                                              .userProfilePic
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
