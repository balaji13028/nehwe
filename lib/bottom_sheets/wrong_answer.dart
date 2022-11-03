import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:nehwe/models/user_details_model.dart';
import '../api_calls/lifes_api.dart';
import '../constants/color_palettes.dart';
import '../courses/concpets_screen.dart';
import '../local_database.dart';
import '../models/courses_model.dart';

// ignore: must_be_immutable
class WrongAnswer extends StatelessWidget {
  ScreenData screendata;
  int index;
  WrongAnswer({super.key, required this.index, required this.screendata});
  UserProfileData user = localUserList[0];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: SizedBox(
        child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topLeft,
            children: [
              Container(
                height: size.height * 0.28,
                padding: EdgeInsets.symmetric(
                    horizontal: size.height * 0.02,
                    vertical: size.height * 0.03),
                decoration: BoxDecoration(
                    color: ColorPalette.wrongAnsFillcolor.withOpacity(0.8),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: size.width * 0.4,
                        ),
                        Column(children: [
                          const Text(
                            'Incorrect',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: ColorPalette.wrongAnstextcolor),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Text(
                            'Answer :- ${screendata.answer!.first}',
                            style: const TextStyle(
                                fontSize: 16,
                                color: ColorPalette.wrongAnstextcolor,
                                fontWeight: FontWeight.w500),
                          ),
                        ])
                      ],
                    ),
                    SizedBox(height: size.height * 0.06),
                    TextButton(
                        style: ButtonStyle(
                          overlayColor: MaterialStateColor.resolveWith(
                              (states) => Colors.transparent),
                        ),
                        onPressed: () async {
                          var lifes = int.parse(newUser.lifes!);
                          newUser.lifes = (lifes - 1).toString();
                          user.lifes = newUser.lifes;
                          await updateLifes(newUser.id, user.lifes,
                              DateTime.now()); //update lifes to server
                          await updateLIFES(
                              newUser.id,
                              user.lifes,
                              DateTime.now()
                                  .toString()); //update lifes in local db.
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Lessons(
                                        unit: newunit,
                                        lesson: newlesson,
                                        course: newcourse,
                                      )));
                        },
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: ColorPalette.wrongAnsButtoncolor),
                          child: const Text(
                            'Exit',
                            style: TextStyle(
                                color: ColorPalette.whitetextcolor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                letterSpacing: 1),
                          ),
                        )),
                  ],
                ),
              ),
              Positioned(
                  bottom: size.height * 0.2,
                  child: Column(
                    children: [
                      Image.asset('assets/mascots/wrong_ans.png'),
                    ],
                  )),
            ]),
      ),
    );
  }
}
