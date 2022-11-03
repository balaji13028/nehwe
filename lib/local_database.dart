import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'models/user_details_model.dart';

// ignore: prefer_typing_uninitialized_variables
var opendatabase;
Future<void> database() async {
  WidgetsFlutterBinding.ensureInitialized();
  String dbPath = await getDatabasesPath();
  opendatabase = openDatabase(
    join(dbPath, 'Nehweapplication.db'),
    onCreate: (db, version) async {
      await db.execute(
        '''CREATE TABLE IF NOT EXISTS userDetails(id INTEGER , firstName TEXT,lastName TEXT,displayName TEXT, phoneNumber VARCHAR(12),avatar TEXT,gender VARCHAR(10),zipcode VARCHAR(10),email VARCHAR(50),dateOfBirth VARCHAR(20),state VARCHAR(20),city VARCHAR(20),country VARCHAR(40),address VARCHAR(100),lifes VARCHAR(12), coins VARCHAR(20),xp VARCHAR(20),subscription VARCHAR(20),lastused VARCHAR(50))''',
      );
    },
    version: 1,
  );
  localUserList = await user();
}

Future<void> insertUser(UserProfileData user) async {
  final db = await opendatabase;

  await db.insert(
    'userDetails',
    user.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  // ignore: avoid_print
  print('inserted  is $user');
}

Future<List<UserProfileData>> user() async {
  final db = await opendatabase;

  final List<Map<String, dynamic>> maps = await db.query('userDetails');

  List<UserProfileData> userslist = List.generate(maps.length, (i) {
    return UserProfileData(
        id: (maps[i]['id'].toString()),
        firstName: maps[i]['firstName'].toString(),
        lastName: maps[i]['lastName'].toString(),
        displayName: maps[i]['displayName'].toString(),
        phoneNumber: maps[i]['phoneNumber'].toString(),
        emailId: maps[i]['email'].toString(),
        dob: maps[i]['dateOfBirth'].toString(),
        state: maps[i]['state'].toString(),
        city: maps[i]['city'].toString(),
        zipcode: maps[i]['zipcode'].toString(),
        address: maps[i]['address'].toString(),
        country: maps[i]['country'].toString(),
        gender: maps[i]['gender'].toString(),
        avatar: maps[i]['avatar'].toString(),
        lifes: maps[i]['lifes'].toString(),
        xp: maps[i]['xp'].toString(),
        subId: maps[i]['subscrption'].toString(),
        lastused: maps[i]['lastused'].toString(),
        coins: maps[i]['coins'].toString());
  });
  print(userslist.length);
  var value = userslist.isNotEmpty;
  if (userslist.length != 0) {
    String userlifes =
        setuserLifes(userslist[0].lastused, userslist.first.lifes);
    //localUserList[0].lifes = newuserlifes;
  }
  //var lifes = (userslist.isNotEmpty) ? newuserlifes : null;
  //localUserList[0].lifes = lifes;
  //print(userslist);
  localUserList = userslist;
  return userslist;
}

String setuserLifes(datetime, userlifes) {
  DateTime compare = DateTime.parse(datetime);
  userlifes = int.parse(userlifes);
  Duration timelapse = DateTime.now().difference(compare);
  String timeasString = timelapse.toString().split(".")[0];
  int hours = int.parse(timeasString.split(':')[0]);
  int minutes = int.parse(timeasString.split(':')[1]);
  if (hours > 0 || minutes > 49) {
    userlifes = 10;
  } else if (minutes > 44) {
    userlifes = userlifes + 9;
  } else if (minutes > 39) {
    userlifes = userlifes + 8;
  } else if (minutes > 34) {
    userlifes = userlifes + 7;
  } else if (minutes > 29) {
    userlifes = userlifes + 6;
  } else if (minutes > 24) {
    userlifes = userlifes + 5;
  } else if (minutes > 19) {
    userlifes = userlifes + 4;
  } else if (minutes > 14) {
    userlifes = userlifes + 3;
  } else if (minutes > 9) {
    userlifes = userlifes + 2;
  } else if (minutes > 4) {
    userlifes = userlifes + 1;
  }
  if (userlifes > 10) {
    userlifes = 10;
  }
  return userlifes.toString();
}

Future<void> deleteUserDetails() async {
  final db = await opendatabase;
  await db.delete('userDetails');
  debugPrint('users list is deleted');
}

Future<void> updateUser(UserProfileData editUser) async {
  final db = await opendatabase;

  await db.update(
    'userDetails',
    editUser.toMap(),

    where: 'phoneNumber = ?',
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs: [editUser.phoneNumber],
  );
}

Future<void> updateXP(xp, id) async {
  final db = await opendatabase;

  await db
      .rawUpdate('UPDATE userDetails SET xp = xp + ? WHERE id = ?', [xp, id]);

  print('updated  $xp, in $id');
}

Future<void> updateLIFES(lifes, lastused, id) async {
  final db = await opendatabase;

  await db.rawUpdate('UPDATE userDetails SET lifes=?, lastused=? WHERE id = ?',
      [lifes, lastused, id]);

  print('updated  $lifes,$lastused in $id');
}
