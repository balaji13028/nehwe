import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants/text_const.dart';
import '../models/user_details_model.dart';

Future noOfUsers(userId) async {
  final response = await http.get(
      Uri.parse('${Consttext.ipAddress}/appgetliftofusers?userId=$userId'));
  debugPrint('user id is $userId');

  List<dynamic> maps = json.decode(response.body);

  debugPrint('user details $maps');

  List<UserProfileData> user = List.generate(maps.length, (index) {
    return UserProfileData(
        id: maps[index]['userId'].toString(),
        firstName: (maps[index]['firstname']).toString(),
        lastName: (maps[index]['lastname']).toString(),
        displayName: (maps[index]['displayname']).toString(),
        emailId: (maps[index]['email']).toString(),
        dob: (maps[index]['udob']).toString(),
        gender: (maps[index]['gender']).toString(),
        phoneNumber: (maps[index]['phonenumber']).toString(),
        address: (maps[index]['address']).toString(),
        city: (maps[index]['city']).toString(),
        state: (maps[index]['state']).toString(),
        country: (maps[index]['country']).toString(),
        zipcode: (maps[index]['zipcode']).toString(),
        avatar: maps[index]['avatar'].toString(),
        xp: maps[index]['totalxp'].toString(),
        subId: maps[index]['subid'].toString(),
        coins: maps[index]['totalcoins'].toString(),
        lastused: maps[index]['lastused'].toString(),
        lifes: maps[index]['userlifes'].toString());
  });

  return user;
}
