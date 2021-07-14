import 'package:farm_system/feature/Courses/courses_Lesson/model/courseLesson_model.dart';
import 'package:farm_system/feature/Courses/courses_home/model/searchCourse_model.dart';
import 'package:farm_system/feature/Courses/courses_home/model/serachModule_model.dart';
import 'package:farm_system/services/error_handler.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:flutter/cupertino.dart';

import '../../../../storage.dart';

class CourseSearchRepo extends ChangeNotifier {
  List<Datum> searchList = List<Datum>();
  List<ContentModule> searchModuleList = List<ContentModule>();


  getSearchCourseList(String searchKey) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    return await _apiCall
        .getSearchCourseList("Bearer $auth", searchKey)
        .then((value) {
      searchList.clear();
      searchList.addAll(value.data);
      notifyListeners();
    }).catchError((e) => ErrorHandler.handleError(e));
  }

  getSearchModuleList(String searchKey, int pages, String courseId) async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    return await _apiCall
        .getSearchModuleList("Bearer $auth", searchKey, pages, courseId)
        .then((value) {
      searchModuleList.clear();
      searchModuleList.addAll(value.Contents);
      notifyListeners();
    }).catchError((e) => ErrorHandler.handleError(e));
  }
}
