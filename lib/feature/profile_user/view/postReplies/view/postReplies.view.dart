import 'package:async_loader/async_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/dashboard/deatailsPost.dart';
import 'package:farm_system/feature/feed/comment/view/commentforpost.view.dart';
import 'package:farm_system/feature/feed/repeat/view/repeatComment.view.dart';
import 'package:farm_system/feature/feed/subcommentPostReply/view/subcomment.view.dart';
import 'package:farm_system/feature/feed/view/readmoretext.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:video_player/video_player.dart';
import 'package:farm_system/feature/profile_user/view/postReplies/modal/postReplies.modal.dart';
import 'package:hexcolor/hexcolor.dart';

class PostRepliesProfileUser extends StatefulWidget {
  final String userId;
  const PostRepliesProfileUser({Key key, this.userId}) : super(key: key);

  @override
  _PostRepliesProfileUserState createState() => _PostRepliesProfileUserState();
}

class _PostRepliesProfileUserState extends State<PostRepliesProfileUser> {
  final _asyncKeyPostReplies = GlobalKey<AsyncLoaderState>();
  bool favorite = false;
  bool repost = false;
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

  VideoPlayerController _controller;
  VoidCallback videoPlayerListener;

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  var userId;
  @override
  void initState() {
    context.read(dashboardProvider).fetchUserDetail();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      userId = await StorageService.getUserId();
    });
    super.initState();
  }

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
      await vcontroller.setLooping(true);
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
  var dataCheck = "Post Reply Profile";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top:false,
      bottom:false,
      child: Container(
        padding: EdgeInsets.only(top:0),
        color: Colors.black,
        child: Consumer(builder: (context, watch, child) {
          final postRepliesRepo = watch(postRepliesProvider);
          return AsyncLoader(
            key: _asyncKeyPostReplies,
            initState: () => postRepliesRepo.postRepliesProfile(widget.userId),
            renderLoad: () => CircularProgressIndicator(),
            renderError: ([err]) => Text('There was a error'),
            renderSuccess: ({data}) => _generateUINew(),
          );
        }),
      ),
    );
  }

  _generateUINew() {
    return Consumer(builder: (context, watch, child) {
      final postRepliesRepo = watch(postRepliesProvider);
      final dashBoardProviderRepo = watch(dashboardProvider);
      return  Visibility(
          visible: postRepliesRepo.postReplies.length > 0,
          child:Builder(
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
                              .difference(postRepliesRepo.postReplies[index].createdAt)
                              .inDays;
                      return GestureDetector(
                        child:
                        //   dashBoardProviderRepo.userId ==
                        // postRepliesRepo ?
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
                                        BorderRadius.all(Radius.circular(25)),
                                        child:
                                        postRepliesRepo.postReplies[index].userPic ==
                                            null
                                            ? Image.asset(dummyUser,
                                            fit: BoxFit.fill,
                                            height: 25,
                                            width: 25)
                                            : CachedNetworkImage(
                                            fit: BoxFit.fill,
                                            height: 52,
                                            width: 52,
                                            imageUrl: getImageUrl(postRepliesRepo
                                                .postReplies[index].userPic)),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(top: 4),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                    child:Text(
                                                        '${postRepliesRepo.postReplies[index].userFullname}',
                                                        style: GoogleFonts.montserrat(
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.bold,
                                                            color: HexColor("#FFFFFF")
                                                        )
                                                    )),
                                                SizedBox(width: 3),
                                                Container(
                                                  child:Text(
                                                    '@${postRepliesRepo.postReplies[index].userName.toString()}',
                                                    style: GoogleFonts.montserrat(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.normal,
                                                        color: HexColor("#666666")
                                                        )
                                                  )
                                                ),
                                                Spacer(),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 0,left: 10),
                                                  child: Container(
                                                      child: days < 7
                                                          ? Text(
                                                          getTime(postRepliesRepo
                                                              .postReplies[index]
                                                              .createdAt),
                                                          style: GoogleFonts.montserrat(
                                                              fontSize: 9,
                                                              color: Colors.grey))
                                                          : Text(
                                                        DateFormat('dd-MMM')
                                                            .format(
                                                            postRepliesRepo
                                                                .postReplies[
                                                            index]
                                                                .createdAt),
                                                        style: GoogleFonts.montserrat(
                                                            color: Colors.grey,fontSize: 9),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(vertical: 0.0),
                                            child: Visibility(
                                              visible: postRepliesRepo.postReplies[index]
                                                  .userName !=
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
                                                                fontSize: 14,
                                                                color: HexColor("#7C7A7A")
                                                            )),
                                                        TextSpan(
                                                            text: " @",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.normal,
                                                                color:HexColor("D41B47")

                                                            )),
                                                        TextSpan(
                                                          text:postRepliesRepo.postReplies[index].replying ??''
                                                          ,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.normal,
                                                              fontStyle:
                                                              FontStyle
                                                                  .normal,
                                                              color:HexColor("D41B47")
                                                          ),
                                                        ),
                                                      ]),
                                                ),

                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 2),
                                          Padding(
                                            padding: EdgeInsets.symmetric(vertical: 2.0),
                                            child: Visibility(
                                              visible: postRepliesRepo.postReplies[index]
                                                  .commentMessage !=
                                                  null,
                                              child: Container(
                                                alignment: Alignment.topLeft,
                                                child: ReadMoreText(
                                                    postRepliesRepo.postReplies[index]
                                                        .commentMessage ??
                                                        '',
                                                    style: GoogleFonts.montserrat(
                                                      fontSize: 14,
                                                      letterSpacing: 0.2,
                                                        color: HexColor("#FFFFFF")
                                                    )),
                                              ),
                                            ),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.only(left: 10, right:10.0, top: 5.0, bottom: 5.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                // _getCommentPostRepliesWidget(
                                                //     postRepliesRepo.postReplies[index].like
                                                //         .contains(dashBoardProviderRepo
                                                //         .userId)
                                                //         ?  Icons.favorite
                                                //         :   Icons.favorite,
                                                //     postRepliesRepo.postReplies[index].like.length
                                                //         .toString(),
                                                //     0,
                                                //     postRepliesRepo.postReplies[index],
                                                //     postRepliesRepo,
                                                //     dashBoardProviderRepo,
                                                //     postRepliesRepo.postReplies[index].userPic
                                                // ),
                                                GestureDetector(
                                                    onTap: () async {

                                                      // print('printinggg');
                                                      // print(userId);
                                                      // print( userProfileAllRepo
                                                      //     .likeCollection);
                                                      postRepliesRepo.likeOrDislikesReple(
                                                          context,
                                                          postRepliesRepo.postReplies[index].id,
                                                          postRepliesRepo.likeCollection);

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
                                                          postRepliesRepo.postReplies[index].like.contains(
                                                              userId) == true
                                                              ?
                                                          Icon(Icons.favorite,
                                                              color: Colors.red)
                                                              : Icon(Icons.favorite,
                                                              color: Colors.grey),
                                                          Text(
                                                            "${postRepliesRepo.postReplies[index].like.length}",
                                                            style: TextStyle(
                                                                color: Colors.grey,
                                                                fontSize: 15),
                                                          ),
                                                        ])),
                                                _getCommentPostRepliesWidget(
                                                    // postRepliesRepo.postReplies[index].like
                                                    //     .contains(dashBoardProviderRepo
                                                    //     .userId)
                                                    //     ?   commentIcon
                                                    //     :    commentIcon,
                                                    postRepliesRepo.postReplies[index].commentCheck.contains(userId) == true ?   commentRed : commentIcon,
                                                    postRepliesRepo.postReplies[index].replyCount,
                                                    1,
                                                    postRepliesRepo.postReplies[index],
                                                    postRepliesRepo,
                                                    dashBoardProviderRepo,
                                                    postRepliesRepo.postReplies[index].userPic
                                                ),
                                                _getCommentPostRepliesWidget(
                                                    repostNewImage,
                                                    postRepliesRepo.postReplies[index].repost.length,
                                                    2,
                                                    postRepliesRepo.postReplies[index],
                                                    postRepliesRepo,
                                                    dashBoardProviderRepo,
                                                    postRepliesRepo.postReplies[index].userPic
                                                ),
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
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailsPost(
                                    id: postRepliesRepo.postReplies[index].parentId,
                                  )));
                        },
                      );
                    },
                    childCount: postRepliesRepo.postReplies.length,
                  ),
                ),
              ),
            ],
          );
        },
      ));
    });
  }


  _getCommentPostRepliesWidget(iconData, text1, i, PostReply postDetails, postRepliesRepo,  dashBoardProviderRepo, userReplyProfile) {
    return GestureDetector(
      onTap: () => {
        _handleOnTap(i, postDetails, postRepliesRepo,  dashBoardProviderRepo, userReplyProfile)},
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
                      style: GoogleFonts.montserrat(color: Colors.grey, fontSize: 15),
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }

  _handleOnTap(int i, PostReply postDetails, postRepliesRepo,  dashBoardProviderRepo, userReplyProfile) {
    if (i == 0) {
      setState(() {
        if (favorite == true) {
          favorite = false;
        } else {
          favorite = true;
        }
      });

      postRepliesRepo.likeOrDislikesReples(context, postDetails.id, postDetails.like);
    } else if (i == 1) {
      print("${postDetails.userPic}");
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SubCommentPostReply(
              parentId: postDetails.id,
              parentUserId: postDetails.userId,
              grandParentId: postDetails.parentId,
              //replying: postDetails.replyingUser2,
              commentPicUser: postDetails.userPic,
              userProfile: userReplyProfile,
              replyingSecondaryName: postDetails.userName,
              replyingUserName:postDetails.userFullname ,
              dataMedia : dataCheck,
              dataMediaId: widget.userId,

              // profilepic: postDetails.postPhoto,
            )),
      );
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => CommentForPost(
      //       postId: postDetails.id,
      //       post: postDetails.userName,
      //       // profilePicUser: postDetails.postPhoto.length!=0 &&  postDetails.postPhoto[0].location !=null ? postDetails.postPhoto[0].location : '',
      //       profilePicUser: userReplyProfile,
      //       adminPicUser : dashBoardProviderRepo.userProfilePic
      //     // profilepic: postDetails.postPhoto,
      //   )),
      // );
      print("Comment");
    } else {
      _modalBottomSheetMenu(i, postDetails);
    }
  }

  void _modalBottomSheetMenu(int i, PostReply postDetails) {
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
                                GestureDetector(
                                  onTap: () async {

                                    setState(() {
                                      if (repost == true) {
                                        repost = false;
                                      } else {
                                        repost = true;
                                      }
                                    });
                                    await  subCommentProviderRepo.repostNestedCommentPost(postDetails.id, postDetails.repost);

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
                                SvgPicture.asset(
                                    repeatIocn,
                                    height: 10,
                                    width: 10,
                                    fit: BoxFit.scaleDown),
                                Padding(
                                    padding: EdgeInsets.only(right: 15)
                                ),
                                GestureDetector(
                                  onTap: () async{
                                    await  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => RepeatCommentPost(
                                          profilePostRepliesDetails: postDetails
                                      )),
                                    );
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
              )
          );
        });
  }
}
