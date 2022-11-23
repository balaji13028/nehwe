import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermojiFunctions.dart';
import 'package:http/http.dart' as http;
import '../constants/text_const.dart';
import '../models/buddies_model.dart';

Future noOfUsers(userId) async {
  final response = await http.get(
      Uri.parse('${Consttext.ipAddress}/appgetlistofusers?userId=$userId'));
  debugPrint('user id is $userId');

  List<dynamic> maps = json.decode(response.body);

  //debugPrint('user details $maps');

  List<BuddyProfileData> buddies = List.generate(maps.length, (index) {
    String decode = FluttermojiFunctions()
        .decodeFluttermojifromString(maps[index]['avatar'].toString());
    return BuddyProfileData(
      buddyId: maps[index]['userId'].toString(),
      buddyDisplayName: (maps[index]['displayname']).toString(),
      buddyFirstName: (maps[index]['firstname']).toString(),
      buddyLastName: (maps[index]['lastname']).toString(),
      status: maps[index]['status'].toString(),
      buddyAvatar: decode,
      buddyXp: maps[index]['totalxp'].toString(),
      buddyStreak: maps[index]['subid'].toString(),
      buddiescount: maps[index]['count'].toString(),
      buddyCoins: maps[index]['totalcoins'].toString(),
    );
  });

  listofusers = buddies;
  return buddies;
}
