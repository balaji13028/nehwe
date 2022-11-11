import 'package:flutter/material.dart';

import '../api_calls/lifes_api.dart';
import '../constants/color_palettes.dart';
import '../local_database.dart';
import '../models/user_details_model.dart';

hintDisplay(BuildContext context, hint) {
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
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: size.height * 0.09,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: ColorPalette.backgroundcolor2,
            ),
            height: size.height * 0.26,
            width: size.width * 0.3,
            child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Hint!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorPalette.secondarycolor),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Text(
                        hint,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 16, color: ColorPalette.textcolor),
                      ),
                      SizedBox(height: size.height * 0.03),
                      GestureDetector(
                        onTap: () async {
                          await updateLifes(newUser.id, user.lifes,
                              DateTime.now()); //update lifes to server
                          await updateLIFES(
                              newUser.id,
                              user.lifes,
                              DateTime.now()
                                  .toString()); //update lifes in local db.
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: size.height * 0.035,
                          width: size.width * 0.24,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: ColorPalette.primarycolor),
                          child: const Text(
                            'Done',
                            style: TextStyle(
                                fontSize: 18,
                                color: ColorPalette.whitetextcolor),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  Positioned(
                      top: -size.height * 0.18,
                      child: Image.asset(
                        'assets/mascots/telling.png',
                        width: size.width * 0.9,
                        height: size.height * 0.18,
                      ))
                ]),
          ),
        );
      });
}
