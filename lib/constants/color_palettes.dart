import 'package:flutter/material.dart';

class ColorPalette {
  static const Color primarycolor = Color(0xFF26a2d6);

  static const Color secondarycolor = Color(0xFF308FB7);

  static const Color backgroundcolor1 = Color(0xFF6EC1E4);

  static const Color backgroundcolor2 = Color(0xFFDEF5FF);

  static const Color rightAnsFillcolor = Color.fromARGB(236, 231, 245, 207);

  static const Color rightAnsButtoncolor = Color.fromARGB(203, 91, 141, 10);

  static const Color rightAnstextlcolor = Color.fromARGB(255, 53, 123, 54);

  static const Color wrongAnsFillcolor = Color(0xfffeccca);

  static const Color wrongAnstextcolor = Color(0xffB90600);

  static const Color wrongAnsButtoncolor = Color(0xffDE4B33);

  static const Color statusfillcolor = Color(0xFFD0D0D0);

  static const Color textcolor = Color(0xFF4B4B4B);

  static const Color lifescolor = Color(0xFFB81D13);

  static const Color exiticoncolor = Color(0xff878787);

  static const Color whitetextcolor = Color(0xffFFFFFF);

  static const Color searchbarcolor = Color(0xffEEEEEE);

  static const Color xpiconcolor = Color(0xfff38300);

  static const Color lessonActiveInner = Color(0xfff8e145);

  static const Color lessonNotActiveOuter = Color(0xffffe577);

  static const Color lessonNotActiveInner = Color(0xfffff297);

  static const Color conceptInActiveInner = Color(0xffABDBD2);

  static const Color conceptInActiveOutter = Color(0xff95DBCE);

  static const Color greenColor =
      Color(0xff51BB11); //some text will be in green color.

  static const Gradient gradientbutton1 = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xff6EC1E4), Color(0xff26A2D6)]);

  static const Gradient gradientbutton4 = LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
      colors: [Color(0xff6EC1E4), Color(0xff26A2D6)]);

  static const Gradient statusbargradient = LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topRight,
      colors: [Color(0x666EC1E4), Color(0xff26A2D6)]);
}
