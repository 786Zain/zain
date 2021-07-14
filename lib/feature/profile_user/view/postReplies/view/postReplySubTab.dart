import 'package:async_loader/async_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/dashboard/deatailsPost.dart';
import 'package:farm_system/feature/farm_post/RepeatDetail/modal/repeatFullView.modal.dart';
import 'package:farm_system/feature/farm_post/newVideoFullpage.dart';
import 'package:farm_system/feature/feed/comment/view/commentforpost.view.dart';
import 'package:farm_system/feature/feed/repeat/view/repeatComment.view.dart';
import 'package:farm_system/feature/feed/subCommentFullView/repeatSubComment/repeatInsideSubComment.view.dart';
import 'package:farm_system/feature/feed/subcommentPostReply/view/subcomment.view.dart';
import 'package:farm_system/feature/feed/view/fullpagepost.view.dart';
import 'package:farm_system/feature/feed/view/readmoretext.dart';
import 'package:farm_system/feature/profile_user/view/postReplies/modal/postReplies.modal.dart';
import 'package:farm_system/feature/profile_user/view/profile_tabs/farmpost/modal/profileSubCategoryIndividual.modal.dart';
import 'package:farm_system/feature/profile_user/view/profile_tabs/farmpost/view/profileSubTabDetailsShimmer.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

import '../../../../../utils.dart';

class PostReplySubTabView extends StatefulWidget {

  final String profileId,userId;

  const PostReplySubTabView({Key key, this.profileId, this.userId}) : super(key: key);


  @override
  _PostReplySubTabViewState createState() => _PostReplySubTabViewState();
}


class _PostReplySubTabViewState extends State<PostReplySubTabView> {

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

  var dataCheck = "PostSubTab";

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        top:false,
        bottom:false,
        child: Container(
          color: Colors.black,
          child:Consumer(builder: (context, watch, child) {

            final PostreplySubTabCategory = watch(PostReplySubTabProvider);
            return AsyncLoader(
              key: _asyncKeyCategorySub,
              initState: ()=> PostreplySubTabCategory.PostReplySubCategoryIndividual(widget.userId,PostreplySubTabCategory.replyCategoryIdnId),
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
          final PostreplySubTabCategory = watch(PostReplySubTabProvider);
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
                              PostreplySubTabCategory.userPostReply[index].createdAt)
                              .inDays;
                          return GestureDetector(
                            child:
                            Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0, top: 10),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0, top: 4),
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(25)),
                                            child:
                                            PostreplySubTabCategory.userPostReply[index].userPic ==
                                                null
                                                ? Image.asset(dummyUser,
                                                fit: BoxFit.fill,
                                                height: 25,
                                                width: 25)
                                                : CachedNetworkImage(
                                                fit: BoxFit.fill,
                                                height: 52,
                                                width: 52,
                                                imageUrl: getImageUrl(PostreplySubTabCategory
                                                    .userPostReply[index].userPic)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.only(top: 4),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                        child:Text(
                                                            '${PostreplySubTabCategory.userPostReply[index].userFullname}',
                                                            style: GoogleFonts.montserrat(
                                                                fontSize: 18,
                                                                fontWeight: FontWeight.bold,
                                                                color: HexColor("#FFFFFF")
                                                            )
                                                        )),
                                                    SizedBox(width: 3),
                                                    Container(
                                                        child:Text(
                                                            '@${PostreplySubTabCategory.userPostReply[index].userName.toString()}',
                                                            style: GoogleFonts.montserrat(
                                                                fontSize: 13,
                                                                fontWeight: FontWeight.normal,
                                                                color: HexColor("#666666")
                                                            )
                                                        )
                                                    ),
                                                    Spacer(),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top:0,left: 10),
                                                      child: Container(
                                                          child: days < 7
                                                              ? Text(
                                                              getTime(PostreplySubTabCategory
                                                                  .userPostReply[index]
                                                                  .createdAt),
                                                              style: GoogleFonts.montserrat(
                                                                  fontSize: 9,
                                                                  color: Colors.grey))
                                                              : Text(
                                                            DateFormat('dd-MMM')
                                                                .format(
                                                                PostreplySubTabCategory
                                                                    .userPostReply[
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
                                                  visible: PostreplySubTabCategory.userPostReply[index]
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
                                                              text:PostreplySubTabCategory.userPostReply[index].replying ??''
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
                                                  visible: PostreplySubTabCategory.userPostReply[index]
                                                      .commentMessage !=
                                                      null,
                                                  child: Container(
                                                    alignment: Alignment.topLeft,
                                                    child: ReadMoreText(

                                                        PostreplySubTabCategory.userPostReply[index]
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
                                                          PostreplySubTabCategory.likeOrDisPostProfileSubTab(
                                                              context,
                                                              PostreplySubTabCategory.userPostReply[index].id,
                                                              PostreplySubTabCategory.likeCollection);

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
                                                              PostreplySubTabCategory.userPostReply[index].like.contains(
                                                                  userId) == true
                                                                  ?
                                                              Icon(Icons.favorite,
                                                                  color: Colors.red)
                                                                  : Icon(Icons.favorite,
                                                                  color: Colors.grey),
                                                              Text(
                                                                "${PostreplySubTabCategory.userPostReply[index].like.length}",
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
                                                        PostreplySubTabCategory.userPostReply[index].commentCheck.contains(userId) == true ?   commentRed : commentIcon,
                                                        PostreplySubTabCategory.userPostReply[index].replyCount,
                                                        1,
                                                        PostreplySubTabCategory.userPostReply[index],
                                                        PostreplySubTabCategory,
                                                        dashBoardProviderRepo,
                                                        PostreplySubTabCategory.userPostReply[index].userPic,
                                                        PostreplySubTabCategory.replyCategoryIdnId,
                                                    ),
                                                    _getCommentPostRepliesWidget(
                                                        repostNewImage,
                                                        PostreplySubTabCategory.userPostReply[index].repost.length,
                                                        2,
                                                        PostreplySubTabCategory.userPostReply[index],
                                                        PostreplySubTabCategory,
                                                        dashBoardProviderRepo,
                                                        PostreplySubTabCategory.userPostReply[index].userPic,
                                                        PostreplySubTabCategory.replyCategoryIdnId
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // Divider(
                                              //   height: 1,
                                              //   thickness: 0.5,
                                              //   color: Colors.grey,
                                              // ),
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
                                        id: PostreplySubTabCategory.userPostReply[index].parentId,
                                      )));
                            },
                          );
                        },
                        childCount: PostreplySubTabCategory.userPostReply.length,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        });

  }

  _getCommentPostRepliesWidget(iconData, text1, i, PostReply postDetails, profileSubTabRepo,  dashBoardProviderRepo, userReplyProfile, replyCategoryIdnId) {
    return GestureDetector(
      onTap: () => {
        _handleOnTap(i, postDetails, profileSubTabRepo,  dashBoardProviderRepo, userReplyProfile, replyCategoryIdnId)},
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

  _handleOnTap(int i, PostReply postDetails, profileSubTabRepo,  dashBoardProviderRepo, userReplyProfile, replyCategoryIdnId) {
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
          dataMediaId: replyCategoryIdnId,
            postSubReplyId: widget.userId,

          )),
      );

          // profilepic: postDetails.postPhoto,

          // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => CommentForPost(
      //       postId: postDetails.id,
      //       post: postDetails.userName,
      //       profilePicUser: userReplyProfile,
      //       adminPicUser : dashBoardProviderRepo.userProfilePic
      //   )),
      // );
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
                                GestureDetector(
                                  onTap: () async{
                                    await  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => RepeatInsideSubComment(
                                        postReplySubTabProfile: postDetails,
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
                                // GestureDetector(
                                //   onTap: () async{
                                //     await  Navigator.push(
                                //       context,
                                //       MaterialPageRoute(builder: (context) => RepeatCommentPost(
                                //          // postProfileSubcategory: postDetails
                                //       )),
                                //     );
                                //
                                //     Navigator.pop(context);
                                //   },
                                //   child: Text(
                                //     "Repeat",
                                //     style: TextStyle(
                                //         fontSize: 15,
                                //         color: Color(0xff888888),
                                //         fontWeight: FontWeight.w600),
                                //   ),
                                // ),
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
