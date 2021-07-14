import 'dart:async';

import 'package:async_loader/async_loader.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/feature/feed/view/readmoretext.dart';
import 'package:farm_system/feature/follower_following/follow_followingrepo/buttonrepo.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class FollowingList extends StatefulWidget {
  @override
  _FollowingListState createState() => _FollowingListState();
}

class _FollowingListState extends State<FollowingList> {
  // final _asyncfollowerKey = GlobalKey<AsyncLoaderState>();
  final _asyncfollowingKey = GlobalKey<AsyncLoaderState>();

  int index = 0;
  var page = 1;
  AnimationController _con;
  Timer _debounce;
  TextEditingController _textEditingController;
  bool drawer = false;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  int toggle = 0;

  // void initState() {
  //   super.initState();
  //   _textEditingController = TextEditingController();
  //   _con = AnimationController(
  //     vsync: this,
  //     duration: Duration(milliseconds: 375),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return getfollowingWidget(context);
  }

  Widget getfollowingWidget(context) {
    return Container(
      color: Colors.black,
      child: Consumer(builder: (context, watch, child) {
        final profileFollows = watch(profileFollow);
        return AsyncLoader(
          key: _asyncfollowingKey,
          initState: () => profileFollows.getFollows(false, true, ""),
          renderLoad: () =>
              SizedBox(
                  height: 30.0,
                  width: 30.0,
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.blue),
                      strokeWidth: 2.0)),
          renderError: ([err]) => Text('There was a error'),
          renderSuccess: ({data}) => _generateFollowingUI(context),
        );
      }),
    );
  }

  _generateFollowingUI(context) {
    return Consumer(builder: (context, watch, child) {
      final profileFollows = watch(profileFollow);
      return profileFollows.followingList.length > 0
          ? ListView.builder(
        itemCount: profileFollows.followingList.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 15,),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                          padding: EdgeInsets.only(bottom: 15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 5),
                                  child: Container(
                                    height: 46.0,
                                    width: 46.0,
                                    child: CircleAvatar(
                                      radius: 26.0,
                                      backgroundImage: NetworkImage(getImageUrl(
                                          profileFollows
                                              .followingList[index]
                                              .profilePic) ??
                                          "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"),
                                    ),
                                  )),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 8, bottom: 2),
                                        child: profileFollows
                                            .followingList[index]
                                            .name !=null
                                            ? Text(
                                            profileFollows
                                                .followingList[index]
                                                .name
                                                .toUpperCase(),
                                            overflow:
                                            TextOverflow.fade,
                                            softWrap: false,
                                            style:GoogleFonts
                                                .montserrat(
                                                fontSize: 12,
                                                fontWeight:
                                                FontWeight
                                                    .w600,
                                                letterSpacing:
                                                2,
                                                color: Colors
                                                    .white,
                                                height: 1))
                                            : Text(""),
                                      ),
                                    ),
                                    Container(
                                      child: Padding(
                                        padding:
                                        EdgeInsets.only(bottom: 2),
                                        child: profileFollows
                                            .followingList[index]
                                            .userName
                                            .isNotEmpty
                                            ? Text(
                                            '@' +
                                                profileFollows
                                                    .followingList[
                                                index]
                                                    .userName
                                                    .toLowerCase(),
                                            overflow:
                                            TextOverflow.fade,
                                            softWrap: false,
                                            style: GoogleFonts
                                                .montserrat(
                                                fontSize: 10,
                                                fontWeight:
                                                FontWeight
                                                    .normal,
                                                color: Colors
                                                    .white,
                                                height: 1))
                                            : Text(""),
                                      ),
                                    ),
                                    Container(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 8, bottom: 2),
                                        child: profileFollows
                                            .followingList[index]
                                            .bio != null &&
                                            profileFollows
                                                .followingList[index]
                                                .bio
                                                .isNotEmpty
                                            ? ReadMoreText(
                                            profileFollows
                                                .followingList[
                                            index]
                                                .bio ??
                                                '',
                                            style: GoogleFonts.montserrat(
                                                fontSize: 10,
                                                fontWeight:
                                                FontWeight
                                                    .normal,
                                                color:
                                                Colors.white,
                                                height: 1))
                                            : Text(""),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                    ),
                    profileFollows.followingList[index].isFollowing ==
                        true
                        ? followingButton(
                        profileFollows.followingList[index].id)
                        : followerButton(
                        profileFollows.followingList[index].id)
                  ],
                ),
              ),
            ],
          );
        },
      )
          : Container(
        child: Text(
          "No Following Users",
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      );
    });
  }

  Widget followerButton(String id) {
    return Container(
      width: 85,
      height: 28,
      padding: EdgeInsets.only(top: 10),
      child: RaisedButton(
          color: Colors.black,
          child: Text(
            "Follow",
            style:
            TextStyle(color: Color.fromRGBO(212, 27, 71, 1), fontSize: 10),
          ),
          // padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
          onPressed: () async {
            var btn = await FollowRepo.followOrUnfollow(id, false);
            _asyncfollowingKey.currentState.reloadState();
            print(btn);
          },
          shape: RoundedRectangleBorder(
              side:
              BorderSide(width: 2.0, color: Color.fromRGBO(212, 27, 71, 1)),
              borderRadius: new BorderRadius.circular(30.0))),
    );
  }


  Widget followingButton(String id) {
    return Consumer(
        builder: (context, watch, child) {
          final profileRepo = watch(profileProvider);
          final followsRepo = watch(profileFollow);
          return Container(
            margin: EdgeInsets.only(top: 10),
            width: 85,
            height: 28,
            child: RaisedButton(
                color: Color.fromRGBO(212, 27, 71, 1),
                child: Text(
                  "Following",
                  style: GoogleFonts.montserrat(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      height: 1),
                ),
                // padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
                onPressed: () async {
                  await FollowRepo.followOrUnfollow(id, true);
                  var userId = await StorageService.getUserId();
                  _asyncfollowingKey.currentState.reloadState();
                  setState(() async{
                    await profileRepo.getUserProfileInfo(userId);
                    await followsRepo.getMyFollows(false, true, "");
                  });

                },
                shape: RoundedRectangleBorder(
                    side:
                    BorderSide(
                        width: 2.0, color: Color.fromRGBO(212, 27, 71, 1)),
                    borderRadius: new BorderRadius.circular(30.0))),
          );
        });
  }
}



//   Widget followingButton(String id) {
//     return Container(
//       width: 85,
//       height: 28,
//       padding: EdgeInsets.only(top: 10),
//       child: RaisedButton(
//           color: Color.fromRGBO(212, 27, 71, 1),
//           child: Text(
//             "Following",
//             style: TextStyle(color: Colors.white, fontSize: 10),
//           ),
//           // padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
//           onPressed: () async {
//             await FollowRepo.followOrUnfollow(id, true);
//             _asyncfollowingKey.currentState.reloadState();
//           },
//           shape: RoundedRectangleBorder(
//               side:
//                   BorderSide(width: 2.0, color: Color.fromRGBO(212, 27, 71, 1)),
//               borderRadius: new BorderRadius.circular(30.0))),
//     );
//   }
// }
