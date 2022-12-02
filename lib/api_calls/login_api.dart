import 'dart:convert';
import 'package:flutter/material.dart';
import '../constants/text_const.dart';
import 'package:http/http.dart' as http;
import '../models/user_details_model.dart';

// <--login page api request START-->//
Future<String> userLogin(phoneNumber, userToken) async {
  final response = await http.get(Uri.parse(
      '${Consttext.ipAddress}/userlogin?phonenumber=$phoneNumber&user_token=$userToken'));
  debugPrint('login number is $phoneNumber');

  if (response.statusCode == 200) {
    debugPrint('otp is ${response.body}');
  } else {
    debugPrint('Request failed with status: ${response.statusCode}.');
  }
  return response.body;
}

Future verifyOTP(num1, num2, num3, num4, num5, num6, phoneNumber) async {
  String otp = '$num1$num2$num3$num4$num5$num6';
  final response = await http.get(Uri.parse(
      '${Consttext.ipAddress}/otpvalidation?otp=$otp&phonenumber=$phoneNumber'));

  debugPrint('status :${response.statusCode}');
  var res = response.body;
  if (res == 'Otp Invalid!' || res == 'New User!') {
    print(res);
    return response.body.toString();
  } else {
    List<dynamic> maps = json.decode(res);

    //debugPrint('user details $maps');

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
          onlineStatus: maps[index]['crr_status'].toString(),
          lastused: maps[index]['lastused'].toString(),
          lifes: maps[index]['userlifes'].toString());
    });

    localUserList = user;
    return user;
  }
}

Future coinslifes(phoneNumber) async {
  final response = await http.get(Uri.parse(
      '${Consttext.ipAddress}/appgetusercoins_lifes?phonenumber=$phoneNumber'));
  debugPrint('status :${response.statusCode}');
  var res = response.body;

  List<dynamic> maps = json.decode(res);

  debugPrint('user COINS AND LIFES $maps');

  List<UserProfileData> user = List.generate(maps.length, (index) {
    return UserProfileData(
        id: maps[index]['userId'].toString(),
        coins: maps[index]['totalcoins'].toString(),
        lifes: maps[index]['userlifes'].toString());
  });

  localUserList = user;
  return user;
}
