import 'package:async_loader/async_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/dashboard/deatailsPost.dart';
import 'package:farm_system/feature/farm_post/RepeatDetail/view/repeatPostFull.view.dart';
import 'package:farm_system/feature/farm_post/newVideoFullpage.dart';
import 'package:farm_system/feature/feed/comment/view/commentforpost.view.dart';
import 'package:farm_system/feature/feed/repeat/view/repeatComment.view.dart';
import 'package:farm_system/feature/feed/subCommentFullView/repeatSubComment/repeatInsideSubComment.view.dart';
import 'package:farm_system/feature/feed/subcommentPostReply/view/subcomment.view.dart';
import 'package:farm_system/feature/feed/view/fullpagepost.view.dart';
import 'package:farm_system/feature/feed/view/readmoretext.dart';
import 'package:farm_system/feature/profile_user/view/Likes/model/likeSubTab_model.dart';
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

class LikeSubTabDetails extends StatefulWidget {
  final String userId;
  final String profileId;

  const LikeSubTabDetails({Key key,this.userId, this.profileId}) : super(key: key);


  @override
  _LikeSubTabDetailsState createState() => _LikeSubTabDetailsState();
}


class _LikeSubTabDetailsState extends State<LikeSubTabDetails> {

  final _asyncKeyCategorySub = GlobalKey<AsyncLoaderState>();
  VideoPlayerController _controller;
  VoidCallback videoPlayerListener;

  bool favorite = false;
  bool repost = false;

  List<String> imageFileTypes = ["png", "jpg", "jpeg", "gif", "JPG" , "PNG", "JPEG", "GIF", "HEIC"];

  var userId;
  var likeSubComment = "likeSubComment";

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      userId = await StorageService.getUserId();
    });
    // TODO: implement initState
    super.initState();
  }

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
            // ignore: non_constant_identifier_names
            final LikeSubTabCategory = watch(LikeSubTabProvider);
            return AsyncLoader(
              key: _asyncKeyCategorySub,
              initState: ()=> LikeSubTabCategory.LikeSubCategoryIndividual(widget.userId,LikeSubTabCategory.likeCategoryIdnId),
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
          // ignore: non_constant_identifier_names
          final LikeSubTabCategory = watch(LikeSubTabProvider);
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
                              LikeSubTabCategory.userLikecategory[index].createdAt)
                              .inDays;
                          return GestureDetector(
                            child: Container(
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
                                            child: LikeSubTabCategory
                                                .userLikecategory[index].profilePic ==
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
                                                    LikeSubTabCategory
                                                        .userLikecategory[index]
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
                                                        child: LikeSubTabCategory
                                                            .userLikecategory[index]
                                                            .name !=
                                                            "" &&
                                                            LikeSubTabCategory
                                                                .userLikecategory[index]
                                                                .name !=
                                                                null
                                                            ? Text(
                                                            '${LikeSubTabCategory
                                                                .userLikecategory[index]
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
                                                        child: LikeSubTabCategory
                                                            .userLikecategory[index]
                                                            .userName !=
                                                            "" &&
                                                            LikeSubTabCategory
                                                                .userLikecategory[index]
                                                                .userName !=
                                                                null
                                                            ? Text(
                                                            '@' + '${LikeSubTabCategory.userLikecategory[index].userName}',
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight: FontWeight.bold,
                                                                color: HexColor("#666666")
                                                            ))
                                                            : Text(" "),

                                                      ),
                                                      Spacer(),
                                                      Padding(
                                                        padding: EdgeInsets.only(right: 4.0),
                                                        child: Container(
                                                          margin: EdgeInsets.only(top: 0, left: 5),
                                                          child: days < 7
                                                              ? Text(
                                                              getTime(
                                                                  LikeSubTabCategory
                                                                      .userLikecategory[index]
                                                                      .createdAt),
                                                              style: TextStyle(
                                                                  fontSize: 9,
                                                                  fontWeight: FontWeight.bold,
                                                                  color: HexColor("#666666")))
                                                              : Text(
                                                              DateFormat(
                                                                  'dd-MMM')
                                                                  .format(
                                                                  LikeSubTabCategory
                                                                      .userLikecategory[index]
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
                                                  padding: EdgeInsets.only(top: 1.0, bottom: 5),
                                                  child: Visibility(
                                                    visible: LikeSubTabCategory.userLikecategory[index].caption != null,
                                                    child: Container(
                                                      alignment: Alignment.topLeft,
                                                      child: ReadMoreText(
                                                          LikeSubTabCategory.userLikecategory[index].caption ?? '',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.normal,
                                                              color: HexColor("#FFFFFF")
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                                LikeSubTabCategory
                                                    .userLikecategory[index].textFeed == false

                                               ? Padding(
                                                  padding: EdgeInsets.only(left: 0),
                                                  child: LikeSubTabCategory
                                                      .userLikecategory[index].postPhoto
                                                      .length > 0 ?
                                                    Container(
                                                    height: 200,
                                                    margin: EdgeInsets.only(bottom: 2),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                        BorderRadius.all(Radius.circular(20)),
                                                        child: imageFileTypes.indexOf(LikeSubTabCategory
                                                            .userLikecategory[index]
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
                                                                    LikeSubTabCategory
                                                                        .userLikecategory[index]
                                                                        .postPhoto[0]
                                                                        .location,
                                                                        likesSubTabData: LikeSubTabCategory.userLikecategory[index],
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
                                                                'op ${LikeSubTabCategory.userLikecategory[index].postPhoto[0].location}',
                                                                child: CachedNetworkImage(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    imageUrl: getImageUrl(LikeSubTabCategory
                                                                        .userLikecategory[index]
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
                                                                            filePaths: LikeSubTabCategory
                                                                                .userLikecategory[
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
                                                                          imageUrl: getImageUrl(LikeSubTabCategory
                                                                              .userLikecategory[
                                                                          index]
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
                                                                                filePaths: LikeSubTabCategory
                                                                                    .userLikecategory[index]
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

                                                LikeSubTabCategory.userLikecategory[index].repeat
                                                    .profilePic !=
                                                    null
                                                    ? GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                RepeatPostFullView(
                                                                  id:  LikeSubTabCategory.userLikecategory[index].repeat.repeatingId,
                                                                )));
                                                  },
                                                  child: Padding(
                                                      padding: const EdgeInsets.only(left:0),
                                                      child: LikeSubTabCategory.userLikecategory[index].repeat.post !=
                                                          null ?
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.all(
                                                              Radius.circular(10.0)),
                                                        ),
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
                                                                    padding:
                                                                    EdgeInsets.all(8.0),
                                                                    child: ClipRRect(
                                                                      borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              25)),
                                                                      child: LikeSubTabCategory
                                                                          .userLikecategory[
                                                                      index]
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
                                                                          height: 40,
                                                                          width: 40,
                                                                          imageUrl: getImageUrl(
                                                                              LikeSubTabCategory
                                                                                  .userLikecategory[
                                                                              index]
                                                                                  .repeat
                                                                                  .profilePic)),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left: 1, top: 15),
                                                                    child: LikeSubTabCategory
                                                                        .userLikecategory[
                                                                    index]
                                                                        .repeat
                                                                        .userName !=
                                                                        "" &&
                                                                        LikeSubTabCategory
                                                                            .userLikecategory[
                                                                        index]
                                                                            .repeat
                                                                            .userName !=
                                                                            null
                                                                        ? Text(
                                                                        Utils.getCapitalizeName(
                                                                            '${LikeSubTabCategory.userLikecategory[index].repeat.name}'),
                                                                        // '${feedProviderRepo.feedList[index].repeat.name}',
                                                                        style: GoogleFonts.montserrat(
                                                                            fontSize: 14,
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
                                                                    padding: EdgeInsets.only(
                                                                        left: 1, top: 17),
                                                                    child: Container(
                                                                      child: LikeSubTabCategory
                                                                          .userLikecategory[
                                                                      index]
                                                                          .repeat
                                                                          .userName !=
                                                                          "" &&
                                                                          LikeSubTabCategory
                                                                              .userLikecategory[
                                                                          index]
                                                                              .repeat
                                                                              .userName !=
                                                                              null
                                                                          ? Text(
                                                                          '@${LikeSubTabCategory.userLikecategory[index].repeat.userName}',
                                                                          style: GoogleFonts.montserrat(
                                                                              fontSize:
                                                                              12,
                                                                              fontWeight:
                                                                              FontWeight
                                                                                  .normal,
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
                                                            LikeSubTabCategory
                                                                .userLikecategory[index]
                                                                .repeat
                                                                .message !=null?
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  left: 8, bottom: 1),
                                                              child: Container(
                                                                child: ReadMoreText(
                                                                    LikeSubTabCategory
                                                                        .userLikecategory[index]
                                                                        .repeat
                                                                        .message ??
                                                                        '',
                                                                    style: GoogleFonts
                                                                        .montserrat(
                                                                        fontSize: 12,

                                                                        fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                        color: HexColor("#FFFFFF"),
                                                                        letterSpacing:
                                                                        0.5)),
                                                              ),
                                                            ):Container(),

                                                            LikeSubTabCategory.userLikecategory[index].repeat.textFeed ==
                                                                false
                                                                ?

                                                            LikeSubTabCategory.userLikecategory[index].repeat.post !=
                                                                null
                                                                ?

                                                            Container(
                                                                height: 200,
                                                                margin:
                                                                EdgeInsets.only(
                                                                    top: 10),
                                                                child: ClipRRect(
                                                                    borderRadius:
                                                                    BorderRadius.all(
                                                                        Radius.circular(
                                                                            20)),
                                                                    child:
                                                                    imageFileTypes.indexOf(LikeSubTabCategory
                                                                        .userLikecategory[index]
                                                                        .repeat
                                                                        .post
                                                                        .split('.')
                                                                        .last) !=
                                                                        -1
                                                                        ? Padding(
                                                                      padding: EdgeInsets.only(
                                                                          top: 8.0,
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
                                                                                      filePaths: LikeSubTabCategory.userLikecategory[index].repeat.post,
                                                                                      // postData: userProfileAllRepo.userAll[index],
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                              child: CachedNetworkImage(fit: BoxFit.cover, imageUrl: getImageUrl(LikeSubTabCategory.userLikecategory[index].repeat.post)),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                        : Stack(
                                                                      children: [
                                                                        GestureDetector(
                                                                          onTap: () {
                                                                            Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlayerNew(filePaths: LikeSubTabCategory.userLikecategory[index].repeat.post)));
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
                                                                                  child: CachedNetworkImage(fit: BoxFit.cover, imageUrl: getImageUrl(LikeSubTabCategory.userLikecategory[index].repeat.thumbnailUrl)),
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
                                                                                Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlayerNew(filePaths: LikeSubTabCategory.userLikecategory[index].repeat.post)));
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
                                                      left: 0,
                                                      right: 0.0,
                                                      top: 5.0,
                                                      bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceEvenly,
                                                    children: <Widget>[
                                                      // _getCommentWidget(
                                                      //     profileSubTabRepo
                                                      //         .userAll[index]
                                                      //         .like
                                                      //         .contains(
                                                      //         dashBoardProviderRepo
                                                      //             .userId)
                                                      //         ? Icons.favorite
                                                      //         : Icons.favorite,
                                                      //     profileSubTabRepo
                                                      //         .userAll[index]
                                                      //         .like.length
                                                      //         .toString(),
                                                      //     0,
                                                      //     profileSubTabRepo
                                                      //         .userAll[index],
                                                      //     profileSubTabRepo,
                                                      //     dashBoardProviderRepo,
                                                      //     profileSubTabRepo
                                                      //         .userAll[index]
                                                      //         .profilePic
                                                      // ),
                                                      LikeSubTabCategory.userLikecategory[index].type == "comment"  ?
                                                      GestureDetector(
                                                          onTap: () async {

                                                            // print('printinggg');
                                                            // print(userId);
                                                            // print( userProfileAllRepo
                                                            //     .likeCollection);
                                                            LikeSubTabCategory.likeOrDislikeSubTabLikeComment(
                                                                context,
                                                                LikeSubTabCategory.userLikecategory[index].id,
                                                                LikeSubTabCategory.likeCollection);

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
                                                                LikeSubTabCategory.userLikecategory[index].like.contains(
                                                                    userId) == true
                                                                    ?
                                                                Icon(Icons.favorite,
                                                                    color: Colors.red)
                                                                    : Icon(Icons.favorite,
                                                                    color: Colors.grey),
                                                                Text(
                                                                  "${ LikeSubTabCategory.userLikecategory[index].like.length}",
                                                                  style: TextStyle(
                                                                      color: Colors.grey,
                                                                      fontSize: 15),
                                                                ),
                                                              ])):
                                                      GestureDetector(
                                                          onTap: () async {

                                                            // print('printinggg');
                                                            // print(userId);
                                                            // print( userProfileAllRepo
                                                            //     .likeCollection);
                                                            LikeSubTabCategory.likeOrDislikeSubTabLike(
                                                                context,
                                                                LikeSubTabCategory.userLikecategory[index].id,
                                                                LikeSubTabCategory.likeCollection);

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
                                                                LikeSubTabCategory.userLikecategory[index].like.contains(
                                                                    userId) == true
                                                                    ?
                                                                Icon(Icons.favorite,
                                                                    color: Colors.red)
                                                                    : Icon(Icons.favorite,
                                                                    color: Colors.grey),
                                                                Text(
                                                                  "${ LikeSubTabCategory.userLikecategory[index].like.length}",
                                                                  style: TextStyle(
                                                                      color: Colors.grey,
                                                                      fontSize: 15),
                                                                ),
                                                              ])),
                                                      _getCommentWidget(
                                                        // profileSubTabRepo.userAll[index].like.contains(
                                                        //     dashBoardProviderRepo.userId)
                                                        //     ? commentIcon
                                                        //     : commentIcon,
                                                        // commentIcon,
                                                          LikeSubTabCategory.userLikecategory[index].commentCheck.contains(userId) == true ?   commentRed : commentIcon,
                                                          LikeSubTabCategory.userLikecategory[index].commentCount,
                                                          1,
                                                          LikeSubTabCategory.userLikecategory[index],
                                                          LikeSubTabCategory,
                                                          dashBoardProviderRepo,
                                                          LikeSubTabCategory.userLikecategory[index].profilePic,
                                                          LikeSubTabCategory.likeCategoryIdnId
                                                      ),
                                                      _getCommentWidget(
                                                          LikeSubTabCategory.userLikecategory[index].repost.contains(userId) == true ?   repostColor : repostNewImage,
                                                          LikeSubTabCategory.userLikecategory[index].repost.length,
                                                          2,
                                                          LikeSubTabCategory.userLikecategory[index],
                                                          LikeSubTabCategory,
                                                          dashBoardProviderRepo,
                                                          LikeSubTabCategory.userLikecategory[index].profilePic,
                                                          LikeSubTabCategory.likeCategoryIdnId,
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
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailsPost(
                                            id: LikeSubTabCategory.userLikecategory[index]
                                                .id,
                                            likesubtabrepeatdetails: LikeSubTabCategory.userLikecategory[index],
                                          )));
                            },
                          );

                        },
                        childCount: LikeSubTabCategory.userLikecategory.length,
                      ),
                    ),
                  ),
                ],
              );
            },

          );
        });

  }

  _getCommentWidget(iconData, text1, i, LikeSubTab postDetails, profileSubTabRepo,  dashBoardProviderRepo, userReplyProfile, likeCategoryIdnId) {
    return GestureDetector(
      onTap: () => {
        _handleOnTap(i, postDetails, profileSubTabRepo,  dashBoardProviderRepo, userReplyProfile, likeCategoryIdnId)},
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

  _handleOnTap(int i, LikeSubTab postDetails, profileSubTabRepo,  dashBoardProviderRepo, userReplyProfile, likeCategoryIdnId) {
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
      print("${postDetails.postPhoto}");
      postDetails.type == "comment" ?
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
              dataMediaId: likeCategoryIdnId,
              likeSubId: widget.userId,
              likeSubComment : likeSubComment,

              // profilepic: postDetails.postPhoto,
            )),
      ) :
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CommentForPost(
            postId: postDetails.id,
            post: postDetails.userName,
            profilePicUser: userReplyProfile,
            adminPicUser : dashBoardProviderRepo.userProfilePic,
          dataLikeSubId: likeCategoryIdnId,
          likeSubId: widget.userId,
          catId: postDetails.category,
          subcateId: postDetails.subCategory,
          likeSubComment : likeSubComment,
        )),
      );
    } else {
      _modalBottomSheetMenu(i, postDetails);
    }
  }

  void _modalBottomSheetMenu(int i, LikeSubTab postDetails) {
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
                  final dashBoardProviderRepo = watch(dashboardProvider);
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
                                postDetails.type == "comment" ?
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
                                ) :
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
                                postDetails.type == "comment" ?
                                GestureDetector(
                                  onTap: () async{
                                    await  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => RepeatInsideSubComment(
                                        likeSubTabProfile: postDetails,
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
                                      MaterialPageRoute(builder: (context) => RepeatCommentPost(
                                           postDetailsSubLikeTab: postDetails,
                                          adminPicUser:
                                          dashBoardProviderRepo
                                              .userProfilePic
                                      )),
                                    );

                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Repeat",
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
