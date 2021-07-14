import 'package:farm_system/feature/Courses/courses_home/model/courselist_model.dart';
import 'package:farm_system/feature/Courses/courses_home/model/searchCourse_model.dart';
import 'package:farm_system/services/error_handler.dart';
import 'package:farm_system/services/network/api.dart';
import 'package:farm_system/services/network/dio_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../storage.dart';

class CourseListRepo extends ChangeNotifier {
  List<CourseList> courseList;
  String courseName;

  getCourseListDetails() async {
    final _apiCall = RestClient(DioClient.getDio());
    final auth = await StorageService.getToken();
    return await _apiCall.getCourseList("Bearer $auth").then((value) {
      courseList =value.courseList;
      print(value.courseList);
      notifyListeners();
    }).catchError((e) => ErrorHandler.handleError(e));
  }
}
