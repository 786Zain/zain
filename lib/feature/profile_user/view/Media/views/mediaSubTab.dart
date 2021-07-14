import 'package:async_loader/async_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/dashboard/deatailsPost.dart';
import 'package:farm_system/feature/farm_post/newVideoFullpage.dart';
import 'package:farm_system/feature/feed/comment/view/commentforpost.view.dart';
import 'package:farm_system/feature/feed/repeat/view/repeatComment.view.dart';
import 'package:farm_system/feature/feed/subCommentFullView/repeatSubComment/repeatInsideSubComment.view.dart';
import 'package:farm_system/feature/feed/subcommentPostReply/view/subcomment.view.dart';
import 'package:farm_system/feature/feed/view/fullpagepost.view.dart';
import 'package:farm_system/feature/feed/view/readmoretext.dart';
import 'package:farm_system/feature/profile_user/view/profile_tabs/farmpost/modal/profileSubCategoryIndividual.modal.dart';
import 'package:farm_system/feature/profile_user/view/profile_tabs/farmpost/view/profileSubTabDetailsShimmer.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:farm_system/feature/profile_user/view/Media/model/userMedia_model.dart';

class MediaSubTabDetails extends StatefulWidget {
  final String userId;
  final String profileId;


  const MediaSubTabDetails({Key key, this.userId,this.profileId}) : super(key: key);


  @override
  _MediaSubTabDetailsState createState() => _MediaSubTabDetailsState();
}


class _MediaSubTabDetailsState extends State<MediaSubTabDetails> {

  final _asyncKeyCategorySub = GlobalKey<AsyncLoaderState>();
  VideoPlayerController _controller;
  VoidCallback videoPlayerListener;

  bool favorite = false;
  bool repost = false;

  List<String> imageFileTypes = ["png", "jpg", "jpeg", "gif", "JPG" , "PNG", "JPEG", "GIF", "HEIC"];

  var userId;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      userId = await StorageService.getUserId();
    });
    // TODO: implement initState
    super.initState();
  }

  var dataCheck = "Media";
  var dataSubMedia = "SubMedia";
  var subMediaCommentId = "subMediaCommentId";

  @override
  Widget build(BuildContext context) {

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
    //     await vcontroller.setLooping(true);
    //     await vcontroller.initialize();
    //     if (mounted) {
    //       setState(() {
    //         _controller = vcontroller;
    //       });
    //     }
    //   } catch (e) {
    //   }
    // }
    return SafeArea(
        top:false,
        bottom:false,
        child: Container(
          color: Colors.black,
          child:Consumer(builder: (context, watch, child) {
            final mediaSubTabRepo = watch(mediaSubTabProvider);
            return AsyncLoader(
              key: _asyncKeyCategorySub,
              initState: ()=> mediaSubTabRepo.mediaSubCategoryIndividual(widget.userId, mediaSubTabRepo.mediaCategoryIdnId,),
              renderLoad: () => ProfileSubTabDetailsShimmer(),
              renderError: ([err]) => Text('There was a error'),
              renderSuccess: ({data}) => _generateUI(),
            );
          }),
        )
    );

  }

  _generateUI(){
    return Consumer(
        builder: (context, watch, child) {
          final mediaSubTabRepo = watch(mediaSubTabProvider);
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
                              mediaSubTabRepo.userMediaAll[index].createdAt)
                          // mediaSubTabRepo.userMediaAll[index].)
                              .inDays;
                          return GestureDetector(
                            child:
                            // mediaSubTabRepo.userMediaAll[index].textFeed == false &&
                            //     mediaSubTabRepo.userMediaAll[index].postPhoto.length > 0?

                            Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0, top: 12),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0, top: 4),
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.all(
                                                Radius.circular(25)),
                                            child: mediaSubTabRepo.userMediaAll[index].profilePic == null
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
                                                    mediaSubTabRepo
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
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Container(
                                                        child: mediaSubTabRepo
                                                            .userMediaAll[index]
                                                            .name !=
                                                            "" &&
                                                            mediaSubTabRepo
                                                                .userMediaAll[index]
                                                                .name !=
                                                                null
                                                            ? Text(
                                                            '${mediaSubTabRepo
                                                                .userMediaAll[index]
                                                                .name}',
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight: FontWeight.bold,
                                                                color: HexColor("#FFFFFF")
                                                            ))
                                                            : Text(" "),
                                                      ),
                                                      SizedBox(width: 2),
                                                      Expanded(
                                                        child: Container(
                                                          child: mediaSubTabRepo
                                                              .userMediaAll[index]
                                                              .userName !=
                                                              "" &&
                                                              mediaSubTabRepo
                                                                  .userMediaAll[index]
                                                                  .userName !=
                                                                  null
                                                              ? Text(
                                                              '@'+
                                                                  '${mediaSubTabRepo
                                                                      .userMediaAll[index]
                                                                      .userName}',
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  fontWeight: FontWeight.normal,
                                                                  color: HexColor("#666666")
                                                              ))
                                                              : Text(" "),
                                                        ),
                                                        flex: 4,
                                                      ),
                                                      Padding(
                                                          padding: EdgeInsets.only(right: 4.0),
                                                          child: Container(
                                                              margin: EdgeInsets.only(top: 0, left: 5),
                                                              child: days < 7
                                                                  ? Text(
                                                                  getTime(
                                                                      mediaSubTabRepo
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
                                                                      mediaSubTabRepo
                                                                          .userMediaAll[index]
                                                                          .createdAt),
                                                                  style: TextStyle(
                                                                      fontSize: 9,
                                                                      fontWeight: FontWeight.bold,
                                                                      color: HexColor("#666666")
                                                                  )
                                                              ))
                                                      ),
                                                    ],
                                                  ),

                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: 1.0, bottom: 5),
                                                  child: Visibility(
                                                    visible: mediaSubTabRepo
                                                        .userMediaAll[index]
                                                        .caption != null,
                                                    child: Container(
                                                        alignment: Alignment
                                                            .topLeft,
                                                        child:
                                                        ReadMoreText(
                                                            mediaSubTabRepo
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
                                                Padding(
                                                  padding: EdgeInsets.only(left: 0,top:10),                                                  child:
                                                // userAllMedia.userMediaAll[index].caption !=null && userAllMedia.userMediaAll[index].postPhoto[0] !=null
                                                mediaSubTabRepo.userMediaAll[index].postPhoto.length > 0 ?
                                                Container(
                                                    height: 200,
                                                    margin: EdgeInsets.only(bottom: 2),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                        BorderRadius.all(Radius.circular(20)),
                                                        child: imageFileTypes.indexOf(mediaSubTabRepo
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
                                                                builder: (context) => FullPagePostView(
                                                                filePaths: mediaSubTabRepo.userMediaAll[index].postPhoto[0].location,
                                                                postProfilesubtabsData: mediaSubTabRepo.userMediaAll[index],
                                                            )));
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
                                                                'op ${mediaSubTabRepo.userMediaAll[index].postPhoto[0].location}',
                                                                child: CachedNetworkImage(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    imageUrl: getImageUrl(mediaSubTabRepo
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
                                                                            filePaths: mediaSubTabRepo
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
                                                                          imageUrl: getImageUrl(mediaSubTabRepo.userMediaAll[index]
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
                                                                                filePaths: mediaSubTabRepo.userMediaAll[index]
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
                                                ),


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
                                                      mediaSubTabRepo.userMediaAll[index].type == "post"
                                                          ? GestureDetector(
                                                          onTap: () {
                                                            // print('printinggg');
                                                            // print(userId);
                                                            // print(feedProviderRepo
                                                            //     .feedList[index].like
                                                            //     .contains(userId));
                                                            mediaSubTabRepo.likeOrDislikSubMedia(
                                                                context,
                                                                mediaSubTabRepo.userMediaAll[index].id,
                                                                mediaSubTabRepo.likeCollection);

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
                                                                mediaSubTabRepo.userMediaAll[index]
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
                                                                  "${mediaSubTabRepo.userMediaAll[index].like.length}",
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
                                                            mediaSubTabRepo.likeOrDislikeSubTabMedia(
                                                                context,
                                                                mediaSubTabRepo.userMediaAll[index].id,
                                                                mediaSubTabRepo.likeCollection);

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
                                                                mediaSubTabRepo.userMediaAll[index]
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
                                                                  "${mediaSubTabRepo.userMediaAll[index].like.length}",
                                                                  style: TextStyle(
                                                                      color: Colors.grey,
                                                                      fontSize: 15),
                                                                ),
                                                              ])),
                                                      _getCommentSubMediaTabWidget(
                                                        mediaSubTabRepo.userMediaAll[index].commentCheck.contains(userId) !=null ? commentRed : commentIcon,
                                                        mediaSubTabRepo.userMediaAll[index]
                                                            .commentCount,
                                                        1,
                                                        mediaSubTabRepo.userMediaAll[index],
                                                        mediaSubTabRepo,
                                                        dashBoardProviderRepo,
                                                        mediaSubTabRepo.userMediaAll[index].profilePic,
                                                        mediaSubTabRepo.mediaCategoryIdnId,
                                                      ),
                                                      _getCommentSubMediaTabWidget(
                                                        repostNewImage,
                                                        mediaSubTabRepo.userMediaAll[index].repost.length,
                                                        2,
                                                        mediaSubTabRepo.userMediaAll[index],
                                                        mediaSubTabRepo,
                                                        dashBoardProviderRepo,
                                                        mediaSubTabRepo.userMediaAll[index].profilePic,
                                                        mediaSubTabRepo.mediaCategoryIdnId,
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
                                ],
                              ),
                            ),
                            // :Container(),
                            //
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailsPost(
                                        id: mediaSubTabRepo
                                            .userMediaAll[index].id,
                                        // fullSubPostProfileAll: mediaSubTabRepo
                                        //     .userMediaAll[index],
                                      )));
                            },


                          );

                        },
                        childCount: mediaSubTabRepo.userMediaAll.length,
                      ),
                    ),
                  ),
                ],
              );
            },

          );
        });

  }

  // _getCommentWidget(iconData, text1, i, Datums postDetails, profileSubTabRepo,  dashBoardProviderRepo, userReplyProfile) {
  //   return GestureDetector(
  //     onTap: () => {
  //       _handleOnTap(i, postDetails, profileSubTabRepo,  dashBoardProviderRepo, userReplyProfile)},
  //     child: Container(
  //       padding: EdgeInsets.only(bottom: 0, left: 10, top: 5),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           i == 0 || i == 3 ?
  //           i ==2 ? Container():
  //           Icon(iconData,
  //               color: i == 0
  //                   ? postDetails.like.length > 0
  //                   ? Colors.red
  //                   : Colors.grey
  //                   : Colors.grey) : SvgPicture.asset(iconData, fit: BoxFit.none),
  //           Container(
  //               margin: EdgeInsets.only(left: 08, right: 15),
  //               child: Row(
  //                 children: [
  //                   Text(
  //                     text1.toString(),
  //                     style: TextStyle(color: Colors.grey, fontSize: 15),
  //                   ),
  //                 ],
  //               )
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // _handleOnTap(int i, Datums postDetails, profileSubTabRepo,  dashBoardProviderRepo, userReplyProfile) {
  //   if (i == 0) {
  //     setState(() {
  //       if (favorite == true) {
  //         favorite = false;
  //       } else {
  //         favorite = true;
  //       }
  //     });
  //
  //     profileSubTabRepo.likeOrDislikeSubCategoryIndividual(context, postDetails.id, postDetails.like);
  //   } else if (i == 1) {
  //     print("${postDetails.postPhoto}");
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => CommentForPost(
  //           postId: postDetails.id,
  //           post: postDetails.userName,
  //           profilePicUser: userReplyProfile,
  //           adminPicUser : dashBoardProviderRepo.userProfilePic
  //       )),
  //     );
  //   } else {
  //     _modalBottomSheetMenu(i, postDetails);
  //   }
  // }
  //
  // void _modalBottomSheetMenu(int i, Datums postDetails) {
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
  //                               SvgPicture.asset(
  //                                   repostBottom,
  //
  //                                   fit: BoxFit.scaleDown),
  //                               Padding(
  //                                   padding: EdgeInsets.only(right: 15)
  //                               ),
  //                               GestureDetector(
  //                                 onTap: () async {
  //
  //                                   setState(() {
  //                                     if (repost == true) {
  //                                       repost = false;
  //                                     } else {
  //                                       repost = true;
  //                                     }
  //                                   });
  //                                   await  repostProvider.repostFeedPost(postDetails.id, postDetails.repost);
  //
  //                                   Navigator.pop(context);
  //
  //                                 },
  //                                 child: Text(
  //                                   "Repost",
  //                                   style: TextStyle(
  //                                       fontSize: 15,
  //                                       color: Color(0xff888888),
  //                                       fontWeight: FontWeight.w600),
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                           Row(
  //                             children: [
  //                               SvgPicture.asset(
  //                                   repeatIocn,
  //                                   height: 10,
  //                                   width: 10,
  //                                   fit: BoxFit.scaleDown),
  //                               Padding(
  //                                   padding: EdgeInsets.only(right: 15)
  //                               ),
  //                               GestureDetector(
  //                                 onTap: () async{
  //                                   await  Navigator.push(
  //                                     context,
  //                                     MaterialPageRoute(builder: (context) => RepeatCommentPost(
  //                                         postProfileSubcategory: postDetails
  //                                     )),
  //                                   );
  //
  //                                   Navigator.pop(context);
  //                                 },
  //                                 child: Text(
  //                                   "Repeat",
  //                                   style: TextStyle(
  //                                       fontSize: 15,
  //                                       color: Color(0xff888888),
  //                                       fontWeight: FontWeight.w600),
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ]),
  //                       ),
  //                     ])
  //                 );
  //               },
  //             )
  //         );
  //       });
  // }

  //New one
  _getCommentSubMediaTabWidget(iconData, text1, i, Datum postDetails, profileSubTabRepo,  dashBoardProviderRepo, userReplyProfile,  mediaCategoryIdnId) {
    return GestureDetector(
      onTap: () => {
        _handleOnTap(i, postDetails, profileSubTabRepo,  dashBoardProviderRepo, userReplyProfile, mediaCategoryIdnId)},
      child: Container(
        padding: EdgeInsets.only(bottom: 0, left: 10, top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            i == 0 || i == 3 ?
            i ==2 ? Container():
            Icon(iconData,
                color: i == 0
                    ? postDetails.like.length > 0
                    ? Colors.red
                    : Colors.grey
                    : Colors.grey) : SvgPicture.asset(iconData, fit: BoxFit.none),
            Container(
                margin: EdgeInsets.only(left: 08, right: 15),
                child: Row(
                  children: [
                    Text(
                      text1.toString(),
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }

  _handleOnTap(int i, Datum postDetails, profileSubTabRepo,  dashBoardProviderRepo, userReplyProfile, mediaCategoryIdnId) {
    if (i == 0) {
      setState(() {
        if (favorite == true) {
          favorite = false;
        } else {
          favorite = true;
        }
      });

      profileSubTabRepo.likeOrDislikeSubCategoryIndividual(context, postDetails.id, postDetails.like);
    } else if (i == 1) {
      // print("${postDetails.postPhoto}");
      postDetails.type == "posts" ?
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CommentForPost(
          postId: postDetails.id,
          post: postDetails.userName,
          profilePicUser: userReplyProfile,
          adminPicUser : dashBoardProviderRepo.userProfilePic,
          dataMediaId: mediaCategoryIdnId,
            subMediaCommentId : subMediaCommentId,
          subMediaId: widget.userId,
          catId: postDetails.category,
          subcateId: postDetails.subCategory,
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
              // dataMedia : dataCheck,
              dataMediaId: mediaCategoryIdnId,
                dataSubMedia : dataSubMedia,
              dataSubMediaId: widget.userId,
              // profilepic: postDetails.postPhoto,
            )),
      );
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
          return SingleChildScrollView(
              child: Consumer(
                builder: (context, watch, child){

                  final repostProvider = watch(feedProvider);
                  final subCommentProviderRepo =
                  watch(subCommentFullPostViewProvider);
                  return Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF222222),
                      ),
                      child:  Column(children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 60, 0, 40),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                    repostBottom,

                                    fit: BoxFit.scaleDown),
                                Padding(
                                    padding: EdgeInsets.only(right: 15)
                                ),
                                postDetails.type == "post" ?
                                GestureDetector(
                                  onTap: () async {

                                    setState(() {
                                      if (repost == true) {
                                        repost = false;
                                      } else {
                                        repost = true;
                                      }
                                    });
                                    await  repostProvider.repostFeedPost(postDetails.id, postDetails.repost);

                                    Navigator.pop(context);

                                  },
                                  child: Text(
                                    "Repost",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xff888888),
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                                    :GestureDetector(
                                  onTap: () async {

                                    setState(() {
                                      if (repost == true) {
                                        repost = false;
                                      } else {
                                        repost = true;
                                      }
                                    });
                                    // await  repostProvider.repostFeedPost(postDetails.id, postDetails.repost);
                                    await  subCommentProviderRepo.repostNestedCommentPost(postDetails.id, postDetails.repost);

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
                                SvgPicture.asset(
                                    repeatIocn,
                                    height: 10,
                                    width: 10,
                                    fit: BoxFit.scaleDown),
                                Padding(
                                    padding: EdgeInsets.only(right: 15)
                                ),
                                postDetails.type == "post" ?
                                GestureDetector(
                                  onTap: () async{
                                    await  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => RepeatCommentPost(
                                          postDetailsMedia: postDetails
                                      )),
                                    );

                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Quote",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xff888888),
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                                : GestureDetector(
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
                                        color: Color(0xff888888),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ])
                  );
                },
              )
          );
        });
  }
}