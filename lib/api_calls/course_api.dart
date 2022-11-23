import 'dart:convert';
import 'package:flutter/material.dart';

import '../constants/text_const.dart';
import '../models/courses_model.dart';
import 'package:http/http.dart' as http;

Future<List<CoursesData>> coursesList(userId) async {
  final response = await http
      .get(Uri.parse('${Consttext.ipAddress}/appgetcourses?userId=$userId'));

  final List<dynamic> maps = json.decode(response.body);
  //print('courses list is ${maps.toString()}');
  debugPrint('course status is ${response.statusCode}');
  List<CoursesData> coursesList = List.generate(maps.length, (index) {
    return CoursesData(
      courseId: (maps[index]['courseId']).toString(),
      courseName: (maps[index]['courseName']).toString(),
      courseStatus: maps[index]['coursestatus'].toString(),
      courseImage: maps[index]['imagePath'].toString(),
    );
  });

  courseList = coursesList;
  return coursesList;
}
