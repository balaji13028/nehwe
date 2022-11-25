import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermojiFunctions.dart';
import 'package:http/http.dart' as http;
import 'package:nehwe/models/buddies_model.dart';

import '../constants/text_const.dart';

Future getbuddies(userId) async {
  final response = await http
      .get(Uri.parse('${Consttext.ipAddress}/appgetfrndlist?userId=$userId'));
  debugPrint('user id is $userId');
  if (response.body == 'User has no friends') {
    response.body.toString();
  } else {
    Map<String, dynamic> maps = json.decode(response.body);

    List<BuddyProfileData> buddies =
        List.generate(maps['Friends_Details'][0].length, (index) {
      var map = maps['Friends_Details'][0];

      String decode = FluttermojiFunctions()
          .decodeFluttermojifromString(map[index]['avatar'].toString());
      return BuddyProfileData(
        buddyId: map[index]['userId'].toString(),
        buddyDisplayName: (map[index]['displayname']).toString(),
        buddyFirstName: (map[index]['firstname']).toString(),
        buddyLastName: (map[index]['lastname']).toString(),
        status: map[index]['status'].toString(),
        buddyAvatar: decode,
        buddyXp: map[index]['totalxp'].toString(),
        buddyStreak: map[index]['subid'].toString(),
        buddiescount: map[index]['count'].toString(),
        buddyCoins: map[index]['totalcoins'].toString(),
      );
    });
    List<FriendRequestsData> reqtIds =
        List.generate(maps['Friends_Reqst_Data'][0].length, (i) {
      return FriendRequestsData(
        requetsedUserId:
            maps['Friends_Reqst_Data'][0][i]['userId_2'].toString(),
        senderUesrId: maps['Friends_Reqst_Data'][0][i]['userId_1'].toString(),
        friendStatus: maps['Friends_Reqst_Data'][0][i]['status'].toString(),
      );
    });
    buddiesList = buddies;
    requestsList = reqtIds;
    return buddies;
  }
}

//to send reponse to server about the requests.
Future<String> friendRequestResponse(userId, requestUserID, sendstatus) async {
  final response = await http.post(Uri.parse(
      '${Consttext.ipAddress}/appaddfrnd?userId1=$userId&userId2=$requestUserID&status=$sendstatus'));
  debugPrint('request to $userId $requestUserID');

  if (response.statusCode == 200) {
    debugPrint('friend request is ${response.body}');
  } else {
    debugPrint('Request failed with status: ${response.statusCode}.');
  }
  return 'friend request to ${response.body}';
}

//to get friend suggestions.
Future friendSuggestions(userId) async {
  final response = await http.get(
      Uri.parse('${Consttext.ipAddress}/appgetfrndsuggestions?userId=$userId'));

  List<dynamic> maps = json.decode(response.body);

  List<FriendRequestsData> suggestionIds = List.generate(maps.length, (i) {
    return FriendRequestsData(
      suggestionId: maps[i]['userId'].toString(),
    );
  });

  suggestionsList = suggestionIds;
  return suggestionIds;
}


// Future buddies(userId) async {
//   final response = await http
//       .get(Uri.parse('${Consttext.ipAddress}/appgetfrndlist?userId=$userId'));
//   debugPrint('user id is $userId');
//   if (response.body == 'User has no friends') {
//     response.body.toString();
//   } else {
//     List<dynamic> maps = json.decode(response.body);

//     debugPrint('user details $maps');

//     List<BuddyProfileData> buddies = List.generate(maps.length, (index) {
//       String decode = FluttermojiFunctions()
//           .decodeFluttermojifromString(maps[index]['avatar'].toString());
//       return BuddyProfileData(
//         buddyId: maps[index]['userId'].toString(),
//         buddyDisplayName: (maps[index]['displayname']).toString(),
//         buddyFirstName: (maps[index]['firstname']).toString(),
//         buddyLastName: (maps[index]['lastname']).toString(),
//         status: maps[index]['status'].toString(),
//         buddyAvatar: decode,
//         buddyXp: maps[index]['totalxp'].toString(),
//         buddyStreak: maps[index]['subid'].toString(),
//         buddiescount: maps[index]['count'].toString(),
//         buddyCoins: maps[index]['totalcoins'].toString(),
//       );
//     });

//     buddiesList = buddies;
//     return buddies;
//   }
// }


