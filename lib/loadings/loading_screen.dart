import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constants/color_palettes.dart';

// ignore: must_be_immutable
class LoadingScreen extends StatefulWidget {
  String text;
  LoadingScreen({super.key, required this.text});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  late final AnimationController lottieController;
  @override
  void initState() {
    super.initState();
    lottieController = AnimationController(vsync: this);
    lottieController.addListener(() {});
  }

  @override
  void dispose() {
    lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: ColorPalette.backgroundcolor2,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Lottie.asset('assets/lottie/loading_buddies.json',
              controller: lottieController, onLoaded: (comp) {
            lottieController
              ..duration = const Duration(seconds: 20)
              ..forward();
          }, animate: true),
          Text(
            widget.text,
            style: const TextStyle(
                fontSize: 18,
                color: ColorPalette.primarycolor,
                fontWeight: FontWeight.bold),
          )
        ]),
      ),
    );
  }
}
