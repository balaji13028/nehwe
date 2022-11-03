import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class Loader extends StatefulWidget {
  const Loader({
    super.key,
  });

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with TickerProviderStateMixin {
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
    return Container(
      color: Colors.white54,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Lottie.asset('assets/lottie/loader.json', repeat: true, animate: true),
      ]),
    );
  }
}
