import 'package:async_loader/async_loader.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/Courses/courses_home/views/course_home.dart';
import 'package:farm_system/feature/farm_plus_setup/farmp_seeall/view/all_expanded_view.dart';
import 'package:farm_system/feature/farm_plus_setup/farmp_seeall/view/farm_seeall.dart';
import 'package:farm_system/feature/farm_plus_setup/view/farm_plus.dart';
import 'package:farm_system/feature/farm_plus_setup/repo/farm_plus_repo.dart';
import 'package:farm_system/feature/farm_plus_subscribe_setup/farm_plus_description/view/description_page.dart';
import 'package:farm_system/feature/login/login.dart';
import 'package:farm_system/feature/new_screen.dart/custom_widget.dart';
import 'package:farm_system/feature/profile_user/view/profiletab.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/routes/router.gr.dart';
import 'package:farm_system/screen/Discovery/all_element.dart';
import 'package:farm_system/screen/Discovery/discovery_model.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dashboard.dart';
// import 'package:cache_image/cache_image.dart';

class DrawerPage extends StatefulWidget {
  @override
  _DrawerPageState createState() => _DrawerPageState(
        userId,
      );
}

class _DrawerPageState extends State<DrawerPage> {
  var userId;
  bool expansion = false;

  _DrawerPageState(
    this.userId,
  );

  @override
  void initState() {
    //context.read(dashboardProvider).fetchUserDetail();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      userId = await StorageService.getUserId();
    });

    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Consumer(builder: (context, watch, child) {
      final dashBoardProviderRepo = watch(dashboardProvider);
      final messageProviders = watch(messageProvider);
      final profileRepo = watch(profileProvider);
      print('bsbdjshbd');
      print( dashBoardProviderRepo
          .userProfilePic);
      print(dashBoardProviderRepo.name);
      print(dashBoardProviderRepo.userName);
      // ignore: non_constant_identifier_names
      final FarmPlusRepo = watch(farmPlusProvider);
      return AsyncLoader(
        initState: () => FarmPlusRepo.farmPlusCategoryList(),
        renderLoad: () => Container(),
        renderError: ([err]) => Text('There was a error'),
        renderSuccess: ({data}) => SizedBox(
          width: 190,
          child: Drawer(
            child: Container(
              decoration: BoxDecoration(color: Colors.black),
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Container(
                        margin: EdgeInsets.fromLTRB(0, 35, 42, 0),
                        child: Column(
                          children: [
                            Visibility(
                              visible:
                                  dashBoardProviderRepo.userProfilePic != null,
                              child: GestureDetector(
                                child:
                                    dashBoardProviderRepo.userProfilePic != null
                                        ? Container(
                                            width: 60.0,
                                            height: 60.0,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(getImageUrl(
                                                    dashBoardProviderRepo
                                                        .userProfilePic)),
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30.0)),
                                              color: Colors.grey,
                                            ),
                                          )
                                        : Container(
                                            height: 60,
                                            width: 60,
                                            color: Colors.red,
                                            child: Image.asset(dummyUser),
                                          ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProfileTab(
                                        userId: dashBoardProviderRepo.userId,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 8)),
                            Text(
                              dashBoardProviderRepo.name ?? '',
                              //profileRepo.userProfileDeatils.name ?? '',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Text('@${dashBoardProviderRepo.userName}',
                                style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff666666)))
                          ],
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 10, 25, 3),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            'MARKETPLACE',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                letterSpacing: 2),
                          ),
                          onTap: () {
                            navigationToScreen(
                                context, DescriptionPage(), false);
                          },
                        ),
                        ListTile(
                          title: Text(
                            'PROMOTIONS',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                letterSpacing: 2),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: Text(
                            'JOBS',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                letterSpacing: 2),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: InkWell(
                            onTap: () {
                              navigationToScreen(
                                  context, FarmPlusPage(farmPlusAppBar: true,), false);
                            },
                            child: Text(
                              'FARM+',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  letterSpacing: 2),
                            ),
                          ),
                          trailing: IconButton(
                            padding: EdgeInsets.only(left: 10),
                            icon: expansion == true
                                ? Icon(
                                    Icons.keyboard_arrow_up,
                                    color: Colors.white,
                                    size: 16,
                                  )
                                : Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                            onPressed: () {
                              changeTheBoolvalue(expansion);
                            },
                          ),
                        ),
                        expansion
                            ? Container(
                                child: ListView.builder(
                                    padding: EdgeInsets.only(bottom: 0, top: 0),
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount:
                                        FarmPlusRepo.farmpluscategory.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        margin: EdgeInsets.only(
                                            left: 35, top: 5, bottom: 7),
                                        child: InkWell(
                                          onTap: () {
                                            var categoryId = FarmPlusRepo
                                                .farmpluscategory[index].id;
                                            var categoryName = FarmPlusRepo
                                                .farmpluscategory[index]
                                                .categoryName;
                                            FarmPlusRepo.farmpluscategory[index]
                                                        .categoryName ==
                                                    FarmPlusRepo
                                                        .farmpluscategory[2]
                                                        .categoryName
                                                ? navigationToScreen(
                                                    context,
                                                    FarmSeeAllPage(
                                                      //subCategory: FarmPlusRepo.farmplusList[0].post[0].categoryContent[index].subCategory,
                                                      categoryId: categoryId,
                                                      categoryName:
                                                          categoryName,
                                                    ),
                                                    false)
                                                : navigationToScreen(
                                                    context,
                                                    FarmPlusExpandedView(
                                                      categoryName:
                                                          categoryName,
                                                      categoryId: categoryId,
                                                    ),
                                                    false);
                                          },
                                          child: Text(
                                            FarmPlusRepo.farmpluscategory[index]
                                                .categoryName
                                                .toUpperCase(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              letterSpacing: 2,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              )
                            : Container(),
                        ListTile(
                          title: Text(
                            'COURSES',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                letterSpacing: 2),
                          ),
                          onTap: () {
                            navigationToScreen(context, CourseHome(), false);
                          },
                        ),
                        ListTile(
                          title: Text(
                            'LOGOUT',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                letterSpacing: 2),
                          ),
                          onTap: () async {
                            StorageService.clearPrefs();
                            await messageProviders.clearRepo();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LoginPage(isRestPassword: true)),
                              (Route<dynamic> route) => false,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  void changeTheBoolvalue(bool expansion1) {
    setState(() {
      expansion = !expansion1;
    });
  }
}
