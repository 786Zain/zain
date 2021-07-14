import 'dart:async';

import 'package:async_loader/async_loader.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/dashboard/drawerPage.dart';
import 'package:farm_system/feature/feed/view/readmoretext.dart';
import 'package:farm_system/feature/follower_following/follow_followingrepo/buttonrepo.dart';
import 'package:farm_system/feature/message/view/message.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class UsersList extends StatefulWidget {
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList>
    with SingleTickerProviderStateMixin {
  final _asyncfollowerKey = GlobalKey<AsyncLoaderState>();
  final _asyncfollowingKey = GlobalKey<AsyncLoaderState>();

  int index = 0;
  var page = 1;
  AnimationController _con;
  Timer _debounce;
  TextEditingController _textEditingController;
  bool drawer = false;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  int toggle = 0;
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _con = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 375),
    );
  }

  var focusNode = FocusNode();

  TabBar get _tabBar => TabBar(
        tabs: [
          Tab(icon: Icon(Icons.call)),
          Tab(icon: Icon(Icons.message)),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: Colors.red,
            drawer: (toggle == 0)
                ? Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: DrawerPage(),
                  )
                : Container(),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(120.0),
              child: AppBar(
                leading: (_textEditingController.text != "")
                    ? Consumer(builder: (context, watch, child) {
                        final messageProviders = watch(messageProvider);
                        return IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios_sharp,
                              size: 15.5,
                            ),
                            padding: EdgeInsets.only(top: 15),
                            onPressed: () {
                              setState(() {
                                messageProviders.getFollows(
                                    true, false, _textEditingController.text);
                                messageProviders.getFollows(
                                    false, true, _textEditingController.text);
                                _textEditingController.clear();
                              });
                            });
                      })
                    : IconButton(
                        icon: Icon(Icons.arrow_back_ios_sharp),
                        iconSize: 25,
                        padding: EdgeInsets.only(top: 15),
                        color: Color.fromRGBO(218, 218, 218, 1),
                        onPressed: () {
                          setState(() {
                            toggle = 0;
                            Navigator.pop(context);
                          });
                        }),
                backgroundColor:
                    toggle == 0 ? Colors.black : Color.fromRGBO(34, 34, 34, 1),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(50.0),
                  child: ColoredBox(
                      color: Colors.black,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: TabBar(
                          labelPadding: EdgeInsets.only(left: 40, right: 40),
                          indicatorColor: Color.fromRGBO(212, 27, 71, 1),
                          isScrollable: true,
                          unselectedLabelColor: Colors.grey,
                          labelColor: Color.fromRGBO(212, 27, 71, 1),
                          indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(
                                  width: 4,
                                  color: Color.fromRGBO(212, 27, 71, 1)),
                              insets: EdgeInsets.only(left: 110, right: 110)),
                          tabs: [
                            Tab(
                              iconMargin: EdgeInsets.only(top:0,bottom:0),
                              child: Text("FOLLOWERS",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 2,
                                    height: 2
                                  )),
                            ),
                            Tab(
                              iconMargin: EdgeInsets.only(top:0,bottom:0),
                              child: Text("FOLLOWING",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 2,
                                    height: 2
                                  )),
                            ),
                          ],
                        ),
                      )),
                ),
                title: Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Container(
                      height: 99,
                      child: SvgPicture.asset(newLogoFarm,
                          height: 120, width: 120, fit: BoxFit.scaleDown)),
                ),
                centerTitle: true,
                actions: <Widget>[
                  Center(
                    child: Container(
                      height: 40,
                      padding: EdgeInsets.only(left: 0.0, right: 20),
                      margin: EdgeInsets.only(top: 15),
                      alignment: Alignment(1.0, -1.0),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 375),
                        height: 80.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: toggle == 0
                              ? Color.fromRGBO(0,0,0,0.0)
                              : Color.fromRGBO(158, 158, 158, 0.1),
                        ),
                        width: (toggle == 0)
                            ? 50.0
                            : MediaQuery.of(context).size.width * 0.8,
                        curve: Curves.easeOut,
                        child: Stack(
                          children: [
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 375),
                              right: 0.0,
                              curve: Curves.easeOut,
                              child: AnimatedOpacity(
                                opacity: (toggle == 0) ? 0.0 : 1.0,
                                duration: Duration(milliseconds: 200),
                              ),
                            ),
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 375),
                              left: (toggle == 0) ? 20.0 : 40.0,
                              curve: Curves.easeOut,
                              child: AnimatedOpacity(
                                opacity: (toggle == 0) ? 0.0 : 1.0,
                                duration: Duration(milliseconds: 200),
                                child: Container(
                                    height: 29.0,
                                    width: 180.0,
                                    child: Consumer(
                                        builder: (context, watch, child) {
                                      final messageProviders =
                                          watch(messageProvider);
                                      return TextField(
                                          onChanged: (T) {
                                            if (_debounce?.isActive ?? false)
                                              _debounce.cancel();
                                            _debounce = Timer(
                                                const Duration(
                                                    milliseconds: 800), () {
                                              setState(() {
                                                messageProviders.getFollows(
                                                    true,
                                                    false,
                                                    _textEditingController
                                                        .text);
                                                messageProviders.getFollows(
                                                    false,
                                                    true,
                                                    _textEditingController
                                                        .text);
                                              });
                                            });
                                          },
                                          focusNode: focusNode,
                                          controller: _textEditingController,
                                          cursorRadius: Radius.circular(10.0),
                                          cursorColor: Colors.black,
                                          style: TextStyle(
                                              fontSize: 12,
                                              letterSpacing: 2,
                                              height: 1,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                          decoration: InputDecoration(
                                            alignLabelWithHint: true,
                                            border: InputBorder.none,
                                            hintText: 'Search the Farm',
                                            contentPadding: EdgeInsets.only(
                                                top: -5, left: 10),
                                            hintStyle: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              letterSpacing: 2,
                                            ),
                                          ));
                                    })),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 10, top: 0),
                              decoration: BoxDecoration(
                                color: toggle == 0
                                    ? Color.fromRGBO(0,0,0,0.0)
                                    : Color.fromRGBO(158, 158, 158, 0.0),
//                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: IconButton(
                                padding: (toggle == 0)
                                    ? EdgeInsets.only(top: 0, left: 15)
                                    : EdgeInsets.only(top: 0, left: 0),
                                iconSize: 32,
                                icon: Icon(
                                  Icons.search,
                                  color: Color.fromRGBO(136, 136, 136, 1),
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (toggle == 0) {
                                      toggle = 1;
                                      _con.forward();
                                      FocusScope.of(context)
                                          .requestFocus(focusNode);
                                    } else {
                                      toggle = 0;
                                      _textEditingController.clear();
                                      _con.reverse();
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            body: TabBarView(
              children: [
                Container(
                    child: ColoredBox(
                      color: Colors.black,
                      child: Column(
                        children: [
                          Flexible(child: getfollersWidget(context)),
                        ],
                      ),
                    )),
                Container(
                    child: ColoredBox(
                      color: Colors.black,
                      child: Column(
                        children: [
                          Flexible(child: getfollowingWidget(context))
                        ],
                      ),
                    )),
              ],
            )));
  }

  Widget getfollersWidget(context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      color: Colors.black,
      padding: EdgeInsets.only(bottom: 20),
      child: Consumer(builder: (context, watch, child) {
        final messageProviders = watch(messageProvider);
        return AsyncLoader(
          key: _asyncfollowerKey,
          initState: () => messageProviders.getFollows(
              true, false, _textEditingController.text),
          renderLoad: () => CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              strokeWidth: 3.0),
          renderError: ([err]) => Text('There was a error'),
          renderSuccess: ({data}) => _generateFollowerUI(context),
        );
      }),
    );
  }

  _generateFollowerUI(context) {
    return Consumer(builder: (context, watch, child) {
      final messageProviders = watch(messageProvider);

      return messageProviders.followerList.length > 0
          ? ListView.builder(
              itemCount: messageProviders.followerList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MessageListing(
                                    userId:
                                        messageProviders.followerList[index].id,
                                    conversationId: "",
                                    userName: messageProviders
                                        .followerList[index].name,
                                    fromUsers: true,
                                  )));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 15, top: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Padding(
                                    padding: EdgeInsets.only(top: 10.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 20, right: 5),
                                            child: Container(
                                              height: 46.0,
                                              width: 46.0,
                                              child: CircleAvatar(
                                                radius: 26.0,
                                                backgroundImage: NetworkImage(
                                                    getImageUrl(messageProviders
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
                                                  child: messageProviders
                                                          .followerList[index]
                                                          .name
                                                          .isNotEmpty
                                                      ? Text(
                                                          messageProviders
                                                              .followerList[
                                                                  index]
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
                                                                  color: Color(0xffFFFFFF),
                                                                  height: 1))
                                                      : Text(""),
                                                ),
                                              ),
                                              Container(
                                                child: Padding(
                                                  padding: EdgeInsets.only(top:2,
                                                      bottom: 2),
                                                  child: messageProviders
                                                          .followerList[index]
                                                          .userName
                                                          .isNotEmpty
                                                      ? Text(
                                                          '@' +
                                                              messageProviders
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
                                                  child: messageProviders
                                                                  .followerList[
                                                                      index]
                                                                  .bio !=
                                                              null &&
                                                          messageProviders
                                                              .followerList[
                                                                  index]
                                                              .bio
                                                              .isNotEmpty
                                                      ? ReadMoreText(
                                                          messageProviders
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
                              messageProviders
                                          .followerList[index].isFollowing ==
                                      true
                                  ? followingButton(
                                      messageProviders.followerList[index].id)
                                  : followerButton(
                                      messageProviders.followerList[index].id)
                            ],
                          ),
                        ),
                      ],
                    ));
              },
            )
          : Container(
              child: Text(
                "No Followers Users",
                style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    height: 1),
                textAlign: TextAlign.center,
              ),
            );
    });
  }

  Widget getfollowingWidget(context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      color: Colors.black,
      child: Consumer(builder: (context, watch, child) {
        final messageProviders = watch(messageProvider);
        return AsyncLoader(
          key: _asyncfollowingKey,
          initState: () => messageProviders.getFollows(
              false, true, _textEditingController.text),
          renderLoad: () => CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              strokeWidth: 3.0),
          renderError: ([err]) => Text('There was a error'),
          renderSuccess: ({data}) => _generateFollowingUI(context),
        );
      }),
    );
  }

  _generateFollowingUI(context) {
    return Consumer(builder: (context, watch, child) {
      final messageProviders = watch(messageProvider);

      return messageProviders.followingList.length > 0
          ? ListView.builder(
              itemCount: messageProviders.followingList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MessageListing(
                                    userId: messageProviders
                                        .followingList[index].id,
                                    conversationId: "",
                                    userName: messageProviders
                                        .followingList[index].name,
                                  )));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 15, top: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                    padding: EdgeInsets.only(top: 10.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 20, right: 5),
                                            child: Container(
                                              height: 46.0,
                                              width: 46.0,
                                              child: CircleAvatar(
                                                radius: 26.0,
                                                backgroundImage: NetworkImage(
                                                    getImageUrl(messageProviders
                                                            .followingList[
                                                                index]
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
                                                  child: messageProviders
                                                          .followingList[index]
                                                          .name
                                                          .isNotEmpty
                                                      ? Text(
                                                          messageProviders
                                                              .followingList[
                                                                  index]
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
                                                  padding: EdgeInsets.only(top:2,
                                                      bottom: 2),
                                                  child: messageProviders
                                                          .followingList[index]
                                                          .userName
                                                          .isNotEmpty
                                                      ? Text(
                                                          '@' +
                                                              messageProviders
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
                                                  child: messageProviders
                                                                  .followingList[
                                                                      index]
                                                                  .bio !=
                                                              null &&
                                                          messageProviders
                                                              .followingList[
                                                                  index]
                                                              .bio
                                                              .isNotEmpty
                                                      ? ReadMoreText(
                                                          messageProviders
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
                              messageProviders
                                          .followingList[index].isFollowing ==
                                      true
                                  ? followingButton(
                                      messageProviders.followingList[index].id)
                                  : followerButton(
                                      messageProviders.followingList[index].id)
                            ],
                          ),
                        ),
                      ],
                    ));
              },
            )
          : Container(
              child: Text(
                "No Following Users",
                style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    height: 1),
                textAlign: TextAlign.center,
              ),
            );
    });
  }

  Widget followerButton(id) {
    return Consumer(builder: (context, watch, child) {
      final _messageProvider = watch(messageProvider);
      final followsRepo = watch(profileFollow);
      return Container(
        margin: EdgeInsets.only(top: 15),
        width: 85,
        height: 28,
        child: RaisedButton(
            color: Colors.black,
            child: Text("Follow",
                style: GoogleFonts.montserrat(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(212, 27, 71, 1),
                    height: 1)),
            // padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
            onPressed: () async {
              await FollowRepo.followOrUnfollow(id, true);
              setState(() async {
                await _messageProvider.getMyFollows(
                    false, true, _textEditingController.text);
              });
            },
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 2.0, color: Color.fromRGBO(212, 27, 71, 1)),
                borderRadius: new BorderRadius.circular(30.0))),
      );
    });
  }

  Widget followingButton(id) {
    return Consumer(builder: (context, watch, child) {
      final _messageProvider = watch(messageProvider);
      return Container(
        margin: EdgeInsets.only(top: 15),
        width: 85,
        height: 28,
        child: RaisedButton(
            color: Colors.red,
            child: Text(
              "Following",
              style: GoogleFonts.montserrat(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Color(0xffFFFFFF),
                  height: 1),
            ),
            // padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
            onPressed: () async {
              await FollowRepo.followOrUnfollow(id, true);
              setState(() async {
                await _messageProvider.getMyFollows(
                    false, true, _textEditingController.text);
              });
            },
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 2.0, color: Color.fromRGBO(212, 27, 71, 1)),
                borderRadius: new BorderRadius.circular(30.0))),
      );
    });
  }
}
