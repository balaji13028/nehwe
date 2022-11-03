import 'package:flutter/material.dart';
import '../constants/color_palettes.dart';
import '../loadings/loading_screen.dart';

confirmToChallenge(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          title: const Text('Confirmation!'),
          titleTextStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ColorPalette.textcolor),
          content: const Text(
            'Are you sure you want to take challenge ?',
            style: TextStyle(
                fontSize: 14,
                //fontWeight: FontWeight.bold,
                color: ColorPalette.textcolor),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => Colors.transparent),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'NO',
                      style: TextStyle(
                          fontSize: 18, color: ColorPalette.secondarycolor),
                    )),
                TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => Colors.transparent),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => LoadingScreen(
                                  text: 'Searching for buddies'))));
                    },
                    child: const Text(
                      'YES',
                      style: TextStyle(
                          fontSize: 18, color: ColorPalette.secondarycolor),
                    ))
              ],
            ),
          ],
        );
      });
}
