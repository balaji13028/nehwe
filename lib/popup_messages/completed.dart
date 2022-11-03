import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../constants/color_palettes.dart';
import '../loadings/loader.dart';

bool _isLoaderVisible = false;
loader(BuildContext context) async {
  if (_isLoaderVisible) {
    context.loaderOverlay.show();
  } else {
    context.loaderOverlay.hide();
  }
}

completed(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return showDialog(
      barrierDismissible: false,
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
                  child: SizedBox(
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
                                'Congratulations',
                                //textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: ColorPalette.greenColor),
                              ),
                              const Text(
                                'You already completed this concept!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: ColorPalette.textcolor),
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
                              top: -120,
                              child: Image.asset(
                                'assets/mascots/completed.png',
                                width: 200,
                              ))
                        ]),
                  ),
                )));
      });
}
