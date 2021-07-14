//import 'package:flutter/material.dart';
//import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
//
//
//class DashboardPage extends StatefulWidget {
//  @override
//  _DashboardPageState createState() => _DashboardPageState();
//}
//
//class _DashboardPageState extends State<DashboardPage> {
//  PersistentTabController _controller;
//
//  @override
//  void initState() {
//    _controller = PersistentTabController(initialIndex: 0);
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return GestureDetector(
//      onTap: () {
//        if (ZoomDrawer.of(context).isOpen()) {
//          ZoomDrawer.of(context).close();
//        }
//      },
//      onHorizontalDragUpdate: (details) {
//        if (details.delta.dx < -2) {
//          if (ZoomDrawer.of(context).isOpen()) {
//            ZoomDrawer.of(context).close();
//          }
//        }
//      },
//      child: Scaffold(
//        appBar: AkrueAppBar(),
//        backgroundColor: AppColors.t1,
//        body: Consumer(
//          builder: return PersistentTabView(
//          controller: repo.persistentTabController,
//          screens: _buildScreens(),
//          items: _navBarItems(watch),
//          confineInSafeArea: false,
//          backgroundColor: AppColors.t1,
//          handleAndroidBackButtonPress: true,
//          resizeToAvoidBottomInset: true,
//          stateManagement: true,
//          decoration: NavBarDecoration(
//            borderRadius: BorderRadius.circular(10.0),
//            colorBehindNavBar: Colors.white,
//          ),
//          popAllScreensOnTapOfSelectedTab: true,
//          itemAnimationProperties: ItemAnimationProperties(
//            // Navigation Bar's items animation properties.
//            duration: Duration(milliseconds: 200),
//            curve: Curves.ease,
//          ),
//          screenTransitionAnimation: ScreenTransitionAnimation(
//            animateTabTransition: true,
//            curve: Curves.ease,
//            duration: Duration(milliseconds: 200),
//          ),
//          navBarStyle: NavBarStyle.style6,
//          onItemSelected: (T) {
//            repo.setIndex(T);
//          },
//        ),
//        ),
//      ),
//    );
//  }
//
//  List<Widget> _buildScreens() {
//    return [
//      FeedPage(),
//      ExplorePage(),
//      LinksPage(),
//      ClosetPage(),
//    ];
//  }
//
//  _navBarItems(T Function<T>(ProviderBase<Object, T> provider) watch) {
//    final repo = watch(dashboardProvider);
//    return [
//      PersistentBottomNavBarItem(
//        icon: Column(
//          children: [
//            Icon(
//              Icons.home,
//              color: Colors.white,
//            ),
//            RichText(
//              text: TextSpan(text: 'Feed', style: TextStyle(fontSize: 12)),
//            )
//          ],
//        ),
//      ),
//      PersistentBottomNavBarItem(
//        icon: Column(
//          children: [
//            SvgPicture.asset(
//              Constants.explore, color: Colors.white,
//              //alignment: Alignment.center,
//              height: 25,
//              width: 25,
//            ),
//            RichText(
//              text: TextSpan(text: 'Explore', style: TextStyle(fontSize: 12)),
//            )
//          ],
//        ),
//      ),
//      PersistentBottomNavBarItem(
//        icon: Column(
//          children: [
//            SvgPicture.asset(
//              Constants.link,
//              color: Colors.white,
//              //alignment: Alignment.center,
//              height: 25,
//              width: 25,
//            ),
//            RichText(
//              text: TextSpan(text: 'Links', style: TextStyle(fontSize: 12)),
//            )
//          ],
//        ),
//      ),
//      PersistentBottomNavBarItem(
//        icon: Column(
//          children: [
//            SvgPicture.asset(
//              Constants.closet, color: Colors.white,
//              //alignment: Alignment.center,
//              height: 25,
//              width: 25,
//            ),
//            RichText(
//              text: TextSpan(text: 'Closet', style: TextStyle(fontSize: 12)),
//            )
//          ],
//        ),
//      ),
//    ];
//  }
//}