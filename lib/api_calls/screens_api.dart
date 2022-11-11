import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/text_const.dart';
import '../models/courses_model.dart';

Future screensList(conceptId) async {
  final response = await http.get(Uri.parse(
      '${Consttext.ipAddress}/appgetscreensbyid?conceptId=$conceptId'));
  var res = response.body;
  //print(res);
  if (res == 'concept data is incomplete!') {
    return response.body.toString();
  } else {
    List<dynamic> maps = json.decode(response.body);

    List<ScreenData> screenList = List.generate(maps.length, (index) {
      String option1 = (maps[index]['optionset1']).toString().trim();
      String option2 = (maps[index]['optionset2']).toString().trim();
      String answ = (maps[index]['answer']).toString().trim();
      return ScreenData(
        screenId: (maps[index]['screenId']).toString(),
        screenlkpId: (maps[index]['screenlkpId']).toString(),
        screenName: (maps[index]['screenName']).toString(),
        text: (maps[index]['text']).toString().trim(),
        question: (maps[index]['question']).toString(),
        optionset1: option1.split(","),
        optionset2: option2.split(","),
        answer: answ.toString(),
        hint: maps[index]['hint'].toString().trim(),
        imageStatus: (maps[index]['imagemodule']).toString(),
        audioStatus: (maps[index]['audiomodule']).toString(),
        textStatus: (maps[index]['textmodule']).toString(),
        answertype: (maps[index]['answertype']).toString(),
        audiofile: (maps[index]['audiopath'][0]).toString(),
        imagefile: (maps[index]['imagepath']).toString(),
      );
    });

    //print('screnns are ${screenList[0].hint}');
    screenlist = screenList;
    return screenList;
  }
}
