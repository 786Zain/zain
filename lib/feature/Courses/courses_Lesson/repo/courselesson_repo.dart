import 'package:farm_system/feature/Courses/courses_Lesson/model/courseLesson_model.dart';
import 'package:farm_system/services/error_handler.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:flutter/cupertino.dart';

import '../../../../storage.dart';

class CourseLessonRepo extends ChangeNotifier {
  List<Content> content;
   int paginationCount;
   List<Content> singlevideo = List<Content>();

  getCourseLessonList(String courseId, bool isCourseslist) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    return await _apiCall.getCourseLessonList("Bearer $auth",courseId,isCourseslist).then((value) {
      content =value.contents;
      paginationCount =value.paginationCount;
      notifyListeners();
    }).catchError((e) => ErrorHandler.handleError(e));
  }

  getCourseVideoList(String courseId,String moduleId, bool isCourseslist) async {
    content.clear();
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    return await _apiCall.getCourseVideoList("Bearer $auth",courseId,moduleId,isCourseslist).then((value) {
      content =value.contents;
      paginationCount =value.paginationCount;
      notifyListeners();
    }).catchError((e) => ErrorHandler.handleError(e));
  }


  getCourseSingleVideo(String courseId,String moduleId,int page) async {
    singlevideo.clear();
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    return await _apiCall.getCourseSingleVideo("Bearer $auth",courseId,moduleId,page).then((value) {
      singlevideo.addAll(value.contents);
      paginationCount =value.paginationCount;
      notifyListeners();
    }).catchError((e) => ErrorHandler.handleError(e));
  }


}
