import 'package:flutter/material.dart';
import '../constants/text_const.dart';
import 'package:http/http.dart' as http;

Future updateOnline(userId, onlineStatus) async {
  final response = await http.post(Uri.parse(
      '${Consttext.ipAddress}/appupdateuserstatus?userId=$userId&status=$onlineStatus'));

  //pr'int('courses list is ${maps.toString()}');
  debugPrint('user status is ${response.statusCode} ${response.body}');
}
