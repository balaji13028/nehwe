import 'package:flutter/material.dart';
import 'package:nehwe/api_calls/lifes_api.dart';
import 'package:nehwe/local_database.dart';
import '../constants/color_palettes.dart';
import '../models/user_details_model.dart';

confirmTOExit(BuildContext context, navigationPage) {
  Size size = MediaQuery.of(context).size;
  UserProfileData user = localUserList[0];
  return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            backgroundColor: ColorPalette.backgroundcolor2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: size.height * 0.25,
                width: size.width * 0.5,
                child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topCenter,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: size.height * 0.07),
                            const Text(
                              'Are you sure you want to Quit ?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: ColorPalette.textcolor),
                            ),
                            const Text(
                              'You will lose one life and your progress',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12, color: ColorPalette.textcolor),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                    style: ButtonStyle(
                                      overlayColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => Colors.transparent),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: ColorPalette.secondarycolor),
                                    )),
                                TextButton(
                                    style: ButtonStyle(
                                      overlayColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => Colors.transparent),
                                    ),
                                    onPressed: () async {
                                      var lifes = int.parse(user.lifes!);
                                      newUser.lifes = (lifes - 1).toString();
                                      user.lifes = newUser.lifes;
                                      await updateLifes(
                                          user.id,
                                          user.lifes,
                                          DateTime
                                              .now()); //update lifes to server
                                      await updateLIFES(
                                          user.id,
                                          user.lifes,
                                          DateTime.now()
                                              .toString()); //update lifes in local db.
                                      // ignore: use_build_context_synchronously
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                              pageBuilder: ((context, animation,
                                                      secondaryAnimation) =>
                                                  navigationPage)));
                                    },
                                    child: const Text(
                                      'Quit',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: ColorPalette.secondarycolor),
                                    ))
                              ],
                            ),
                          ]),
                      Positioned(
                          top: -110,
                          child: Image.asset(
                            'assets/mascots/telling.png',
                            width: 180,
                          ))
                    ])));
      });
}
