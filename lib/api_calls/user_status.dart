import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nehwe/models/courses_status_model.dart';

import '../constants/text_const.dart';

Future userStatus(phoneNumber) async {
  final response = await http.get(Uri.parse(
      '${Consttext.ipAddress}/appgetuserconceptsbyphonenumber?phonenumber=$phoneNumber'));
  debugPrint('Request  with status: ${response.statusCode}.');
  debugPrint('user status is ${response.body}');
  var res = response.body;
  if (res == 'hmm user concepts not captured yet') {
  } else {
    List<dynamic> maps = json.decode(response.body);

    List<StatusOfCourses> status = List.generate(maps.length, (index) {
      return StatusOfCourses(
        courseId: maps[index]['courseId'].toString(),
        courseStatus: maps[index]['coursestatus'].toString(),
        unitId: maps[index]['unitId'].toString(),
        unitStatus: maps[index]['unitstatus'].toString(),
        lessonId: maps[index]['lessonId'].toString(),
        lessonStatus: maps[index]['lessonstatus'].toString(),
        conceptId: maps[index]['conceptId'].toString(),
        conceptStatus: maps[index]['conceptstatus'].toString(),
      );
    });

    statuslist = status;
    return status;
  }
}
