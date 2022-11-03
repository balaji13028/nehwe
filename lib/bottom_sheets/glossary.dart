import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/color_palettes.dart';
import '../models/courses_model.dart';

// ignore: must_be_immutable
class Glossary extends StatelessWidget {
  ScreenData glossary;
  Glossary({super.key, required this.glossary});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
        height: size.height,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: ColorPalette.whitetextcolor,
        ),
        padding: EdgeInsets.only(
          left: size.width * 0.05,
          right: size.width * 0.05,
          top: size.width * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Glossary :',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ColorPalette.secondarycolor),
            ),
            Text(glossary.gsHeading!),
            Text(glossary.gsDescription!),
            Text(glossary.gsExample!)
          ],
        ),
      ),
    );
  }
}
