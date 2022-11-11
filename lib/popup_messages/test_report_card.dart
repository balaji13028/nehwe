import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:nehwe/api_calls/test_api.dart';
import 'package:nehwe/courses/units_screen.dart';
import 'package:nehwe/local_database.dart';
import 'package:nehwe/models/user_details_model.dart';
import '../api_calls/units_api.dart';
import '../api_calls/xp_api.dart';
import '../constants/color_palettes.dart';
import '../loadings/loader.dart';
import '../models/courses_model.dart';

bool _isLoaderVisible = false;
loader(BuildContext context) async {
  if (_isLoaderVisible) {
    context.loaderOverlay.show();
  } else {
    context.loaderOverlay.hide();
  }
}

testReport(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return GlobalLoaderOverlay(
          useDefaultLoading: false,
          overlayWidget: const Loader(),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Dialog(
              backgroundColor: ColorPalette.backgroundcolor2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              child: Container(
                height: size.height * 0.32,
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
                            'Congratulations!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: ColorPalette.greenColor),
                          ),
                          SizedBox(height: size.height * 0.004),
                          const Text(
                            'You have completed this test successfully.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16, color: ColorPalette.textcolor),
                          ),
                          SizedBox(height: size.height * 0.008),
                          Row(
                            children: [
                              const Text(
                                'Accuracy',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: ColorPalette.secondarycolor),
                              ),
                              SizedBox(width: size.width * 0.045),
                              const Text(
                                '100%',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: ColorPalette.textcolor),
                              )
                            ],
                          ),
                          SizedBox(height: size.height * 0.01),
                          Row(
                            children: [
                              const Text(
                                'Earned xp ',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: ColorPalette.secondarycolor),
                              ),
                              SizedBox(width: size.width * 0.02),
                              Text(
                                '${newunit.unitXP}/${newunit.unitXP}',
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: ColorPalette.textcolor),
                              )
                            ],
                          ),
                          SizedBox(height: size.height * 0.03),
                          GestureDetector(
                            onTap: () async {
                              _isLoaderVisible = true;
                              loader(context);
                              await updateTestStatus(
                                newcourse.courseId,
                                newunit.unitId,
                                '1',
                                newUser.id,
                                newscreen.testId,
                              ); //send reponse to server(test is completed).
                              await unitsList(newcourse.courseId,
                                  newUser.id); //retrive the units from server.
                              await updateUserXP(newUser.id,
                                  newunit.unitXP); //earned xp is send to server
                              await updateXP(newunit.unitXP,
                                  newUser.id); //update xp in local db
                              await user(); //retrieve user details from localDB.

                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          Units(course: newcourse))));
                            },
                            child: Container(
                              height: size.height * 0.035,
                              width: size.width * 0.25,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(220),
                                color: ColorPalette.primarycolor,
                              ),
                              child: const Text(
                                'Done',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: ColorPalette.whitetextcolor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                      Positioned(
                          top: -size.height * 0.25,
                          child: Image.asset(
                            'assets/mascots/completed.png',
                            width: size.width * 1.5,
                            height: size.height * 0.25,
                          ))
                    ]),
              ),
            ),
          ),
        );
      });
}
