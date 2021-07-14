import 'package:async_loader/async_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/dashboard/dashboard.dart';
import 'package:farm_system/dashboard/repo/dash_board_repo.dart';
import 'package:farm_system/feature/edit_setup/view/edit_profile.dart';
import 'package:farm_system/feature/follower_following/followPage.dart';
import 'package:farm_system/feature/follower_following/follow_followingrepo/buttonrepo.dart';
import 'package:farm_system/feature/message/view/message.dart';
import 'package:farm_system/feature/profile_user/repo/profileRepo.dart';
import 'package:farm_system/feature/profile_user/view/profile_tabs/farmpost/view/profileInfoShimmer.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/screen/Discovery/all_element.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:basic_utils/basic_utils.dart';

import '../../../utils.dart';

class ProfileInfo extends StatefulWidget {
  final String userId;

  const ProfileInfo({Key key, this.userId}) : super(key: key);

  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo>
    with TickerProviderStateMixin {
  final _asyncKey = GlobalKey<AsyncLoaderState>();
  final int _startingTabCount = 4;
  List<Tab> _tabs = List<Tab>();
  List<Widget> _generalWidgets = List<Widget>();
  TabController _tabController;
  TabController _tabController2;
  bool follow = false;

  var userId;

  @override
  void initState() {
    print('sagarnayakuserID');
    print(widget.userId);
    _tabController = TabController(length: 4, vsync: this);
    _tabController2 = TabController(length: 5, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      userId = await StorageService.getUserId();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final dashBoardProviderRepo = watch(dashboardProvider);
      final profileRepo = watch(profileProvider);
      return Scaffold(
        backgroundColor: Colors.black,
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   leading: GestureDetector(
        //     onTap: () {
        //       dashBoardProviderRepo.userId == profileRepo.userProfileDeatils.id
        //           ? navigationToScreen(context, DashBoard(), false)
        //           : navigationToScreen(context, DashBoard(), false);
        //     },
        //     child: Icon(
        //       Icons.arrow_back,
        //       color: Colors.white,
        //     ),
        //   ),
        //   title: Text(
        //     '',
        //     style: TextStyle(
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
        body: Stack(
          children: <Widget>[
            Center(
              child: Consumer(builder: (context, watch, child) {
                final profileProviderRepo = watch(profileProvider);
                return AsyncLoader(
                  key: _asyncKey,
                  initState: () async => await profileProviderRepo
                      .getUserProfileInfo(widget.userId),
                  renderLoad: () => ProfileInfoShimmer(),
                  renderError: ([err]) => Text('There was a error'),
                  renderSuccess: ({data}) => _generateUI(),
                );
              }),
            ),
          ],
        ),
      );
    });
  }

  Consumer _generateUI() {
    return Consumer(builder: (context, watch, child) {
      final dashBoardProviderRepo = watch(dashboardProvider);
      final profileRepo = watch(profileProvider);

      return profileRepo.userProfileDeatils.id != null
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    overflow: Overflow.visible,
                    alignment: Alignment.bottomLeft,
                    children: <Widget>[
                      profileRepo.userProfileDeatils.profilePic.length > 1
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 5,
                              child: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl: profileRepo.userProfileDeatils
                                      .profilePic[1].location),
                            )
                          : Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              width: 400,
                              height: 150,
                              decoration: BoxDecoration(),
                              child: SvgPicture.asset(
                                logo_text_left,
                                fit: BoxFit.cover,
                              ),
                            ),
                      Positioned(
                          top: MediaQuery.of(context).size.height / 7.5,
                          left: 10,
                          child: profileRepo
                                      .userProfileDeatils.profilePic.length >
                                  1
                              ? Container(
                                  width: 86.0,
                                  height: 86.0,
                                  decoration: new BoxDecoration(
                                    color: const Color(0xff7c94b6),
                                    image: new DecorationImage(
                                      image: NetworkImage(profileRepo
                                          .userProfileDeatils
                                          .profilePic[0]
                                          .location),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: new BorderRadius.all(
                                        new Radius.circular(50.0)),
                                    border: new Border.all(
                                      color: Colors.white,
                                      width: 4.0,
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 86.0,
                                  height: 86.0,
                                  decoration: new BoxDecoration(
                                    color: const Color(0xff7c94b6),
                                    image: new DecorationImage(
                                      image: NetworkImage(
                                          dashBoardProviderRepo.userProfilePic),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: new BorderRadius.all(
                                        new Radius.circular(50.0)),
                                    border: new Border.all(
                                      color: Colors.white,
                                      width: 4.0,
                                    ),
                                  ),
                                )),
                      Positioned(
                          top: 15,
                          left: 10,
                          child: GestureDetector(
                            onTap: (){
                              dashBoardProviderRepo.userId == profileRepo.userProfileDeatils.id
                                  ? navigationToScreen(context, DashBoard(), false)
                                  : navigationToScreen(context, DashBoard(), false);
                            },
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.grey,
                              child: Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: IconButton(
                                  icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
                                ),
                              ),
                            ),
                          )
                        ),
                    ],
                  ),
                  dashBoardProviderRepo.userId ==
                          profileRepo.userProfileDeatils.id
                      ? Container(
                          padding: EdgeInsets.only(left: 230, top: 4),
                          child: RaisedButton(
                              color: Colors.black,
                              child: Text(
                                "Edit Profile",
                                style:
                                    GoogleFonts.montserrat(color: Colors.red),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditProfile(
                                            userId: widget.userId)));
                              },
                              shape: RoundedRectangleBorder(
                                  side:
                                      BorderSide(width: 1.0, color: Colors.red),
                                  borderRadius:
                                      new BorderRadius.circular(30.0))),
                        )
                      : Row(
                          children: [
                            Container(
                                padding: EdgeInsets.only(
                                    left: 200, top: 5, right: 10),
                                child: GestureDetector(
                                  child: IconButton(
                                    icon: SvgPicture.asset(
                                      discoverEdit,
                                      fit: BoxFit.none,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MessageListing(
                                                    userId: profileRepo
                                                        .userProfileDeatils.id,
                                                    conversationId: "",
                                                    userName: profileRepo
                                                        .userProfileDeatils
                                                        .userName,
                                                  )));
                                    },
                                  ),
                                )),
                            profileRepo.isFollowing
                                ? Container(
                                    child: RaisedButton(
                                        color: Colors.black,
                                        child: Text(
                                          "Following",
                                          style: GoogleFonts.montserrat(
                                              color: Colors.red),
                                        ),
                                        onPressed: () async {
                                          await profileRepo.followOrUnfollow(
                                              profileRepo.userProfileDeatils.id,
                                              true);
                                        },
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 1.0, color: Colors.red),
                                            borderRadius:
                                                new BorderRadius.circular(
                                                    30.0))),
                                  )
                                : Container(
                                    child: RaisedButton(
                                        color: Colors.black,
                                        child: Text(
                                          "Follow",
                                          style: GoogleFonts.montserrat(
                                              color: Colors.red),
                                        ),
                                        onPressed: () async {
                                          await profileRepo.followOrUnfollow(
                                              profileRepo.userProfileDeatils.id,
                                              false);
                                        },
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 1.0, color: Colors.red),
                                            borderRadius:
                                                new BorderRadius.circular(
                                                    30.0))),
                                  )
                          ],
                        ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        profileRepo.userProfileDeatils.name != null
                            ?
                        Text(
                            Utils.getCapitalizeName(
                                '${profileRepo.userProfileDeatils.name}'),
                            // '${feedProviderRepo.feedList[index].repeat.name}',
                            style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight:
                                FontWeight
                                    .bold,
                                    color: HexColor("#D41B47"),


                                    ))



                            : Text(''),
                        SizedBox(
                          height: 5,
                        ),
                        Text('@${profileRepo.userProfileDeatils.userName}',
                            style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Color(0xff666666))),
                        SizedBox(height: 10),
                        profileRepo.userProfileDeatils.bio != null
                            ? Text(
                                profileRepo.userProfileDeatils.bio,
                                style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                              )
                            : Text(''),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: <Widget>[
                            profileRepo.userProfileDeatils.city != null
                                ? Visibility(
                                    visible:
                                        profileRepo.userProfileDeatils.city !=
                                            null,
                                    // && profileRepo.userProfileDeatils.state != null,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: Icon(
                                            Icons.location_on_outlined,
                                            color: Colors.red,
                                            size: 14,
                                          ),
                                        ),
                                        Text(
                                            '${profileRepo.userProfileDeatils.city}  ${profileRepo.userProfileDeatils.state ?? ''}',
                                            style: GoogleFonts.montserrat(
                                                color: Colors.grey,
                                                fontSize: 14)),
                                      ],
                                    ),
                                  )
                                : Container(),
                            profileRepo.userProfileDeatils.website != null
                                ? Visibility(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(right: 1, left: 10),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.attachment,
                                            color: Colors.red,
                                            size: 16,
                                          ),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                              profileRepo
                                                  .userProfileDeatils.website,
                                              style: GoogleFonts.montserrat(
                                                  color: Colors.grey,
                                                  fontSize: 14)),
                                        ],
                                      ),
                                    ),
                                    visible: profileRepo
                                            .userProfileDeatils.website !=
                                        null)
                                : Container(),
                            SizedBox(
                              width: 13,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 2, left: 1),
                                  child: Icon(
                                    Icons.calendar_today_outlined,
                                    color: Colors.red,
                                    size: 14,
                                  ),
                                ),
                                Text(profileRepo.userProfileDeatils.birthDate,
                                    style: GoogleFonts.montserrat(
                                        color: Colors.grey, fontSize: 14)),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            InkWell(
                                child: Text(
                                    profileRepo
                                        .userProfileDeatils.following.length
                                        .toString(),
                                    style: GoogleFonts.montserrat(
                                        color: Colors.red, fontSize: 14)),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FollowFollowingTab()),
                                  );
                                }),
                            SizedBox(
                              width: 5,
                            ),
                            InkWell(
                                child: Text("Following",
                                    style: GoogleFonts.montserrat(
                                        color: Colors.grey, fontSize: 14)),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FollowFollowingTab()),
                                  );
                                }),
                            SizedBox(
                              width: 20,
                            ),
                            InkWell(
                                child: Text(
                                    profileRepo
                                        .userProfileDeatils.followers.length
                                        .toString(),
                                    style: GoogleFonts.montserrat(
                                        color: Colors.red, fontSize: 14)),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FollowFollowingTab()),
                                  );
                                }),
                            SizedBox(
                              width: 5,
                            ),
                            InkWell(
                                child: Text("Followers",
                                    style: GoogleFonts.montserrat(
                                        color: Colors.grey, fontSize: 14)),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FollowFollowingTab()),
                                  );
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Container(child: ProfileInfoShimmer());
    });
  }
}
