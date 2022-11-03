import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants/text_const.dart';

// <---- send the user details to server ---> //

void userApi(firstName, lastName, displayName, phoneNumber, emailId,
    dateofbirth, address, city, state, country, zipcode, gender, avatar) async {
  final response = await http.get(Uri.parse(
      '${Consttext.ipAddress}/appadduser?firstName=$firstName&lastName=$lastName&displayName=$displayName&phoneNumber=$phoneNumber&zipcode=$zipcode&email=$emailId&dateOfBirth=$dateofbirth&state=$state&city=$city&address=$address&gender=$gender&country=$country&avatar=$avatar'));

  debugPrint('user added status :${response.statusCode}');
  debugPrint(response.body);
}

// <---- edit the user details to server ---> //
Future updateUserProfile(phoneNumber, firstName, lastName, displayName, emailId,
    address, city, state, country, zipcode, avatar) async {
  final response = await http.post(Uri.parse(
      '${Consttext.ipAddress}/appupdateuser?firstName=$firstName&lastName=$lastName&displayName=$displayName&phoneNumber=$phoneNumber&zipcode=$zipcode&email=$emailId&state=$state&city=$city&address=$address&country=$country&avatar=$avatar'));

  debugPrint('update user status :${response.statusCode}');
}
