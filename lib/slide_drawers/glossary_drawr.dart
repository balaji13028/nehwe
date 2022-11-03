import 'package:flutter/material.dart';
import 'package:nehwe/models/courses_model.dart';
import '../constants/color_palettes.dart';

// ignore: must_be_immutable
class GlossaryDrawer extends StatelessWidget {
  ScreenData glossary;
  GlossaryDrawer({super.key, required this.glossary});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        height: size.height * 0.55,
        width: size.width * 0.78,
        child: Drawer(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
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
        ));
  }
}
