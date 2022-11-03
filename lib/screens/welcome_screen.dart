import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../constants/color_palettes.dart';
import 'login_screen.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: IntroductionScreen(
      scrollPhysics: const ClampingScrollPhysics(),
      globalHeader: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder:
                            ((context, animation, secondaryAnimation) =>
                                const LoginScreen())));
              },
              child: const Text('Skip',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: ColorPalette.primarycolor)),
            ),
          ),
        ],
      ),
      showBackButton: false,
      isTopSafeArea: true,
      showNextButton: true,
      showDoneButton: false,
      nextStyle: ButtonStyle(
        overlayColor:
            MaterialStateColor.resolveWith((states) => Colors.transparent),
      ),
      next: Row(mainAxisAlignment: MainAxisAlignment.end, children: const [
        Text(
          'Next',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: ColorPalette.secondarycolor),
        ),
      ]),
      dotsDecorator: DotsDecorator(
        size: const Size.square(8.0),
        activeSize: const Size(22.0, 9.0),
        activeColor: ColorPalette.secondarycolor,
        color: Colors.black26,
        spacing: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 25),
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
      pages: [
        PageViewModel(
            title: 'Online Learning Platform',
            body:
                'Choose from 100,00 online vedio courses with new additions published.',
            image: SvgPicture.asset(
              'assets/images/online_img.svg',
              fit: BoxFit.cover,
            ),
            decoration: const PageDecoration(
                titleTextStyle: TextStyle(
                    fontSize: 32,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600,
                    color: ColorPalette.textcolor),
                bodyTextStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w200,
                    color: ColorPalette.textcolor))),
        PageViewModel(
            title: 'Learn on your Schedule',
            body: 'Anywhere, anytime, Start learning today!.',
            image: SvgPicture.asset(
              'assets/images/timetolearn_img.svg',
              fit: BoxFit.cover,
            ),
            decoration: const PageDecoration(
                titleTextStyle: TextStyle(
                    fontSize: 32,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600,
                    color: ColorPalette.textcolor),
                bodyTextStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w200,
                    color: ColorPalette.textcolor))),
        PageViewModel(
            title: 'Ready to find a course?',
            body: 'Discover the online learning.',
            image: SvgPicture.asset(
              'assets/images/readytolearn_img.svg',
              fit: BoxFit.cover,
            ),
            footer: TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => Colors.transparent),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder:
                              ((context, animation, secondaryAnimation) =>
                                  const LoginScreen())));
                },
                child: Container(
                  height: 40,
                  width: double.infinity,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(vertical: 60),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: ColorPalette.gradientbutton4),
                  child: const Text(
                    'Start learning',
                    style: TextStyle(
                        color: ColorPalette.whitetextcolor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        letterSpacing: 1),
                  ),
                )),
            decoration: const PageDecoration(
                titleTextStyle: TextStyle(
                    fontSize: 32,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600,
                    color: ColorPalette.textcolor),
                bodyTextStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w200,
                    color: ColorPalette.textcolor))),
      ],
    ));
  }
}
