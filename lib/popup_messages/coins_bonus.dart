import 'package:flutter/material.dart';

import '../constants/color_palettes.dart';

bounceCoins(BuildContext context, String coins) {
  return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: ColorPalette.backgroundcolor2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 260,
                  width: 300,
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 60, bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Congratulations',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorPalette.greenColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 40),
                        child: Text(
                          'You have earned $coins coins for signup bonus.',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 14, color: ColorPalette.textcolor),
                        ),
                      ),
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
                ),
                Positioned(
                    top: -80, child: Image.asset('assets/mascots/coins.png'))
              ]),
        );
      });
}
