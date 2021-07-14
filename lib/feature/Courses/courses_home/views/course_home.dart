import 'package:async_loader/async_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/dashboard/drawerPage.dart';
import 'package:farm_system/feature/Courses/courses_Lesson/views/courseLesson.dart';
import 'package:farm_system/feature/feed/view/readmoretext.dart';
import 'package:farm_system/feature/message/view/conversations.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/screen/Discovery/all_element.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../utils.dart';
import 'course_searchPage.dart';

class CourseHome extends StatefulWidget {
  @override
  _CourseHomeState createState() => _CourseHomeState();
}

class _CourseHomeState extends State<CourseHome> {
  final _asyncKey = GlobalKey<AsyncLoaderState>();
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer:
      (toggle == 0)
          ? Container(
        width: 190,
        child: DrawerPage(),
      )
          : Container(),
      backgroundColor: Colors.black,
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.menu,color: Colors.grey,),
        //   onPressed: (){
        //     Navigator.pop(context);
        //   },
        // ),
        backgroundColor: Colors.black,
        title: Center(
            child: Container(
                height: 80,
                child: Center(
                    child: SvgPicture.asset(newLogoFarm,
                        height: 80, width: 80, fit: BoxFit.scaleDown)))),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.grey,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CourseSearchScreen()),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.88,
              child: getAsynWidget(context),
            )
          ],
        ),
      ),
    );
  }

  Widget getAsynWidget(context) {
    return Container(
      color: Colors.black,
      child: Consumer(builder: (context, watch, child) {
        final courselistRepo = watch(courseListRepoProvider);
        return AsyncLoader(
          key: _asyncKey,
          initState: () => courselistRepo.getCourseListDetails(),
          renderLoad: () => Container(
            height: 0,
            width: 0,
            child: SizedBox(
                height: 20.0,
                width: 20.0,
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.black),
                    strokeWidth: 0)),
          ),
          renderError: ([err]) => Text('There was a error'),
          renderSuccess: ({data}) => _generateUI(context),
        );
      }),
    );
  }

  Consumer _generateUI(context) {
    return Consumer(builder: (context, watch, child) {
      final courselistRepo = watch(courseListRepoProvider);
      return GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: (1 / .6),
          shrinkWrap: true,
          children: List.generate(courselistRepo.courseList.length, (index) {
            return GestureDetector(
              onTap: () {
                courselistRepo.courseName = courselistRepo.courseList[index].courseName;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CourseLessonpage(
                              courseId: courselistRepo.courseList[index].id,
                            )));
              },
              child: SizedBox(
                width: 350,
                height: 120,
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(25)),
                  child: Stack(alignment: Alignment.center, children: <Widget>[
                    SizedBox(
                        width: 350,
                        height: 120,
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            clipBehavior: Clip.antiAlias,
                            child: Stack(
                              children: [
                                courselistRepo.courseList[index].courseCover !=
                                        null
                                    ? CachedNetworkImage(
                                        height: 120,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        imageUrl: courselistRepo
                                            .courseList[index].courseCover)
                                    : Image.asset(
                                        "assets/images/dummycImg.jpg",
                                        fit: BoxFit.cover,
                                        height: 120,
                                        width: double.infinity,
                                      ),
                                Container(
                                  alignment: Alignment.topCenter,
                                  padding: EdgeInsets.only(left: 12, right: 12),
                                  width: double.infinity,
                                  child: ReadMoreText(
                                      Utils.getCapitalizeName(
                                        '${courselistRepo.courseList[index].courseName}',
                                      ),
                                      colorClickableText: HexColor("D41B47"),
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.white,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            )))
                  ]),
                ),
              ),
            );
          }));
    });
  }
}
