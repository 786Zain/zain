import 'dart:async';

import 'package:async_loader/async_loader.dart';
import 'package:badges/badges.dart';
import 'package:farm_system/common/bottom_nav_bar.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/dashboard/drawerPage.dart';
import 'package:farm_system/feature/farm_plus_setup/view/farm_plus.dart';
import 'package:farm_system/feature/feed/view/feedLoaderShimmer.dart';
import 'package:farm_system/feature/feed/view/newFeedPage.dart';
import 'package:farm_system/feature/first_screen/view/first_screen.dart';
import 'package:farm_system/feature/message/view/conversations.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/routes/router.gr.dart';
import 'package:farm_system/screen/Discovery/all_element.dart';
import 'package:farm_system/screen/Discovery/discovery_seachlist.dart';
import 'package:farm_system/screen/Discovery/discovery_serach_bar.dart';
import 'package:farm_system/screen/fourth_screen.dart';
import 'package:farm_system/screen/Discovery/second_screen.dart';
import 'package:farm_system/screen/third_screen.dart';
import 'package:farm_system/services/push_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:farm_system/services/socket.dart';
import 'package:farm_system/feature/first_screen/repo/NotificationModel.dart';
import 'package:validators/validators.dart';

import '../navigator.dart';

class DashBoard extends StatefulWidget {
  final String value;
  final String password;
  final String userId;

  const DashBoard({
    Key key,
    this.value,
    this.password,
    this.userId,
  }) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard>
    with SingleTickerProviderStateMixin {
  bool deleteStatus = false;
  int index = 0;
  final _asyncKey = GlobalKey<AsyncLoaderState>();
  var page = 1;
  AnimationController _con;
  Timer _debounce;
  TextEditingController _textEditingController = TextEditingController();
  bool drawer = false;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  var focusNode = FocusNode();

  void initState() {
    SocketLibrary.connectSocketIo(context);
    super.initState();
    _textEditingController.clearComposing();
    _con = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 375),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    switch (index) {
      case 0:
        child = NewsFeedPage();
        break;
      case 1:
        child = DiscoveryPage();
        break;
      case 2:
        child = FarmPlusPage(
          farmPlusAppBar: false,
        );
        break;
      case 3:
        child = ConversationList();
        break;
      case 4:
        child = FirstScreen(
          farmPlusAppBar: false,
        );
        break;
    }
    return index != 3
        ? index != 2
            ? index != 4
                ? Scaffold(
                    key: _drawerKey,
                    backgroundColor: Colors.black,
                    appBar: AppBar(
                      leading: index != 3
                          ? index == 1
                              ? IconButton(
                                  icon: new Icon(
                                    Icons.menu,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(
                                      () {
                                        _drawerKey.currentState.openDrawer();
                                      },
                                    );
                                  },
                                )
                              : IconButton(
                                  icon: new Icon(
                                    Icons.menu,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(
                                      () {
                                        _drawerKey.currentState.openDrawer();
                                      },
                                    );
                                  },
                                )
                          : Container(),
                      title: index != 3
                          ? index == 1
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 18.0),
                                  child: Container(
                                      height: 99,
                                      child: Center(
                                          child: SvgPicture.asset(newLogoFarm,
                                              height: 120,
                                              width: 120,
                                              fit: BoxFit.scaleDown))),
                                )
                              // Container(
                              //             child: Text(
                              //               'Discovery',
                              //               style: TextStyle(
                              //                   color: Colors.white,
                              //                   fontSize: 18,
                              //                   letterSpacing: 1),
                              //             ),
                              //           )
                              : Padding(
                                  padding: const EdgeInsets.only(top: 18.0),
                                  child: Container(
                                      height: 99,
                                      child: Center(
                                          child: SvgPicture.asset(newLogoFarm,
                                              height: 120,
                                              width: 120,
                                              fit: BoxFit.scaleDown))),
                                )
                          : Container(),
                      centerTitle: true,
                      actions: <Widget>[
                        index == 1
                            ? IconButton(
                                icon: new Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  navigationToScreen(
                                      context, DiscoverySearchUi(), true);
                                },
                              )
                            : IconButton(
                                icon: new Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  navigationToScreen(
                                      context, DiscoverySearchUi(), true);
                                },
                              ),
                      ],
                      backgroundColor: Colors.black,
                    ),
                    drawer: DrawerPage(),
                    floatingActionButton: FloatingActionButton(
                      backgroundColor: HexColor("D41B47"),
                      // child: SvgPicture.asset(camera, fit: BoxFit.none),
                      child: Icon(
                          Icons.add,
                        size: 52,
                      ),
                      onPressed: () {
                        AppNavigator.push(Routes.farmPost);
                      },
                    ),
                    bottomNavigationBar: getCustomNavBar(),
                    body: Container(color: Colors.black, child: child))
                : getScaffoldFarm1(child)
            : getScaffoldFarm(child)
        : getScaffoldMessage(child);
  }

  Function debounce(Function fn, [int t = 30]) {
    Timer _debounce;
    return () {
      // still within the time, abandoned the last time
      if (_debounce?.isActive ?? false) _debounce.cancel();
      _debounce = Timer(Duration(milliseconds: t), () {
        fn();
      });
    };
  }

  Widget getScaffoldFarm(child) {
    return Scaffold(
      key: _drawerKey,
      drawer: (toggle == 0)
          ? Container(
              width: 190,
              child: DrawerPage(),
            )
          : Container(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey,
          ),
          height: 40,
          margin: EdgeInsets.only(
            left: 0,
            right: 10,
            top: 10,
          ),
          child: TextFormField(
            showCursor: false,
            cursorColor: Colors.white,
            onChanged: (value) {},
            enableSuggestions: false,
            autocorrect: false,
            style: TextStyle(
                fontSize: 18.0,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w600,
                color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              hintText: 'Search Farm+',
              contentPadding: EdgeInsets.only(bottom: 2, top: 4),
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
              ),
            ),
          ),
        ),
        actions: <Widget>[
          Center(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: toggle == 0
                    ? Color.fromRGBO(34, 34, 34, 1)
                    : Color.fromRGBO(158, 158, 158, 0.1),
              ),
              margin: EdgeInsets.only(right: 15),
              padding: EdgeInsets.only(bottom: 2, left: 0.0),
              alignment: Alignment(1.0, -1.0),
            ),
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: Container(color: Colors.black, child: child),
      bottomNavigationBar: getCustomNavBar(),
    );
  }

  Widget getScaffoldFarm1(child) {
    return Scaffold(
      key: _drawerKey,
      drawer: (toggle == 0)
          ? Container(
              width: 190,
              child: DrawerPage(),
            )
          : Container(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
            child: Text(
          "Notifications",
          style: TextStyle(fontSize: 17,letterSpacing: 2.0),
        )),
        actions: <Widget>[
          Center(
            child: IconButton(
              icon: Icon(
                Icons.more_horiz,
                color: Colors.white,
              ),
              onPressed: () {
                _showPopup();
              },
            ),
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: Container(color: Colors.black, child: child),
      bottomNavigationBar: getCustomNavBar(),
    );
  }

  Widget dropdown(child) {
    return Scaffold(
      key: _drawerKey,
      drawer: (toggle == 0)
          ? Container(
              width: 190,
              child: DrawerPage(),
            )
          : Container(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey,
          ),
          height: 40,
          margin: EdgeInsets.only(
            left: 0,
            right: 10,
            top: 10,
          ),
          child: TextFormField(
            showCursor: false,
            cursorColor: Colors.white,
            onChanged: (value) {},
            enableSuggestions: false,
            autocorrect: false,
            style: TextStyle(
                fontSize: 18.0,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w600,
                color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              hintText: 'Search Farm+',
              contentPadding: EdgeInsets.only(bottom: 2, top: 4),
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
              ),
            ),
          ),
        ),
        actions: <Widget>[
          Center(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: toggle == 0
                    ? Color.fromRGBO(34, 34, 34, 1)
                    : Color.fromRGBO(158, 158, 158, 0.1),
              ),
              margin: EdgeInsets.only(right: 15),
              padding: EdgeInsets.only(bottom: 2, left: 0.0),
              alignment: Alignment(1.0, -1.0),
            ),
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: Container(color: Colors.black, child: child),
      bottomNavigationBar: getCustomNavBar(),
    );
  }

  // Widget getScaffoldFarm(child) {
  //   return Scaffold(
  //     key: _drawerKey,
  //     drawer: Container(
  //       width: MediaQuery.of(context).size.width * 0.8,
  //       child: DrawerPage(),
  //     ),
  //     backgroundColor: Colors.black,
  //     body: Container(color: Colors.black, child: child),
  //     bottomNavigationBar: getCustomNavBar(),
  //   );
  // }

  Widget getScaffoldMessage(child) {
    return Scaffold(
        key: _drawerKey,
        drawer: (toggle == 0)
            ? Container(
                width: 190,
                child: DrawerPage(),
              )
            : Container(),
        // backgroundColor: Colors.black,
        appBar: AppBar(
          leading: (_textEditingController.text != "")
              ? Consumer(builder: (context, watch, child) {
                  final messageProviders = watch(messageProvider);
                  return IconButton(
                      icon: Icon(Icons.arrow_back_ios_sharp),
                      iconSize: 24,
                      onPressed: () {
                        setState(() {
                          messageProviders.getConversations(1, "");
                          _textEditingController.clear();
                        });
                      });
                })
              : IconButton(
                  icon: Icon(
                    Icons.menu,
                  ),
                  iconSize: 32,
                  onPressed: () {
                    setState(
                      () {
                        toggle = 0;
                        _drawerKey.currentState.openDrawer();
                      },
                    );
                  }),
          backgroundColor: Colors.black,
          title: Padding(
            padding: EdgeInsets.only(top: 18.0),
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
                decoration: toggle == 0
                    ? BoxDecoration()
                    : BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: toggle == 0
                            ? Color.fromRGBO(34, 34, 34, 1)
                            : Color.fromRGBO(158, 158, 158, 0.1),
                      ),
                margin: EdgeInsets.only(right: 15),
                padding: EdgeInsets.only(bottom: 2, left: 0.0),
                alignment: Alignment(1.0, -1.0),
                child: AnimatedContainer(
                  padding: EdgeInsets.only(right: 20, bottom: 5),
                  duration: Duration(milliseconds: 375),
                  height: 80.0,
                  decoration: toggle == 0
                      ? BoxDecoration()
                      : BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: toggle == 0
                              ? Color.fromRGBO(34, 34, 34, 1)
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
                              child: Consumer(builder: (context, watch, child) {
                                final messageProviders = watch(messageProvider);
                                return TextField(
                                    focusNode: focusNode,
                                    onChanged: (T) {
                                      if (_debounce?.isActive ?? false)
                                        _debounce.cancel();
                                      _debounce = Timer(
                                          const Duration(milliseconds: 800),
                                          () {
                                        setState(() {
                                          messageProviders.getConversations(
                                              page,
                                              _textEditingController.text);
                                        });
                                      });
                                    },
                                    controller: _textEditingController,
                                    cursorRadius: Radius.circular(10.0),
                                    cursorWidth: 2.0,
                                    autofocus: false,
                                    cursorColor: Colors.white,
                                    style: TextStyle(
                                        fontSize: 14,
                                        height: 1,
                                        letterSpacing: 2,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Search Chats',
                                      contentPadding: EdgeInsets.only(
                                          bottom: 3, top: 0, left: 50),
                                      hintStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14.0,
                                      ),
                                    ));
                              })),
                        ),
                      ),
                      Container(
                        decoration: toggle == 0
                            ? BoxDecoration()
                            : BoxDecoration(
                                color: toggle == 0
                                    ? Color.fromRGBO(34, 34, 34, 1)
                                    : Color.fromRGBO(158, 158, 158, 0.0),
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                        child: IconButton(
                          icon: Icon(
                            Icons.search,
                            color: Color.fromRGBO(136, 136, 136, 0.9),
                          ),
                          onPressed: () {
                            setState(() {
                              if (toggle == 0) {
                                toggle = 1;
                                FocusScope.of(context).requestFocus(focusNode);
                                _con.forward();
                              } else {
                                toggle = 0;
                                _textEditingController.clear();
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                _con.reverse();
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
        body: Container(color: Colors.black, child: child),
        bottomNavigationBar: getCustomNavBar());
  }

  Widget getCustomNavBar() {
    return Consumer(builder: (context, watch, child) {
      final feedProviderRepo = watch(feedProvider);
      return AsyncLoader(
        key: _asyncKey,
        // ignore: missing_return
        initState: () async {
          await feedProviderRepo.getFeedList();
        },
        renderLoad: () => SizedBox(),
        renderError: ([err]) => Text('There was a error'),
        renderSuccess: ({data}) => CustomizedBottomNavigationBar(
            indicatorColor: Color(0xffFF0000),
            activeColor: Colors.white,
            onTap: (currentIndex) {
              setState(() => index = currentIndex);
            },
            currentIndex: index,
            items: [
              NavigationBarItem(
                icon: index == 0
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DashBoard()),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: SvgPicture.asset(
                            homeIcon,
                            fit: BoxFit.none,
                            height: 40,
                            width: 26,
                          ),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: SvgPicture.asset(
                          homeIcon,
                          fit: BoxFit.none,
                          height: 40,
                          width: 26,
                        ),
                      ),
                backgroundColor: Colors.black,
              ),
              NavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 15, right: 5),
                    child: SvgPicture.asset(searchIcons,
                        fit: BoxFit.none, height: 45, width: 26),
                  ),
                  backgroundColor: Colors.black),
              NavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 15, right: 5),
                    child:  Image.asset(centerLogogo,
                        fit: BoxFit.none, height: 45, width: 50),
                  ),
                  backgroundColor: Colors.red),
              // NavigationBarItem(
              //     icon: Container(
              //       height: 95,
              //       child: CircleAvatar(
              //         radius: 75,
              //         backgroundColor: HexColor('#D41B47'),
              //         child: Image.asset(middle_logo,
              //             height: 80, width: 66, fit: BoxFit.scaleDown),
              //       ),
              //     ),
              //     backgroundColor: Colors.black),
              NavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: SvgPicture.asset(newMessage,
                        fit: BoxFit.none, height: 40, width: 31),
                  ),
                  backgroundColor: Colors.black),
              feedProviderRepo.notificationCount != 0
                  ? NavigationBarItem(
                      icon: Badge(
                        position: BadgePosition(top: 0.0, start: 22),
                        badgeColor: HexColor('#D41B47'),
                        badgeContent:
                            Text(''),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: SvgPicture.asset(notification,
                              fit: BoxFit.none, height: 40, width: 23),
                        ),
                      ),
                      backgroundColor: Colors.black)
                  : NavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: SvgPicture.asset(notification,
                            fit: BoxFit.none, height: 40, width: 23),
                      ),
                      backgroundColor: Colors.black)
            ]),
      );
    });
  }



  Widget _buildChatPage(BuildContext context) {
    return Container(
      child: DropdownButton<String>(
        items: <String>['A', 'B', 'C', 'D'].map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: new Text(value),
          );
        }).toList(),
        onChanged: (_) {},
      ),
    );
  }

  _showPopup() async {
    double left = MediaQuery.of(context).size.width - 50;
    double top = 40;
    showMenu(
      context: context,
      color: Color.fromRGBO(55, 52, 52, 1),
      position: RelativeRect.fromLTRB(left, top, 0, 0),
      items: [
        PopupMenuItem<String>(
            height: 30,
            child: InkWell(
              onTap: () {
                context.read(notificationList).clearNotification();
                context.read(notificationList).notificationList.clear();
                Navigator.pop(context);
              },
              child: Container(
                  width: 180,
                  child: const Text('Clear Notifications',
                      style: TextStyle(
                        letterSpacing: 1.0,
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold))),
            ),
            value: 'delete'),
        PopupMenuItem<String>(
            height: 30,
            child: InkWell(
              onTap: () {
                context.read(notificationList).onOffNotification(
                      context.read(notificationList).Type,
                    );
                Navigator.pop(context);
              },
              child: Container(
                  width: 180,
                  child: Text(
                      (context.read(notificationList).Type)
                          ? 'Turn On Notifications'
                          : 'Turn Off Notifications',
                      style: TextStyle(
                          letterSpacing: 1.0,
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold))),
            ),
            value: 'notification'),
      ],
      elevation: 8.0,
    );
  }
}
