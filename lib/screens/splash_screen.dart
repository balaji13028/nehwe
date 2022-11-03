import 'package:flutter/material.dart';
import 'package:nehwe/models/user_intime.dart';
import 'package:nehwe/screens/welcome_screen.dart';

import 'package:splash_screen_view/SplashScreenView.dart';
import '../api_calls/course_api.dart';
import '../constants/color_palettes.dart';
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
    //debugPrint('useras are $localUserList');

    return SplashScreenView(
        imageSrc: 'assets/images/ic_launcher.png',
        navigateRoute:
            (localUserList.isEmpty) ? const WelcomePage() : const DashBoard(),
        text: 'Nehwe',
        speed: 350,
        textStyle: const TextStyle(
            fontSize: 60,
            color: ColorPalette.whitetextcolor,
            fontWeight: FontWeight.bold),
        textType: TextType.TyperAnimatedText,
        duration: 2800,
        imageSize: 220,
        backgroundColor: ColorPalette.primarycolor);
  }
}
