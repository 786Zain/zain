import 'package:async_loader/async_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/dashboard/viewImageOrVIdeo.dart';
import 'package:farm_system/feature/farm_post/RepeatDetail/view/repeatPostFull.view.dart';
import 'package:farm_system/feature/farm_post/newVideoFullpage.dart';
import 'package:farm_system/feature/feed/comment/view/commentforpost.view.dart';
import 'package:farm_system/feature/feed/models/ModelBasedonPostId.dart';
import 'package:farm_system/feature/feed/models/getFeed.model.dart';
import 'package:farm_system/feature/feed/repeat/view/repeatComment.view.dart';
import 'package:farm_system/feature/feed/repeatSubComment/view/repeatSubComment.view.dart';
import 'package:farm_system/feature/feed/repo/feedRepo.dart';
import 'package:farm_system/feature/feed/subCommentFullView/view/subcommentfull.view.dart';
import 'package:farm_system/feature/feed/subcommentPostReply/view/subcomment.view.dart';
import 'package:farm_system/feature/feed/view/fullpagepost.view.dart';
import 'package:farm_system/feature/feed/view/readmoretext.dart';
import 'package:farm_system/feature/profile_user/view/Likes/model/likeSubTab_model.dart';
import 'package:farm_system/feature/profile_user/view/profile_tabs/farmpost/modal/profileSubCategoryIndividual.modal.dart';
import 'package:farm_system/feature/profile_user/view/profile_tabs/farmpost/modal/userProfileAllData.modal.dart';
import 'package:farm_system/feature/profile_user/view/Likes/model/Like_model.dart' as likemodel;
import 'package:farm_system/feature/profile_user/view/profiletab.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/screen/Discovery/all_element.dart';
import 'package:farm_system/screen/Discovery/discovery_model.dart' as dis;
import 'package:farm_system/storage.dart';
import 'package:farm_system/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:video_player/video_player.dart';
import 'package:farm_system/models/sub_category_models.dart';

class DetailsPost extends StatefulWidget {
  final String id;
  final FeedDetail repeatDetails;
  final isFromDiscover;
  final dis.Feed discoveryDetail;
  final Datum fullPostProfileAll;
  final Datums fullSubPostProfileAll;
  final dis.Post discoveryother;
  final bool hideImage;
  final PostFeed discoverySeeAll;
  final likemodel.Datum likesrepeatdetails;
  final LikeSubTab likesubtabrepeatdetails;

  const DetailsPost({Key key,
    this.id,
    this.repeatDetails,
    this.isFromDiscover,
    this.discoveryDetail,
    this.fullPostProfileAll,
    this.fullSubPostProfileAll,
    this.discoveryother,
    this.hideImage,
    this.discoverySeeAll,
    this.likesrepeatdetails,
    this.likesubtabrepeatdetails,
  })
      : super(key: key);

  @override
  _DetailsPostState createState() => _DetailsPostState();
}

class _DetailsPostState extends State<DetailsPost> {
  final _asyncKey = GlobalKey<AsyncLoaderState>();
  bool favorite = false;
  VideoPlayerController _controller;
  VoidCallback videoPlayerListener;

  // void getVideoFile(fileUrl) async {
  //   try {
  //     final VideoPlayerController vcontroller =
  //     VideoPlayerController.network(fileUrl);
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
  //         // _controller = vcontroller;
  //       });
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  var userId;

  @override
  void initState() {
    print(widget.hideImage);
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

  String commentUpdate = 'Post Update';
  bool repostDetail = false;
  bool repostSubComment = false;

  @override
  Widget build(BuildContext context) {
    final _asyncLoader = Consumer(builder: (context, watch, child) {
      final feedProviderRepo = watch(feedProvider);
      final dashBoardProviderRepo = watch(dashboardProvider);

      print(feedProviderRepo.feedList[0].like.length);
      print(dashBoardProviderRepo.userId);

      return AsyncLoader(
          key: _asyncKey,
          initState: () => feedProviderRepo.getFeedUserInfo(widget.id),
          renderLoad: () => SizedBox(),
          renderError: ([err]) =>
              Center(
                child: Text("Error"),
              ),
          renderSuccess: ({data}) => _generateView());
    });

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Padding(
          padding: EdgeInsets.only(top: 18.0),
          child: Container(
              height: 99,
              child: SvgPicture.asset(newLogoFarm,
                  height: 120, width: 120, fit: BoxFit.scaleDown)),
        ),
        centerTitle: true,
        leading: GestureDetector(
            child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
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
              var dt = new DateTime.now();
              var days = dt
                  .difference(feedProviderRepo.feedDetail.post[0].createdAt)
                  .inDays;
              if (feedProviderRepo.feedDetail.post[0].postPhoto.length > 0 &&
                  imageFileTypes.indexOf(getImageUrl(feedProviderRepo
                      .feedDetail.post[0].postPhoto[0].location)
                      .split('.')
                      .last) ==
                      -1) {
              }

              return GestureDetector(
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0, top: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0, top: 4),
                              child: InkWell(
                                onTap: () {
                                  navigationToScreen(
                                      context,
                                      ProfileTab(
                                          userId: feedProviderRepo
                                              .feedDetail.post[0].profileId),
                                      false);
                                },
                                child: ClipRRect(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                                  child: feedProviderRepo
                                      .feedDetail.post[0].profilePic ==
                                      null
                                      ? Image.asset(dummyUser,
                                      fit: BoxFit.fill,
                                      height: 25,
                                      width: 25)
                                      : CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      height: 52,
                                      width: 52,
                                      imageUrl: getImageUrl(feedProviderRepo
                                          .feedDetail.post[0].profilePic)),
                                ),
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
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  child: Container(
                                                    child: feedProviderRepo
                                                        .feedDetail
                                                        .post[0]
                                                        .name !=
                                                        "" &&
                                                        feedProviderRepo
                                                            .feedDetail
                                                            .post[0]
                                                            .name !=
                                                            null
                                                        ? Text(
                                                        Utils.getCapitalizeName(
                                                            '${feedProviderRepo
                                                                .feedDetail
                                                                .post[0]
                                                                .name}'),
                                                        style: GoogleFonts
                                                            .montserrat(
                                                            fontSize: 18,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold,
                                                            color: Colors
                                                                .white))
                                                        : Text(" "),
                                                  ),
                                                  onTap: () {
                                                    navigationToScreen(
                                                        context,
                                                        ProfileTab(
                                                            userId: feedProviderRepo
                                                                .feedDetail
                                                                .post[0]
                                                                .profileId),
                                                        false);
                                                  },
                                                ),
                                                Padding(
                                                  padding:
                                                  EdgeInsets.only(left: 4.0),
                                                  child: InkWell(
                                                    child: Container(
                                                      child: feedProviderRepo
                                                          .feedDetail
                                                          .post[0]
                                                          .userName !=
                                                          "" &&
                                                          feedProviderRepo
                                                              .feedDetail
                                                              .post[0]
                                                              .userName !=
                                                              null
                                                          ? Text(
                                                          '@${feedProviderRepo
                                                              .feedDetail
                                                              .post[0]
                                                              .userName}',
                                                          style: GoogleFonts
                                                              .montserrat(
                                                              fontSize: 13,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              color: Color(
                                                                  0xff666666)))
                                                          : Text(" "),
                                                    ),
                                                    onTap: () {
                                                      navigationToScreen(
                                                          context,
                                                          ProfileTab(
                                                              userId:
                                                              feedProviderRepo
                                                                  .feedDetail
                                                                  .post[0]
                                                                  .profileId),
                                                          false);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            flex: 5,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(right: 4.0),
                                            child: Container(
                                                margin: EdgeInsets.only(top: 0, left: 5),
                                                child: days < 7
                                                    ? Text(
                                                    getTime(feedProviderRepo
                                                        .feedDetail
                                                        .post[0]
                                                        .createdAt),
                                                    style: GoogleFonts
                                                        .montserrat(
                                                        fontSize: 9,
                                                        fontWeight:
                                                        FontWeight.normal,
                                                        color: Color(
                                                            0xff888888)))
                                                    : Text(
                                                    DateFormat('dd-MMM')
                                                        .format(
                                                        feedProviderRepo
                                                            .feedDetail
                                                            .post[0]
                                                            .createdAt),
                                                    style: GoogleFonts
                                                        .montserrat(
                                                        fontSize: 9,
                                                        fontWeight:
                                                        FontWeight.normal,
                                                        color: Color(
                                                            0xff888888))
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 1.0, bottom: 5),
                                      child: Visibility(
                                        visible: feedProviderRepo
                                            .feedDetail.post[0].caption !=
                                            null,
                                        child: Container(
                                          alignment: Alignment.topLeft,
                                          child: ReadMoreText(
                                              feedProviderRepo
                                                  .feedDetail.post[0].caption ??
                                                  '',
                                              colorClickableText: Colors.grey,
                                              style: TextStyle(
                                                fontSize: 15,
                                                letterSpacing: 0.5,
                                                color: Colors.white,
                                              )),
                                        ),
                                      ),
                                    ),
                                    // widget.hideImage != null && !widget.hideImage
                                    //     ?
                                    Padding(
                                        padding: EdgeInsets.only(left: 0),
                                        child: feedProviderRepo.feedDetail.post
                                            .isNotEmpty &&
                                            feedProviderRepo.feedDetail.post[0]
                                                .textFeed == false &&
                                            feedProviderRepo.feedDetail.post[0]
                                                .postPhoto.length >
                                                0
                                            ?
                                        Container(
                                          height: 200,
                                          margin: EdgeInsets.only(
                                              top: 10),
                                          child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(
                                                      20)),
                                              child:
                                              imageFileTypes.indexOf(
                                                  feedProviderRepo
                                                      .feedDetail
                                                      .post[0].postPhoto[0]
                                                      .location
                                                      .split(
                                                      '.')
                                                      .last) !=
                                                  -1
                                                  ? GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                                FullPagePostView(
                                                                    postData: widget
                                                                        .repeatDetails,
                                                                    discoverySeeAll: widget
                                                                        .discoverySeeAll,
                                                                    postDetailsNew: feedProviderRepo
                                                                        .feedDetail
                                                                        .post[0],
                                                                    filePaths: getImageUrl(
                                                                        feedProviderRepo
                                                                            .feedDetail
                                                                            .post[0]
                                                                            .postPhoto[0]
                                                                            .location))));
                                                  },
                                                  child: CachedNetworkImage(
                                                      fit: BoxFit
                                                          .cover,
                                                      height:
                                                      176,
                                                      width:
                                                      338,
                                                      imageUrl:
                                                      getImageUrl(
                                                          feedProviderRepo
                                                              .feedDetail
                                                              .post[0]
                                                              .postPhoto[0]
                                                              .location)))
                                                  : Stack(
                                                children: [
                                                  GestureDetector(
                                                    onTap:
                                                        () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (
                                                                  context) =>
                                                                  VideoPlayerNew(
                                                                      filePaths: feedProviderRepo
                                                                          .feedDetail
                                                                          .post[0]
                                                                          .postPhoto[0]
                                                                          .location)));
                                                    },
                                                    child:
                                                    LayoutBuilder(
                                                      builder:
                                                          (BuildContext context,
                                                          BoxConstraints constraints) {
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
                                                                imageUrl: getImageUrl(
                                                                    feedProviderRepo
                                                                        .feedDetail
                                                                        .post[0]
                                                                        .postPhoto[0]
                                                                        .thumbnailUrl)),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  Positioned(
                                                      top:
                                                      80,
                                                      left:
                                                      135,
                                                      child:
                                                      GestureDetector(
                                                        onTap:
                                                            () {},
                                                        child:
                                                        ClipOval(
                                                          child: Material(
                                                            color: HexColor(
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
                                              )),
                                        )
                                            : Container()),

                                    widget.fullSubPostProfileAll != null &&
                                        widget.fullSubPostProfileAll.repeat
                                            .userName !=
                                            null
                                        ? Container(
                                      child: Text(
                                        "",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                        : widget.fullPostProfileAll != null &&
                                        widget.fullPostProfileAll.repeat
                                            .userName !=
                                            null
                                        ? GestureDetector(
                                      // onTap: () {
                                      //   Navigator.push(
                                      //       context,
                                      //       MaterialPageRoute(
                                      //           builder: (context) =>
                                      //               RepeatPostFullView(
                                      //                 id: widget.repeatDetails
                                      //                     .repeat.repeatingId,
                                      //               )));
                                      // },
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 0, right: 20.0, top: 3.0, bottom: 3.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Color(0XFFDADADA)),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      10.0)),
                                              color: Colors.transparent),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(0.0),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(top: 4.0, left: 8, right: 8, bottom: 4),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                        BorderRadius
                                                            .all(Radius
                                                            .circular(
                                                            25)),
                                                        child: widget.fullPostProfileAll.repeat.profilePic == null
                                                            ? Container(
                                                          width: 60.0,
                                                          height: 60.0,
                                                          decoration:
                                                          BoxDecoration(
                                                            image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage("https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"),
                                                            ),
                                                            borderRadius:
                                                            BorderRadius.all(Radius.circular(30.0)
                                                            ),
                                                            color: Colors.redAccent,
                                                          ),
                                                        )
                                                            : CachedNetworkImage(
                                                            fit: BoxFit.cover,
                                                            height: 45,
                                                            width: 45,
                                                            imageUrl: getImageUrl(
                                                                widget.fullPostProfileAll.repeat.profilePic)
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
                                                                    child: widget
                                                                        .fullPostProfileAll
                                                                        .repeat
                                                                        .name !=
                                                                        "" &&
                                                                        widget
                                                                            .fullPostProfileAll
                                                                            .repeat
                                                                            .name !=
                                                                            null
                                                                        ? Text(
                                                                        '${widget
                                                                            .fullPostProfileAll
                                                                            .repeat.name}',
                                                                        style: GoogleFonts
                                                                            .montserrat(
                                                                            fontSize:
                                                                            18,
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                            color: Color(
                                                                                0xff666666)))
                                                                        : Text(" "),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(left: 2, top: 4),
                                                                    child: widget
                                                                        .fullPostProfileAll
                                                                        .repeat
                                                                        .userName !=
                                                                        "" &&
                                                                        widget
                                                                            .fullPostProfileAll
                                                                            .repeat
                                                                            .userName !=
                                                                            null
                                                                        ? Text(
                                                                        '@'
                                                                            '${widget
                                                                            .fullPostProfileAll
                                                                            .repeat.userName}',
                                                                        style: GoogleFonts
                                                                            .montserrat(
                                                                            fontSize:
                                                                            12,
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                            color: Color(
                                                                                0xff666666)))
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
                                                                    widget
                                                                        .fullPostProfileAll
                                                                        .repeat
                                                                        .message ??
                                                                        '',
                                                                    style: TextStyle(
                                                                      fontSize: 15,
                                                                      letterSpacing: 0.5,
                                                                      color: Colors.white,
                                                                    )),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              widget.fullPostProfileAll
                                                  .repeat.textFeed ==
                                                  false
                                                  ? Padding(
                                                  padding:
                                                  EdgeInsets.only(
                                                      left: 0),
                                                  child: widget
                                                      .fullPostProfileAll
                                                      .repeat
                                                      .post
                                                      .length >
                                                      0
                                                      ? Container(
                                                    height: 200,
                                                    margin: EdgeInsets
                                                        .only(
                                                        top: 0),
                                                    child: ClipRRect(
                                                        borderRadius: BorderRadius
                                                            .all(
                                                            Radius.circular(20)),
                                                        child: imageFileTypes
                                                            .indexOf(widget
                                                            .fullPostProfileAll
                                                            .repeat.post
                                                            .split('.')
                                                            .last) != -1
                                                            ? GestureDetector(
                                                          // onTap: () {
                                                          //   Navigator.push(
                                                          //       context,
                                                          //       MaterialPageRoute(
                                                          //           builder: (context) => FullPagePostView(postData: widget.repeatDetails, discoverySeeAll: widget.discoverySeeAll, postDetailsNew: feedProviderRepo.feedDetail.post[0], filePaths: getImageUrl(widget.fullPostProfileAll.repeat.post))));
                                                          // },
                                                            child: Padding(
                                                              padding: EdgeInsets.only(
                                                                  top: 4.0,
                                                                  left: 8.0,
                                                                  right: 8.0,
                                                                  bottom: 10),
                                                              child: Container(
                                                                height: 200,
                                                                margin: EdgeInsets.only(top: 0),
                                                                child: ClipRRect(
                                                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                                                  child: OverflowBox(
                                                                      minWidth: 350,
                                                                    minHeight: 220,
                                                                    maxHeight: 400,
                                                                    maxWidth: 350,
                                                                    child: CachedNetworkImage(
                                                                        fit: BoxFit.cover,
                                                                        imageUrl: getImageUrl(
                                                                            widget
                                                                                .fullPostProfileAll
                                                                                .repeat
                                                                                .post)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ))
                                                            : Stack(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                print('empty');
                                                                // Navigator.push(
                                                                //     context,
                                                                //     MaterialPageRoute(builder: (context) => VideoPlayerNew(filePaths: feedProviderRepo.feedDetail.post[0].postPhoto[0].location)));
                                                              },
                                                              child: Padding(
                                                                padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 10),
                                                                child: LayoutBuilder(
                                                                  builder: (
                                                                      BuildContext context,
                                                                      BoxConstraints constraints) {
                                                                    return Container(
                                                                      height: 200,
                                                                      child: ClipRRect(
                                                                        borderRadius: BorderRadius.all(Radius.circular(12)),
                                                                        child: OverflowBox(
                                                                          minWidth: 320,
                                                                          minHeight: 200,
                                                                          maxHeight: 400,
                                                                          maxWidth: 320,
                                                                          child: CachedNetworkImage(
                                                                              fit: BoxFit
                                                                                  .cover,
                                                                              imageUrl: getImageUrl(
                                                                                  widget
                                                                                      .fullPostProfileAll
                                                                                      .repeat
                                                                                      .thumbnailUrl)),
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
                                                                  onTap: () {},
                                                                  child: ClipOval(
                                                                    child: Material(
                                                                      color: Colors
                                                                          .blue,
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
                                                        )),
                                                  )
                                                      : Container())
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
// this is for Like Main All tab Repeat Expansion
                                        : widget.likesrepeatdetails != null &&
                                        widget.likesrepeatdetails.repeat
                                            .userName !=
                                            null
                                        ? GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RepeatPostFullView(
                                                      id: widget
                                                          .likesrepeatdetails
                                                          .repeat.repeatingId,
                                                    )));
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 0, right: 20.0, top: 3.0, bottom: 3.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Color(0XFFDADADA)),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      10.0)),
                                              color: Colors.transparent),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                EdgeInsets.all(0.0),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(top: 4.0, left: 8, right: 8, bottom: 4),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                        BorderRadius
                                                            .all(Radius
                                                            .circular(
                                                            25)),
                                                        child: widget
                                                            .likesrepeatdetails
                                                            .repeat
                                                            .profilePic ==
                                                            null
                                                            ? Container(
                                                          width: 60.0,
                                                          height:
                                                          60.0,
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
                                                            fit: BoxFit
                                                                .cover,
                                                            height: 45,
                                                            width: 45,
                                                            imageUrl: getImageUrl(
                                                                widget
                                                                    .likesrepeatdetails
                                                                    .repeat
                                                                    .profilePic)),
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
                                                                    child: widget
                                                                        .likesrepeatdetails
                                                                        .repeat
                                                                        .name !=
                                                                        "" &&
                                                                        widget
                                                                            .likesrepeatdetails
                                                                            .repeat
                                                                            .name !=
                                                                            null
                                                                        ? Text(
                                                                        '${widget
                                                                            .likesrepeatdetails
                                                                            .repeat.name}',
                                                                        style: GoogleFonts
                                                                            .montserrat(
                                                                            fontSize:
                                                                            18,
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                            color: Color(
                                                                                0xff666666)))
                                                                        : Text(" "),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(left: 2, top: 4),
                                                                    child: widget
                                                                        .likesrepeatdetails
                                                                        .repeat
                                                                        .userName !=
                                                                        "" &&
                                                                        widget
                                                                            .likesrepeatdetails
                                                                            .repeat
                                                                            .userName !=
                                                                            null
                                                                        ? Text(
                                                                        '@'
                                                                            '${widget
                                                                            .likesrepeatdetails
                                                                            .repeat.userName}',
                                                                        style: GoogleFonts
                                                                            .montserrat(
                                                                            fontSize:
                                                                            13,
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                            color: Color(
                                                                                0xff666666)))
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
                                                                    widget
                                                                        .likesrepeatdetails
                                                                        .repeat
                                                                        .message ??
                                                                        '',
                                                                    style: TextStyle(
                                                                      fontSize: 14,
                                                                      letterSpacing: 0.5,
                                                                      color: Colors.white,
                                                                    )),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                    ),

                                                  ],
                                                ),
                                              ),

                                              widget.likesrepeatdetails
                                                  .repeat.textFeed ==
                                                  false
                                                  ? Padding(
                                                  padding:
                                                  EdgeInsets.only(
                                                      left: 0),
                                                  child: widget
                                                      .likesrepeatdetails
                                                      .repeat
                                                      .post
                                                      .length >
                                                      0
                                                      ? Container(
                                                    height: 200,
                                                    margin: EdgeInsets
                                                        .only(
                                                        top:
                                                        10),
                                                    child: ClipRRect(
                                                        borderRadius: BorderRadius
                                                            .all(
                                                            Radius.circular(20)),
                                                        child: imageFileTypes
                                                            .indexOf(widget
                                                            .likesrepeatdetails
                                                            .repeat.post
                                                            .split('.')
                                                            .last) != -1
                                                            ? GestureDetector(
                                                            onTap: () {
                                                              print(
                                                                  'sagvshagsghvahsahs');
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (
                                                                          context) =>
                                                                          FullPagePostView(
                                                                              postData: widget
                                                                                  .repeatDetails,
                                                                              discoverySeeAll: widget
                                                                                  .discoverySeeAll,
                                                                              postDetailsNew: feedProviderRepo
                                                                                  .feedDetail
                                                                                  .post[0],
                                                                              filePaths: getImageUrl(
                                                                                  widget
                                                                                      .likesrepeatdetails
                                                                                      .repeat
                                                                                      .post))));
                                                            },
                                                            child: Padding(
                                                              padding: EdgeInsets.only(top: 2.0, left: 8.0, right: 8.0, bottom: 10),
                                                              child: Container(
                                                                height: 200,
                                                                child: ClipRRect(
                                                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                                                  child: OverflowBox(
                                                                      minWidth: 320,
                                                                    minHeight: 200,
                                                                    maxHeight: 400,
                                                                    maxWidth: 320,
                                                                    child: CachedNetworkImage(
                                                                        fit: BoxFit.cover,
                                                                        height: 176,
                                                                        width: 338,
                                                                        imageUrl: getImageUrl(
                                                                            widget
                                                                                .likesrepeatdetails
                                                                                .repeat
                                                                                .post)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ))
                                                            : Stack(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(builder: (context) => VideoPlayerNew(filePaths:  widget
                                                                        .likesrepeatdetails
                                                                        .repeat.post)));
                                                              },
                                                              child: LayoutBuilder(
                                                                builder: (
                                                                    BuildContext context,
                                                                    BoxConstraints constraints) {
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
                                                                          imageUrl: getImageUrl(
                                                                              widget
                                                                                  .likesrepeatdetails
                                                                                  .repeat
                                                                                  .thumbnailUrl)),
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
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(builder: (context) => VideoPlayerNew(filePaths:  widget
                                                                            .likesrepeatdetails
                                                                            .repeat.post)));
                                                                  },
                                                                  child: ClipOval(
                                                                    child: Material(
                                                                      color: Colors
                                                                          .blue,
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
                                                        )),
                                                  )
                                                      : Container())
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
// End of Like Main All tab Repeat Expansion

// this is for Like Sub tab Repeat Expansion
                                        : widget.likesubtabrepeatdetails != null &&
                                        widget.likesubtabrepeatdetails.repeat
                                            .userName !=
                                            null
                                        ? GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RepeatPostFullView(
                                                      id: widget
                                                          .likesubtabrepeatdetails
                                                          .repeat.repeatingId,
                                                    )));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.all(
                                                Radius.circular(
                                                    10.0)),
                                            color: Colors.transparent),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                              EdgeInsets.all(0.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    EdgeInsets.all(
                                                        8.0),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                      BorderRadius
                                                          .all(Radius
                                                          .circular(
                                                          25)),
                                                      child: widget
                                                          .likesubtabrepeatdetails
                                                          .repeat
                                                          .profilePic ==
                                                          null
                                                          ? Container(
                                                        width: 60.0,
                                                        height:
                                                        60.0,
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
                                                          fit: BoxFit
                                                              .cover,
                                                          height: 52,
                                                          width: 52,
                                                          imageUrl: getImageUrl(
                                                              widget
                                                                  .likesubtabrepeatdetails
                                                                  .repeat
                                                                  .profilePic)),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    EdgeInsets.only(
                                                        top: 15),
                                                    child: widget
                                                        .likesubtabrepeatdetails
                                                        .repeat
                                                        .name !=
                                                        "" &&
                                                        widget
                                                            .likesubtabrepeatdetails
                                                            .repeat
                                                            .name !=
                                                            null
                                                        ? Text(
                                                        '${widget
                                                            .likesubtabrepeatdetails
                                                            .repeat.name}',
                                                        style: GoogleFonts
                                                            .montserrat(
                                                            fontSize:
                                                            14,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold,
                                                            color: Color(
                                                                0xff666666)))
                                                        : Text(" "),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    EdgeInsets.only(
                                                        left: 10,
                                                        top: 15),
                                                    child: widget
                                                        .likesubtabrepeatdetails
                                                        .repeat
                                                        .userName !=
                                                        "" &&
                                                        widget
                                                            .likesubtabrepeatdetails
                                                            .repeat
                                                            .userName !=
                                                            null
                                                        ? Text(
                                                        '@'
                                                            '${widget
                                                            .likesubtabrepeatdetails
                                                            .repeat.userName}',
                                                        style: GoogleFonts
                                                            .montserrat(
                                                            fontSize:
                                                            12,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold,
                                                            color: Color(
                                                                0xff666666)))
                                                        : Text(" "),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10),
                                              child: Container(
                                                child: ReadMoreText(
                                                    widget
                                                        .likesubtabrepeatdetails
                                                        .repeat
                                                        .message ??
                                                        '',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      letterSpacing: 0.5,
                                                      color: Colors.white,
                                                    )),
                                              ),
                                            ),
                                            widget.likesubtabrepeatdetails
                                                .repeat.textFeed ==
                                                false
                                                ? Padding(
                                                padding:
                                                EdgeInsets.only(
                                                    left: 0),
                                                child: widget
                                                    .likesubtabrepeatdetails
                                                    .repeat
                                                    .post
                                                    .length >
                                                    0
                                                    ? Container(
                                                  height: 200,
                                                  margin: EdgeInsets
                                                      .only(
                                                      top:
                                                      10),
                                                  child: ClipRRect(
                                                      borderRadius: BorderRadius
                                                          .all(
                                                          Radius.circular(20)),
                                                      child: imageFileTypes
                                                          .indexOf(widget
                                                          .likesubtabrepeatdetails
                                                          .repeat.post
                                                          .split('.')
                                                          .last) != -1
                                                          ? GestureDetector(
                                                          onTap: () {
                                                            print(
                                                                'sagvshagsghvahsahs');
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (
                                                                        context) =>
                                                                        FullPagePostView(
                                                                            postData: widget
                                                                                .repeatDetails,
                                                                            discoverySeeAll: widget
                                                                                .discoverySeeAll,
                                                                            postDetailsNew: feedProviderRepo
                                                                                .feedDetail
                                                                                .post[0],
                                                                            filePaths: getImageUrl(
                                                                                widget
                                                                                    .likesubtabrepeatdetails
                                                                                    .repeat
                                                                                    .post))));
                                                          },
                                                          child: CachedNetworkImage(
                                                              fit: BoxFit.cover,
                                                              height: 176,
                                                              width: 338,
                                                              imageUrl: getImageUrl(
                                                                  widget
                                                                      .likesubtabrepeatdetails
                                                                      .repeat
                                                                      .post)))
                                                          : Stack(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(builder: (context) => VideoPlayerNew(filePaths:  widget
                                                                      .likesubtabrepeatdetails
                                                                      .repeat.post)));
                                                            },
                                                            child: LayoutBuilder(
                                                              builder: (
                                                                  BuildContext context,
                                                                  BoxConstraints constraints) {
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
                                                                        imageUrl: getImageUrl(
                                                                            widget
                                                                                .likesubtabrepeatdetails
                                                                                .repeat
                                                                                .thumbnailUrl)),
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
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(builder: (context) => VideoPlayerNew(filePaths:  widget
                                                                          .likesubtabrepeatdetails
                                                                          .repeat.post)));
                                                                },
                                                                child: ClipOval(
                                                                  child: Material(
                                                                    color: Colors
                                                                        .blue,
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
                                                      )),
                                                )
                                                    : Container())
                                                : Container(),
                                          ],
                                        ),
                                      ),
                                    )
// End of Like Sub tab Repeat Expansion

                                        : widget.repeatDetails != null &&
                                        widget.repeatDetails.repeat
                                            .userName !=
                                            null
                                        ? GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RepeatPostFullView(
                                                      id: widget
                                                          .repeatDetails
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
                                                  Radius.circular(10.0)
                                              ),
                                              color: Colors.transparent),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              widget.repeatDetails.repeat.textFeed == false
                                                  ? Container(
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
                                                              onTap:
                                                                  () {
                                                                navigationToScreen(
                                                                    context,
                                                                    ProfileTab(
                                                                        userId: widget
                                                                            .repeatDetails
                                                                            .repeat
                                                                            .profileId),
                                                                    false);
                                                              },
                                                              child:
                                                              ClipRRect(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                    .circular(
                                                                    25)),
                                                                child: widget
                                                                    .repeatDetails
                                                                    .repeat
                                                                    .profilePic ==
                                                                    null
                                                                    ? Container(
                                                                  width: 60.0,
                                                                  height: 60.0,
                                                                  decoration: BoxDecoration(
                                                                    image: DecorationImage(
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      image: NetworkImage(
                                                                          "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"),
                                                                    ),
                                                                    borderRadius: BorderRadius
                                                                        .all(
                                                                        Radius
                                                                            .circular(
                                                                            30.0)),
                                                                    color: Colors
                                                                        .redAccent,
                                                                  ),
                                                                )
                                                                    : CachedNetworkImage(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    height: 52,
                                                                    width: 52,
                                                                    imageUrl: getImageUrl(
                                                                        widget
                                                                            .repeatDetails
                                                                            .repeat
                                                                            .profilePic)),
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
                                                                          child: widget
                                                                              .repeatDetails
                                                                              .repeat.name !=
                                                                              "" && widget
                                                                              .repeatDetails
                                                                              .repeat.name !=
                                                                              null
                                                                              ? InkWell(
                                                                            onTap: () {
                                                                              navigationToScreen(
                                                                                  context,
                                                                                  ProfileTab(
                                                                                      userId: widget
                                                                                          .repeatDetails
                                                                                          .repeat
                                                                                          .profileId),
                                                                                  false);
                                                                            },
                                                                            child: Text(Utils
                                                                                .getCapitalizeName(
                                                                                '${widget
                                                                                    .repeatDetails
                                                                                    .repeat
                                                                                    .name}'),
                                                                                style: GoogleFonts
                                                                                    .montserrat(
                                                                                    fontSize: 18,
                                                                                    fontWeight: FontWeight
                                                                                        .bold,
                                                                                    color: Color(
                                                                                        0xff666666))),
                                                                          )
                                                                              : Text(" "),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsets.only(left: 2, top: 4),
                                                                          child: widget
                                                                              .repeatDetails
                                                                              .repeat
                                                                              .userName != "" &&
                                                                              widget
                                                                                  .repeatDetails
                                                                                  .repeat
                                                                                  .userName !=
                                                                                  null
                                                                              ? InkWell(
                                                                            onTap: () {
                                                                              navigationToScreen(
                                                                                  context,
                                                                                  ProfileTab(
                                                                                      userId: widget
                                                                                          .repeatDetails
                                                                                          .repeat
                                                                                          .profileId),
                                                                                  false);
                                                                            },
                                                                            child: Text(
                                                                                '@${widget.repeatDetails.repeat.userName}',
                                                                                style: GoogleFonts.montserrat(
                                                                                    fontSize: 13,
                                                                                    fontWeight: FontWeight.normal,
                                                                                    color: Color(0xff666666))),
                                                                          )
                                                                              : Text(" "),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(right: 10, left: 2),
                                                                    child: Container(
                                                                      alignment: Alignment.topLeft,
                                                                      child: ReadMoreText(
                                                                          widget.repeatDetails.repeat.message ?? '',
                                                                          style: GoogleFonts.montserrat(
                                                                              fontSize: 13,
                                                                              fontWeight: FontWeight.normal,
                                                                              color: Colors.white,
                                                                              letterSpacing: 0.5)),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                              )
                                                  : Padding(
                                                padding: EdgeInsets.all(0.0),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.all(8.0),
                                                      child:
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.all(Radius.circular(25)),
                                                        child: widget.repeatDetails.repeat.profilePic == null
                                                            ? Container(
                                                          width: 60.0,
                                                          height: 60.0,
                                                          decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(
                                                                  "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"),
                                                            ),
                                                            borderRadius: BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    25.0)),
                                                            color: Colors
                                                                .redAccent,
                                                          ),
                                                        )
                                                            : InkWell(
                                                          onTap: () {
                                                            navigationToScreen(
                                                                context,
                                                                ProfileTab(
                                                                    userId: widget
                                                                        .repeatDetails
                                                                        .repeat
                                                                        .profileId),
                                                                false);
                                                          },
                                                          child: CachedNetworkImage(
                                                              fit: BoxFit.fill,
                                                              height: 52,
                                                              width: 52,
                                                              imageUrl: getImageUrl(
                                                                  widget
                                                                      .repeatDetails
                                                                      .repeat
                                                                      .profilePic)),
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
                                                                padding:
                                                                EdgeInsets.only(
                                                                    top: 4.0),
                                                                child:
                                                                Row(
                                                                  children: [
                                                                    Padding(
                                                                        padding: EdgeInsets
                                                                            .only(
                                                                            left: 1,
                                                                            top: 10),
                                                                        child: InkWell(
                                                                          onTap: () {
                                                                            navigationToScreen(
                                                                                context,
                                                                                ProfileTab(
                                                                                    userId: widget
                                                                                        .repeatDetails
                                                                                        .repeat
                                                                                        .profileId),
                                                                                false);
                                                                          },
                                                                          child: Container(
                                                                            child: widget
                                                                                .repeatDetails
                                                                                .repeat
                                                                                .userName !=
                                                                                "" &&
                                                                                widget
                                                                                    .repeatDetails
                                                                                    .repeat
                                                                                    .userName !=
                                                                                    null
                                                                                ? Text(
                                                                                Utils
                                                                                    .getCapitalizeName(
                                                                                    '${widget
                                                                                        .repeatDetails
                                                                                        .repeat
                                                                                        .name}'),
                                                                                style: GoogleFonts
                                                                                    .montserrat(
                                                                                  fontSize: 13,
                                                                                  fontWeight: FontWeight
                                                                                      .bold,
                                                                                  color: HexColor(
                                                                                      '#666666'),
                                                                                  // color: Color(
                                                                                  //     0xff666666)
                                                                                ))
                                                                                : Text(
                                                                                " "),
                                                                          ),
                                                                        )),
                                                                    SizedBox(
                                                                      width: 5.0,
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets
                                                                          .only(
                                                                          left: 1,
                                                                          top: 10),
                                                                      child: InkWell(
                                                                        onTap: () {
                                                                          navigationToScreen(
                                                                              context,
                                                                              ProfileTab(
                                                                                  userId: widget
                                                                                      .repeatDetails
                                                                                      .repeat
                                                                                      .profileId),
                                                                              false);
                                                                        },
                                                                        child: Container(
                                                                          child: widget
                                                                              .repeatDetails
                                                                              .repeat
                                                                              .userName !=
                                                                              "" &&
                                                                              widget
                                                                                  .repeatDetails
                                                                                  .repeat
                                                                                  .userName !=
                                                                                  null
                                                                              ? Text(
                                                                              '@${widget
                                                                                  .repeatDetails
                                                                                  .repeat
                                                                                  .userName}',
                                                                              style: GoogleFonts
                                                                                  .montserrat(
                                                                                  fontSize: 12,
                                                                                  fontWeight: FontWeight
                                                                                      .normal,
                                                                                  color: Color(
                                                                                      0xff666666)))
                                                                              : Text(
                                                                              " "),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 4.0),
                                                                child:
                                                                Container(
                                                                  alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                                  child:
                                                                  ReadMoreText(
                                                                      widget
                                                                          .repeatDetails
                                                                          .repeat
                                                                          .message ??
                                                                          '',
                                                                      style: GoogleFonts
                                                                          .montserrat(
                                                                          fontSize: 13,
                                                                          fontWeight: FontWeight
                                                                              .normal,
                                                                          color: Colors
                                                                              .white,
                                                                          letterSpacing: 0.5)),
                                                                ),
                                                              )
                                                            ])),
                                                  ],
                                                ),
                                              ),
                                              feedProviderRepo.feedDetail.post[0].repeat.post !=
                                                  null
                                                  ? widget
                                                  .repeatDetails
                                                  .repeat
                                                  .textFeed ==
                                                  false
                                                  ? Container(
                                                  height: 200,
                                                  margin: EdgeInsets.only(top: 0),
                                                  child: ClipRRect(
                                                      borderRadius: BorderRadius
                                                          .all(
                                                          Radius.circular(20)),
                                                      child: imageFileTypes
                                                          .indexOf(
                                                          widget.repeatDetails
                                                              .repeat.post
                                                              .split('.')
                                                              .last) != -1
                                                          ? Padding(
                                                        padding: EdgeInsets.only(
                                                            top: 4.0,
                                                            left: 8.0,
                                                            right: 8.0,
                                                            bottom: 5),
                                                        child: Container(
                                                          height: 200,
                                                          margin: EdgeInsets.only(top: 0),
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(12)
                                                            ),
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
                                                                      builder: (
                                                                          context) =>
                                                                          FullPagePostView(
                                                                            filePaths: widget
                                                                                .repeatDetails
                                                                                .repeat
                                                                                .post,
                                                                            postData: widget
                                                                                .repeatDetails,
                                                                          ),
                                                                    ),
                                                                  );
                                                                },
                                                                child: CachedNetworkImage(
                                                                    fit: BoxFit.cover,
                                                                    imageUrl: getImageUrl(
                                                                        widget.repeatDetails.repeat.post)
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                          : Stack(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              print('video video');
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (
                                                                          context) =>
                                                                          VideoPlayerNew(
                                                                              filePaths: widget
                                                                                  .repeatDetails
                                                                                  .repeat
                                                                                  .post)));
                                                            },
                                                            child: LayoutBuilder(
                                                              builder: (
                                                                  BuildContext context,
                                                                  BoxConstraints constraints) {
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
                                                                        imageUrl: getImageUrl(
                                                                            widget
                                                                                .repeatDetails
                                                                                .repeat
                                                                                .thumbnailUrl)),
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
                                                                  print(
                                                                      'video video');
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (
                                                                              context) =>
                                                                              VideoPlayerNew(
                                                                                  filePaths: widget
                                                                                      .repeatDetails
                                                                                      .repeat
                                                                                      .post)));
                                                                },
                                                                child: ClipOval(
                                                                  child: Material(
                                                                    color: Colors
                                                                        .blue,
                                                                    // button color
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
                                                      )))
                                                  : Container()
                                                  : Container()
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                        : Container(),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 0,
                                          right: 0.0,
                                          top: 4.0,
                                          bottom: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          // _getCommentPostWidget(
                                          //     feedProviderRepo.feedList[0].like
                                          //             .contains(
                                          //                 dashBoardProviderRepo
                                          //                     .userId)
                                          //         ? Icons.favorite
                                          //         : Icons.favorite,
                                          //     feedProviderRepo
                                          //         .feedList[0].like.length
                                          //         .toString(),
                                          //     0,
                                          //     feedProviderRepo.feedList[0],
                                          //     feedProviderRepo,
                                          //     dashBoardProviderRepo,
                                          //     feedProviderRepo
                                          //         .feedList[0].profilePic),
                                          //
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              // GestureDetector(
                                              //     onTap: () {
                                              //       feedProviderRepo.likeOrDislike(
                                              //           context,
                                              //           widget.id,
                                              //           feedProviderRepo
                                              //               .likeCollection);
                                              //       print(feedProviderRepo
                                              //           .feedList[0].like);
                                              //       feedProviderRepo
                                              //           .getFeedUserInfo(widget.id);
                                              //     },
                                              //     child: Row(
                                              //         mainAxisAlignment:
                                              //             MainAxisAlignment.start,
                                              //         crossAxisAlignment:
                                              //             CrossAxisAlignment.center,
                                              //         children: [
                                              //           Icon(Icons.favorite,
                                              //               color: feedProviderRepo
                                              //                           .likeCollection
                                              //                           .length !=
                                              //                       0
                                              //                   ? Colors.red
                                              //                   : Colors.grey),
                                              //           Text(
                                              //             "${feedProviderRepo.feedDetail.post[0].like.length}",
                                              //             style: TextStyle(
                                              //                 color: Colors.grey,
                                              //                 fontSize: 15),
                                              //           ),
                                              //         ])),
                                              GestureDetector(
                                                  onTap: () async {
                                                    feedProviderRepo
                                                        .likeOrDislike(
                                                        context,
                                                        widget.id,
                                                        feedProviderRepo
                                                            .likeCollection);

                                                    await feedProviderRepo
                                                        .getFeedUserInfo(
                                                        widget.id);
                                                  },
                                                  child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                      children: [
                                                        feedProviderRepo
                                                            .feedDetail
                                                            .post[0].like
                                                            .contains(
                                                            userId) ==
                                                            true
                                                            ? Icon(
                                                            Icons.favorite,
                                                            color: Colors.red)
                                                            : Icon(
                                                            Icons.favorite,
                                                            color: Colors.grey),
                                                        Text(
                                                          "${feedProviderRepo
                                                              .feedDetail
                                                              .post[0].like
                                                              .length}",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey,
                                                              fontSize: 15),
                                                        ),
                                                      ])),
                                            ],
                                          ),

                                          _getCommentPostWidget(
                                            //  commentIcon,
                                              feedProviderRepo.feedDetail
                                                  .post[0]
                                                  .commentCheck
                                                  .contains(userId) ==
                                                  true
                                                  ? commentRed
                                                  : commentIcon,
                                              feedProviderRepo
                                                  .feedDetail.post[0]
                                                  .commentCount,
                                              // feedProviderRepo
                                              //     .feedList[0].commentCount,
                                              1,
                                              feedProviderRepo.feedDetail
                                                  .post[0],
                                              //feedProviderRepo.feedList[0],
                                              feedProviderRepo,
                                              dashBoardProviderRepo,
                                              feedProviderRepo
                                                  .feedList[0].profilePic),
                                          _getCommentPostWidget(
                                            // repostNewImage,
                                              feedProviderRepo
                                                  .feedDetail.post[0].repost
                                                  .contains(userId) ==
                                                  true
                                                  ? repostColor
                                                  : repostNewImage,
                                              feedProviderRepo
                                                  .feedDetail.post[0].repost
                                                  .length,
                                              // widget.repeatDetails.repost.length,
                                              2,
                                              feedProviderRepo.feedDetail
                                                  .post[0],
                                              // feedProviderRepo.feedList[0],
                                              feedProviderRepo,
                                              dashBoardProviderRepo,
                                              feedProviderRepo
                                                  .feedList[0].profilePic),
                                          // _getCommentPostWidget(
                                          //     Icons.upload_file,
                                          //     "",
                                          //     2,
                                          //     feedProviderRepo.feedList[0],
                                          //     feedProviderRepo,
                                          //     dashBoardProviderRepo,
                                          //     feedProviderRepo
                                          //         .feedList[0].profilePic),
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
            },
          ),
          // Consumer(builder: (context, watch, child) {
          //   final feedProviderRepo = watch(feedProvider);
          //   final dashBoardProviderRepo = watch(dashboardProvider);
          //   var dt = new DateTime.now();
          //   var days= dt.difference(feedProviderRepo.feedDetail.post[0].createdAt).inDays;
          //   if (feedProviderRepo.feedDetail.post[0].postPhoto.length > 0  &&
          //       imageFileTypes.indexOf(getImageUrl(feedProviderRepo.feedDetail.post[0].postPhoto[0].location).split('.').last)  == -1 )
          //   {
          //     getVideoFile(
          //         getImageUrl(feedProviderRepo.feedDetail.post[0].postPhoto[0].location));
          //   }
          //   return GestureDetector(
          //     child: Container(
          //       margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
          //       child: Visibility(
          //           visible: feedProviderRepo.feedDetail !=null,
          //           child: Column(
          //             children: [
          //               ListTile(
          //                 leading: Container(
          //                   margin: EdgeInsets.only(top: 10),
          //                   child: ClipRRect(
          //                     borderRadius: BorderRadius.all(Radius.circular(20)),
          //                     child: CachedNetworkImage(
          //                         fit: BoxFit.fill,
          //                         height: 25,
          //                         width: 25,
          //                         imageUrl: getImageUrl(
          //                             feedProviderRepo.feedDetail.post[0].profilePic)),
          //                   ),
          //                 ),
          //                 title: Container(
          //                   margin: EdgeInsets.only(top: 16),
          //                   child: Text(feedProviderRepo.feedDetail.post[0].userName ?? '',
          //                       style: TextStyle(
          //                           fontSize: 15,
          //                           color: Colors.white
          //                       )),
          //                 ),
          //                 // trailing: Container(
          //                 //     margin: EdgeInsets.only(right: 10),
          //                 //     child: Text(getTime(data.data[index].createdAt),
          //                 //         style: TextStyle(fontSize: 15))),
          //               ),
          //               Visibility(
          //                 visible: feedProviderRepo.feedDetail.post[0].caption.isNotEmpty,
          //                 child: Container(
          //                   alignment: Alignment.topLeft,
          //                   padding: EdgeInsets.only(left: 29, right: 29, top: 09),
          //                   child: Text(feedProviderRepo.feedDetail.post[0].caption ?? '',
          //                       style: TextStyle(
          //                         fontSize: 15,
          //                         letterSpacing: 0.5,
          //                         color: Colors.white,
          //                       )),
          //                 ),
          //               ),
          //               feedProviderRepo.feedDetail.post[0].postPhoto.length > 0
          //                   ? Container(
          //                 height: 200,
          //                 margin: EdgeInsets.only(top: 10),
          //                 child: ClipRRect(
          //                   borderRadius: BorderRadius.all(Radius.circular(20)),
          //                   child:
          //                   imageFileTypes.indexOf( feedProviderRepo
          //                       .feedDetail.post[0].postPhoto[0].location
          //                       .split('.')
          //                       .last)
          //
          //                       != -1
          //                       ? CachedNetworkImage(
          //                       fit: BoxFit.fill,
          //                       height: 176,
          //                       width: 338,
          //                       imageUrl: getImageUrl(feedProviderRepo
          //                           .feedDetail.post[0].postPhoto[0].location))
          //                       : _controller != null &&
          //                       _controller.value.initialized
          //                       ?  VideoWidget(
          //                       play: true,
          //                       url:          feedProviderRepo
          //                           .feedDetail.post[0].postPhoto[0].location
          //                   )
          //                   // ChewieListItem(videoPlayerController:
          //                   //   VideoPlayerController.network(
          //                   //       feedProviderRepo
          //                   //           .feedDetail.postPhoto[0].location),
          //                   // )
          //                   // VideoPlayer(_controller)
          //                       : Container(),
          //                 ),
          //               )
          //                   : Container(),
          //               Container(
          //                 margin: EdgeInsets.only(left: 02, right: 01, top: 10),
          //                 child: Row(
          //                   mainAxisAlignment: MainAxisAlignment.start,
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Row(
          //                       children: [
          //                         _getCommentWidget(
          //                             Icons.favorite,
          //                             feedProviderRepo.commentList[0].like.length
          //                                 .toString(),
          //                             0,
          //                             feedProviderRepo.commentList[0],
          //                             feedProviderRepo,
          //                             dashBoardProviderRepo,
          //                             feedProviderRepo.feedDetail.comments[0].userPic
          //                         )
          //                       ],
          //                     ),
          //                     Row(
          //                       children: [
          //                         _getCommentWidget(
          //                             commentIcon,
          //                             "3k",
          //                             1,
          //                             feedProviderRepo.commentList[0],
          //                             feedProviderRepo,
          //                           dashBoardProviderRepo,
          //                             feedProviderRepo.feedDetail.comments[0].userPic
          //                         )
          //                       ],
          //                     ),
          //                     Row(
          //                       children: [
          //                         _getCommentWidget(
          //                             Icons.arrow_downward_rounded,
          //                             "2k",
          //                             2,
          //                             feedProviderRepo.commentList[0],
          //                             feedProviderRepo,
          //                             dashBoardProviderRepo,
          //                             feedProviderRepo.feedDetail.comments[0].userPic
          //                         )
          //                       ],
          //                     ),
          //                     Spacer(),
          //                     Row(
          //                       children: [
          //                         _getCommentWidget(
          //                             Icons.bookmark_border,
          //                             "",
          //                             2,
          //                             feedProviderRepo.commentList[0],
          //                             feedProviderRepo,
          //                             dashBoardProviderRepo,
          //                             feedProviderRepo.feedDetail.comments[0].userPic
          //                         )
          //                       ],
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //               Padding(
          //                 padding: EdgeInsets.only(top: 22),
          //                 child: Divider(
          //                   height: 1,
          //                   thickness: 0.5,
          //                   color: Colors.grey,
          //                 ),
          //               )
          //             ],
          //           )),
          //     ),
          //     onTap: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => ViewImageOrVideo(
          //                 id: widget.id,
          //               )));
          //     },
          //   );
          // }),
          Consumer(builder: (context, watch, child) {
            final feedProviderRepo = watch(feedProvider);
            final dashBoardProviderRepo = watch(dashboardProvider);
            return Visibility(
                visible: feedProviderRepo.commentList != null,
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
                    itemCount: feedProviderRepo.commentList.length,
                    builder: (BuildContext context, int index) {
                      var dt = new DateTime.now();
                      var days = dt
                          .difference(
                          feedProviderRepo.commentList[index].createdAt)
                          .inDays;

                      print(feedProviderRepo.commentList[index].media);
                      if (feedProviderRepo.commentList[index].media != null &&
                          imageFileTypes.indexOf(getImageUrl(feedProviderRepo
                              .commentList[index].media[0])
                              .split('.')
                              .last) ==
                              -1) {
                        // getVideoFile(getImageUrl(
                        //     feedProviderRepo.commentList[index].media));
                      }

                      print("user id");
                      print(dashBoardProviderRepo.userName);

                      print("comment List id");
                      print(feedProviderRepo.feedDetail.post[0].id);
                      print(feedProviderRepo.commentList[index].userName);
                      if (dashBoardProviderRepo.userId ==
                          feedProviderRepo.commentList[index].userId) {
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
                                        child: feedProviderRepo
                                            .commentList[index]
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
                                                feedProviderRepo
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
                                                  .start,
                                              children: <Widget>[
                                                Container(
                                                    child:Text(
                                                        '${feedProviderRepo.commentList[index].userFullname}',
                                                        style: GoogleFonts.montserrat(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.bold,
                                                            color: HexColor("#FFFFFF")
                                                        )
                                                    )),
                                                SizedBox(width: 3),
                                                Expanded(
                                                  child: Container(
                                                      child:Text(
                                                          '@${feedProviderRepo.commentList[index].userName}',
                                                          style: GoogleFonts.montserrat(
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.normal,
                                                              color: HexColor("#666666")
                                                          )
                                                      )
                                                  ),
                                                    flex: 4
                                                ),
                                                // Expanded(
                                                //   child: Container(
                                                //     child: feedProviderRepo
                                                //         .commentList[
                                                //     index]
                                                //         .userFullname !=
                                                //         "" &&
                                                //         feedProviderRepo
                                                //             .commentList[
                                                //         index]
                                                //             .userFullname !=
                                                //             null
                                                //         ? Text(
                                                //         '${feedProviderRepo
                                                //             .commentList[index]
                                                //             .userFullname}',
                                                //         style: TextStyle(
                                                //           fontSize: 15,
                                                //           color:
                                                //           Colors.white,
                                                //         ))
                                                //         : Text(" "),
                                                //   ),
                                                //   flex: 5,
                                                // ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 4.0),
                                                    child: Container(
                                                        margin: EdgeInsets.only(
                                                            top: 0, left: 5),
                                                        child: days < 7
                                                            ? Text(
                                                            getTime(
                                                                feedProviderRepo
                                                                    .commentList[
                                                                index]
                                                                    .createdAt),
                                                            style: TextStyle(
                                                                fontSize:
                                                                15,
                                                                color: Color(
                                                                    0xff888888)))
                                                            : Text(DateFormat(
                                                            'dd-MMM').format(
                                                            feedProviderRepo
                                                                .commentList[index]
                                                                .createdAt))),
                                                  ),
                                                  flex: 0,
                                                ),
                                                dashBoardProviderRepo.userId ==
                                                    feedProviderRepo
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
                                                            top: 0,
                                                            left: 5),
                                                        child:
                                                        GestureDetector(
                                                          onTap: () {
                                                            _modalBottomSheetMenu(
                                                              feedProviderRepo
                                                                  .commentList[
                                                              index]
                                                                  .id,
                                                              feedProviderRepo
                                                                  .commentList[
                                                              index],
                                                            );
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
                                              visible: feedProviderRepo
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
                                                      DefaultTextStyle
                                                          .of(
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
                                                          text: feedProviderRepo
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
                                              visible: feedProviderRepo
                                                  .commentList[index]
                                                  .commentMessage !=
                                                  null,
                                              child: Container(
                                                alignment: Alignment.topLeft,
                                                child: ReadMoreText(
                                                    feedProviderRepo
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
                                          Padding(
                                            padding: EdgeInsets.only(left: 0),
                                            child:
                                            feedProviderRepo
                                                .commentList[index]
                                                .media !=
                                                null
                                                ? Container(
                                              height: 200,
                                              margin: EdgeInsets.only(
                                                  top: 10),
                                              child: ClipRRect(
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius
                                                        .circular(
                                                        20)),
                                                child: imageFileTypes.indexOf(
                                                    feedProviderRepo
                                                        .commentList[
                                                    index]
                                                        .media
                                                        .split(
                                                        '.')
                                                        .last) !=
                                                    -1
                                                    ? GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                                FullPagePostView(
                                                                  filePaths: feedProviderRepo
                                                                      .commentList[index]
                                                                      .media,
                                                                  commentList: feedProviderRepo
                                                                      .commentList[index],
                                                                )));
                                                  },
                                                  child: CachedNetworkImage(
                                                      fit: BoxFit
                                                          .fill,
                                                      height:
                                                      176,
                                                      width:
                                                      338,
                                                      imageUrl: getImageUrl(
                                                          feedProviderRepo
                                                              .commentList[
                                                          index]
                                                              .media)),
                                                  //     OverflowBox(
                                                  //   minWidth:
                                                  //       0.0,
                                                  //   minHeight:
                                                  //       0.0,
                                                  //   maxWidth: double
                                                  //       .infinity,
                                                  //   maxHeight:
                                                  //       double
                                                  //           .infinity,
                                                  //   child: Hero(
                                                  //     tag:
                                                  //         'd ${feedProviderRepo.commentList[index].media}',
                                                  //     child: CachedNetworkImage(
                                                  //         imageUrl: getImageUrl(feedProviderRepo
                                                  //             .commentList[index]
                                                  //             .media)),
                                                  //   ),
                                                  // ),
                                                )
                                                    : _controller !=
                                                    null &&
                                                    _controller
                                                        .value
                                                        .initialized
                                                    ? Stack(
                                                  children: [
                                                    GestureDetector(
                                                      onTap:
                                                          () {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder: (
                                                                    context) =>
                                                                    VideoPlayerNew(
                                                                        filePaths: feedProviderRepo
                                                                            .commentList[index]
                                                                            .media)));
                                                      },
                                                      child:
                                                      LayoutBuilder(
                                                        builder:
                                                            (
                                                            BuildContext context,
                                                            BoxConstraints constraints) {
                                                          return InViewNotifierWidget(
                                                            id: '$index',
                                                            builder: (
                                                                BuildContext context,
                                                                bool isInView,
                                                                Widget child) {
                                                              return VideoWidget(
                                                                  play: isInView,
                                                                  url:
                                                                  //'https://sfo2.digitaloceanspaces.com/peoplepedia/1607424784883_sample-mp4-file.mp4'
                                                                  feedProviderRepo
                                                                      .commentList[index]
                                                                      .media
                                                                // 'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4'

                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    Positioned(
                                                        top:
                                                        90,
                                                        left:
                                                        160,
                                                        child:
                                                        ClipOval(
                                                          child: Material(
                                                            color: Colors.blue,
                                                            // button color
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
                                                  //     feedProviderRepo
                                                  //             .commentList[
                                                  //                 index]
                                                  //             .like
                                                  //             .contains(
                                                  //                 dashBoardProviderRepo
                                                  //                     .userId)
                                                  //         ? Icons.favorite
                                                  //         : Icons.favorite,
                                                  //     // Icons.favorite,
                                                  //     // 2,
                                                  //
                                                  //     feedProviderRepo
                                                  //         .commentList[index]
                                                  //         .like
                                                  //         .length
                                                  //         .toString(),
                                                  //     0,
                                                  //     feedProviderRepo
                                                  //         .commentList[index],
                                                  //     feedProviderRepo,
                                                  //     dashBoardProviderRepo
                                                  //         .userProfilePic,
                                                  //     feedProviderRepo
                                                  //         .commentList[index]
                                                  //         .userPic),
                                                  //Checking

                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      // GestureDetector(
                                                      //     onTap: () {
                                                      //       feedProviderRepo.likeOrDislikeComment(
                                                      //           context,
                                                      //           feedProviderRepo.commentList[index].id,
                                                      //           feedProviderRepo.likeCollectionComment[index]);
                                                      //
                                                      //       feedProviderRepo
                                                      //           .getFeedUserInfo(
                                                      //           feedProviderRepo.commentList[index].id);
                                                      //     },
                                                      //     child: Row(
                                                      //         mainAxisAlignment:
                                                      //         MainAxisAlignment.start,
                                                      //         crossAxisAlignment:
                                                      //         CrossAxisAlignment.center,
                                                      //         children: [
                                                      //           Icon(Icons.favorite,
                                                      //               color: feedProviderRepo.commentList[index].like.length != 0
                                                      //                   ? Colors.red
                                                      //                   : Colors.grey),
                                                      //           Text(
                                                      //             "${feedProviderRepo.commentList[index].like.length}",
                                                      //             style: TextStyle(
                                                      //                 color: Colors.grey,
                                                      //                 fontSize: 15),
                                                      //           ),
                                                      //         ])),
                                                      //New one
                                                      GestureDetector(
                                                          onTap: () async {
                                                            feedProviderRepo
                                                                .likeOrDislikeComment(
                                                                context,
                                                                feedProviderRepo
                                                                    .commentList[
                                                                index]
                                                                    .id,
                                                                feedProviderRepo
                                                                    .likeCollectionComment[
                                                                index]);

                                                            // await   feedProviderRepo
                                                            //        .getFeedUserInfo(
                                                            //        feedProviderRepo.commentList[index].id);
                                                            await feedProviderRepo
                                                                .getFeedUserInfo(
                                                                feedProviderRepo
                                                                    .commentList[
                                                                index]
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
                                                                feedProviderRepo
                                                                    .commentList[
                                                                index]
                                                                    .like
                                                                    .contains(
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
                                                                Text(
                                                                  "${feedProviderRepo
                                                                      .commentList[index]
                                                                      .like
                                                                      .length}",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                      15),
                                                                ),
                                                              ])),
                                                    ],
                                                  ),
                                                  _getCommentWidget(
                                                    // commentIcon,
                                                      feedProviderRepo
                                                          .commentList[
                                                      index]
                                                          .commentCheck
                                                          .contains(
                                                          userId) ==
                                                          true
                                                          ? commentRed
                                                          : commentIcon,
                                                      feedProviderRepo
                                                          .commentList[index]
                                                          .replyCount,
                                                      1,
                                                      feedProviderRepo
                                                          .commentList[index],
                                                      feedProviderRepo,
                                                      dashBoardProviderRepo
                                                          .userProfilePic,
                                                      feedProviderRepo
                                                          .commentList[index]
                                                          .userPic),
                                                  Row(
                                                    children: [
                                                      _getCommentWidget(
                                                          feedProviderRepo
                                                              .commentList[
                                                          index]
                                                              .repost
                                                              .contains(
                                                              userId) ==
                                                              true
                                                              ? repostColor
                                                              : repostNewImage,
                                                          feedProviderRepo
                                                              .commentList[
                                                          index]
                                                              .repost
                                                              .length,
                                                          2,
                                                          feedProviderRepo
                                                              .commentList[
                                                          index],
                                                          feedProviderRepo,
                                                          dashBoardProviderRepo
                                                              .userProfilePic,
                                                          feedProviderRepo
                                                              .feedDetail
                                                              .comments[index]
                                                              .userPic)
                                                    ],
                                                  ),
                                                  // Row(
                                                  //   children: [
                                                  //     _getCommentWidget(
                                                  //         Icons.upload_file,
                                                  //         "",
                                                  //         2,
                                                  //         feedProviderRepo.commentList[index],
                                                  //         feedProviderRepo,
                                                  //         dashBoardProviderRepo.userProfilePic,
                                                  //         feedProviderRepo.feedDetail.comments[index].userPic
                                                  //     )
                                                  //   ],
                                                  // ),
                                                ]),
                                          )
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
                          print( feedProviderRepo.commentList[index].id);
                          print( feedProviderRepo.commentList[index].parentId);
                          print(index);
                          print(feedProviderRepo.commentList[index].like);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SubCommentFullView(
                                        userData:
                                        feedProviderRepo.commentList[index],
                                        userNested: index,
                                      )));
                        },
                      );

                      Column(
                        children: [
                          GestureDetector(
                            child: Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25)),
                                            child: feedProviderRepo
                                                .commentList[index]
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
                                                    feedProviderRepo
                                                        .commentList[index]
                                                        .userPic)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      );
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
      onTap: () =>
      {
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
      feedProviderRepo.likeOrDislike(context, widget.id, postDetails.like);
    } else if (i == 1) {
      print("${postDetails.postPhoto}");
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                CommentForPost(
                    postId: postDetails.id,
                    post: postDetails.userName,
                    postSecondaryName: postDetails.name,
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
                                SvgPicture.asset(repostBottom,
                                    fit: BoxFit.scaleDown),
                                Padding(padding: EdgeInsets.only(right: 15)),
                                GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      if (repostDetail == true) {
                                        repostDetail = false;
                                      } else {
                                        repostDetail = true;
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
                                    print("nnnnenennwnenwe");
                                    print(postDetails.toJson());
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RepeatCommentPost(
                                                // postDetails: postDetails,
                                                  detailsPostPage: postDetails,
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

  _getCommentWidget(iconData, text1, i, Comment postDetails, feedProviderRepo,
      dashBoardProviderRepo, userReplyProfile) {
    return GestureDetector(
      onTap: () {
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
            // i == 0 || i == 2 || i == 3 ?   Icon(iconData,
            //     color: i == 0
            //         ? postDetails.like.length > 0
            //         ? Colors.red
            //         : Colors.grey
            //         : Colors.grey) : SvgPicture.asset(iconData, fit: BoxFit.none),
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

  _handleOnTap(int i, Comment postDetails, feedProviderRepo, String profilePic,
      userReplyProfile) {
    if (i == 0) {
      print("like");
    } else if (i == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                SubCommentPostReply(
                  parentId: postDetails.id,
                  parentUserId: postDetails.userId,
                  grandParentId: postDetails.parentId,
                  replying: postDetails.replying,
                  commentPicUser: postDetails.userPic,
                  userProfile: profilePic,
                  replyingSecondaryName: postDetails.userFullname,
                  replyingUserName: postDetails.userName,
                  //replyingName: postDetails.userName
                  // profilepic: postDetails.postPhoto,
                )),
      );
    } else {
      print("Share");
      _modalBottomRepeatForSubComment(i, postDetails);
    }
  }

  //Repeat For Sub Comment
  void _modalBottomRepeatForSubComment(int i, Comment postDetails) {
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
                                      if (repostSubComment == true) {
                                        repostSubComment = false;
                                      } else {
                                        repostSubComment = true;
                                      }
                                    });

                                    print('Comment Repost Value here');
                                    print(repostSubComment);
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

  void _modalBottomSheetMenu(String id, Comment commentList) {
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
                                              CommentForPost(
                                                commentUpdate: commentUpdate,
                                                postId: commentList.id,
                                                textTyped:
                                                commentList.commentMessage,
                                                adminPicUser:
                                                commentList.userPic,
                                                userNamePost:
                                                commentList.replying,
                                                userFile: commentList.media,
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
        _controller.setLooping(false);
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
