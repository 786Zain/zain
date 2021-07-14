import 'package:async_loader/async_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/Courses/courses_Lesson/views/courselesson_video.dart';
import 'package:farm_system/feature/farm_plus_setup/view/video_expanded/video_expanded.dart';
import 'package:farm_system/feature/feed/view/readmoretext.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/screen/Discovery/all_element.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class CourseDetailpage extends ConsumerWidget {
  final String courseId;
  final String moduleId;
  final int page;
  final String videotitle;
  final String imagepath;
  final String bodytext;
  final String filepath;
  final int index3;

  CourseDetailpage(
      {Key key,
      this.courseId,
      this.moduleId,
      this.page,
      this.videotitle,
      this.imagepath,
      this.bodytext,
      this.filepath,
      this.index3})
      : super(key: key);

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
           // Navigator.pop(context);
            navigationToScreen(context, CourseVideoList(
              courseId: courseId,
              moduleId: moduleId,
              title:CourselessonProvider
                  .content[0].moduleName,
            ), false);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.grey, size: 20),
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 8),
          child: Center(
              child: Container(
                  height: 80,
                  child: Center(
                      child: SvgPicture.asset(newLogoFarm,
                          height: 80, width: 80, fit: BoxFit.scaleDown)))),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(child: Consumer(builder: (context, watch, child) {
            final CourselessonProvider = watch(courseLessonRepoProvider);
            return AsyncLoader(
              key: _asyncKey,
              initState: () => CourselessonProvider.getCourseSingleVideo(
                  courseId, moduleId, page),
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
          }))
        ],
      ),
    );
  }

  Consumer _generateUI(context) {
    return Consumer(builder: (context, watch, child) {
      final CourselessonProvider = watch(courseLessonRepoProvider);
      return Container(
        height: 500,
        child: ListView.builder(
            itemCount: CourselessonProvider.singlevideo.length,
            itemBuilder: (BuildContext context, int i) {
              return Column(
                children: [
                  Container(
                    child: Text(CourselessonProvider.singlevideo[i].title,
                        //'$videotitle',
                        style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: Colors.white,
                            letterSpacing: 0.9,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 200,
                      child:
                          // VideoPlayerNeww(
                          //   filePaths: filepath,
                          // )
                          CachedNetworkImage(
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        imageUrl:
                            CourselessonProvider.singlevideo[i].thumbnailUrl,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: InkWell(
                      child: Container(
                        child: Text("Enter Full Screen",
                            style: GoogleFonts.montserrat(
                                fontSize: 16,
                                color: Colors.white,
                                letterSpacing: 0.9,
                                fontWeight: FontWeight.normal)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(
                      left: 5,
                      top: 5,
                    ),
                    width: double.infinity,
                    child: ReadMoreText(
                        CourselessonProvider.singlevideo[i].bodyText,
                        colorClickableText: HexColor("D41B47"),
                        style: GoogleFonts.montserrat(
                            fontSize: 12,
                            color: Colors.white,
                            letterSpacing: 0.9,
                            fontWeight: FontWeight.normal)),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          height: 30,
                          width: 150,
                          decoration: BoxDecoration(
                            color: HexColor("#FFFFFF"),
                            borderRadius: BorderRadius.circular(105),
                          ),
                          // ignore: unrelated_type_equality_checks
                          child:  CourselessonProvider.paginationCount == page
                              ? FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  onPressed: () {
                                    navigationToScreen(context, CourseDetailpage(
                                      imagepath:
                                      CourselessonProvider
                                          .content[i]
                                          .thumbnailUrl,
                                      moduleId: moduleId,
                                      courseId: courseId,
                                      page: page - 1,
                                      filepath: CourselessonProvider
                                          .content[i].videoLink,
                                    ), false);
                                  },
                                  child: Text(
                                    "LAST LESSON",
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: HexColor("#D41B47"),
                                        letterSpacing: 2,
                                        fontStyle: FontStyle.normal),
                                  ),
                                )
                              : FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Text(
                                    "LAST LESSON",
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color:
                                            Colors.transparent.withOpacity(0.5),
                                        letterSpacing: 2,
                                        fontStyle: FontStyle.normal),
                                  ),
                                )),
                      Container(
                          height: 30,
                          width: 150,
                          decoration: BoxDecoration(
                            color: HexColor("#D41B47"),
                            borderRadius: BorderRadius.circular(105),
                          ),
                          child: CourselessonProvider.paginationCount > page
                              ? FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  onPressed: () {
                                    navigationToScreen(context, CourseDetailpage(
                                                    imagepath:
                                                        CourselessonProvider
                                                            .content[i]
                                                            .thumbnailUrl,
                                                    moduleId: moduleId,
                                                    courseId: courseId,
                                                    page: page + 1,
                                                    filepath: CourselessonProvider
                                                        .content[i].videoLink,
                                    ), false);
                                  },
                                  child: Text(
                                    "NEXT LESSON",
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        letterSpacing: 2,
                                        color: Colors.white,
                                        fontStyle: FontStyle.normal),
                                  ),
                                )
                              : FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Text(
                                    "NEXT LESSON",
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        letterSpacing: 2,
                                        color:
                                            Colors.transparent.withOpacity(0.5),
                                        fontStyle: FontStyle.normal),
                                  ),
                                )),
                    ],
                  )
                ],
              );
            }),
      );
    });
  }
}
