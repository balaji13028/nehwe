import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/text_const.dart';

Future<String> lifes(phoneNumber) async {
  final response = await http.get(Uri.parse(
      '${Consttext.ipAddress}/appadduserlifes?phonenumber=$phoneNumber'));
  debugPrint('LIFES number is $phoneNumber');

  if (response.statusCode == 200) {
    debugPrint('lifes is ${response.body}');
  } else {
    debugPrint('Request failed with status: ${response.statusCode}.');
  }
  return 'lifes is ${response.body}';
}

Future<String> updateLifes(userId, lifes, lastused) async {
  final response = await http.post(Uri.parse(
      '${Consttext.ipAddress}/appupdateuserlifes?userid=$userId&userlifes=$lifes&lastused=$lastused'));
  print(
      '${Consttext.ipAddress}/appupdateuserlifes?userid=$userId&lifes=$lifes&lastused=$lastused');
  if (response.statusCode == 200) {
    debugPrint('lifes is ${response.body}');
  } else {
    debugPrint('Request failed with status: ${response.statusCode}.');
  }
  return 'lifes is ${response.body}';
}
