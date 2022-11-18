import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermojiFunctions.dart';
import 'package:http/http.dart' as http;
import 'package:nehwe/models/buddies_model.dart';

import '../constants/text_const.dart';

Future buddies(userId) async {
  final response = await http
      .get(Uri.parse('${Consttext.ipAddress}/appgetfrndlist?userId=$userId'));
  debugPrint('user id is $userId');

  List<dynamic> maps = json.decode(response.body);

  //debugPrint('user details $maps');

  List<BuddyProfileData> buddies = List.generate(maps.length, (index) {
    String decode = FluttermojiFunctions()
        .decodeFluttermojifromString(maps[index]['avatar'].toString());
    return BuddyProfileData(
      buddyId: maps[index]['userdetid'].toString(),
      buddyName: (maps[index]['displayname']).toString(),
      buddyAvatar: decode,
      buddyXp: maps[index]['totalxp'].toString(),
      buddyStreak: maps[index]['subid'].toString(),
      buddiescount: maps[index]['totalcoins'].toString(),
      buddyCourses: maps[index]['lastused'].toString(),
    );
  });

  buddiesList = buddies;
  return buddies;
}
