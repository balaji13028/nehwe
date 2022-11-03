import 'package:flutter/material.dart';

import '../constants/color_palettes.dart';

screenAreNotAsssigned(BuildContext context) {
  Size size = MediaQuery.of(context).size;
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
                      SizedBox(height: size.height * 0.08),
                      const Text(
                        'Alert!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorPalette.textcolor),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          'Screens are not assigned, we updated soon!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14, color: ColorPalette.textcolor),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 35,
                          width: 120,
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
                      )
                    ],
                  ),
                  Positioned(
                      top: -100,
                      child: Image.asset('assets/mascots/on_progress.png',
                          width: 180))
                ]),
          ),
        );
      });
}
