import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nehwe/constants/color_palettes.dart';
import 'package:nehwe/screens/welcome_screen.dart';
import 'package:nehwe/widgets/background.dart';

class SelectLanguage extends StatefulWidget {
  const SelectLanguage({super.key});

  @override
  State<SelectLanguage> createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
  bool ontapEN = false;
  bool ontapIT = false;

  final List locale = [
    {'name': 'ENGLISH', 'locale': Locale('en', 'US')},
    {'name': 'italian', 'locale': Locale('it', 'IT')},
  ];
  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height * 0.24,
                width: size.width * 0.5,
                alignment: Alignment.bottomCenter,
                child: SvgPicture.asset(
                  'assets/images/readytolearn_img.svg',
                  fit: BoxFit.fitWidth,
                ),
              ),
              const Text(
                'Choose Your Preferred Language',
                style: TextStyle(
                    fontSize: 22,
                    color: ColorPalette.textcolor,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                'Please select your language',
                style: TextStyle(
                  fontSize: 18,
                  color: ColorPalette.textcolor.withOpacity(0.6),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    ontapEN = true;
                    ontapIT = false;
                    print(locale[0]['name']);
                    updateLanguage(locale[0]['locale']);
                  });
                },
                child: Container(
                  height: size.height * 0.048,
                  width: size.width,
                  margin: EdgeInsets.only(
                      top: size.height * 0.06, left: 20, right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: ontapEN == true
                          ? ColorPalette.primarycolor
                          : ColorPalette.whitetextcolor,
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 0),
                            blurRadius: 0.1,
                            color: ColorPalette.textcolor)
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'English',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: ontapEN == true
                                ? ColorPalette.whitetextcolor
                                : ColorPalette.textcolor),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    ontapEN = false;
                    ontapIT = true;
                    print(locale[1]['name']);
                    updateLanguage(locale[1]['locale']);
                  });
                },
                child: Container(
                  height: size.height * 0.048,
                  width: size.width,
                  margin: EdgeInsets.only(
                      top: size.height * 0.02, left: 20, right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: ontapIT == true
                          ? ColorPalette.primarycolor
                          : ColorPalette.whitetextcolor,
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 0),
                            blurRadius: 0.1,
                            color: ColorPalette.textcolor)
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Italian',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: ontapIT == true
                                ? ColorPalette.whitetextcolor
                                : ColorPalette.textcolor),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                              pageBuilder:
                                  ((context, animation, secondaryAnimation) =>
                                      const WelcomePage())));
                    },
                    child: Expanded(
                      child: Container(
                        height: size.height * 0.05,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: ColorPalette.primarycolor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Next'.tr,
                              style: const TextStyle(
                                  color: ColorPalette.whitetextcolor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  letterSpacing: 1),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 15,
                              color: ColorPalette.whitetextcolor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
