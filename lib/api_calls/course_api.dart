import 'dart:convert';
import '../constants/text_const.dart';
import '../models/courses_model.dart';
import 'package:http/http.dart' as http;

Future<List<CoursesData>> coursesList(userId) async {
  final response = await http
      .get(Uri.parse('${Consttext.ipAddress}/appgetcourses?userId=$userId'));

  final List<dynamic> maps = json.decode(response.body);
  //print('courses list is ${maps.toString()}');

  List<CoursesData> coursesList = List.generate(maps.length, (index) {
    var image = base64Decode(maps[index]['imagePath'].toString());
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
