import 'package:farm_system/feature/Courses/courses_Lesson/views/courseLesson.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/screen/Discovery/all_element.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:google_fonts/google_fonts.dart';

class ModuleSearchScreen extends ConsumerWidget {
  final _controller = TextEditingController();
  String searchKey;
  final String courseId;

  ModuleSearchScreen({this.courseId});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final CourseSearchRepo = watch(courseSearchprovider);
    return Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
            elevation: 0,
            toolbarHeight: 100,
            backgroundColor: Colors.grey[900],
            brightness: Brightness.dark,
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: IconButton(
                  onPressed: () {
                    //Navigator.pop(context);
                    navigationToScreen(
                        context,
                        CourseLessonpage(
                          courseId: courseId,
                        ),
                        false);
                    CourseSearchRepo.searchModuleList.clear();
                  },
                  padding: EdgeInsets.only(top: 7),
                  icon: Icon(Icons.arrow_back_ios,
                      color: Color.fromRGBO(145, 145, 145, 100), size: 25)),
            ),
            title: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[800]),
              height: 40,
              width: 400,
              margin: EdgeInsets.only(
                left: 0,
                right: 5,
                top: 6,
              ),
              child: TextFormField(
                controller: _controller,
                showCursor: true,
                cursorColor: Colors.white,
                onChanged: (T) {
                  CourseSearchRepo.getSearchModuleList(T, 1, courseId);
                },
                autofocus: true,
                enableSuggestions: false,
                autocorrect: false,
                style: GoogleFonts.montserrat(
                    fontSize: 14,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600]),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color.fromRGBO(145, 145, 145, 100),
                    ),
                    hintText: 'Search the Module',
                    contentPadding: EdgeInsets.only(bottom: 2, top: 6),
                    hintStyle: GoogleFonts.montserrat(
                        fontSize: 14,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey[600])),
              ),
            )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CourseSearchRepo.searchModuleList.length != null
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                          itemCount: CourseSearchRepo.searchModuleList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(top: 20.0, left: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CourseSearchRepo.searchModuleList[index]
                                                  .moduleCover !=
                                              null
                                          ? Container(
                                              width: 110.0,
                                              height: 60.0,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      CourseSearchRepo
                                                          .searchModuleList[
                                                              index]
                                                          .moduleCover),
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                              ),
                                            )
                                          : Container(
                                              height: 60.0,
                                              width: 110.0,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/images/dummycImg.jpg"),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.0))),
                                            ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      InkWell(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding:
                                                  EdgeInsets.only(bottom: 30.0),
                                              child: CourseSearchRepo
                                                          .searchModuleList[
                                                              index]
                                                          .moduleName !=
                                                      null
                                                  ? Text(
                                                      CourseSearchRepo
                                                          .searchModuleList[
                                                              index]
                                                          .moduleName,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          letterSpacing: 0.5,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color:
                                                              Colors.grey[600]),
                                                    )
                                                  : Text(" "),
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          // courselistRepo.courseName = CourseSearchRepo
                                          //     .searchList[index]
                                          //     .courseName;
                                          // FocusScope.of(context).unfocus();
                                          // navigationToScreen(
                                          //     context,
                                          //     CourseLessonpage(
                                          //       courseId: CourseSearchRepo
                                          //           .searchList[index].id,
                                          //       // title: CourseSearchRepo
                                          //       //     .searchList[index]
                                          //       //     .courseName
                                          //     ),
                                          //     false);
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          }),
                    )
                  : Container(
                      margin: EdgeInsets.only(
                        top: 20.0,
                      ),
                      child: Center(
                        child: Text(
                          'No Search History Found',
                          style: TextStyle(
                              fontSize: 16,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[600]),
                        ),
                      ),
                    )
            ],
          ),
        ));
  }
}
