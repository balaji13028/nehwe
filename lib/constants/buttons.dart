import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'color_palettes.dart';

hintButton(context) {
  Size size = MediaQuery.of(context).size;
  return Container(
    height: size.height * 0.055,
    width: size.width * 0.13,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 2, color: ColorPalette.primarycolor)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/hint_icon1.svg',
          width: 20,
          color: ColorPalette.primarycolor,
        ),
        const Text(
          'Hint',
          style: TextStyle(fontSize: 10, color: ColorPalette.textcolor),
        )
      ],
    ),
  );
}

submitButton(context) {
  Size size = MediaQuery.of(context).size;
  return Container(
    height: size.height * 0.048,
    width: size.width * 0.7,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorPalette.primarycolor),
    child: const Text(
      'Submit',
      style: TextStyle(
          color: ColorPalette.whitetextcolor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          letterSpacing: 1),
    ),
  );
}

testSubmitButton(context) {
  Size size = MediaQuery.of(context).size;
  return Container(
    height: size.height * 0.048,
    width: size.width,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorPalette.primarycolor),
    child: const Text(
      'Submit',
      style: TextStyle(
          color: ColorPalette.whitetextcolor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          letterSpacing: 1),
    ),
  );
}

glossaryButton(context) {
  Size size = MediaQuery.of(context).size;
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        height: size.height * 0.22,
        width: size.width * 0.05,
        color: Colors.transparent,
      ),
      Container(
          height: size.height * 0.22,
          width: size.width * 0.05,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  bottomLeft: Radius.circular(25)),
              color: ColorPalette.textcolor.withOpacity(0.7)),
          child: const Text(
            'G\nL\nO\nS\nS\nA\nR\nY',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: ColorPalette.whitetextcolor),
          )),
    ],
  );
}
