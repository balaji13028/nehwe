import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/text_const.dart';
import '../models/courses_model.dart';

Future unitsList(courseId, userId) async {
  final response = await http.get(Uri.parse(
      '${Consttext.ipAddress}/appgetunits?courseId=$courseId&userId=$userId'));

  List<dynamic> maps = json.decode(response.body)[0];
  List<dynamic> lessonMap = json.decode(response.body)[1];

  List<UnitData> unitList = List.generate(maps.length, (index) {
    return UnitData(
        unitId: maps[index]['unitId'].toString(),
        unitName: maps[index]['unitName'].toString(),
        unitXP: maps[index]['xp'].toString(),
        unitStatus: maps[index]['unitStatus'].toString());
  });
  List<LessonData> lessonList = List.generate(lessonMap.length, (index2) {
    return LessonData(
        lessonId: lessonMap[index2]['lessionId'].toString(),
        unitId: lessonMap[index2]['unitId'].toString(),
        lessonName: lessonMap[index2]['lessionName'].toString(),
        lessonStatus: lessonMap[index2]['lessonStatus'].toString(),
        lessonXP: lessonMap[index2]['xp'].toString());
  });

  unitlist = unitList;
  lessonlist = lessonList;
  return unitList;
}
