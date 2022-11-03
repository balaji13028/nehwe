import 'package:flutter/material.dart';

import '../api_calls/lifes_api.dart';
import '../constants/color_palettes.dart';
import '../local_database.dart';
import '../models/user_details_model.dart';

hintDisplay(BuildContext context, hint) {
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
            width: size.width * 0.4,
            child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: size.height * 0.02),
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
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () async {
                        await updateLifes(newUser.id, user.lifes,
                            DateTime.now()); //update lifes to server
                        await updateLIFES(
                            newUser.id,
                            user.lifes,
                            DateTime.now()
                                .toString()); //update lifes in local db.
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 35,
                        width: 120,
                        margin: const EdgeInsets.only(bottom: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(220),
                          color: ColorPalette.primarycolor,
                        ),
                        child: const Text(
                          'Ok',
                          style: TextStyle(
                              fontSize: 16,
                              color: ColorPalette.whitetextcolor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: -120,
                      child: Image.asset(
                        'assets/mascots/telling.png',
                        width: 180,
                      ))
                ]),
          ),
        );
      });
}
