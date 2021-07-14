import 'package:farm_system/feature/follower_following/Following/views/following_page.dart';
import 'package:farm_system/feature/follower_following/followPage_add/add_follow.dart';
import 'package:farm_system/feature/follower_following/followers/views/followers_Pages.dart';
import 'package:farm_system/feature/profile_user/view/profiletab.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:google_fonts/google_fonts.dart';

class FollowFollowingTab extends StatefulWidget {
  // final index;

  // const FollowFollowingTab({
  //   Key key,
  //   this.index,
  // }) : super(key: key);

  @override
  _FollowFollowingTabState createState() => _FollowFollowingTabState();
}

class _FollowFollowingTabState extends State<FollowFollowingTab>
    with SingleTickerProviderStateMixin {
  // TabController tabController1;
  // TabController tabController2;

  TabController _tabController;

  @override
  void initState() {
    _tabController =
        new TabController(length: 2, vsync: this, 
        // initialIndex: widget.index
        );
    super.initState();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   tabController1 = new TabController(
  //     vsync: this,
  //     length: 2,
  //   );
  // }

  // changeMyTab() {
  //   setState(() {
  //     tabController.index = 1;
  //   });
  // }

  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final profileRepo = watch(profileProvider);
      return DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                backgroundColor: Colors.grey[900],
                actions: [
                  IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  Spacer(),
                  Center(
                    child: new InkWell(
                      onTap: () {},
                      child: new Container(
                          child: Text(profileRepo.userProfileDeatils.name.toUpperCase(),style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              letterSpacing: 2,
                              height: 1),)),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                      icon: Icon(Icons.add, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddFollowUi()),
                        );
                      }),
                ],
                floating: true,
                automaticallyImplyLeading: false,
                pinned: true,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(50.0),
                  child: ColoredBox(
                      color: Colors.black,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: TabBar(
                          controller: _tabController,
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
                expandedHeight: 100,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  // background: ProfileInfo(userId: widget.userId),
                ),
              ),
            ];
          },
          body: TabBarView(controller: _tabController, children: [
            Container(child: Follower()),
            Container(
              child: Following(),
            )
          ]),
        ),
      );
    });
  }
}
