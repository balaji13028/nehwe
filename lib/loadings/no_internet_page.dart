import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoInternet extends StatefulWidget {
  const NoInternet({
    super.key,
  });

  @override
  State<NoInternet> createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> with TickerProviderStateMixin {
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
        Lottie.asset('assets/lottie/no_internet.json',
            repeat: true, animate: true),
      ]),
    );
  }
}
