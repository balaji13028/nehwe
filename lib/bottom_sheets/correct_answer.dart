import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/color_palettes.dart';
import '../prepare_screen_list/concept_screens/concept_prepare_ScreenList.dart';

// ignore: must_be_immutable
class CorrectAnswer extends StatelessWidget {
  int index;
  CorrectAnswer({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topRight,
          children: [
            Container(
              height: size.height * 0.28,
              padding: EdgeInsets.symmetric(
                  horizontal: size.height * 0.02, vertical: size.height * 0.04),
              decoration: BoxDecoration(
                  color: ColorPalette.rightAnsFillcolor.withOpacity(0.9),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Great Job!',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: ColorPalette.rightAnstextlcolor,
                        letterSpacing: 0.9),
                  ),
                  SizedBox(height: size.height * 0.07),
                  TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => Colors.transparent),
                      ),
                      onPressed: () {
                        var indx = index + 1;
                        navigatetoScreen(context, indx);
                      },
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: ColorPalette.rightAnsButtoncolor),
                        child: const Text(
                          'Next Question',
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
                bottom: size.height * 0.18,
                child: Column(
                  children: [
                    Image.asset('assets/mascots/correct_ans.png'),
                  ],
                )),
            Positioned(
                top: size.height * 0.07,
                child: Container(
                  height: 1,
                  width: size.height * 0.24,
                  decoration: const BoxDecoration(
                      //
                      boxShadow: [
                        BoxShadow(
                            color: ColorPalette.textcolor,
                            blurRadius: 7,
                            offset: Offset(1, 1))
                      ]),
                ))
          ]),
    );
  }
}
