import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/text_const.dart';

Future<String> coins(phoneNumber) async {
  final response = await http.get(Uri.parse(
      '${Consttext.ipAddress}/appaddusercoins?phonenumber=$phoneNumber'));
  debugPrint('COINS number is $phoneNumber');

  if (response.statusCode == 200) {
    debugPrint('coins is ${response.body}');
  } else {
    debugPrint('Request failed with status: ${response.statusCode}.');
  }
  return 'coins is ${response.body}';
}
