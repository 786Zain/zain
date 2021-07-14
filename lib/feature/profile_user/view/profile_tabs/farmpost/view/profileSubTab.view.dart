import 'package:async_loader/async_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/dashboard/deatailsPost.dart';
import 'package:farm_system/feature/farm_post/RepeatDetail/modal/repeatFullView.modal.dart';
import 'package:farm_system/feature/farm_post/newVideoFullpage.dart';
import 'package:farm_system/feature/feed/comment/view/commentforpost.view.dart';
import 'package:farm_system/feature/feed/repeat/view/repeatComment.view.dart';
import 'package:farm_system/feature/feed/view/fullpagepost.view.dart';
import 'package:farm_system/feature/feed/view/readmoretext.dart';
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

import '../../../../../../utils.dart';

class ProfileSubTabDetails extends StatefulWidget {
  final String userId;
  final String profileId;

  const ProfileSubTabDetails({Key key, this.userId,this.profileId}) : super(key: key);

  @override
  _ProfileSubTabDetailsState createState() => _ProfileSubTabDetailsState();
}

class _ProfileSubTabDetailsState extends State<ProfileSubTabDetails> {
  final _asyncKeyCategorySub = GlobalKey<AsyncLoaderState>();
  VideoPlayerController _controller;
  VoidCallback videoPlayerListener;

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
  var userId;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      userId = await StorageService.getUserId();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return SafeArea(
        top: false,
        bottom: false,
        child: Container(
          color: Colors.black,
          child: Consumer(builder: (context, watch, child) {
            final profileSubTabRepo = watch(profileSubTabProvider);
            return AsyncLoader(
              key: _asyncKeyCategorySub,
              initState: () => profileSubTabRepo.profileSubCategoryIndividual(widget.userId,
                  profileSubTabRepo.profileCategoryIdnId),
              renderLoad: () => ProfileSubTabDetailsShimmer(),
              renderError: ([err]) => Text('There was a error'),
              renderSuccess: ({data}) => _generateUI(),
            );
          }),
        ));
  }

  _generateUI() {
    return Consumer(builder: (context, watch, child) {
      final profileSubTabRepo = watch(profileSubTabProvider);
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
                              profileSubTabRepo.userAll[index].createdAt)
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
                                      padding: EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25)),
                                        child: profileSubTabRepo.userAll[index]
                                                    .profilePic ==
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
                                                    profileSubTabRepo
                                                        .userAll[index]
                                                        .profilePic)),
                                      ),
                                    ),
                                    Expanded(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 4.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
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
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                child: profileSubTabRepo.userAll[index].name !=
                                                                            "" &&
                                                                        profileSubTabRepo.userAll[index].name !=
                                                                            null
                                                                    ? Text(
                                                                        '${profileSubTabRepo.userAll[index].name}',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.white))
                                                                    : Text(" "),
                                                              ),
                                                              SizedBox(
                                                                width: 3,
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  child: profileSubTabRepo.userAll[index].userName !=
                                                                              "" &&
                                                                          profileSubTabRepo.userAll[index].userName !=
                                                                              null
                                                                      ? Text(
                                                                          '@' +
                                                                              '${profileSubTabRepo.userAll[index].userName}',
                                                                          style: TextStyle(
                                                                              fontSize: 13,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: HexColor("#666666")))
                                                                      : Text(" "),
                                                                ),
                                                                flex: 4,
                                                              ),
                                                            ]))
                                                  ])),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(right: 4.0),
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      top: 0, left: 5),
                                                  child: days < 7
                                                      ? Text(
                                                          getTime(profileSubTabRepo
                                                              .userAll[index]
                                                              .createdAt),
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: HexColor(
                                                                  "#666666")))
                                                      : Text(
                                                          DateFormat('dd-MMM')
                                                              .format(
                                                                  profileSubTabRepo
                                                                      .userAll[
                                                                          index]
                                                                      .createdAt),
                                                          style: TextStyle(
                                                              fontSize: 9,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: HexColor("#666666"))),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 4.0),
                                          child: Visibility(
                                            visible: profileSubTabRepo
                                                    .userAll[index].caption !=
                                                null,
                                            child: Container(
                                              alignment: Alignment.topLeft,
                                              child: ReadMoreText(
                                                  profileSubTabRepo
                                                          .userAll[index]
                                                          .caption ??
                                                      '',
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      letterSpacing: 0.5,
                                                      color:
                                                          HexColor("#FFFFFF"))),
                                            ),
                                          ),
                                        ),
                                        profileSubTabRepo
                                                    .userAll[index].textFeed ==
                                                false
                                            ? Padding(
                                                padding:
                                                    EdgeInsets.only(left: 0),
                                                child:
                                                    profileSubTabRepo
                                                                    .userAll[
                                                                        index]
                                                                    .postPhoto
                                                                    .length >
                                                                0 &&
                                                            profileSubTabRepo
                                                                    .userAll[
                                                                        index]
                                                                    .textFeed ==
                                                                false
                                                        ? Container(
                                                            height: 200,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 10),
                                                            child: ClipRRect(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20)),
                                                                child: imageFileTypes.indexOf(profileSubTabRepo
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
                                                                                  filePaths: profileSubTabRepo.userAll[index].postPhoto[0].location,
                                                                                  subCategoryProfileData: profileSubTabRepo.userAll[index],
                                                                                ),
                                                                              ));
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              450,
                                                                          width:
                                                                              320,
                                                                          color:
                                                                              Colors.grey[900],
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
                                                                                CachedNetworkImage(fit: BoxFit.cover, imageUrl: getImageUrl(profileSubTabRepo.userAll[index].postPhoto[0].location)),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : Stack(
                                                                        children: [
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlayerNew(filePaths: profileSubTabRepo.userAll[index].postPhoto[0].location)));
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
                                                                                    child: CachedNetworkImage(fit: BoxFit.cover, imageUrl: getImageUrl(profileSubTabRepo.userAll[index].postPhoto[0].thumbnailUrl)),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ),
                                                                          ),
                                                                          Positioned(
                                                                              top: 80,
                                                                              left: 135,
                                                                              child: GestureDetector(
                                                                                onTap: () {},
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
                                                                      )),
                                                          )
                                                        : Container(),
                                              )
                                            : Container(),

                                        profileSubTabRepo.userAll[index].repeat
                                            .name !=
                                            null

                                            ? GestureDetector(
                                            onTap: () {
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             RepeatPostFullView(
                                              //               id: userProfileAllRepo
                                              //                   .userAll[
                                              //               index]
                                              //                   .repeat
                                              //                   .repeatingId,
                                              //             )));
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(left: 0, right: 20.0, top: 3.0, bottom: 3.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Color(0XFFDADADA)),
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(
                                                          10.0)),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      EdgeInsets.all(0.0),
                                                      child:
                                                      Row(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets.only(top: 4.0, left: 8, right: 8, bottom: 4),
                                                            child:
                                                            ClipRRect(
                                                              borderRadius: BorderRadius.all(Radius.circular(25)),
                                                              child: profileSubTabRepo.userAll[index].repeat.profilePic == null
                                                                  ? Container(
                                                                width: 45.0,
                                                                height: 45.0,
                                                                decoration: BoxDecoration(
                                                                  image: DecorationImage(
                                                                    fit: BoxFit.cover,
                                                                    image: NetworkImage("https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"),
                                                                  ),
                                                                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                  color: Colors.redAccent,
                                                                ),
                                                              )
                                                                  : CachedNetworkImage(fit: BoxFit.fill,
                                                                  height: 45, width: 45,
                                                                  imageUrl: getImageUrl(profileSubTabRepo.userAll[index].repeat.profilePic)),
                                                            ),
                                                          ),
                                                         Expanded(
                                                             child: Column(
                                                               mainAxisAlignment: MainAxisAlignment.start,
                                                               children: [
                                                                 Padding(
                                                                     padding: EdgeInsets.only(top: 0),
                                                                   child: Row(
                                                                     children: [
                                                                       Padding(
                                                                         padding:
                                                                         EdgeInsets.only(left: 2, top: 4),
                                                                         child: profileSubTabRepo.userAll[index].repeat.userName != "" &&
                                                                             profileSubTabRepo.userAll[index].repeat.userName != null
                                                                             ? Text(Utils.getCapitalizeName('${profileSubTabRepo.userAll[index].repeat.name}'),
                                                                             // '${feedProviderRepo.feedList[index].repeat.name}',
                                                                             style: GoogleFonts.montserrat(
                                                                                 fontSize: 18,
                                                                                 letterSpacing: 0.5,
                                                                                 fontWeight: FontWeight.bold,
                                                                                 color: HexColor("#666666")))
                                                                             : Text(" "),
                                                                       ),
                                                                       SizedBox(
                                                                         width:
                                                                         5.0,
                                                                       ),
                                                                       Padding(
                                                                         padding:
                                                                         EdgeInsets.only(left: 0, top: 4),
                                                                         child:
                                                                         Container(
                                                                           child: profileSubTabRepo.userAll[index].repeat.userName != "" &&
                                                                               profileSubTabRepo.userAll[index].repeat.userName != null ?
                                                                           Text('@${profileSubTabRepo.userAll[index].repeat.userName}',
                                                                               style: GoogleFonts.montserrat(fontSize: 13,
                                                                                   fontWeight: FontWeight.normal,
                                                                                   letterSpacing: 0.5,
                                                                                   color: HexColor("#666666"))) : Text(" "),
                                                                         ),
                                                                       ),
                                                                       Spacer(),
                                                                     ],
                                                                   ),
                                                                 ),
                                                                 profileSubTabRepo.userAll[index].repeat.message !=
                                                                     null
                                                                     ? Padding(
                                                                   padding:
                                                                   EdgeInsets.only(right: 10,
                                                                     // bottom: 1

                                                                   ),
                                                                   child:
                                                                   Container(
                                                                     alignment: Alignment.topLeft,
                                                                     child: ReadMoreText(profileSubTabRepo.userAll[index].repeat.message ?? '',
                                                                         style: GoogleFonts.montserrat(fontSize: 14,
                                                                             fontWeight: FontWeight.normal,
                                                                             color: HexColor("#FFFFFF"),
                                                                             letterSpacing: 0.5)),
                                                                   ),
                                                                 )
                                                                     : Container(),
                                                               ],
                                                             )
                                                         )
                                                        ],
                                                      ),
                                                    ),

                                                    profileSubTabRepo.userAll[index].repeat.textFeed ==
                                                        false
                                                        ?
                                                    profileSubTabRepo.userAll[index].repeat.post !=
                                                        null
                                                        ?

                                                    Container(
                                                        height: 200,
                                                        margin: EdgeInsets.only(top: 0),
                                                        child: ClipRRect(
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(20)),
                                                            child:
                                                            imageFileTypes.indexOf(profileSubTabRepo.userAll[index].repeat.post
                                                                .split('.').last) != -1
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
                                                                EdgeInsets.only(top: 10),
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
                                                                              filePaths: profileSubTabRepo.userAll[index].repeat.post,
                                                                              // postData: userProfileAllRepo.userAll[index],
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                      child: CachedNetworkImage(fit: BoxFit.cover,
                                                                          imageUrl: getImageUrl(profileSubTabRepo.userAll[index].repeat.post)),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                                : Stack(
                                                              children: [
                                                                GestureDetector(
                                                                  // onTap: () {
                                                                  //   Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlayerNew(filePaths: feedProviderRepo.feedList[index].postPhoto[0].location)));
                                                                  // },
                                                                  child: Padding(
                                                                    padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 10),
                                                                    child: LayoutBuilder(
                                                                      builder: (BuildContext context, BoxConstraints constraints) {
                                                                        return Container(
                                                                          height:
                                                                          200,
                                                                          child: ClipRRect(
                                                                            borderRadius: BorderRadius.all(Radius.circular(12)),
                                                                            child: OverflowBox(
                                                                              minWidth: 320,
                                                                              minHeight: 200,
                                                                              maxHeight: 400,
                                                                              maxWidth: 320,
                                                                              child: CachedNetworkImage(fit: BoxFit.cover,
                                                                                  imageUrl: getImageUrl(profileSubTabRepo.userAll[index].repeat.thumbnailUrl)),
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
                                                                      // onTap: () {
                                                                      //   Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlayerNew(filePaths: feedProviderRepo.feedList[index].postPhoto[0].location)));
                                                                      // },
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
                                                        : Container(),
                                                  ],
                                                ),
                                              ),
                                            )
                                        )
                                            : Container(),



                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 0,
                                              right: 0.0,
                                              top: 8.0,
                                              bottom: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
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
                                              GestureDetector(
                                                  onTap: () async {
                                                    // print('printinggg');
                                                    // print(userId);
                                                    // print( userProfileAllRepo
                                                    //     .likeCollection);
                                                    profileSubTabRepo
                                                        .likeOrDislikeAllTabFarm(
                                                            context,
                                                            profileSubTabRepo
                                                                .userAll[index]
                                                                .id,
                                                            profileSubTabRepo
                                                                .likeCollection);

                                                    // await   feedProviderRepo
                                                    //        .getFeedUserInfo(
                                                    //        feedProviderRepo.commentList[index].id);
                                                    // await userProfileAllRepo
                                                    //     .userProfileAll(
                                                    //   userProfileAllRepo.userAll[index].id);
                                                  },
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        profileSubTabRepo.userAll[index].like
                                                                    .contains(
                                                                        userId) ==
                                                                true
                                                            ? Icon(
                                                                Icons.favorite,
                                                                color:
                                                                    Colors.red)
                                                            : Icon(
                                                                Icons.favorite,
                                                                color: Colors
                                                                    .grey),
                                                        Text(
                                                          "${profileSubTabRepo.userAll[index].like.length}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 15),
                                                        ),
                                                      ])),
                                              _getCommentWidget(
                                                  // profileSubTabRepo.userAll[index].like.contains(
                                                  //     dashBoardProviderRepo.userId)
                                                  //     ? commentIcon
                                                  //     : commentIcon,
                                                  // commentIcon,
                                                  profileSubTabRepo
                                                              .userAll[index]
                                                              .commentCheck
                                                              .contains(
                                                                  userId) ==
                                                          true
                                                      ? commentRed
                                                      : commentIcon,
                                                  profileSubTabRepo
                                                      .userAll[index]
                                                      .commentCount,
                                                  1,
                                                  profileSubTabRepo
                                                      .userAll[index],
                                                  profileSubTabRepo,
                                                  dashBoardProviderRepo,
                                                  profileSubTabRepo
                                                      .userAll[index]
                                                      .profilePic,
                                                  profileSubTabRepo.profileCategoryIdnId
                                              ),
                                              _getCommentWidget(
                                                  profileSubTabRepo
                                                              .userAll[index]
                                                              .repost
                                                              .contains(
                                                                  userId) ==
                                                          true
                                                      ? repostColor
                                                      : repostNewImage,
                                                  profileSubTabRepo
                                                      .userAll[index]
                                                      .repost
                                                      .length,
                                                  2,
                                                  profileSubTabRepo
                                                      .userAll[index],
                                                  profileSubTabRepo,
                                                  dashBoardProviderRepo,
                                                  profileSubTabRepo
                                                      .userAll[index]
                                                      .profilePic,
                                                  profileSubTabRepo.profileCategoryIdnId
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
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
                                        id: profileSubTabRepo.userAll[index].id,
                                        fullSubPostProfileAll:
                                            profileSubTabRepo.userAll[index],
                                      )));
                        },
                      );
                      ;
                      ;
                    },
                    childCount: profileSubTabRepo.userAll.length,
                  ),
                ),
              ),
            ],
          );
        },
      );
    });
  }

  _getCommentWidget(iconData, text1, i, Datums postDetails, profileSubTabRepo,
      dashBoardProviderRepo, userReplyProfile, profileCategoryIdnId) {
    return GestureDetector(
      onTap: () => {
        _handleOnTap(i, postDetails, profileSubTabRepo, dashBoardProviderRepo,
            userReplyProfile, profileCategoryIdnId)
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

  _handleOnTap(int i, Datums postDetails, profileSubTabRepo,
      dashBoardProviderRepo, userReplyProfile, profileCategoryIdnId) {
    if (i == 0) {
      setState(() {
        if (favorite == true) {
          favorite = false;
        } else {
          favorite = true;
        }
      });

      profileSubTabRepo.likeOrDislikeSubCategoryIndividual(
          context, postDetails.id, postDetails.like);
    } else if (i == 1) {
      print("${postDetails.postPhoto}");
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CommentForPost(
                subCateFarm: widget.profileId,
                postId: postDetails.id,
                post: postDetails.userName,
                profilePicUser: userReplyProfile,
                postSecondaryName: postDetails.name,
                adminPicUser: dashBoardProviderRepo.userProfilePic,
             profileSubTabId : widget.userId,
            )),
      );
    } else {
      _modalBottomSheetMenu(i, postDetails);
    }
  }

  void _modalBottomSheetMenu(int i, Datums postDetails) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        context: context,
        builder: (builder) {
          return SingleChildScrollView(child: Consumer(
            builder: (context, watch, child) {
              final repostProvider = watch(feedProvider);
              final profileSubTabRepo = watch(profileSubTabProvider);
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
                                    Future.delayed(Duration(seconds: 2),
                                        () async {
                                      await profileSubTabRepo
                                          .profileSubCategoryIndividual(widget.userId,
                                              profileSubTabRepo
                                                  .profileCategoryIdnId);
                                    });
                                    // await profileSubTabRepo.profileSubCategoryIndividual(profileSubTabRepo.profileCategoryIdnId);
                                    await profileSubTabRepo
                                        .getProfileSubTabDetails();
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
                                Padding(padding: EdgeInsets.only(right: 15)),
                                GestureDetector(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RepeatCommentPost(
                                                  postProfileSubcategory:
                                                      postDetails,
                                                  adminPicUser:
                                                      dashBoardProviderRepo
                                                          .userProfilePic)),
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
                  ]));
            },
          ));
        });
  }
}
