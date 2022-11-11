import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/text_const.dart';
import '../models/courses_model.dart';

Future unitsList(courseId, userId) async {
  final response = await http.get(Uri.parse(
      '${Consttext.ipAddress}/appgetunits?courseId=$courseId&userId=$userId'));

  List<dynamic> maps = json.decode(response.body);

  List<UnitData> unitList = List.generate(maps.length, (index) {
    if (maps[index].length < 5) {
      return UnitData(
          unitId: maps[index]['unitId'].toString(),
          unitName: maps[index]['unitName'].toString(),
          unitXP: maps[index]['xp'].toString(),
          unitStatus: maps[index]['unitStatus'].toString());
    } else {
      return UnitData();
    }
  });

  List<LessonData> lessonList = List.generate(maps.length, (index2) {
    if (maps[index2].length >= 5) {
      String pdfstring = maps[index2]['pdfPath'].toString();

      return LessonData(
          lessonId: maps[index2]['lessionId'].toString(),
          unitId: maps[index2]['unitId'].toString(),
          lessonName: maps[index2]['lessionName'].toString(),
          lessonStatus: maps[index2]['lessonStatus'].toString(),
          glossary:
              pdfstring.toString().replaceAll('[', '').replaceAll(']', ''),
          lessonXP: maps[index2]['xp'].toString());
    } else {
      return LessonData();
    }
  });
  unitlist = unitList;
  lessonlist = lessonList;
  return unitList;
} 





// Future unitsList(courseId, userId) async {
//   final response = await http.get(Uri.parse(
//       '${Consttext.ipAddress}/appgetunits?courseId=$courseId&userId=$userId'));

//   List<dynamic> maps = json.decode(response.body)[0];
//   List<dynamic> lessonMap = json.decode(response.body)[1];

//   List<UnitData> unitList = List.generate(maps.length, (index) {
//     return UnitData(
//         unitId: maps[index]['unitId'].toString(),
//         unitName: maps[index]['unitName'].toString(),
//         unitXP: maps[index]['xp'].toString(),
//         unitStatus: maps[index]['unitStatus'].toString());
//   });
//   List<LessonData> lessonList = List.generate(lessonMap.length, (index2) {
//     return LessonData(
//         lessonId: lessonMap[index2]['lessionId'].toString(),
//         unitId: lessonMap[index2]['unitId'].toString(),
//         lessonName: lessonMap[index2]['lessionName'].toString(),
//         lessonStatus: lessonMap[index2]['lessonStatus'].toString(),
//         lessonXP: lessonMap[index2]['xp'].toString());
//   });

//   unitlist = unitList;
//   lessonlist = lessonList;
//   return unitList;
// }
