import 'package:async_loader/async_loader.dart';
import 'package:extended_tabs/extended_tabs.dart';
import 'package:farm_system/feature/feed/view/newFeedPage.dart';
import 'package:farm_system/feature/profile_user/view/profile_info.dart';
import 'package:farm_system/feature/profile_user/view/profile_tabs/farmpost/farmPost_subtab.dart';
import 'package:farm_system/feature/profile_user/view/profile_tabs/farmpost/view/profileSubTab.view.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmPostTab extends StatefulWidget {
  @override
  _FarmPostTabState createState() => _FarmPostTabState();
}

class _FarmPostTabState extends State<FarmPostTab>
    with SingleTickerProviderStateMixin {
  TabController controller;
  final _asyncKeyCategorys = GlobalKey<AsyncLoaderState>();

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
    scrollController.addListener(() => setState(() {}));
  }

  var tabSelect = [
    "All",
    "Hitting",
    "Pitching",
    "Defense",
    "Mental & Strength"
  ];

  var categoryId;
  var newData;

  ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, watch, child) {
        final profileSubTabRepo = watch(profileSubTabProvider);
        return AsyncLoader(
          key: _asyncKeyCategorys,
          initState: () => profileSubTabRepo.getProfileSubTabDetails(),
          renderLoad: () => Container(),
          renderError: ([err]) => Text('There was a error'),
          renderSuccess: ({data}) => _generateUI(),
        );
      }),
    );
  }

  _generateUI() {
    return Consumer(builder: (context, watch, child) {
      final profileSubTabRepo = watch(profileSubTabProvider);

      return DefaultTabController(
          length: 5,
          child: NestedScrollView(
            controller: scrollController,
            headerSliverBuilder: (context, value) {
              return [
                SliverAppBar(
                  expandedHeight: 1,
                  backgroundColor: Colors.black,
                  floating: true,
                  automaticallyImplyLeading: false,
                  pinned: true,
                  bottom: TabBar(
                    onTap: (val) {
                      profileSubTabRepo.feedCategory.forEach((element) {
                        if (element.categoryName == tabSelect[val]) {
                          setState(() {
                            categoryId = element.id;
                            profileSubTabRepo
                                .setProfileCategoryIdnId(categoryId);
                          });
                        }
                      });
                    },
                    labelPadding: EdgeInsets.only(left: 10, right: 10),
                    indicatorColor: Colors.red,
                    unselectedLabelColor: Colors.grey,
                    labelColor: Colors.red,
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(width: 2, color: Colors.red),
                    ),
                    tabs: [
                      Tab(
                        child: Text(
                          "All",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Hitting",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Pitching",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Defense",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Mental & Strength",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                  ),
                ),
              ];
            },
            body: TabBarView(children: [
              Container(
                child: AllTab(),
              ),
              Container(
                // child: ProfileSubTabDetails(profileId: categoryId),
              ),
              Container(
                // child: ProfileSubTabDetails(profileId: categoryId),
              ),
              Container(
                // child: ProfileSubTabDetails(profileId: categoryId),
              ),
              Container(
                // child: ProfileSubTabDetails(profileId: categoryId),
              ),
            ]),
          ));
    });
  }
}
