import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants/text_const.dart';
import '../models/courses_model.dart';

Future<List<ConceptData>> conceptsList(
    courseId, unitId, lessonId, userId) async {
  final response = await http.get(Uri.parse(
      '${Consttext.ipAddress}/appgetconcepts?courseId=$courseId&unitId=$unitId&lessonId=$lessonId&userId=$userId'));

  List<dynamic> maps = json.decode(response.body);

  //print('concepts list is ${maps.toString()}');

  List<ConceptData> conceptList = List.generate(maps.length, (index) {
    return ConceptData(
        conceptId: (maps[index]['conceptId']).toString(),
        conceptName: (maps[index]['conceptName']).toString(),
        xp: (maps[index]['exp']).toString(),
        conceptstatus: maps[index]['conceptstatus'].toString());
  });

  conceptlist = conceptList;
  return conceptList;
}

Future<String> userconcepts(phoneNumber) async {
  final response = await http.get(Uri.parse(
      '${Consttext.ipAddress}/appadduserconcepts?phonenumber=$phoneNumber'));
  debugPrint('concept number is $phoneNumber');

  if (response.statusCode == 200) {
    debugPrint('concept is ${response.body}');
  } else {
    debugPrint('Request failed with status: ${response.statusCode}.');
  }
  return 'cpncept is ${response.body}';
}

///This is for update the concept status to server
Future<void> conceptstatus(unitId, unitStatus, lessonId, lessonStatus,
    conceptId, conceptStatus, userId) async {
  final response = await http.get(Uri.parse(
      '${Consttext.ipAddress}/appupdateuserconcepts?unitId=$unitId&unitStatus=$unitStatus&lessonId=$lessonId&lessonStatus=$lessonStatus&conceptId=$conceptId&conceptStatus=$conceptStatus&userId=$userId'));
  print(
      '${Consttext.ipAddress}/appupdateuserconcepts?unitId=$unitId&unitStatus=$unitStatus&lessonId=$lessonId&lessonStatus=$lessonStatus&conceptId=$conceptId&conceptStatus=$conceptStatus&userId=$userId');
  debugPrint('status :${response.statusCode}');

  debugPrint('concepts status is ${response.body}');
}
