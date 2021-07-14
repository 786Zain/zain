import 'package:async_loader/async_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_system/feature/Courses/courses_Lesson/views/courselesson_video.dart';
import 'package:farm_system/feature/Courses/courses_home/views/course_home.dart';
import 'package:farm_system/feature/Courses/courses_home/views/course_searchPage.dart';
import 'package:farm_system/feature/Courses/courses_home/views/module_searchPage.dart';
import 'package:farm_system/feature/feed/view/readmoretext.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../utils.dart';

class CourseLessonpage extends ConsumerWidget {
  final String courseId;


  CourseLessonpage({
    Key key,
    this.courseId,

  }) : super(key: key);

  final _asyncKey = GlobalKey<AsyncLoaderState>();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final CourselessonProvider = watch(courseLessonRepoProvider);
    final courselistRepo = watch(courseListRepoProvider);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            //courselistRepo.courseName = '';
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CourseHome()));
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.grey, size: 20),
        ),
        title: Center(
          child: Text(Utils.getCapitalizeName(courselistRepo.courseName),
              style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: Colors.white,
                  letterSpacing: 0.9,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600)),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.grey,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ModuleSearchScreen(
                  courseId:courseId,
                )),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: getAsynWidget(context),
          )
        ],
      ),
    );
  }

  Widget getAsynWidget(context) {
    return Container(
      color: Colors.black,
      child: Consumer(builder: (context, watch, child) {
        final CourselessonProvider = watch(courseLessonRepoProvider);
        return AsyncLoader(
          key: _asyncKey,
          initState: () =>
              CourselessonProvider.getCourseLessonList(courseId, true),
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
      final CourselessonProvider = watch(courseLessonRepoProvider);
      return CourselessonProvider.content.isNotEmpty
          ? GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: (1 / .6),
              shrinkWrap: true,
              children:
                  List.generate(CourselessonProvider.content.length, (index) {
                return GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => CourseVideoList(
                      //               courseId: CourselessonProvider
                      //                   .content[index].courseId,
                      //               moduleId:
                      //                   CourselessonProvider.content[index].id,
                      //               title: CourselessonProvider
                      //                   .content[index].moduleName,
                      //               index2: index,
                      //             )));
                    },
                    child: SizedBox(
                        width: 350,
                        height: 120,
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25)),
                            child: Stack(
                                alignment: Alignment.topCenter,
                                children: <Widget>[
                                  SizedBox(
                                      width: 350,
                                      height: 120,
                                      child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          clipBehavior: Clip.antiAlias,
                                          child: CourselessonProvider
                                                      .content[index]
                                                      .courseId !=
                                                  null
                                              ? Stack(
                                                  children: [
                                                    CourselessonProvider
                                                                .content[index]
                                                                .moduleCover !=
                                                            null
                                                        ? CachedNetworkImage(
                                                            height: 120,
                                                            width:
                                                                double.infinity,
                                                            fit: BoxFit.cover,
                                                            imageUrl:
                                                                CourselessonProvider
                                                                    .content[
                                                                        index]
                                                                    .moduleCover)
                                                        : Image.asset(
                                                            "assets/images/coursedummyImg.webp",
                                                            fit: BoxFit.cover,
                                                            height: 180,
                                                            width: double
                                                                .infinity),
                                                    Container(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      width: double.infinity,
                                                      child: ReadMoreText(
                                                          Utils.getCapitalizeName(
                                                              '${CourselessonProvider.content[index].moduleName}'),
                                                          colorClickableText:
                                                              HexColor(
                                                                  "D41B47"),
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .white,
                                                                  letterSpacing:
                                                                      0.9,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                    ),
                                                  ],
                                                )
                                              : Container(
                                                  child: Text(
                                                    "no course",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                )))
                                ]))));
              }))
          : Container(
              child: Center(
                  child: Text(
                "No course",
                style: TextStyle(
                    color: Colors.white, letterSpacing: 0.9, fontSize: 20),
              )),
            );
    });
  }
}
