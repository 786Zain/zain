import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/dashboard/deatailsPost.dart';
import 'package:farm_system/feature/farm_post/newVideoFullpage.dart';
import 'package:farm_system/feature/feed/models/ModelBasedonPostId.dart';
import 'package:farm_system/feature/feed/view/fullpagepost.view.dart';
import 'package:farm_system/feature/feed/view/readmoretext.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SubCommentViewPage extends StatefulWidget {
  @override
  _SubCommentViewPageState createState() => _SubCommentViewPageState();
}

class _SubCommentViewPageState extends State<SubCommentViewPage> {


  List<String> imageFileTypes = ["png", "jpg", "jpeg", "gif", "JPG" , "PNG", "JPEG", "GIF", "HEIC"];

  VideoPlayerController _controller;
  VoidCallback videoPlayerListener;
  void getVideoFile(fileUrl) async {
    try {
      final VideoPlayerController vcontroller =
      VideoPlayerController.network(fileUrl);
      videoPlayerListener = () {
        if (_controller != null && _controller.value.size != null) {
          if (mounted) setState(() {});
          _controller.removeListener(videoPlayerListener);
        }
      };
      vcontroller.addListener(videoPlayerListener);
      await vcontroller.setLooping(false);
      await vcontroller.initialize();
      //await _controller?.dispose();
      if (mounted) {
        setState(() {
          _controller = vcontroller;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Consumer(
              builder: (context, watch, child){
                final feedProviderRepo = watch(feedProvider);
                final dashBoardProviderRepo = watch(dashboardProvider);
                return Visibility(
                    visible: feedProviderRepo.commentList !=null,
                    child:InViewNotifierList(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        initialInViewIds: ['0'],
                        isInViewPortCondition:
                            (double deltaTop, double deltaBottom, double viewPortDimension) {
                          return deltaTop < (0.5 * viewPortDimension) &&
                              deltaBottom > (0.5 * viewPortDimension);
                        },
                        itemCount: feedProviderRepo.commentList.length,
                        builder: (BuildContext context, int index){
                          var dt = new DateTime.now();
                          var days= dt.difference(feedProviderRepo.commentList[index].createdAt).inDays;

                          print("comment media file");
                          print(feedProviderRepo.commentList[index].media);
                          if (feedProviderRepo.commentList[index].media !=null &&

                              imageFileTypes.indexOf(
                                  getImageUrl(
                                      feedProviderRepo
                                          .commentList[index].media[0])
                                      .split('.')
                                      .last
                              )  == -1
                          ) {
                            getVideoFile(getImageUrl(feedProviderRepo
                                .commentList[index].media));
                          }

                          print("user id");
                          print( dashBoardProviderRepo.userName);

                          print("comment List id");
                          print (feedProviderRepo.feedDetail.post[0].id);
                          print (feedProviderRepo.commentList[index].userName);
                          if(dashBoardProviderRepo.userId == feedProviderRepo.commentList[index].userId){
                            print("find ");
                          }else{
                            print("not find");
                          }

                          return GestureDetector(
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top: 4, left: 4, right: 4),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child:  ClipRRect(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(20)),
                                            child: feedProviderRepo.commentList[index].userPic ==
                                                null
                                                ? Image.asset(dummyUser,
                                                fit: BoxFit.fill, height: 25, width: 25)
                                                : CachedNetworkImage(
                                                fit: BoxFit.fill,
                                                height: 52,
                                                width: 52,
                                                imageUrl: getImageUrl(feedProviderRepo.commentList[index].userPic)),
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
                                                    Expanded(
                                                      child: Container(
                                                        child: feedProviderRepo.commentList[index].userFullname !=
                                                            "" &&
                                                            feedProviderRepo.commentList[index].userFullname !=
                                                                null
                                                            ? Text(
                                                            '${feedProviderRepo.commentList[index].userFullname}',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              color: Colors.white,
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
                                                        padding: EdgeInsets.only(right: 4.0),
                                                        child: Container(
                                                            margin: EdgeInsets.only(top: 16, left: 5),
                                                            child:  days < 7 ? Text(
                                                                getTime(feedProviderRepo.commentList[index].createdAt),
                                                                style: TextStyle(fontSize: 15, color: Colors.white)): Text(DateFormat('dd-MMM').format(feedProviderRepo.commentList[index].createdAt)) ),
                                                      ),flex: 1,
                                                    ),
                                                    dashBoardProviderRepo.userId == feedProviderRepo.commentList[index].userId ?
                                                    Expanded(
                                                      child: Padding(
                                                          padding: EdgeInsets.only(right: 4.0),
                                                          child: Container(
                                                            margin: EdgeInsets.only(top: 16, left: 5),
                                                            child:  GestureDetector(
                                                              onTap: () => _modalBottomSheetMenu(),
                                                              child: Icon(Icons.more_vert,
                                                                color: Colors.white,
                                                              ),
                                                            ),
                                                          )
                                                      ),flex: 1,
                                                    ): Container(),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(vertical: 0.0),
                                                child:  Visibility(
                                                  visible: feedProviderRepo.commentList[index].replying != null,
                                                  child: Container(
                                                    alignment: Alignment.topLeft,
                                                    child:
                                                    RichText(
                                                      overflow: TextOverflow.ellipsis,
                                                      text: TextSpan(
                                                          style: DefaultTextStyle.of(context).style,
                                                          children: <TextSpan>[
                                                            TextSpan(text: "Replying to ",
                                                                style: TextStyle(
                                                                    color: Colors.grey
                                                                )
                                                            ),
                                                            TextSpan(
                                                              text: feedProviderRepo.commentList[index].replying,
                                                              style: TextStyle(
                                                                  fontStyle: FontStyle.normal,
                                                                  color: Colors.red
                                                              ),
                                                            ),
                                                          ]),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                                child:  Visibility(
                                                  visible: feedProviderRepo.commentList[index].commentMessage != null,
                                                  child: Container(
                                                    alignment: Alignment.topLeft,
                                                    child:
                                                    ReadMoreText(
                                                        feedProviderRepo.commentList[index].commentMessage ?? '',
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
                                                child: feedProviderRepo.commentList[index].media !=null
                                                    ? Container(
                                                  height: 200,
                                                  margin: EdgeInsets.only(top: 10),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.all(Radius.circular(20)),
                                                    child:

                                                    imageFileTypes.indexOf( feedProviderRepo.commentList[index].media
                                                        .split('.')
                                                        .last)

                                                        != -1
                                                        ? GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    FullPagePostView(
                                                                        filePaths:
                                                                        feedProviderRepo.commentList[index].media)
                                                            )
                                                        );
                                                      },
                                                      child: OverflowBox(
                                                        minWidth: 0.0,
                                                        minHeight: 0.0,
                                                        maxWidth: double.infinity,
                                                        maxHeight: double.infinity,
                                                        child: Hero(
                                                          tag: 'g ${  feedProviderRepo.commentList[index].media}',
                                                          child: CachedNetworkImage(
                                                              imageUrl: getImageUrl(
                                                                  feedProviderRepo.commentList[index].media)),
                                                        ),
                                                      ),
                                                    )
                                                        : _controller != null &&
                                                        _controller.value.initialized
                                                        ?
                                                    Stack(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        VideoPlayerNew(
                                                                            filePaths:
                                                                            feedProviderRepo.commentList[index].media)
                                                                )
                                                            );
                                                          },
                                                          child: LayoutBuilder(
                                                            builder: (BuildContext context, BoxConstraints constraints) {
                                                              return InViewNotifierWidget(
                                                                id: '$index',
                                                                builder:
                                                                    (BuildContext context, bool isInView, Widget child) {
                                                                  return Container();
                                                                  //   VideoWidget(
                                                                  //     play: isInView,
                                                                  //     url:
                                                                  //     //'https://sfo2.digitaloceanspaces.com/peoplepedia/1607424784883_sample-mp4-file.mp4'
                                                                  //     feedProviderRepo.commentList[index].media
                                                                  //   // 'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4'
                                                                  //
                                                                  // );
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
                                                                color: Colors.blue, // button color
                                                                child: SizedBox(
                                                                    width: 46,
                                                                    height: 46,
                                                                    child: Icon(Icons.play_arrow,
                                                                      color: Colors.white,
                                                                      size: 30,
                                                                    )),
                                                              ),
                                                            )
                                                        ),
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
                                                padding: EdgeInsets.only(left: 0, right:0.0, top: 8.0, bottom: 8.0),
                                                child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      _getCommentWidget(
                                                          feedProviderRepo.commentList[index].like
                                                              .contains(dashBoardProviderRepo
                                                              .userId)
                                                              ?  Icons.favorite
                                                              :   Icons.favorite,
                                                          feedProviderRepo.commentList[index].like.length
                                                              .toString(),
                                                          0,
                                                          feedProviderRepo.commentList[index],
                                                          feedProviderRepo,
                                                          dashBoardProviderRepo,
                                                          feedProviderRepo.commentList[index].userPic
                                                      ),
                                                      _getCommentWidget(
                                                          commentIcon,
                                                          "3k",
                                                          1,
                                                          feedProviderRepo.commentList[index],
                                                          feedProviderRepo,
                                                          dashBoardProviderRepo,
                                                          feedProviderRepo.commentList[index].userPic
                                                      ),
                                                      Row(
                                                        children: [
                                                          _getCommentWidget(
                                                              Icons.arrow_downward_rounded,
                                                              "2k",
                                                              2,
                                                              feedProviderRepo.commentList[index],
                                                              feedProviderRepo,
                                                              dashBoardProviderRepo,
                                                              feedProviderRepo.feedDetail.comments[index].userPic
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          _getCommentWidget(
                                                              Icons.bookmark_border,
                                                              "",
                                                              2,
                                                              feedProviderRepo.commentList[index],
                                                              feedProviderRepo,
                                                              dashBoardProviderRepo,
                                                              feedProviderRepo.feedDetail.comments[index].userPic
                                                          )
                                                        ],
                                                      ),
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
                              print(feedProviderRepo.commentList[index].id);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailsPost(
                                        id: feedProviderRepo.commentList[index].id,
                                      )));
                            },
                          );
                        }
                    )
                );
              }
          )
        ],
      ),
    );
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        context: context,
        builder: (builder) {
          return SingleChildScrollView(
            child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF222222),
                ),
                child:  Column(children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 60, 0, 40),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                      Row(
                        children: [
                          Icon(Icons.delete,
                            color: Colors.red,
                          ),
                          Padding(
                              padding: EdgeInsets.only(right: 15)
                          ),
                          Text(
                            "Delete",
                            style: TextStyle(
                                fontSize: 15,
                                // color: HexColor("666666"),
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.edit,
                            color: Colors.red,
                          )  ,
                          Padding(
                              padding: EdgeInsets.only(right: 15)
                          ),
                          Text(
                            "Edit",
                            style: TextStyle(
                                fontSize: 15,
                                // color: HexColor("666666"),
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ]),
                  ),
                ])),
          );
        });
  }

  _getCommentWidget(iconData, text1, i, Comment postDetails, feedProviderRepo,  dashBoardProviderRepo, userReplyProfile) {
    return GestureDetector(
      //   onTap: () => _handleOnTap(i, postDetails, feedProviderRepo,  dashBoardProviderRepo, userReplyProfile),
      child: Container(
        padding: EdgeInsets.only(bottom: 10, left: 15, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            i == 0 || i == 2 || i == 3 ?   Icon(iconData,
                color: i == 0
                    ? postDetails.like.length > 0
                    ? Colors.red
                    : Colors.grey
                    : Colors.grey) : SvgPicture.asset(iconData, fit: BoxFit.none),
            // Icon(iconData,
            //     color: i == 0
            //         ? postDetails.like.length > 0
            //             ? Colors.red
            //             : Colors.grey
            //         : Colors.grey),
            Container(
              margin: EdgeInsets.only(left: 08, right: 15),
              child: Text(
                text1,
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
