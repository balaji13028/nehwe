import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants/text_const.dart';
import '../models/courses_model.dart';

Future testapi(courseId, unitId, userId) async {
  final response = await http.get(Uri.parse(
      '${Consttext.ipAddress}/appgettests?courseId=$courseId&unitId=$unitId&userId=$userId'));

  try {
    List<dynamic> maps = json.decode(response.body);
    List<ScreenData> screenList = List.generate(maps.length, (index) {
      String option1 = (maps[index]['optionset1']).toString().trim();
      String option2 = (maps[index]['optionset2']).toString().trim();

      return ScreenData(
        screenId: (maps[index]['testscreenId']).toString(),
        testId: (maps[index]['testId']).toString(),
        status: (maps[index]['teststatus']).toString(),
        screenlkpId: (maps[index]['screenlkpId']).toString(),
        screenName: (maps[index]['testName']).toString(),
        text: (maps[index]['text']).toString().trim(),
        question: (maps[index]['question']).toString().trim(),
        optionset1: option1.split(","),
        optionset2: option2.split(","),
        answer: (maps[index]['answer']).toString().trim(),
        imageStatus: (maps[index]['imagemodule']).toString(),
        audioStatus: (maps[index]['audiomodule']).toString(),
        textStatus: (maps[index]['textmodule']).toString(),
        answertype: (maps[index]['answertype']).toString(),
        audiofile: (maps[index]['audiopath'][0]).toString(),
        imagefile: (maps[index]['imagepath']).toString(),
      );
    });

    screenlist = screenList;
    return screenList;
  } catch (e) {
    print('message is $Error');
  }
}

Future<void> updateTestStatus(
  courseId,
  unitId,
  testStatus,
  userId,
  testId,
) async {
  final response = await http.get(Uri.parse(
      '${Consttext.ipAddress}/appupdateusertests1?courseId=$courseId&unitId=$unitId&testStatus=$testStatus&userId=$userId&testId=$testId'));
  print(
      '${Consttext.ipAddress}/appupdateusertests1?courseId=$courseId&unitId=$unitId&testStatus=$testStatus&userId=$userId&testId=$testId');
  debugPrint('status :${response.statusCode}');

  debugPrint('test status is ${response.body}');
}
