import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';
import '../constants/color_palettes.dart';
import '../help_support/help_support.dart';

class UserLevelRank extends StatefulWidget {
  const UserLevelRank({Key? key}) : super(key: key);

  @override
  State<UserLevelRank> createState() => _UserLevelRankState();
}

class _UserLevelRankState extends State<UserLevelRank> {
  bool status = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorPalette.backgroundcolor2,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: size.height * 0.44,
            padding: EdgeInsets.only(
              top: size.height * 0.07,
              left: size.width * 0.04,
              right: size.width * 0.04,
            ),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: ColorPalette.whitetextcolor,
                              borderRadius: BorderRadius.circular(6)),
                          child: const Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: ColorPalette.textcolor,
                          ),
                        ),
                      ),
                      const Text(
                        'Levels',
                        style: TextStyle(
                            color: ColorPalette.secondarycolor,
                            letterSpacing: 0.9,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const HelpSupport())));
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: ColorPalette.whitetextcolor,
                              borderRadius: BorderRadius.circular(6)),
                          child: const Icon(
                            Icons.question_mark,
                            color: ColorPalette.textcolor,
                          ),
                        ),
                      ),
                    ]),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Image.asset('assets/badges/level_1.png'),
                ),
                const Text(
                  'Level 3',
                  style: TextStyle(
                      color: ColorPalette.secondarycolor,
                      letterSpacing: 0.9,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  height: 20,
                  width: 80,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ColorPalette.whitetextcolor),
                  child: const Text('140 xp'),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: size.height * 0.04),
              decoration: const BoxDecoration(
                color: ColorPalette.whitetextcolor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 10,
                          width: size.width * 0.5,
                          color: ColorPalette.primarycolor,
                          //margin: const EdgeInsets.only(top: 10),
                        ),
                        SizedBox(height: size.height * 0.0865),
                        leftside(2, 'Keep Going', true,
                            ColorPalette.backgroundcolor2),
                        SizedBox(height: size.height * 0.0865),
                        leftside(
                            4, 'The Pro', true, ColorPalette.backgroundcolor2),
                        SizedBox(height: size.height * 0.0865),
                        leftside(6, 'Unstoppable', true,
                            ColorPalette.backgroundcolor2),
                        SizedBox(height: size.height * 0.0865),
                        leftside(8, 'Unstoppable', true,
                            ColorPalette.backgroundcolor2),
                        SizedBox(height: size.height * 0.0865),
                        leftside(10, 'Unstoppable', true,
                            ColorPalette.backgroundcolor2),
                        SizedBox(height: size.height * 0.0865),
                      ],
                    ),
                    // Column(
                    //   children: [
                    //     const SizedBox(
                    //       height: 5,
                    //     ),
                    //     center('1', true),
                    //     SizedBox(height: size.height * 0.088),
                    //     center('2', true),
                    //     SizedBox(height: size.height * 0.089),
                    //     center('3', true),
                    //     SizedBox(height: size.height * 0.089),
                    //     center('4', false),
                    //     SizedBox(height: size.height * 0.089),
                    //     center('5', false),
                    //     SizedBox(height: size.height * 0.089),
                    //     center('6', false),
                    //     SizedBox(height: size.height * 0.089),
                    //     center('7', false),
                    //     SizedBox(height: size.height * 0.089),
                    //     center('8', false),
                    //     SizedBox(height: size.height * 0.089),
                    //     center('9', false),
                    //     SizedBox(height: size.height * 0.089),
                    //     center('10', false),
                    //     SizedBox(height: size.height * 0.088),
                    //     center('D', false)
                    //   ],
                    // ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        rightside(
                            1, 'Starter', true, ColorPalette.backgroundcolor2),
                        SizedBox(height: size.height * 0.0865),
                        rightside(3, 'The Ninja', true,
                            ColorPalette.backgroundcolor2),
                        SizedBox(height: size.height * 0.0865),
                        rightside(5, 'The Pro Max', true,
                            ColorPalette.backgroundcolor2),
                        SizedBox(height: size.height * 0.0865),
                        rightside(7, 'The Pro Max', true,
                            ColorPalette.backgroundcolor2),
                        SizedBox(height: size.height * 0.0865),
                        rightside(9, 'The Pro Max', true,
                            ColorPalette.backgroundcolor2),
                        SizedBox(height: size.height * 0.0865),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget center(String level, st) {
    return Container(
      height: 20,
      width: 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: (status = st)
              ? ColorPalette.secondarycolor
              : ColorPalette.searchbarcolor,
          borderRadius: BorderRadius.circular(20)),
      child: Text(
        level,
        style: TextStyle(
            color: (status = st)
                ? ColorPalette.whitetextcolor
                : ColorPalette.exiticoncolor,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget rightside(int levelNo, String levelName, st, Color color) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.11,
      width: size.width * 0.40,
      padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
      margin: EdgeInsets.only(right: size.width * 0.04),
      decoration: BoxDecoration(
          color: (status = st)
              ? ColorPalette.primarycolor
              : ColorPalette.backgroundcolor2,
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(50), topRight: Radius.circular(50))),
      child: Container(
        height: 90,
        decoration: const BoxDecoration(
            color: ColorPalette.whitetextcolor,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
                topRight: Radius.circular(50))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      'Level $levelNo',
                      style: const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.w500),
                    ),
                    (status = st)
                        ? const Icon(
                            Icons.check_circle,
                            size: 18,
                            color: ColorPalette.rightAnstextlcolor,
                          )
                        : const Icon(
                            Icons.lock,
                            size: 18,
                            color: Color.fromARGB(255, 248, 133, 83),
                          )
                  ],
                ),
                Visibility(
                  visible: status = st,
                  child: Text(levelName,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/flag_img.png',
                  width: 60,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget leftside(int levelNo, String levelName, st, Color color) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.11,
      width: size.width * 0.4,
      margin: EdgeInsets.only(left: size.width * 0.05),
      padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
      decoration: BoxDecoration(
          color: (status = st)
              ? ColorPalette.primarycolor
              : ColorPalette.backgroundcolor2,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50), topLeft: Radius.circular(50))),
      child: Container(
        decoration: const BoxDecoration(
            color: ColorPalette.whitetextcolor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50), topLeft: Radius.circular(50))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              'assets/icons/ninja_img.png',
              width: 40,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      'Level $levelNo',
                      style: const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.w500),
                    ),
                    (status = st)
                        ? const Icon(
                            Icons.check_circle,
                            size: 18,
                            color: ColorPalette.rightAnstextlcolor,
                          )
                        : const Icon(
                            Icons.lock,
                            size: 18,
                            color: Color.fromARGB(255, 248, 133, 83),
                          )
                  ],
                ),
                Visibility(
                  visible: status = st,
                  child: Text(levelName,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
