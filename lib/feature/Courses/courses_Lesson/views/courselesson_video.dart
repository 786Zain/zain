import 'package:async_loader/async_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_system/feature/Courses/courses_Lesson/views/courseDetail_lesson.dart';
import 'package:farm_system/feature/feed/view/readmoretext.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/screen/Discovery/all_element.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../utils.dart';
import 'courseLesson.dart';

class CourseVideoList extends ConsumerWidget {
  final String courseId;
  final String moduleId;
  final String title;
  final int index2;

  CourseVideoList( {
    Key key,
    this.courseId,
    this.moduleId,
    this.title,
    this.index2
  }) : super(key: key);

  final _asyncKey = GlobalKey<AsyncLoaderState>();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final courselistRepo = watch(courseListRepoProvider);
    final CourselessonProvider = watch(courseLessonRepoProvider);
    print('iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii');
    print(index2);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            navigationToScreen(context, CourseLessonpage(
              courseId: courseId,
            ), false);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.red, size: 20),
        ),
        title: Center(
          child: Text(Utils.getCapitalizeName(title),
              style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: Colors.white,
                  letterSpacing: 0.9,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600)),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: getVideoWidget(context),
          )
        ],
      ),
    );
  }

  Widget getVideoWidget(context) {
    return Container(
      color: Colors.black,
      child: Consumer(builder: (context, watch, child) {
        final CourselessonProvider = watch(courseLessonRepoProvider);
        return AsyncLoader(
          key: _asyncKey,
          initState: () => CourselessonProvider.getCourseVideoList(courseId, moduleId, true),
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
      final courselistRepo = watch(courseListRepoProvider);
      return CourselessonProvider.content.isNotEmpty
          ?
      GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: (1 / .6),
              shrinkWrap: true,
              children:
                  List.generate(CourselessonProvider.content.length, (index) {
                return GestureDetector(
                    onTap: () {
                      CourselessonProvider.content[index].type != 'folder'?
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CourseDetailpage(
                                bodytext : CourselessonProvider.content[index].bodyText,
                                videotitle : CourselessonProvider.content[index].title,
                                imagepath: CourselessonProvider.content[index].thumbnailUrl,
                                moduleId: moduleId,
                                courseId: courseId,
                                page: index + 1,
                                filepath: CourselessonProvider.content[index].videoLink,
                                index3:index,
                                  )))
                          : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CourseVideoList(
                                courseId: courseId,
                                moduleId: CourselessonProvider.content[index].id,
                                title: CourselessonProvider
                                    .content[index].moduleName,
                              )));
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
                                      child: CourselessonProvider
                                                  .content[index].type ==
                                              'folder'
                                          ? Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              clipBehavior: Clip.antiAlias,
                                              child: Stack(
                                                children: [
                                                  CachedNetworkImage(
                                                      height: 120,
                                                      width: double.infinity,
                                                      fit: BoxFit.cover,
                                                      imageUrl:
                                                          CourselessonProvider
                                                              .content[index]
                                                              .moduleCover),
                                                  CourselessonProvider
                                                              .content[index]
                                                              .moduleName !=
                                                          null
                                                      ? Container(
                                                          alignment: Alignment
                                                              .topCenter,
                                                          width:
                                                              double.infinity,
                                                          child: ReadMoreText(
                                                              Utils.getCapitalizeName(
                                                                  '${CourselessonProvider.content[index].moduleName}'),
                                                              colorClickableText:
                                                                  HexColor(
                                                                      "D41B47"),
                                                              style: GoogleFonts.montserrat(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .white,
                                                                  letterSpacing:
                                                                      0.9,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        )
                                                      : Container(
                                                          alignment: Alignment
                                                              .topCenter,
                                                          width:
                                                              double.infinity,
                                                          child: ReadMoreText(
                                                              Utils.getCapitalizeName(
                                                                  '${CourselessonProvider.content[index].moduleName}'),
                                                              colorClickableText:
                                                                  HexColor(
                                                                      "D41B47"),
                                                              style: GoogleFonts.montserrat(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .white,
                                                                  letterSpacing:
                                                                      0.9,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        )
                                                ],
                                              ))
                                          : Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              clipBehavior: Clip.antiAlias,
                                              child: CourselessonProvider
                                                          .content[index]
                                                          .moduleId !=
                                                      null
                                                  ? Stack(
                                                      children: [
                                                        CachedNetworkImage(
                                                            height: 120,
                                                            width: double
                                                                .infinity,
                                                            fit: BoxFit.cover,
                                                            imageUrl:
                                                                CourselessonProvider
                                                                    .content[
                                                                        index]
                                                                    .thumbnailUrl),
                                                        CourselessonProvider
                                                                    .content[
                                                                        index]
                                                                    .title !=
                                                                null
                                                            ? Container(
                                                                alignment:
                                                                    Alignment
                                                                        .topCenter,
                                                                width: double
                                                                    .infinity,
                                                                child: ReadMoreText(
                                                                    Utils.getCapitalizeName(
                                                                        '${CourselessonProvider.content[index].title}'),
                                                                    colorClickableText:
                                                                        HexColor(
                                                                            "D41B47"),
                                                                    style: GoogleFonts.montserrat(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .white,
                                                                        letterSpacing:
                                                                            0.9,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                              )
                                                            : Container(
                                                                alignment:
                                                                    Alignment
                                                                        .topCenter,
                                                                width: double
                                                                    .infinity,
                                                                child: ReadMoreText(
                                                                    Utils.getCapitalizeName(
                                                                      '${CourselessonProvider.content[index].title}'),
                                                                    colorClickableText:
                                                                        HexColor(
                                                                            "D41B47"),
                                                                    style: GoogleFonts.montserrat(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .white,
                                                                        letterSpacing:
                                                                            0.9,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                              )
                                                      ],
                                                    )
                                                  : Container(
                                                      child: Text(
                                                        "no course",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
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
