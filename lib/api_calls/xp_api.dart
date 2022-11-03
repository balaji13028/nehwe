import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/text_const.dart';

Future<String> userxp(phoneNumber) async {
  final response = await http.get(Uri.parse(
      '${Consttext.ipAddress}/appadduserxp?phonenumber=$phoneNumber'));
  debugPrint('xp number is $phoneNumber');

  if (response.statusCode == 200) {
    debugPrint('xp is ${response.body}');
  } else {
    debugPrint('Request failed with status: ${response.statusCode}.');
  }
  return 'xp is ${response.body}';
}

Future updateUserXP(userId, xp) async {
  final response = await http.post(Uri.parse(
      '${Consttext.ipAddress}/appupdateuserxp?userId=$userId&userxp=$xp'));
  debugPrint('xp  is $userId and  $xp');

  if (response.statusCode == 200) {
    debugPrint('xp is ${response.body}');
  } else {
    debugPrint('Request failed with status: ${response.statusCode}.');
  }
  return 'xp is ${response.body}';
}
