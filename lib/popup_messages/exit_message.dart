import 'package:flutter/material.dart';
import 'package:nehwe/api_calls/lifes_api.dart';
import 'package:nehwe/local_database.dart';
import '../constants/color_palettes.dart';
import '../models/user_details_model.dart';

confirmTOExit(BuildContext context, navigationPage) {
  Size size = MediaQuery.of(context).size;
  UserProfileData user = localUserList[0];
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
            backgroundColor: ColorPalette.backgroundcolor2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: Container(
                height: size.height * 0.26,
                width: size.width * 0.3,
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: size.height * 0.09,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: ColorPalette.backgroundcolor2,
                ),
                child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topCenter,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Are you sure you want to Quit ?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: ColorPalette.textcolor),
                            ),
                            SizedBox(height: size.height * 0.004),
                            const Text(
                              'You will lose one life and progress of this concept',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12, color: ColorPalette.textcolor),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    child: Container(
                                      height: size.height * 0.035,
                                      width: size.width * 0.24,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              width: 1,
                                              color:
                                                  ColorPalette.secondarycolor)),
                                      child: const Text(
                                        'Cancle',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: ColorPalette.primarycolor),
                                      ),
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
                                    child: Container(
                                      height: size.height * 0.035,
                                      width: size.width * 0.24,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: ColorPalette.primarycolor),
                                      child: const Text(
                                        'Quit',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: ColorPalette.whitetextcolor),
                                      ),
                                    ))
                              ],
                            ),
                          ]),
                      Positioned(
                          top: -size.height * 0.2,
                          child: Image.asset(
                            'assets/mascots/telling.png',
                            width: size.width * 1,
                            height: size.height * 0.2,
                          ))
                    ])));
      });
}
