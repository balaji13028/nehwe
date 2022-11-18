import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nehwe/models/user_intime.dart';
import 'package:nehwe/screens/welcome_screen.dart';
import '../api_calls/course_api.dart';
import '../loadings/loader.dart';
import '../local_database.dart';
import '../models/user_details_model.dart';
import 'dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _hasdata = false;
  @override
  void initState() {
    userTiming.intime = DateTime.now().toString();
    super.initState();
    myfunction();
    Timer(Duration(milliseconds: 2200.toInt()), () {
      (localUserList.isEmpty)
          ? Navigator.pushReplacement(context,
              MaterialPageRoute(builder: ((context) => const WelcomePage())))
          : Navigator.pushReplacement(context,
              MaterialPageRoute(builder: ((context) => const DashBoard())));
    });
  }

  myfunction() async {
    await database();
    localUserList = await user();
    setState(() {
      courses();
      _hasdata = true;
    });
  }

  void courses() async {
    if (localUserList.isNotEmpty) await coursesList(localUserList[0].id);
  }

  @override
  Widget build(BuildContext context) {
    if (_hasdata == false) {
      return const Loader();
    }
    debugPrint('useras are $localUserList');
    return Image.asset(
      'assets/gifs/splash_screen.gif',
      fit: BoxFit.cover,
    );
    // return SplashScreenView(
    //   imageSrc: 'assets/gifs/splash.gif',
    //   imageSize: size.height.toInt(),
    //   navigateRoute:
    //       (localUserList.isEmpty) ? const WelcomePage() : const DashBoard(),
    // );
  }
}
