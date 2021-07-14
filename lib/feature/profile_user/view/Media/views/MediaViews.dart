import 'package:async_loader/async_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/dashboard/deatailsPost.dart';
import 'package:farm_system/feature/farm_plus_setup/view/video_expanded/video_expanded.dart';
import 'package:farm_system/feature/farm_post/newVideoFullpage.dart';
import 'package:farm_system/feature/feed/comment/view/commentforpost.view.dart';
import 'package:farm_system/feature/feed/models/getFeed.model.dart';
import 'package:farm_system/feature/feed/repeat/view/repeatComment.view.dart';
import 'package:farm_system/feature/feed/subCommentFullView/repeatSubComment/repeatInsideSubComment.view.dart';
import 'package:farm_system/feature/feed/subcommentPostReply/view/subcomment.view.dart';
import 'package:farm_system/feature/feed/view/fullpagepost.view.dart';
import 'package:farm_system/feature/feed/view/readmoretext.dart';
import 'package:farm_system/feature/profile_user/view/Media/model/userMedia_model.dart';
import 'package:farm_system/feature/profile_user/view/profile_tabs/farmpost/view/profileSubTabDetailsShimmer.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:video_player/video_player.dart';
import 'package:hexcolor/hexcolor.dart';


import '../../../../../utils.dart';

class Media extends StatefulWidget {
  final String userId;

  const Media({Key key, this.userId}) : super(key: key);

  @override
  _MediaState createState() => _MediaState();
}

class _MediaState extends State<Media> {
  final _asyncKey = GlobalKey<AsyncLoaderState>();
  bool isScroll = true;

  bool favorite = false;
  bool repost = false;
  VideoPlayerController _controller;
  VoidCallback videoPlayerListener;

  var userId;
  var dataCheck = "Media";
  var mediaPost = "MediaPost";
  @override
  void initState() {
    context.read(dashboardProvider).fetchUserDetail();
    setState(() {
      isScroll = !isScroll;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      userId = await StorageService.getUserId();
    });
    super.initState();
  }

// @override
//   void setState(fn) {
//   isScroll = ! isScroll;
//
//   // TODO: implement setState
//     super.setState(fn);
//   }
  // @override
  // void initState() {
  //   print("people-----------");
  //   context.read(dashboardProvider).fetchUserDetail();

  //   super.initState();
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

  // void getVideoFile(fileUrl) async {
  //   print(fileUrl);
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
    return SafeArea(
      top:false,
      bottom:false,
      child: Container(
        padding: EdgeInsets.only(top:10),
        color: Colors.black,
        child: Consumer(builder: (context, watch, child) {
          final userAllMedia = watch(userMedia);
          return AsyncLoader(
            key: _asyncKey,
            initState: () => userAllMedia.getUserMedia(widget.userId),
            renderLoad: () => ProfileSubTabDetailsShimmer(),
            renderError: ([err]) => Text('There was a error'),
            renderSuccess: ({data}) => _generateUINew(context),
          );
        }),
      ),
    );
  }

  _generateUINew(context) {
    return Consumer(builder: (context, watch, child) {
      final userAllMedia = watch(userMedia);
      final dashBoardProviderRepo = watch(dashboardProvider);
      final feedProviderRepo = watch(feedProvider);
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
                          .difference(userAllMedia.userMediaAll[index].createdAt)
                          .inDays;
                      if (userAllMedia.userMediaAll[index].postPhoto.length > 0 &&
                          imageFileTypes.indexOf(getImageUrl(userAllMedia
                              .userMediaAll[index].postPhoto[0].location)
                              .split('.')
                              .last) ==
                              -1) {
                        // getVideoFile(getImageUrl(
                        // userAllMedia.userMediaAll[index].postPhoto));
                      }
                      return
                        // userAllMedia
                        //   .userMediaAll[index].textFeed == false &&  userAllMedia.userMediaAll[index].postPhoto.length > 0?
                        Container(
                          child:
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0, top: 12),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailsPost(
                                              id: userAllMedia.userMediaAll[index].id,
                                              // fullPostProfileAll: userAllMedia.userMediaAll[index],
                                            )));
                                  },
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0, top: 4),
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(25)),
                                          child:
                                          userAllMedia
                                              .userMediaAll[index].profilePic ==
                                              null
                                              ? Image.asset(
                                              dummyUser,
                                              fit: BoxFit.fill,
                                              height: 25,
                                              width: 25
                                          )
                                              : CachedNetworkImage(
                                              fit: BoxFit.fill,
                                              height: 52,
                                              width: 52,
                                              imageUrl: getImageUrl(
                                                  userAllMedia
                                                      .userMediaAll[index].profilePic
                                              )),
                                        ),
                                      ),
                                      Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(top: 4.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: userAllMedia
                                                          .userMediaAll[index]
                                                          .name !=
                                                          "" &&
                                                          userAllMedia
                                                              .userMediaAll[index]
                                                              .name !=
                                                              null
                                                          ? Text(
                                                          '${userAllMedia
                                                              .userMediaAll[index]
                                                              .name}',
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight: FontWeight.bold,
                                                              color: HexColor("#FFFFFF")
                                                          ))
                                                          : Text(" "),
                                                    ),
                                                    SizedBox(width: 3),
                                                    Container(
                                                      child: userAllMedia
                                                          .userMediaAll[index]
                                                          .userName !=
                                                          "" &&
                                                          userAllMedia
                                                              .userMediaAll[index]
                                                              .userName !=
                                                              null
                                                          ? Text(
                                                          '@'+
                                                              '${userAllMedia
                                                                  .userMediaAll[index]
                                                                  .userName}',
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight: FontWeight.normal,
                                                              color: HexColor("#666666")
                                                          ))
                                                          : Text(" "),
                                                    ),
                                                    Spacer(),
                                                    Padding(
                                                        padding: const EdgeInsets.only(top: 0,left: 10),
                                                        child: Container(

                                                            child: days < 7
                                                                ? Text(
                                                                getTime(
                                                                    userAllMedia
                                                                        .userMediaAll[index].createdAt),
                                                                style: TextStyle(
                                                                    fontSize: 9,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: HexColor("#666666")
                                                                ))
                                                                : Text(
                                                                DateFormat(
                                                                    'dd-MMM')
                                                                    .format(
                                                                    userAllMedia
                                                                        .userMediaAll[index]
                                                                        .createdAt),
                                                                style: TextStyle(
                                                                    fontSize: 9,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: HexColor("#666666")
                                                                )
                                                            )
                                                        )
                                                    ),
                                                  ],
                                                ),

                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 2.0),
                                                child: Visibility(
                                                  visible: userAllMedia
                                                      .userMediaAll[index]
                                                      .caption != null,
                                                  child: Container(
                                                      alignment: Alignment
                                                          .topLeft,
                                                      child:
                                                      ReadMoreText(
                                                          userAllMedia
                                                              .userMediaAll[index]
                                                              .caption ?? '',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.normal,
                                                              color: HexColor("#FFFFFF")
                                                          )
                                                      )),
                                                ),
                                              ),
                                              Container(
                                                  height: 200,
                                                  margin: EdgeInsets.only(top: 10),
                                                  child: ClipRRect(
                                                      borderRadius:
                                                      BorderRadius.all(Radius.circular(20)),
                                                      child: imageFileTypes.indexOf(userAllMedia
                                                          .userMediaAll[index]
                                                          .postPhoto[0]
                                                          .location
                                                          .split('.')
                                                          .last) !=
                                                          -1
                                                          ? GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    FullPagePostView(
                                                                  filePaths:
                                                                      userAllMedia
                                                                          .userMediaAll[
                                                                              index]
                                                                          .postPhoto[
                                                                              0].location,
                                                                      postProfileMainTabData:
                                                                      userAllMedia
                                                                          .userMediaAll[
                                                                      index],
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
                                                              'op ${userAllMedia.userMediaAll[index].postPhoto[0].location}',
                                                              child: CachedNetworkImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  imageUrl: getImageUrl(userAllMedia
                                                                      .userMediaAll[index]
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
                                                                          filePaths: userAllMedia
                                                                              .userMediaAll[
                                                                          index]
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
                                                                        imageUrl: getImageUrl(userAllMedia.userMediaAll[index]
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
                                                                              filePaths: userAllMedia
                                                                                  .userMediaAll[index]
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
                                                  )),
                                              // userAllMedia
                                              //     .userMediaAll[index].textFeed ==
                                              //     false ?
                                              // Padding(
                                              //   padding: EdgeInsets.only(
                                              //       left:0),
                                              //   child:
                                              // // userAllMedia.userMediaAll[index].caption !=null && userAllMedia.userMediaAll[index].postPhoto[0] !=null
                                              // userAllMedia.userMediaAll[index].postPhoto.length > 0 ?
                                              // Container(
                                              //     height: 200,
                                              //     margin: EdgeInsets.only(top: 10),
                                              //     child: ClipRRect(
                                              //         borderRadius:
                                              //         BorderRadius.all(Radius.circular(20)),
                                              //         child: imageFileTypes.indexOf(userAllMedia
                                              //             .userMediaAll[index]
                                              //             .postPhoto[0]
                                              //             .location
                                              //             .split('.')
                                              //             .last) !=
                                              //             -1
                                              //             ? GestureDetector(
                                              //           // onTap: () {
                                              //           //   Navigator.push(
                                              //           //       context,
                                              //           //       MaterialPageRoute(
                                              //           //         builder: (context) =>
                                              //           //             FullPagePostView(
                                              //           //           filePaths:
                                              //           //               userAllMedia
                                              //           //                   .userMediaAll[
                                              //           //                       index]
                                              //           //                   .postPhoto[
                                              //           //                       0],
                                              //           //           postProfileAllData:
                                              //           //               userAllMedia
                                              //           //                       .userMediaAll[
                                              //           //                   index],
                                              //           //         ),
                                              //           //       ));
                                              //           // },
                                              //           child: OverflowBox(
                                              //             minWidth: 320,
                                              //             minHeight: 200,
                                              //             maxHeight: 400,
                                              //             maxWidth: 320,
                                              //             child: Hero(
                                              //               tag:
                                              //               'op ${userAllMedia.userMediaAll[index].postPhoto[0].location}',
                                              //               child: CachedNetworkImage(
                                              //                   fit: BoxFit
                                              //                       .cover,
                                              //                   imageUrl: getImageUrl(userAllMedia
                                              //                       .userMediaAll[index]
                                              //                       .postPhoto[0]
                                              //                       .location)),
                                              //             ),
                                              //           ),
                                              //         )
                                              //             : Stack(
                                              //           children: [
                                              //             GestureDetector(
                                              //               onTap: () {
                                              //                 Navigator.push(
                                              //                     context,
                                              //                     MaterialPageRoute(
                                              //                         builder: (context) => VideoPlayerNew(
                                              //                             filePaths: userAllMedia
                                              //                                 .userMediaAll[
                                              //                             index]
                                              //                                 .postPhoto[
                                              //                             0]
                                              //                                 .location)));
                                              //               },
                                              //               child: LayoutBuilder(
                                              //                 builder: (BuildContext
                                              //                 context,
                                              //                     BoxConstraints
                                              //                     constraints) {
                                              //                   return Container(
                                              //                     height: 450,
                                              //                     width: 320,
                                              //                     child: OverflowBox(
                                              //                       minWidth: 320,
                                              //                       minHeight: 200,
                                              //                       maxHeight: 400,
                                              //                       maxWidth: 320,
                                              //                       child: CachedNetworkImage(
                                              //                           fit: BoxFit
                                              //                               .cover,
                                              //                           imageUrl: getImageUrl(userAllMedia.userMediaAll[index]
                                              //                               .postPhoto[
                                              //                           0]
                                              //                               .thumbnailUrl)),
                                              //                     ),
                                              //                   );
                                              //                 },
                                              //               ),
                                              //             ),
                                              //             Positioned(
                                              //                 top: 70,
                                              //                 left: 130,
                                              //                 child: GestureDetector(
                                              //                   onTap: () {
                                              //                     Navigator.push(
                                              //                         context,
                                              //                         MaterialPageRoute(
                                              //                             builder: (context) => VideoPlayerNew(
                                              //                                 filePaths: userAllMedia
                                              //                                     .userMediaAll[index]
                                              //                                     .postPhoto[0]
                                              //                                     .location)));
                                              //                   },
                                              //                   child: ClipOval(
                                              //                     child: Material(
                                              //                       color:
                                              //                       Colors.blue,
                                              //                       child: SizedBox(
                                              //                           width: 46,
                                              //                           height: 46,
                                              //                           child: Icon(
                                              //                             Icons
                                              //                                 .play_arrow,
                                              //                             color: Colors
                                              //                                 .white,
                                              //                             size: 30,
                                              //                           )),
                                              //                     ),
                                              //                   ),
                                              //                 )),
                                              //           ],
                                              //         )
                                              //
                                              //       //Do Not delete this data below
                                              //       // VideoPlayer(_controller)
                                              //       // : Container(),
                                              //     )):Container(),
                                              // ):Container(),


                                              // Padding(
                                              //   padding: EdgeInsets.only(
                                              //       left: 0),
                                              //   child: mediaSubTabRepo
                                              //       .userMediaAll[index].postPhoto
                                              //       .length > 0
                                              //       ? Container(
                                              //
                                              //     height: 200,
                                              //     margin: EdgeInsets.only(
                                              //         top: 10),
                                              //     child: ClipRRect(
                                              //       borderRadius:
                                              //       BorderRadius.all(
                                              //           Radius.circular(20)),
                                              //       child:
                                              //
                                              //       imageFileTypes.indexOf(
                                              //           mediaSubTabRepo
                                              //               .userMediaAll[index]
                                              //               .postPhoto[0]
                                              //               .location
                                              //               .split('.')
                                              //               .last)
                                              //
                                              //           != -1
                                              //           ? GestureDetector(
                                              //         onTap: () {
                                              //           // Navigator.push(
                                              //           //     context,
                                              //           //     MaterialPageRoute(
                                              //           //       builder: (
                                              //           //           context) =>
                                              //                     // FullPagePostView(
                                              //                     //   filePaths:
                                              //                     //   mediaSubTabRepo
                                              //                     //       .userMediaAll[index]
                                              //                     //       .postPhoto[0]
                                              //                     //       .location,
                                              //                     //   subCategoryProfileData: mediaSubTabRepo
                                              //                     //       .userMediaAll[index].category,
                                              //                     // ),
                                              //
                                              //              // )
                                              //           //);
                                              //         },
                                              //         child: OverflowBox(
                                              //           minWidth: 0.0,
                                              //           minHeight: 0.0,
                                              //           maxWidth: double
                                              //               .infinity,
                                              //           maxHeight: double
                                              //               .infinity,
                                              //           child: Hero(
                                              //             tag: 'king ${ mediaSubTabRepo
                                              //                 .userMediaAll[index]
                                              //                 .postPhoto[0]
                                              //                 .location}',
                                              //             child: CachedNetworkImage(
                                              //                 imageUrl: getImageUrl(
                                              //                     mediaSubTabRepo
                                              //                         .userMediaAll[index]
                                              //                         .postPhoto[0].location)),
                                              //           ),
                                              //         ),
                                              //       )
                                              //           : _controller !=
                                              //           null &&
                                              //           _controller.value
                                              //               .initialized
                                              //           ?
                                              //       Stack(
                                              //         children: [
                                              //           GestureDetector(
                                              //             onTap: () {
                                              //               Navigator.push(
                                              //                   context,
                                              //                   MaterialPageRoute(
                                              //                       builder: (
                                              //                           context) =>
                                              //                           VideoPlayerNew(
                                              //                               filePaths:
                                              //                               mediaSubTabRepo
                                              //                                   .userMediaAll[index]
                                              //                                   .postPhoto[0]
                                              //                                   .location)
                                              //                   )
                                              //               );
                                              //             },
                                              //           ),
                                              //           Positioned(
                                              //               top: 90,
                                              //               left: 160,
                                              //               child: ClipOval(
                                              //                 child: Material(
                                              //                   color: Colors
                                              //                       .blue,
                                              //                   // button color
                                              //                   child: SizedBox(
                                              //                       width: 46,
                                              //                       height: 46,
                                              //                       child: Icon(
                                              //                         Icons
                                              //                             .play_arrow,
                                              //                         color: Colors
                                              //                             .white,
                                              //                         size: 30,
                                              //                       )),
                                              //                 ),
                                              //               )
                                              //           ),
                                              //         ],
                                              //       )
                                              //           : Container(),
                                              //     ),
                                              //   )
                                              //       : Container(),
                                              // ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 0,
                                                    right: 0.0,
                                                    top: 5.0,
                                                    bottom: 5.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceEvenly,
                                                  children: <Widget>[
                                                    // _getCommentWidget(
                                                    //     mediaSubTabRepo
                                                    //         .userMediaAll[index]
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

                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                      children: [
                                                        userAllMedia.userMediaAll[index].type == "post"  ?
                                                        GestureDetector(
                                                            onTap: () {
                                                              // print('printinggg');
                                                              // print(userId);
                                                              // print(feedProviderRepo
                                                              //     .feedList[index].like
                                                              //     .contains(userId));
                                                              userAllMedia.likeOrDislikeMedia(
                                                                  context,
                                                                  userAllMedia.userMediaAll[index].id,
                                                                  userAllMedia
                                                                      .likeCollection);

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
                                                                  userAllMedia.userMediaAll[index]
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
                                                                    "${userAllMedia.userMediaAll[index].like.length}",
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
                                                              userAllMedia.likeOrDislikeCommentMedia(
                                                                  context,
                                                                  userAllMedia.userMediaAll[index].id,
                                                                  userAllMedia
                                                                      .likeCollection);

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
                                                                  userAllMedia.userMediaAll[index]
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
                                                                    "${userAllMedia.userMediaAll[index].like.length}",
                                                                    style: TextStyle(
                                                                        color: Colors.grey,
                                                                        fontSize: 15),
                                                                  ),
                                                                ]))
                                                        ,
                                                      ],
                                                    ),
                                                    _getCommentWidget(
                                                      // userAllMedia.userMediaAll[index]
                                                      //     .like
                                                      //     .contains(
                                                      //     dashBoardProviderRepo
                                                      //         .userId)
                                                      //     ? commentIcon
                                                      //     : commentIcon,
                                                        userAllMedia.userMediaAll[index].commentCheck.contains(userId) == true ? commentRed : commentIcon,
                                                        userAllMedia.userMediaAll[index]
                                                            .commentCount,
                                                        1,
                                                        userAllMedia.userMediaAll[index],
                                                        userAllMedia,
                                                        dashBoardProviderRepo,
                                                        userAllMedia.userMediaAll[index]
                                                            .profilePic
                                                    ),
                                                    _getCommentWidget(
                                                        repostNewImage,
                                                        userAllMedia.userMediaAll[index]
                                                            .repost.length,
                                                        2,
                                                        userAllMedia.userMediaAll[index],
                                                        userAllMedia,
                                                        dashBoardProviderRepo,
                                                        userAllMedia.userMediaAll[index]
                                                            .profilePic
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
                              ),
                              Divider(
                                height: 1,
                                thickness: 0.5,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        );

                      // Container(
                      //     child:
                      //     Column(
                      //         children: [
                      //           Padding(
                      //             padding: EdgeInsets.all(
                      //                4,
                      //             ),
                      //             // padding: EdgeInsets.only(top: 4.0),
                      //             child: Row(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: <Widget>[
                      //                 Column(children: [
                      //                   Padding(
                      //                     padding: EdgeInsets.all(8.0),
                      //                     child: Container(
                      //                       child: ClipRRect(
                      //                         borderRadius:
                      //                         BorderRadius.all(Radius.circular(52)),
                      //                         child: userAllMedia
                      //                             .userMediaAll[index].profilePic ==
                      //                             null
                      //                             ? Image.asset(dummyUser,
                      //                             fit: BoxFit.fill, height: 25, width: 25)
                      //                             : CachedNetworkImage(
                      //                             fit: BoxFit.fill,
                      //                             height: 52,
                      //                             width: 52,
                      //                             imageUrl: getImageUrl(userAllMedia
                      //                                 .userMediaAll[index].profilePic)),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ]),
                      //                 SizedBox(
                      //                   width: 10,
                      //                 ),
                      //                 Column(
                      //                     mainAxisSize: MainAxisSize.min,
                      //                     crossAxisAlignment: CrossAxisAlignment.start,
                      //                     mainAxisAlignment: MainAxisAlignment.start,
                      //                     children: [
                      //                       Row(
                      //                         children: [
                      //                           Padding(
                      //                             padding: EdgeInsets.only(top: 4.0),
                      //                             child: Container(
                      //                               child: userAllMedia
                      //                                   .userMediaAll[index].name !=
                      //                                   null
                      //                                   ?
                      //                               Text(
                      //                                   Utils.getCapitalizeName(
                      //                                       '${userAllMedia.userMediaAll[index].name}'),
                      //                                   style: GoogleFonts.montserrat(
                      //                                       fontSize: 16,
                      //                                       fontWeight: FontWeight.bold,
                      //                                       color: HexColor("#666666")
                      //                                   )
                      //
                      //                               )
                      //                                   : Text(" "),
                      //
                      //                             ),
                      //                           ),
                      //                           SizedBox(width: 2,
                      //                           ),
                      //                           Padding(
                      //                             padding: const EdgeInsets.only(top: 0.0),
                      //                             child: Container(
                      //
                      //                               child: userAllMedia
                      //                                   .userMediaAll[index].userName !=
                      //                                   null ?
                      //
                      //                               Text(
                      //                                   Utils.getCapitalizeName(
                      //                                       '@${userAllMedia.userMediaAll[index].userName}'),
                      //                                   style: GoogleFonts.montserrat(
                      //                                       fontSize: 14,
                      //                                       fontWeight: FontWeight.normal,
                      //                                       color: HexColor("#666666")
                      //                                   )
                      //
                      //                               )
                      //                                   : Text(" "),
                      //
                      //                             ),
                      //                           ),
                      //
                      //                         ],
                      //                       ),
                      //                       SizedBox(width:5),
                      //
                      //                       Container(
                      //                           width: 230,
                      //                           padding: const EdgeInsets.only(top:5,bottom: 5),
                      //                           child: ReadMoreText(
                      //                               userAllMedia
                      //                                   .userMediaAll[index].caption  ??
                      //                                   '',
                      //                               style: GoogleFonts.montserrat(
                      //                                 fontSize: 14,
                      //                                 fontWeight: FontWeight.normal,
                      //                                   color: HexColor("#666666")
                      //                               ))
                      //                         //
                      //                       )
                      //                     ]),
                      //                 Expanded(
                      //                   child: Column(
                      //                       crossAxisAlignment: CrossAxisAlignment.end,
                      //                       mainAxisAlignment: MainAxisAlignment.end,
                      //                       children: [
                      //                         Container(
                      //                             margin: EdgeInsets.only(
                      //                                 top: 0, left: 5),
                      //                             child: days < 7
                      //                                 ? Text(
                      //                                 getTime(userAllMedia
                      //                                     .userMediaAll[index]
                      //                                     .createdAt),
                      //                                 style:
                      //                                 GoogleFonts.montserrat(
                      //                                     fontSize: 10,
                      //                                     fontWeight:
                      //                                     FontWeight
                      //                                         .normal,
                      //                                     color: HexColor("#666666")
                      //
                      //                                     // color: Color(
                      //                                     //     0xff888888)
                      //                                 )
                      //
                      //                             )
                      //                                 : Text(DateFormat('dd-MMM')
                      //                                 .format(userAllMedia
                      //                                 .userMediaAll[index]
                      //                                 .createdAt),                                                        style: TextStyle(
                      //                                 color: HexColor("#666666"),fontSize: 10
                      //                             )
                      //                             )),
                      //                       ]),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //           SizedBox(
                      //             height: 3,
                      //           ),
                      //           userAllMedia
                      //               .userMediaAll[index].textFeed ==true
                      //               ?
                      //           Container():
                      //           Padding(
                      //             padding: const EdgeInsets.symmetric(horizontal:35),
                      //             child:
                      //             // userAllMedia.userMediaAll[index].caption !=null && userAllMedia.userMediaAll[index].postPhoto[0] !=null
                      //             userAllMedia.userMediaAll[index].postPhoto.length > 0 ?
                      //             Container(
                      //                 height: 180,
                      //                 margin: EdgeInsets.only(bottom: 2),
                      //                 child: ClipRRect(
                      //                     borderRadius:
                      //                     BorderRadius.all(Radius.circular(20)),
                      //                     child: imageFileTypes.indexOf(userAllMedia
                      //                         .userMediaAll[index]
                      //                         .postPhoto[0]
                      //                         .location
                      //                         .split('.')
                      //                         .last) !=
                      //                         -1
                      //                         ? GestureDetector(
                      //                       // onTap: () {
                      //                       //   Navigator.push(
                      //                       //       context,
                      //                       //       MaterialPageRoute(
                      //                       //         builder: (context) =>
                      //                       //             FullPagePostView(
                      //                       //           filePaths:
                      //                       //               userAllMedia
                      //                       //                   .userMediaAll[
                      //                       //                       index]
                      //                       //                   .postPhoto[
                      //                       //                       0],
                      //                       //           postProfileAllData:
                      //                       //               userAllMedia
                      //                       //                       .userMediaAll[
                      //                       //                   index],
                      //                       //         ),
                      //                       //       ));
                      //                       // },
                      //                       child: OverflowBox(
                      //                         minWidth: 320,
                      //                         minHeight: 200,
                      //                         maxHeight: 400,
                      //                         maxWidth: 320,
                      //                         child: Hero(
                      //                           tag:
                      //                           'op ${userAllMedia.userMediaAll[index].postPhoto[0].location}',
                      //                           child: CachedNetworkImage(
                      //                               fit: BoxFit
                      //                                   .cover,
                      //                               imageUrl: getImageUrl(userAllMedia
                      //                                   .userMediaAll[index]
                      //                                   .postPhoto[0]
                      //                                   .location)),
                      //                         ),
                      //                       ),
                      //                     )
                      //                         : Stack(
                      //                       children: [
                      //                         GestureDetector(
                      //                           onTap: () {
                      //                             Navigator.push(
                      //                                 context,
                      //                                 MaterialPageRoute(
                      //                                     builder: (context) => VideoPlayerNew(
                      //                                         filePaths: userAllMedia
                      //                                             .userMediaAll[
                      //                                         index]
                      //                                             .postPhoto[
                      //                                         0]
                      //                                             .location)));
                      //                           },
                      //                           child: LayoutBuilder(
                      //                             builder: (BuildContext
                      //                             context,
                      //                                 BoxConstraints
                      //                                 constraints) {
                      //                               return Container(
                      //                                 height: 450,
                      //                                 width: 320,
                      //                                 child: OverflowBox(
                      //                                   minWidth: 320,
                      //                                   minHeight: 200,
                      //                                   maxHeight: 400,
                      //                                   maxWidth: 320,
                      //                                   child: CachedNetworkImage(
                      //                                       fit: BoxFit
                      //                                           .cover,
                      //                                       imageUrl: getImageUrl(userAllMedia
                      //                                           .userMediaAll[
                      //                                       index]
                      //                                           .postPhoto[
                      //                                       0]
                      //                                           .thumbnailUrl)),
                      //                                 ),
                      //                               );
                      //                             },
                      //                           ),
                      //                         ),
                      //                         Positioned(
                      //                             top: 70,
                      //                             left: 130,
                      //                             child: GestureDetector(
                      //                               onTap: () {
                      //                                 Navigator.push(
                      //                                     context,
                      //                                     MaterialPageRoute(
                      //                                         builder: (context) => VideoPlayerNew(
                      //                                             filePaths: userAllMedia
                      //                                                 .userMediaAll[index]
                      //                                                 .postPhoto[0]
                      //                                                 .location)));
                      //                               },
                      //                               child: ClipOval(
                      //                                 child: Material(
                      //                                   color:
                      //                                   Colors.blue,
                      //                                   child: SizedBox(
                      //                                       width: 46,
                      //                                       height: 46,
                      //                                       child: Icon(
                      //                                         Icons
                      //                                             .play_arrow,
                      //                                         color: Colors
                      //                                             .white,
                      //                                         size: 30,
                      //                                       )),
                      //                                 ),
                      //                               ),
                      //                             )),
                      //                       ],
                      //                     )
                      //
                      //                   //Do Not delete this data below
                      //                   // VideoPlayer(_controller)
                      //                   // : Container(),
                      //                 )):Container(),
                      //           ),
                      //
                      //           SizedBox(height: 10,),
                      //           Padding(
                      //             padding: const EdgeInsets.only(right: 80,left: 80),
                      //             child: Row(
                      //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //               children: <Widget>[
                      //                 Icon(
                      //                   Icons.favorite,
                      //                   color: Colors.grey[600],
                      //                   size: 20,
                      //                 ),
                      //                 SizedBox(
                      //                   width: 50,
                      //                 ),
                      //                 Container(
                      //                   child: SvgPicture.asset("assets/images/comment.svg"),
                      //                 ),
                      //                 SizedBox(width: 50,),
                      //                 Container(
                      //                   child: SvgPicture.asset("assets/images/RepostNew.svg"),
                      //                 ),
                      //                 // Icon(
                      //                 //   Icons.repeat_outlined,
                      //                 //   color: Colors.grey[600],
                      //                 //   size: 20,
                      //                 // ),
                      //
                      //
                      //               ],
                      //             ),
                      //           ),
                      //           Divider(
                      //             thickness: 0.4,
                      //             color: Colors.grey,
                      //           )
                      //         ])
                      // ):Container();
                    },
                    childCount: userAllMedia.userMediaAll.length,
                  ),
                ),
              ),
            ],
          );
        },
      );
    });
  }


  _getCommentWidget(iconData, text1, i, Datum postDetails,
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

  _handleOnTap(int i, Datum postDetails, feedProviderRepo,
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
      // postDetails.type == "post" ?
      postDetails.type == "posts" ?
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
              dataMediaId: widget.userId,
              catId: postDetails.category,
              subcateId: postDetails.subCategory,
              // mediaPost: mediaPost,
              // profilepic: postDetails.postPhoto,
            )),
      )
          :Navigator.push(
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
              dataMedia : dataCheck,
              dataMediaId: widget.userId,

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
                                postDetails.type == "post" ?
                                GestureDetector(
                                  onTap: () async {
                                    print("repeattttttttt ksfbdhb");
                                    print(postDetails.toJson());
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RepeatCommentPost(
                                                  postDetailsMedia: postDetails,
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
                                        mediaAllTabProfile: postDetails,
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