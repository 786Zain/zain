// import 'package:farm_system/feature/profile_user/view/Likes/views/likes.dart';
// import 'package:farm_system/feature/profile_user/view/Media/views/MediaViews.dart';
// import 'package:farm_system/feature/profile_user/view/postReplies/view/postReplies.view.dart';
// import 'package:farm_system/feature/profile_user/view/profile_info.dart';
// import 'package:farm_system/feature/profile_user/view/profile_tabs/farmpost/farmPost_subtab.dart';
// import 'package:farm_system/feature/profile_user/view/profile_tabs/farmpost/farmPosts_tab.dart';
// import 'package:farm_system/riverpod/riverpods.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/all.dart';

// class ProfileTab extends StatefulWidget {
//   final String userId;
//
//   const ProfileTab({Key key, this.userId}) : super(key: key);
//
//   @override
//   _ProfileTabState createState() => _ProfileTabState();
// }

// class _ProfileTabState extends State<ProfileTab>
//     with SingleTickerProviderStateMixin {
//
//   ScrollPosition _position;
//   bool _visible;
//
//   @override
//   void dispose() {
//     _removeListener();
//     super.dispose();
//   }
//
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _removeListener();
//     _addListener();
//   }
//
//   void _addListener() {
//     _position = Scrollable.of(context)?.position;
//     _position?.addListener(_positionListener);
//     _positionListener();
//   }
//   void _removeListener() {
//     _position?.removeListener(_positionListener);
//   }
//   void _positionListener() {
//     final FlexibleSpaceBarSettings settings =
//     context.inheritFromWidgetOfExactType(FlexibleSpaceBarSettings);
//     bool visible = settings == null || settings.currentExtent <= settings.minExtent;
//     if (_visible != visible) {
//       setState(() {
//         _visible = visible;
//       });
//     }
//     print(_visible);
//   }
//
//
//   TabController controller;
//
//
//   _scrollListener() {
//     print("people");
//     if (listScrollController.offset <=
//         listScrollController.position.maxScrollExtent &&
//         !listScrollController.position.outOfRange) {
//       setState(() async {
//         print("hello");
//       });
//     }
//   }
//   final ScrollController listScrollController = ScrollController();
//
//
//   @override
//   void initState() {
//     listScrollController.addListener(_scrollListener);
//     super.initState();
//     controller = new TabController(length: 4, vsync: this);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: DefaultTabController(
//         length: 4,
//         child: NestedScrollView(
//           headerSliverBuilder: (context, value) {
//             print(value);
//             return [
//               SliverAppBar(
//                 backgroundColor: Colors.black,
//                 floating: false,
//                 primary: true,
//                 pinned: true,
//                 automaticallyImplyLeading: false,
//                 onStretchTrigger:(){
//                   print("ash--");
//                 } ,
//                 bottom: TabBar(
//                   controller: controller,
//                   physics: BouncingScrollPhysics(),
//                   labelPadding: EdgeInsets.only(left: 15, right: 15),
//                   indicatorColor: Colors.red,
//                   isScrollable: true,
//                   unselectedLabelColor: Colors.grey,
//                   labelColor: Colors.red,
//                   indicator: UnderlineTabIndicator(
//                     borderSide: BorderSide(width: 2, color: Colors.red),
//                   ),
//                   tabs: [
//                     Tab(
//                       child: Text(
//                         "Farm Posts",
//                         style: TextStyle(
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                     Tab(
//                       child: Text(
//                         "Post Replies",
//                         style: TextStyle(
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                     Tab(
//                       child: Text(
//                         "Media",
//                         style: TextStyle(
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                     Tab(
//                       child: Text(
//                         "Likes",
//                         style: TextStyle(fontSize: 14),
//                       ),
//                     ),
//                   ],
//                 ),
//                 expandedHeight: 500,
//                 flexibleSpace: FlexibleSpaceBar(
//
//                   collapseMode: CollapseMode.pin,
//                   background: ProfileInfo(
//                     userId: widget.userId,
//                   ),
//                 ),
//               ),
//               // SliverPersistentHeader(delegate: _SliverAppBarDelegate(
//               //    TabBar(
//               //      controller: controller,
//               //
//               //      labelPadding: EdgeInsets.only(left: 15, right: 15),
//               //     indicatorColor: Colors.red,
//               //     isScrollable: true,
//               //     unselectedLabelColor: Colors.grey,
//               //     labelColor: Colors.red,
//               //     indicator: UnderlineTabIndicator(
//               //       borderSide: BorderSide(width: 2, color: Colors.red),
//               //     ),
//               //     tabs: [
//               //
//               //       Tab(
//               //         child: Text(
//               //           "Farm Posts",
//               //           style: TextStyle(
//               //             fontSize: 14,
//               //           ),
//               //         ),
//               //       ),
//               //       Tab(
//               //         child: Text(
//               //           "Post Replies",
//               //           style: TextStyle(
//               //             fontSize: 14,
//               //           ),
//               //         ),
//               //       ),
//               //       Tab(
//               //         child: Text(
//               //           "Media",
//               //           style: TextStyle(
//               //             fontSize: 14,
//               //           ),
//               //         ),
//               //       ),
//               //       Tab(
//               //         child: Text(
//               //           "Likes",
//               //           style: TextStyle(fontSize: 14),
//               //         ),
//               //       ),
//               //     ],
//               //   ),
//               //
//               // ),
//               //   pinned: true,
//               // )
//
//             ];
//           },
//           body: TabBarView(
//             physics: ScrollPhysics(),
//               controller: controller,
//               children: [
//             Container(child: AllTab()),
//             //Container(child: subTab()),
//             Container(child: PostRepliesProfileUser()),
//             Container(child: Media()),
//             Container(child: Likes()),
//           ]),
//         ),
//       ),
//     );
//   }
//
// }

// class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
//   _SliverAppBarDelegate(this._tabBar);
//
//   final TabBar _tabBar;
//
//   @override
//   double get minExtent => _tabBar.preferredSize.height;
//   @override
//   double get maxExtent => _tabBar.preferredSize.height;
//
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return new Container(
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           bottomRight: Radius.circular(60.0),
//           bottomLeft: Radius.circular(60.0),
//         ),
//       ),
//       child: _tabBar,
//     );
//   }
//
//   @override
//   bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
//     return true;
//   }
// }

import 'package:async_loader/async_loader.dart';
import 'package:farm_system/feature/profile_user/view/Likes/views/likes.dart';
import 'package:farm_system/feature/profile_user/view/Media/views/MediaViews.dart';
import 'package:farm_system/feature/profile_user/view/postReplies/repo/postreplySubTab_repo.dart';
import 'package:farm_system/feature/profile_user/view/postReplies/view/postReplies.view.dart';
import 'package:farm_system/feature/profile_user/view/postReplies/view/postReplySubTab.dart';
import 'package:farm_system/feature/profile_user/view/profile_info.dart';
import 'package:farm_system/feature/profile_user/view/profile_tabs/farmpost/farmPost_subtab.dart';
import 'package:farm_system/feature/profile_user/view/profile_tabs/farmpost/farmPosts_tab.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/ui/decoratedTab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Likes/views/likeSubTab.dart';
import 'Media/views/mediaSubTab.dart';
import 'profile_tabs/farmpost/view/profileSubTab.view.dart';

class ProfileTab extends StatefulWidget {
  final userId;

  const ProfileTab({Key key, this.userId}) : super(key: key);
  @override
  _SliverWithTabBarState createState() => _SliverWithTabBarState();
}

class _SliverWithTabBarState extends State<ProfileTab>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  Widget build(BuildContext context) {

    TabController _tabController;
    var _tabs = new List<String>(4);
    _tabs[0] = "Farm Posts";
    _tabs[1] = "Post Replies";
    _tabs[2] = "Media";
    _tabs[3] = "Likes";
    Map<int, Color> color = {
      50: Color.fromRGBO(0, 0, 0, .1),
      100: Color.fromRGBO(0, 0, 0, .2),
      200: Color.fromRGBO(0, 0, 0, .3),
      300: Color.fromRGBO(0, 0, 0, .4),
      400: Color.fromRGBO(0, 0, 0, .5),
      500: Color.fromRGBO(0, 0, 0, .6),
      600: Color.fromRGBO(0, 0, 0, .7),
      700: Color.fromRGBO(0, 0, 0, .8),
      800: Color.fromRGBO(0, 0, 0, .9),
      900: Color.fromRGBO(0, 0, 0, 1),
    };
    MaterialColor primeColor = MaterialColor(0xFF000000, color);
    MaterialColor accentColor = MaterialColor(0xFF000000, color);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: primeColor),
        home: SafeArea(
          top: true,
          child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.black,
            body: DefaultTabController(
              length: _tabs.length,
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                      sliver: SliverAppBar(
                        pinned: true,
                        stretchTriggerOffset: 10,
                        expandedHeight: MediaQuery.of(context).size.height * 0.5,
                        forceElevated: innerBoxIsScrolled,
                        flexibleSpace: FlexibleSpaceBar(
                            background: ProfileInfo(
                          userId: widget.userId,
                        )),
                        bottom: PreferredSize(
                          preferredSize: Size.fromHeight(0.0),
                          child: ColoredBox(
                            color: Colors.black,
                            child: DecoratedTabBar(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              tabBar: TabBar(
                                labelPadding:
                                    EdgeInsets.only(left: 23, right: 23),
                                indicatorColor: Colors.red,
                                isScrollable: true,
                                unselectedLabelColor: Colors.grey,
                                labelColor: Colors.red,
                                indicator: UnderlineTabIndicator(
                                  borderSide:
                                      BorderSide(width: 4, color: Colors.red),
                                ),
                                tabs: [
                                  Tab(
                                    iconMargin:
                                        EdgeInsets.only(top: 0, bottom: 0),
                                    child: Text(
                                      "Farm Posts",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          height: 2),
                                    ),
                                  ),
                                  Tab(
                                    iconMargin:
                                        EdgeInsets.only(top: 0, bottom: 0),
                                    child: Text(
                                      "Post Replies",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          height: 2),
                                    ),
                                  ),
                                  Tab(
                                    iconMargin:
                                        EdgeInsets.only(top: 0, bottom: 0),
                                    child: Text(
                                      "Media",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          height: 2),
                                    ),
                                  ),
                                  Tab(
                                      iconMargin:
                                          EdgeInsets.only(top: 0, bottom: 0),
                                      child: Text(
                                        "Likes",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            height: 2),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  children: <Widget>[
                    NestedTabBar(userId: widget.userId),
                    NestedTabBar1(userId: widget.userId),
                    NestedTabBar2(userId: widget.userId),
                    NestedTabBar3(userId: widget.userId),

                    // Container(
                    //     child: Likes(
                    //   userId: widget.userId,
                    // )),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class NestedTabBar extends StatefulWidget {
  final userId;

  const NestedTabBar({Key key, this.userId}) : super(key: key);
  @override
  _NestedTabBarState createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  TabController _nestedTabController;
  var tabSelect = [
    "All",
    "Hitting",
    "Pitching",
    "Defense",
    "Mental & Strength"
  ];
  var categoryId;
  final _asyncKeyCategorys = GlobalKey<AsyncLoaderState>();
  @override
  void initState() {
    super.initState();
    _nestedTabController = new TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final profileSubTabRepo = watch(profileSubTabProvider);
      return AsyncLoader(
        key: _asyncKeyCategorys,
        initState: () => profileSubTabRepo.getProfileSubTabDetails(),
        renderLoad: () => Container(),
        renderError: ([err]) => Text('There was a error'),
        renderSuccess: ({data}) => _generateUI(),
      );
    });
  }

  _generateUI() {
    double screenHeight = MediaQuery.of(context).size.height;
    return Consumer(builder: (context, watch, child) {
      final profileSubTabRepo = watch(profileSubTabProvider);
      return Container(
        color: Colors.black,
        margin: EdgeInsets.only(top: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: DecoratedTabBar(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                  ),
                ),
                tabBar: TabBar(
                  controller: _nestedTabController,
                  labelPadding: EdgeInsets.only(left: 15, right: 15),
                  indicatorColor: Colors.red,
                  isScrollable: true,
                  unselectedLabelColor: Colors.grey,
                  labelColor: Colors.red,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 4, color: Colors.red),
                  ),
                  onTap: (val) {
                    profileSubTabRepo.feedCategory.forEach((element) {
                      if (element.categoryName == tabSelect[val]) {
                        setState(() {
                          categoryId = element.id;
                          profileSubTabRepo.setProfileCategoryIdnId(categoryId);
                        });
                      }
                    });
                  },
                  tabs: [
                    Tab(
                      iconMargin: EdgeInsets.only(top: 0, bottom: 0),
                      child: Text(
                        "All",
                        style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2,
                            height: 2),
                      ),
                    ),
                    Tab(
                      iconMargin: EdgeInsets.only(top: 0, bottom: 0),
                      child: Text(
                        "Hitting",
                        style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 2),
                      ),
                    ),
                    Tab(
                      iconMargin: EdgeInsets.only(top: 0, bottom: 0),
                      child: Text(
                        "Pitching",
                        style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 2),
                      ),
                    ),
                    Tab(
                      iconMargin: EdgeInsets.only(top: 0, bottom: 0),
                      child: Text(
                        "Defense",
                        style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 2),
                      ),
                    ),
                    Tab(
                      iconMargin: EdgeInsets.only(top: 0, bottom: 0),
                      child: Text(
                        "Mental & Strength",
                        style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: screenHeight * 0.50,
                child: TabBarView(
                  controller: _nestedTabController,
                  children: <Widget>[
                    AllTab(userId: widget.userId),
                    ProfileSubTabDetails(userId: widget.userId,profileId: categoryId),
                    ProfileSubTabDetails(userId: widget.userId,profileId: categoryId),
                    ProfileSubTabDetails(userId: widget.userId,profileId: categoryId),
                    ProfileSubTabDetails(userId: widget.userId,profileId: categoryId)
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}


class NestedTabBar1 extends StatefulWidget {
  final userId;
  const NestedTabBar1({Key key, this.userId}) : super(key: key);
  @override
  _NestedTabBar1State createState() => _NestedTabBar1State();
}

class _NestedTabBar1State extends State<NestedTabBar1>
    with TickerProviderStateMixin {
  TabController _nestedTabController;
  var tabSelect = [
    "All",
    "Hitting",
    "Pitching",
    "Defense",
    "Mental & Strength"
  ];
  var categoryId;
  final _asyncKeyCategorys = GlobalKey<AsyncLoaderState>();
  @override
  void initState() {
    super.initState();
    _nestedTabController = new TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final postReplySubTabRepo = watch(PostReplySubTabProvider);
      return AsyncLoader(
        key: _asyncKeyCategorys,
        initState: () => postReplySubTabRepo.getReplySubTabDetails(),
        renderLoad: () => Container(),
        renderError: ([err]) => Text('There was a error'),
        renderSuccess: ({data}) => _generateUI(),
      );
    });
  }

  _generateUI() {
    double screenHeight = MediaQuery.of(context).size.height;
    return Consumer(builder: (context, watch, child) {
      final postReplySubTabRepo = watch(PostReplySubTabProvider);
      return Container(
        color: Colors.black,
        margin: EdgeInsets.only(top: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: DecoratedTabBar(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                  ),
                ),
                tabBar: TabBar(
                  controller: _nestedTabController,
                  labelPadding: EdgeInsets.only(left: 15, right: 15),
                  indicatorColor: Colors.red,
                  isScrollable: true,
                  unselectedLabelColor: Colors.grey,
                  labelColor: Colors.red,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 4, color: Colors.red),
                  ),
                  onTap: (val) {
                    postReplySubTabRepo.postreplycategory.forEach((element) {
                      if (element.categoryName== tabSelect[val]) {
                        setState(() {
                          categoryId = element.id;
                          postReplySubTabRepo.setreplyCategoryIdnId(categoryId);
                        });
                      }
                    });
                  },
                  tabs: [
                    Tab(
                      iconMargin: EdgeInsets.only(top: 0, bottom: 0),
                      child: Text(
                        "All",
                        style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2,
                            height: 2),
                      ),
                    ),
                    Tab(
                      iconMargin: EdgeInsets.only(top: 0, bottom: 0),
                      child: Text(
                        "Hitting",
                        style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 2),
                      ),
                    ),
                    Tab(
                      iconMargin: EdgeInsets.only(top: 0, bottom: 0),
                      child: Text(
                        "Pitching",
                        style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 2),
                      ),
                    ),
                    Tab(
                      iconMargin: EdgeInsets.only(top: 0, bottom: 0),
                      child: Text(
                        "Defense",
                        style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 2),
                      ),
                    ),
                    Tab(
                      iconMargin: EdgeInsets.only(top: 0, bottom: 0),
                      child: Text(
                        "Mental & Strength",
                        style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: screenHeight * 0.50,
                child: TabBarView(
                  controller: _nestedTabController,
                  children: <Widget>[
                    PostRepliesProfileUser(userId: widget.userId),
                    PostReplySubTabView(userId:widget.userId,profileId: categoryId),
                    PostReplySubTabView(userId:widget.userId,profileId: categoryId),
                    PostReplySubTabView(userId:widget.userId,profileId: categoryId),
                    PostReplySubTabView(userId:widget.userId,profileId: categoryId)
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}





class NestedTabBar2 extends StatefulWidget {
  final userId;

  const NestedTabBar2({Key key, this.userId}) : super(key: key);
  @override
  _NestedTabBar2State createState() => _NestedTabBar2State();
}

class _NestedTabBar2State extends State<NestedTabBar2>
    with TickerProviderStateMixin {
  TabController _nestedTabController;
  var tabSelect = [
    "All",
    "Hitting",
    "Pitching",
    "Defense",
    "Mental & Strength"
  ];
  var categoryId;
  final _asyncKeyCategorys = GlobalKey<AsyncLoaderState>();
  @override
  void initState() {
    super.initState();
    _nestedTabController = new TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      // final profileSubTabRepo = watch(profileSubTabProvider);
      final mediaSubTabRepo = watch(mediaSubTabProvider);

      return AsyncLoader(
        key: _asyncKeyCategorys,
        initState: () => mediaSubTabRepo.getMediaSubTabDetails(),
        renderLoad: () => Container(),
        renderError: ([err]) => Text('There was a error'),
        renderSuccess: ({data}) => _generateUI(),
      );
    });
  }

  _generateUI() {
    double screenHeight = MediaQuery.of(context).size.height;
    return Consumer(builder: (context, watch, child) {
      final mediaSubTabRepo = watch(mediaSubTabProvider);
      return Container(
        color: Colors.black,
        margin: EdgeInsets.only(top: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: DecoratedTabBar(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                  ),
                ),
                tabBar: TabBar(
                  controller: _nestedTabController,
                  labelPadding: EdgeInsets.only(left: 15, right: 15),
                  indicatorColor: Colors.red,
                  isScrollable: true,
                  unselectedLabelColor: Colors.grey,
                  labelColor: Colors.red,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 4, color: Colors.red),
                  ),
                  onTap: (val) {
                    mediaSubTabRepo.mediacategory.forEach((element) {
                      if (element.categoryName == tabSelect[val]) {
                        setState(() {
                          categoryId = element.id;
                          mediaSubTabRepo.setMediaCategoryIdnId(categoryId);

                          // medaiaSubTabRepo.setMediaCategoryIdnId(categoryId);
                        });
                      }
                    });
                  },
                  tabs: [
                    Tab(
                      iconMargin: EdgeInsets.only(top: 0, bottom: 0),
                      child: Text(
                        "All",
                        style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2,
                            height: 2),
                      ),
                    ),
                    Tab(
                      iconMargin: EdgeInsets.only(top: 0, bottom: 0),
                      child: Text(
                        "Hitting",
                        style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 2),
                      ),
                    ),
                    Tab(
                      iconMargin: EdgeInsets.only(top: 0, bottom: 0),
                      child: Text(
                        "Pitching",
                        style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 2),
                      ),
                    ),
                    Tab(
                      iconMargin: EdgeInsets.only(top: 0, bottom: 0),
                      child: Text(
                        "Defense",
                        style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 2),
                      ),
                    ),
                    Tab(
                      iconMargin: EdgeInsets.only(top: 0, bottom: 0),
                      child: Text(
                        "Mental & Strength",
                        style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: screenHeight * 0.50,
                child: TabBarView(
                  controller: _nestedTabController,
                  children: <Widget>[
                Media(userId: widget.userId),
                    MediaSubTabDetails(userId: widget.userId, profileId: categoryId),
                    MediaSubTabDetails(userId: widget.userId, profileId: categoryId),
                    MediaSubTabDetails(userId: widget.userId, profileId: categoryId),
                    MediaSubTabDetails(userId: widget.userId, profileId: categoryId)
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}

class NestedTabBar3 extends StatefulWidget {
  final userId;

  const NestedTabBar3({Key key, this.userId}) : super(key: key);
  @override
  _NestedTabBar3State createState() => _NestedTabBar3State();
}

class _NestedTabBar3State extends State<NestedTabBar3>
    with TickerProviderStateMixin {
  TabController _nestedTabController;
  var tabSelect = [
    "All",
    "Hitting",
    "Pitching",
    "Defense",
    "Mental & Strength"
  ];
  var categoryId;
  final _asyncKeyCategorys = GlobalKey<AsyncLoaderState>();
  @override
  void initState() {
    super.initState();
    _nestedTabController = new TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final LikeSubTabCategory = watch(LikeSubTabProvider);
      return AsyncLoader(
        key: _asyncKeyCategorys,
        initState: () => LikeSubTabCategory.getLikeSubTabDetails(),
        renderLoad: () => Container(),
        renderError: ([err]) => Text('There was a error'),
        renderSuccess: ({data}) => _generateUI(),
      );
    });
  }

  _generateUI() {
    double screenHeight = MediaQuery.of(context).size.height;
    return Consumer(builder: (context, watch, child) {
      final LikeSubTabCategory = watch(LikeSubTabProvider);
      return Container(
        color: Colors.black,
        margin: EdgeInsets.only(top: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: DecoratedTabBar(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                  ),
                ),
                tabBar: TabBar(
                  controller: _nestedTabController,
                  labelPadding: EdgeInsets.only(left: 15, right: 15),
                  indicatorColor: Colors.red,
                  isScrollable: true,
                  unselectedLabelColor: Colors.grey,
                  labelColor: Colors.red,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 4, color: Colors.red),
                  ),
                  onTap: (val) {
                    LikeSubTabCategory.likecategory.forEach((element) {
                      if (element.categoryName == tabSelect[val]) {
                        setState(() {
                          categoryId = element.id;
                          LikeSubTabCategory.setLikeCategoryIdnId(categoryId);
                        });
                      }
                    });
                  },
                  tabs: [
                    Tab(
                      iconMargin: EdgeInsets.only(top: 0, bottom: 0),
                      child: Text(
                        "All",
                        style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2,
                            height: 2),
                      ),
                    ),
                    Tab(
                      iconMargin: EdgeInsets.only(top: 0, bottom: 0),
                      child: Text(
                        "Hitting",
                        style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 2),
                      ),
                    ),
                    Tab(
                      iconMargin: EdgeInsets.only(top: 0, bottom: 0),
                      child: Text(
                        "Pitching",
                        style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 2),
                      ),
                    ),
                    Tab(
                      iconMargin: EdgeInsets.only(top: 0, bottom: 0),
                      child: Text(
                        "Defense",
                        style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 2),
                      ),
                    ),
                    Tab(
                      iconMargin: EdgeInsets.only(top: 0, bottom: 0),
                      child: Text(
                        "Mental & Strength",
                        style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: screenHeight * 0.50,
                child: TabBarView(
                  controller: _nestedTabController,
                  children: <Widget>[
                    Likes(
                  userId: widget.userId),
                    LikeSubTabDetails(userId: widget.userId,profileId: categoryId),
                    LikeSubTabDetails(userId: widget.userId,profileId: categoryId),
                    LikeSubTabDetails(userId: widget.userId,profileId: categoryId),
                    LikeSubTabDetails(userId: widget.userId,profileId: categoryId)
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}