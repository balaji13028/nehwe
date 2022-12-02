import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants/text_const.dart';

Future<String> sendFriendNotifation(userId, requestedUserID, sendstatus) async {
  final response = await http.get(Uri.parse(
      '${Consttext.ipAddress}/pushnotification?fromuserId=$userId&touserId=$requestedUserID&stringmsg=$sendstatus'));
  debugPrint('request to $userId $requestedUserID');

  if (response.statusCode == 200) {
    debugPrint('friend request is ${response.body}');
  } else {
    debugPrint('Request failed with status: ${response.statusCode}.');
  }
  return 'friend request to ${response.body}';
}
