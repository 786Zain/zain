import 'dart:async';
import 'dart:ui';

import 'package:async_loader/async_loader.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/feature/feed/view/readmoretext.dart';
import 'package:farm_system/feature/follower_following/Following/views/following_list.dart';
import 'package:farm_system/feature/follower_following/follow_followingrepo/buttonrepo.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class FollowerList extends StatefulWidget {
  @override
  _FollowerListState createState() => _FollowerListState();
}

class _FollowerListState extends State<FollowerList> {

  final _asyncfollowerKey = GlobalKey<AsyncLoaderState>();

  bool follower = false;
  bool following = false;

  int index = 0;
  var page = 1;
  int toggle = 0;
  @override
  Widget build(BuildContext context) {
    return getfollersWidget(context);
  }

  Widget getfollersWidget(context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.only(bottom: 20),
      child: Consumer(builder: (context, watch, child) {
        final profileFollows = watch(profileFollow);
        return AsyncLoader(
          key: _asyncfollowerKey,
          initState: () => profileFollows.getFollows(true, false, ""),
          renderLoad: () =>SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(strokeWidth: 3),
          ),
          renderError: ([err]) => Text('There was a error'),
          renderSuccess: ({data}) => _generateFollowerUI(context),
        );
      }),
    );
  }

  _generateFollowerUI(context) {
    return Consumer(builder: (context, watch, child) {
      final profileFollows = watch(profileFollow);

      return profileFollows.followerList.length > 0
          ? ListView.builder(
              itemCount: profileFollows.followerList.length,
              itemBuilder: (BuildContext context, int index) {
                return
                    // InkWell(
                    //     onTap: (){
                    //   Navigator.push(context, MaterialPageRoute(builder: (context) => MessageListing(userId: messageProviders.followerList[index].id,conversationId: "",userName: messageProviders.followerList[index].name,fromUsers: true,)));
                    // },
                    Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Padding(
                                padding: EdgeInsets.only(bottom: 15.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding:
                                            EdgeInsets.only(left: 20, right: 5),
                                        child: Container(
                                          height: 46.0,
                                          width: 46.0,
                                          child: CircleAvatar(
                                            radius: 26.0,
                                            backgroundImage: NetworkImage(getImageUrl(
                                                    profileFollows
                                                        .followerList[index]
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
                                                      .followerList[index]
                                                      .name
                                                      .isNotEmpty
                                                  ? Text(
                                                      profileFollows
                                                          .followerList[index]
                                                          .name
                                                          .toUpperCase(),
                                                      overflow:
                                                          TextOverflow.fade,
                                                      softWrap: false,
                                                      style: GoogleFonts
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
                                                      .followerList[index]
                                                      .userName
                                                      .isNotEmpty
                                                  ? Text(
                                                      '@' +
                                                          profileFollows
                                                              .followerList[
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
                                                      .followerList[index]
                                                      .bio
                                                      .isNotEmpty
                                                  ? ReadMoreText(
                                                      profileFollows
                                                              .followerList[
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
                          profileFollows.followerList[index].isFollowing == true
                              ? followingButton(
                                  profileFollows.followerList[index].id)
                              : followerButton(
                                  profileFollows.followerList[index].id)
                        ],
                      ),
                    ),
                  ],
                );
              },
            )
          : Container(
              child: Text(
                "No Followers Users",
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
      margin: EdgeInsets.only(top: 10),
      width: 85,
      height: 28,
      child: RaisedButton(
          color: Colors.black,
          child: Text(
            "Follow",
            style:
            GoogleFonts.montserrat(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(212, 27, 71, 1),
                height: 1),
          ),
          // padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
          onPressed: () async {
            await FollowRepo.followOrUnfollow(id, false);
            _asyncfollowerKey.currentState.reloadState();
          },
          shape: RoundedRectangleBorder(
              side:
                  BorderSide(width: 2.0, color: Color.fromRGBO(212, 27, 71, 1)),
              borderRadius: new BorderRadius.circular(30.0))),
    );
  }

  Widget followingButton(String id) {
    return Consumer(
        builder: (context, watch, child)
    {
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
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
            // padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
            onPressed: () async {
              await FollowRepo.followOrUnfollow(id, true);
              var userId = await StorageService.getUserId();
              _asyncfollowerKey.currentState.reloadState();
              setState(()async {
                await profileRepo.getUserProfileInfo(userId);
                await followsRepo.getMyFollows(false, true, "");
              });

            },
            shape: RoundedRectangleBorder(
                side:
                BorderSide(width: 2.0, color: Color.fromRGBO(212, 27, 71, 1)),
                borderRadius: new BorderRadius.circular(30.0))),
      );
    });
  }
}
