import 'package:async_loader/async_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_system/animation/animation.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/dashboard/deatailsPost.dart';
import 'package:farm_system/feature/farm_post/RepeatDetail/view/repeatPostFull.view.dart';
import 'package:farm_system/feature/farm_post/newVideoFullpage.dart';
import 'package:farm_system/feature/feed/comment/view/commentforpost.view.dart';
import 'package:farm_system/feature/feed/models/ModelBasedonPostId.dart';
import 'package:farm_system/feature/feed/models/getFeed.model.dart';
import 'package:farm_system/feature/feed/repeat/view/repeatComment.view.dart';
import 'package:farm_system/feature/feed/repo/feedRepo.dart';
import 'package:farm_system/feature/feed/view/fullpagepost.view.dart';
import 'package:farm_system/feature/feed/view/readmoretext.dart';
import 'package:farm_system/feature/profile_user/view/profile_tabs/farmpost/view/profileSubTabDetailsShimmer.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/screen/Discovery/all_element.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:video_player/video_player.dart';

import '../../../../../utils.dart';
import '../../profiletab.dart';
import 'modal/userProfileAllData.modal.dart';
import 'package:hexcolor/hexcolor.dart';

class AllTab extends StatefulWidget {
  final String id;
  final String userId;

  const AllTab({Key key, this.id, this.userId}) : super(key: key);

  @override
  _AllTabState createState() => _AllTabState();
}

class _AllTabState extends State<AllTab> {
  bool favorite = false;
  bool repost = false;
  final _asyncKey = GlobalKey<AsyncLoaderState>();
  VideoPlayerController _controller;
  VoidCallback videoPlayerListener;
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
  void dispose() {
    // TODO: implement dispose
    if (_controller != null) {
      _controller.dispose();
    }
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

  // void getVideoFile(fileUrl) async {
  //   print(fileUrl);
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
  //     await vcontroller.setLooping(true);
  //     await vcontroller.initialize();
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
  Widget build(BuildContext context) {

    print("new idddd");
    print(widget.userId);
    return SafeArea(
        top: false,
        bottom: false,
        child: Consumer(builder: (context, watch, child) {
          final userProfileAllRepo = watch(userAllProvider);
          return AsyncLoader(
            key: _asyncKey,
            initState: () => userProfileAllRepo.userProfileAll(widget.userId),
            renderLoad: () => ProfileSubTabDetailsShimmer(),
            renderError: ([err]) => Text('There was a error'),
            renderSuccess: ({data}) => _generateUINew(),
          );
        }));
  }

  _generateUINew() {
    return Consumer(builder: (context, watch, child) {
      final userProfileAllRepo = watch(userAllProvider);
      final profileRepo = watch(profileProvider);

      final dashBoardProviderRepo = watch(dashboardProvider);
      return Builder(
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
                          .difference(
                              userProfileAllRepo.userAll[index].createdAt)
                          .inDays;
                      if (userProfileAllRepo.userAll[index].postPhoto.length >
                              0 &&
                          imageFileTypes.indexOf(getImageUrl(userProfileAllRepo
                                      .userAll[index].postPhoto[0].location)
                                  .split('.')
                                  .last) ==
                              -1) {
                        // getVideoFile(getImageUrl(
                        //     userProfileAllRepo.userAll[index].postPhoto[0].location));
                      }
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailsPost(
                                          id: userProfileAllRepo
                                              .userAll[index].id,
                                          fullPostProfileAll:
                                              userProfileAllRepo.userAll[index],
                                        )));
                          },
                          child:
                          Container(
                              child: Column(children: [
                            Padding(
                              padding: EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0, top: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    // padding: EdgeInsets.all(8.0),
                                    padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0, top: 4),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
                                      child: userProfileAllRepo
                                                  .userAll[index].profilePic ==
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
                                                  userProfileAllRepo
                                                      .userAll[index]
                                                      .profilePic)),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(top: 4.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                child: userProfileAllRepo
                                                                .userAll[index]
                                                                .name !=
                                                            "" &&
                                                        userProfileAllRepo
                                                                .userAll[index]
                                                                .name !=
                                                            null
                                                    ? Text(
                                                        Utils.getCapitalizeName(
                                                            '${userProfileAllRepo.userAll[index].name}'),
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                letterSpacing:
                                                                    0.5,
                                                                color: HexColor(
                                                                    "#FFFFFF")))
                                                    : Text(" "),
                                              ),
                                              SizedBox( width: 2),
                                              Container(
                                                  child: userProfileAllRepo.userAll[index].userName != null
                                                      ? Text(
                                                          '@${userProfileAllRepo.userAll[index].userName.toString()}',
                                                          style: GoogleFonts.montserrat(
                                                                  fontSize: 13,
                                                                  fontWeight: FontWeight.normal,
                                                                  letterSpacing: 0.5,
                                                                  color: HexColor("#666666")))
                                                      : Text("")),
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
                                                              userProfileAllRepo
                                                                  .userAll[
                                                                      index]
                                                                  .createdAt),
                                                          style: GoogleFonts.montserrat(
                                                                  fontSize: 9,
                                                                  color: HexColor("#888888"),
                                                                  fontWeight: FontWeight.w400
                                                                  ))
                                                      : Text(
                                                          DateFormat('dd-MMM').format(
                                                              userProfileAllRepo
                                                                  .userAll[
                                                                      index]
                                                                  .createdAt),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 9),
                                                        ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 1.0, bottom: 5),
                                          child: Visibility(
                                            visible: userProfileAllRepo
                                                    .userAll[index].caption !=
                                                null,
                                            child: Container(
                                              alignment: Alignment.topLeft,
                                              child: ReadMoreText(
                                                  userProfileAllRepo.userAll[index].caption ?? '',
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      letterSpacing: 0.5,
                                                      color:HexColor('#FFFFFF')
                                                  )
                                                  // )
                                                  ),
                                            ),
                                          ),
                                        ),
                                        userProfileAllRepo
                                                    .userAll[index].textFeed ==
                                                false
                                            ? Padding(
                                                padding: EdgeInsets.only(left: 0),
                                                child: userProfileAllRepo.userAll[index].postPhoto.length > 0
                                                        ? Container(
                                                            height: 200,
                                                            margin: EdgeInsets.only(top: 10),
                                                            child: ClipRRect(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20)),
                                                                child: imageFileTypes.indexOf(userProfileAllRepo
                                                                            .userAll[index]
                                                                            .postPhoto[0]
                                                                            .location
                                                                            .split('.')
                                                                            .last) !=
                                                                        -1
                                                                    ? GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                builder: (context) => FullPagePostView(
                                                                                  filePaths: userProfileAllRepo.userAll[index].postPhoto[0].location,
                                                                                  postProfileAllData: userProfileAllRepo.userAll[index],
                                                                                ),
                                                                              ));
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          height: 450,
                                                                          width: 320,
                                                                          color: Colors.grey[900],
                                                                          child: OverflowBox(
                                                                            minWidth: 320,
                                                                            minHeight: 200,
                                                                            maxHeight: 400,
                                                                            maxWidth: 320,
                                                                            child: Hero(
                                                                              tag: 'pop ${userProfileAllRepo.userAll[index].postPhoto[0].location}',
                                                                              child: CachedNetworkImage(fit: BoxFit.cover, imageUrl: getImageUrl(userProfileAllRepo.userAll[index].postPhoto[0].location)),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : Stack(
                                                                        children: [
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlayerNew(filePaths: userProfileAllRepo.userAll[index].postPhoto[0].location)));
                                                                            },
                                                                            child:
                                                                                LayoutBuilder(
                                                                              builder: (BuildContext context, BoxConstraints constraints) {
                                                                                return Container(
                                                                                  height: 450,
                                                                                  width: 320,
                                                                                  child: OverflowBox(
                                                                                    minWidth: 320,
                                                                                    minHeight: 200,
                                                                                    maxHeight: 400,
                                                                                    maxWidth: 320,
                                                                                    child: CachedNetworkImage(fit: BoxFit.cover, imageUrl: getImageUrl(userProfileAllRepo.userAll[index].postPhoto[0].thumbnailUrl)),
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
                                                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlayerNew(filePaths: userProfileAllRepo.userAll[index].postPhoto[0].location)));
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
                                                                      )
                                                                ),
                                                          )
                                                        : Container(),
                                              )
                                            : Container(),

                                        userProfileAllRepo.userAll[index].repeat
                                                    .name !=
                                                null
                                            ? GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              RepeatPostFullView(
                                                                id: userProfileAllRepo
                                                                    .userAll[
                                                                        index]
                                                                    .repeat
                                                                    .repeatingId,
                                                              )));
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(left: 0, right: 20.0, top: 3.0, bottom: 3.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Color(0XFFDADADA)),
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(10.0)),
                                                        color: Colors.transparent),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              userProfileAllRepo.userAll[index]
                                                                  .repeat.textFeed ==
                                                                  false
                                                                  ? Container(
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsets.all(0.0),
                                                                      child: Row(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsets.only(top: 4.0, left: 8, right: 8, bottom: 4),
                                                                            child: InkWell(
                                                                              onTap: () {
                                                                                navigationToScreen(
                                                                                    context,
                                                                                    ProfileTab(
                                                                                        userId: userProfileAllRepo.userAll[index]
                                                                                            .repeat
                                                                                            .profileId),
                                                                                    false);
                                                                              },
                                                                              child: ClipRRect(
                                                                                borderRadius: BorderRadius
                                                                                    .all(Radius
                                                                                    .circular(
                                                                                    25)),
                                                                                child:userProfileAllRepo.userAll[index]
                                                                                    .repeat
                                                                                    .profilePic ==
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
                                                                                    imageUrl: getImageUrl(userProfileAllRepo.userAll[index].repeat.profilePic)),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child: Column(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                Padding(
                                                                                    padding: EdgeInsets.only(top: 0.0),
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: EdgeInsets.only(left: 2, top: 4),
                                                                                        child: userProfileAllRepo.userAll[index]
                                                                                            .repeat
                                                                                            .name !=
                                                                                            "" &&
                                                                                            userProfileAllRepo.userAll[index]
                                                                                                .repeat
                                                                                                .name !=
                                                                                                null
                                                                                            ? InkWell(
                                                                                          onTap: () {
                                                                                            navigationToScreen(
                                                                                                context,
                                                                                                ProfileTab(
                                                                                                    userId: userProfileAllRepo.userAll[index]
                                                                                                        .repeat.profileId),
                                                                                                false);
                                                                                          },
                                                                                          child: Text(
                                                                                              Utils.getCapitalizeName(
                                                                                                  '${userProfileAllRepo.userAll[index]
                                                                                                      .repeat.name}'),
                                                                                              style: GoogleFonts.montserrat(
                                                                                                  fontSize:
                                                                                                  18,
                                                                                                  fontWeight:
                                                                                                  FontWeight.bold,
                                                                                                  color: Color(0xff666666))),
                                                                                        )
                                                                                            : Text(" "),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsets.only(left: 2, top: 4),
                                                                                        child: userProfileAllRepo.userAll[index]
                                                                                            .repeat
                                                                                            .userName !=
                                                                                            "" &&
                                                                                            userProfileAllRepo.userAll[index]
                                                                                                .repeat
                                                                                                .userName !=
                                                                                                null
                                                                                            ? InkWell(
                                                                                          onTap: () {
                                                                                            navigationToScreen(
                                                                                                context,
                                                                                                ProfileTab(
                                                                                                    userId: userProfileAllRepo.userAll[index]
                                                                                                        .repeat.profileId),
                                                                                                false);
                                                                                          },
                                                                                          child: Text(
                                                                                              '@${userProfileAllRepo.userAll[index]
                                                                                                  .repeat.userName}',
                                                                                              style: GoogleFonts.montserrat(
                                                                                                  fontSize: 12,
                                                                                                  fontWeight: FontWeight.normal,
                                                                                                  color: Color(0xff666666))),
                                                                                        )
                                                                                            : Text(" "),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsets.only(right: 10),
                                                                                  child: Container(
                                                                                    alignment: Alignment.topLeft,
                                                                                    child: ReadMoreText(
                                                                                        userProfileAllRepo.userAll[index]
                                                                                            .repeat
                                                                                            .message ??
                                                                                            '',
                                                                                        style: GoogleFonts
                                                                                            .montserrat(
                                                                                            fontSize: 14,
                                                                                            fontWeight:
                                                                                            FontWeight
                                                                                                .normal,
                                                                                            color:HexColor('#FFFFFF'),
                                                                                            letterSpacing:
                                                                                            0.5)),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),

                                                                  ],
                                                                ),
                                                              ):
                                                              Padding(
                                                                padding:
                                                                EdgeInsets.all(0.0),
                                                                child: Row(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsets.all(8.0),
                                                                      child: ClipRRect(
                                                                        borderRadius: BorderRadius
                                                                            .all(Radius
                                                                            .circular(
                                                                            25)),
                                                                        child: userProfileAllRepo.userAll[index]
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
                                                                              fit: BoxFit
                                                                                  .cover,
                                                                              image:
                                                                              NetworkImage("https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"),
                                                                            ),
                                                                            borderRadius:
                                                                            BorderRadius.all(Radius.circular(25.0)),
                                                                            color: Colors
                                                                                .redAccent,
                                                                          ),
                                                                        )
                                                                            : InkWell(
                                                                          onTap:
                                                                              () {
                                                                            navigationToScreen(
                                                                                context,
                                                                                ProfileTab(userId: userProfileAllRepo.userAll[index]
                                                                                    .repeat.profileId),
                                                                                false);
                                                                          },
                                                                          child: CachedNetworkImage(
                                                                              fit: BoxFit.fill,
                                                                              height: 45,
                                                                              width: 45,
                                                                              imageUrl: getImageUrl(userProfileAllRepo.userAll[index].repeat.profilePic)
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                        child: Column(
                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                            children: [
                                                                              Padding(
                                                                                padding: EdgeInsets.only(top: 4.0),
                                                                                child: Row(
                                                                                  children: [
                                                                                    Padding(
                                                                                        padding: EdgeInsets.only(left: 1, top: 0),
                                                                                        child:
                                                                                        InkWell(
                                                                                          onTap:
                                                                                              () {
                                                                                            navigationToScreen(context, ProfileTab(userId: userProfileAllRepo.userAll[index]
                                                                                                .repeat.profileId), false);
                                                                                          },
                                                                                          child:
                                                                                          Container(
                                                                                            child: userProfileAllRepo.userAll[index]
                                                                                                .repeat.userName != "" && userProfileAllRepo.userAll[index]
                                                                                                .repeat.userName != null
                                                                                                ? Text(Utils.getCapitalizeName('${userProfileAllRepo.userAll[index]
                                                                                                .repeat.name}'),
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
                                                                                    SizedBox(
                                                                                      width:
                                                                                      5.0,
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: EdgeInsets.only(
                                                                                          left: 0,
                                                                                          top: 1
                                                                                      ),
                                                                                      child:
                                                                                      InkWell(
                                                                                        onTap:
                                                                                            () {
                                                                                          navigationToScreen(
                                                                                              context,
                                                                                              ProfileTab(userId:userProfileAllRepo.userAll[index]
                                                                                                  .repeat.profileId),
                                                                                              false);
                                                                                        },
                                                                                        child:
                                                                                        Container(
                                                                                          child:userProfileAllRepo.userAll[index]
                                                                                              .repeat.userName != "" && userProfileAllRepo.userAll[index]
                                                                                              .repeat.userName != null
                                                                                              ? Text('@${userProfileAllRepo.userAll[index]
                                                                                              .repeat.userName}', style: GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.normal, color: Color(0xff666666)))
                                                                                              : Text(" "),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              Padding(
                                                                               padding: EdgeInsets.only(top: 1, bottom: 5),
                                                                                child:
                                                                                Container(
                                                                                  alignment:
                                                                                  Alignment
                                                                                      .topLeft,
                                                                                  child: ReadMoreText(
                                                                                      userProfileAllRepo.userAll[index]
                                                                                          .repeat.message ??
                                                                                          '',
                                                                                      style: GoogleFonts.montserrat(
                                                                                          fontSize:
                                                                                          13,
                                                                                          fontWeight:
                                                                                          FontWeight.normal,
                                                                                          color:HexColor('#FFFFFF'),
                                                                                          letterSpacing: 0.5)),
                                                                                ),
                                                                              )
                                                                            ])),
                                                                  ],
                                                                ),
                                                              ),
                                                              userProfileAllRepo.userAll[index].repeat.textFeed ==
                                                                  false
                                                                  ?
                                                                  userProfileAllRepo.userAll[index].repeat.post !=
                                                                          null
                                                                      ?

                                                                  Container(
                                                                      height: 200,
                                                                      margin:
                                                                      EdgeInsets.only(
                                                                          top: 0),
                                                                      child: ClipRRect(
                                                                          borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(
                                                                                  20)),
                                                                          child:
                                                                          imageFileTypes.indexOf(userProfileAllRepo
                                                                              .userAll[index]
                                                                              .repeat
                                                                              .post
                                                                              .split('.')
                                                                              .last) !=
                                                                              -1
                                                                              ? Padding(
                                                                            padding: EdgeInsets.only(
                                                                                top: 0.0,
                                                                                left: 8.0,
                                                                                right: 8.0,
                                                                                bottom: 10),
                                                                            child:
                                                                            Container(
                                                                              height: 200,
                                                                              margin: EdgeInsets.only(top: 5),
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
                                                                                            filePaths: userProfileAllRepo.userAll[index].repeat.post,
                                                                                            postProfileAllData: userProfileAllRepo.userAll[index],

                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                    child: CachedNetworkImage(fit: BoxFit.cover, imageUrl: getImageUrl(userProfileAllRepo.userAll[index].repeat.post)),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                              :  Stack(
                                                                            children: [
                                                                              GestureDetector(
                                                                                onTap:
                                                                                    () {
                                                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlayerNew(filePaths: (userProfileAllRepo.userAll[index].repeat.post))));
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
                                                                                            child: CachedNetworkImage(fit: BoxFit.cover, imageUrl: getImageUrl(userProfileAllRepo.userAll[index].repeat.thumbnailUrl)),
                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Positioned(
                                                                                  top: 90,
                                                                                  left: 135,
                                                                                  child: GestureDetector(
                                                                                    onTap: () {
                                                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlayerNew(filePaths: userProfileAllRepo.userAll[index].repeat.post)));
                                                                                    },
                                                                                    child: ClipOval(
                                                                                      child: Material(
                                                                                        color: Colors.blue,
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
                                                        ),
                                                )
                                              )
                                            : Container(),

                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: 5,
                                              left: 10,
                                              right: 10.0,
                                              bottom: 5.0),
                                          child:
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: [
                                                  // GestureDetector(
                                                  //     onTap: () {
                                                  //       // print('printinggg');
                                                  //       // print(userId);
                                                  //       // print(feedProviderRepo
                                                  //       //     .feedList[index].like
                                                  //       //     .contains(userId));
                                                  //       userProfileAllRepo.likeOrDislike(
                                                  //           context,
                                                  //           userProfileAllRepo.userAll[index].id,
                                                  //           userProfileAllRepo
                                                  //               .likeCollection);
                                                  //
                                                  //       userProfileAllRepo
                                                  //           .userProfileAll(
                                                  //           userProfileAllRepo.userAll[index].id);
                                                  //     },
                                                  //     child: Row(
                                                  //         mainAxisAlignment:
                                                  //         MainAxisAlignment.start,
                                                  //         crossAxisAlignment:
                                                  //         CrossAxisAlignment.center,
                                                  //         children: [
                                                  //           userProfileAllRepo.userAll[index]
                                                  //               .like
                                                  //               .contains(
                                                  //               userId) ==
                                                  //               true
                                                  //               ? Icon(Icons.favorite,
                                                  //               color: Colors.red)
                                                  //               : Icon(Icons.favorite,
                                                  //               color: Colors.grey),
                                                  //           // Icon(Icons.favorite,
                                                  //           //     color: feedProviderRepo.feedList[index].like.contains(userId)
                                                  //           //         ? Colors.red
                                                  //           //         : Colors.grey),
                                                  //           Text(
                                                  //             "${ userProfileAllRepo.userAll[index].like.length}",
                                                  //             style: TextStyle(
                                                  //                 color: Colors.grey,
                                                  //                 fontSize: 15),
                                                  //           ),
                                                  //         ])),

                                                  GestureDetector(
                                                      onTap: () async {

                                                        // print('printinggg');
                                                        // print(userId);
                                                        // print( userProfileAllRepo
                                                        //     .likeCollection);
                                                        userProfileAllRepo.likeOrDislike(
                                                            context,
                                                            userProfileAllRepo.userAll[index].id,
                                                            userProfileAllRepo
                                                                .likeCollection);

                                                        // await   feedProviderRepo
                                                        //        .getFeedUserInfo(
                                                        //        feedProviderRepo.commentList[index].id);
                                                        // await userProfileAllRepo
                                                        //     .userProfileAll(
                                                        //   userProfileAllRepo.userAll[index].id);
                                                      },
                                                      child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            userProfileAllRepo.userAll[index].like.contains(
                                                                userId) == true
                                                                ?
                                                            Icon(Icons.favorite,
                                                                color: Colors.red)
                                                                : Icon(Icons.favorite,
                                                                color: Colors.grey),
                                                            Text(
                                                              "${userProfileAllRepo.userAll[index].like.length}",
                                                              style: TextStyle(
                                                                  color: Colors.grey,
                                                                  fontSize: 15),
                                                            ),
                                                          ])),
                                                ],
                                              ),
                                              // _getCommentWidget(
                                              //     userProfileAllRepo
                                              //             .userAll[index].like
                                              //             .contains(
                                              //                 dashBoardProviderRepo
                                              //                     .userId)
                                              //         ? Icons.favorite
                                              //         : Icons.favorite,
                                              //     userProfileAllRepo
                                              //         .userAll[index]
                                              //         .like
                                              //         .length
                                              //         .toString(),
                                              //     0,
                                              //     userProfileAllRepo
                                              //         .userAll[index],
                                              //     userProfileAllRepo,
                                              //     dashBoardProviderRepo,
                                              //     userProfileAllRepo
                                              //         .userAll[index]
                                              //         .profilePic),
                                              _getCommentWidget(
                                                  // userProfileAllRepo
                                                  //         .userAll[index].like
                                                  //         .contains(
                                                  //             dashBoardProviderRepo
                                                  //                 .userId)
                                                  //     ? commentIcon
                                                  //     : commentIcon,
                                                  // commentIcon,
                                                  userProfileAllRepo.userAll[index].commentCheck.contains(userId) == true ?   commentRed : commentIcon,
                                                  userProfileAllRepo
                                                      .userAll[index]
                                                      .commentCount,
                                                  1,
                                                  userProfileAllRepo
                                                      .userAll[index],
                                                  userProfileAllRepo,
                                                  dashBoardProviderRepo,
                                                  userProfileAllRepo
                                                      .userAll[index]
                                                      .profilePic),
                                              _getCommentWidget(
                                                  userProfileAllRepo.userAll[index].repost.contains(userId) == true ?   repostColor : repostNewImage,
                                                  userProfileAllRepo
                                                      .userAll[index]
                                                      .repost
                                                      .length,
                                                  2,
                                                  userProfileAllRepo
                                                      .userAll[index],
                                                  userProfileAllRepo,
                                                  dashBoardProviderRepo,
                                                  userProfileAllRepo
                                                      .userAll[index]
                                                      .profilePic),
                                            ],
                                          ),
                                        ),
                                        // Divider(
                                        //   height: 1,
                                        //   thickness: 1,
                                        //   color: Colors.grey,
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              height: 1,
                              thickness: 0.5,
                              color: Colors.grey,
                            ),
                          ])));
                    },
                    childCount: userProfileAllRepo.userAll.length,
                  ),
                ),
              ),
            ],
          );
        },
      );
    });
  }

  _getCommentWidget(iconData, text1, i, Datum postDetails, userProfileAllRepo,
      dashBoardProviderRepo, userReplyProfile) {
    return GestureDetector(
      onTap: () => {
        _handleOnTap(i, postDetails, userProfileAllRepo, dashBoardProviderRepo,
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

  _handleOnTap(int i, Datum postDetails, userProfileAllRepo,
      dashBoardProviderRepo, userReplyProfile) {



    if (i == 0) {
      setState(() {
        if (favorite == true) {
          favorite = false;
        } else {
          favorite = true;
        }
      });

      userProfileAllRepo.likeOrDislikes(
          context, postDetails.id, postDetails.like);
    } else if (i == 1) {
      // print("${postDetails.postPhoto}");

      print(postDetails.id);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CommentForPost(
              famAll : widget.userId,
                postId: postDetails.id,
                post: postDetails.userName,
                postSecondaryName: postDetails.name,
                profilePicUser: userReplyProfile,
                adminPicUser: dashBoardProviderRepo.userProfilePic)),
      );
      print("Comment");
    } else {
      _modalBottomSheetMenu(i, postDetails);
    }
  }

  void _modalBottomSheetMenu(int i, Datum postDetails) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        context: context,
        builder: (builder) {
          return SingleChildScrollView(child: Consumer(
            builder: (context, watch, child) {
              final repostProvider = watch(feedProvider);
              final userProfileAllRepo = watch(userAllProvider);
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
                                    Future.delayed(Duration(seconds: 1), () async{
                                    //  await profileSubTabRepo.profileSubCategoryIndividual(profileSubTabRepo.profileCategoryIdnId);
                                      await userProfileAllRepo.userProfileAll(widget.userId);
                                    });
                                    // await profileSubTabRepo.profileSubCategoryIndividual(profileSubTabRepo.profileCategoryIdnId);

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
                                                allUserDetails: postDetails,
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
