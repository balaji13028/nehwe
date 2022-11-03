import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/color_palettes.dart';

class BuddieAdd extends StatefulWidget {
  const BuddieAdd({Key? key}) : super(key: key);

  @override
  State<BuddieAdd> createState() => _BuddieAddState();
}

class _BuddieAddState extends State<BuddieAdd> {
  bool statusBuddy = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var totalHeight = size.height;
    var upperContainerheight = size.height * 0.4;
    return Scaffold(
      backgroundColor: ColorPalette.backgroundcolor2,
      body: Column(
        children: [
          Container(
            height: upperContainerheight,
            padding:
                EdgeInsets.only(top: size.height * 0.06, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      color: ColorPalette.primarycolor,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  CircleAvatar(
                    radius: 50,
                    child: Image.asset(
                      'assets/images/avatar1.png',
                      fit: BoxFit.fill,
                      width: 130,
                      height: 130,
                    ),
                  ),
                ]),
                SizedBox(height: size.height * 0.02),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Mahamadou_Lovel',
                        style: TextStyle(
                            fontSize: 20,
                            color: ColorPalette.primarycolor,
                            fontWeight: FontWeight.w600),
                      ),
                    ]),
              ],
            ),
          ),
          Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            children: [
              Container(
                height: totalHeight - upperContainerheight,
                width: double.infinity,
                padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
                decoration: const BoxDecoration(
                    color: ColorPalette.whitetextcolor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            height: 110,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorPalette.backgroundcolor2
                                    .withOpacity(0.6)),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/steak_icon.svg',
                                    color: const Color(0xffFF4D00),
                                  ),
                                  const Text(
                                    '3',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: ColorPalette.secondarycolor),
                                  ),
                                  const Text(
                                    'Day Streaks',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: ColorPalette.primarycolor),
                                  )
                                ])),
                        Container(
                            height: 110,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorPalette.backgroundcolor2
                                    .withOpacity(0.6)),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/xp_icon.svg',
                                    color:
                                        const Color.fromARGB(255, 222, 216, 44),
                                  ),
                                  const Text(
                                    '25',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: ColorPalette.secondarycolor),
                                  ),
                                  const Text(
                                    'Xp',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: ColorPalette.primarycolor),
                                  )
                                ])),
                        Container(
                            height: 110,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorPalette.backgroundcolor2
                                    .withOpacity(0.6)),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: const [
                                  Icon(
                                    Icons.people_sharp,
                                    size: 32,
                                    color: Color.fromARGB(255, 7, 92, 167),
                                  ),
                                  Text(
                                    '1',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: ColorPalette.secondarycolor),
                                  ),
                                  Text(
                                    'Buddies',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: ColorPalette.primarycolor),
                                  )
                                ])),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    Row(
                      children: const [
                        Text(
                          'Courses ',
                          style: TextStyle(
                            color: ColorPalette.secondarycolor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: size.height * 0.06,
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                        top: 10,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorPalette.backgroundcolor2.withOpacity(0.8),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/icons/communication.png',
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Communication',
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: ColorPalette.primarycolor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SvgPicture.asset(
                              'assets/icons/badge_icon.svg',
                            ),
                          ]),
                    ),
                    Container(
                      height: size.height * 0.06,
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorPalette.backgroundcolor2.withOpacity(0.8),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Row(
                                children: [
                                  Image.asset('assets/icons/uk_flag.png'),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      'English',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: ColorPalette.primarycolor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -28,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      statusBuddy = !statusBuddy;
                    });
                  },
                  child: Card(
                    borderOnForeground: false,
                    semanticContainer: false,
                    color: const Color.fromARGB(255, 154, 197, 128),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                        height: 45,
                        width: 180,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: (statusBuddy == true)
                                ? ColorPalette.rightAnsFillcolor
                                : ColorPalette.greenColor),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              (statusBuddy == true)
                                  ? const Icon(Icons.check,
                                      size: 28, color: ColorPalette.greenColor)
                                  : const Icon(Icons.add,
                                      size: 28,
                                      color: ColorPalette.whitetextcolor),
                              const SizedBox(
                                width: 10,
                              ),
                              (statusBuddy == true)
                                  ? const Text(
                                      'Added',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: ColorPalette.greenColor),
                                    )
                                  : const Text(
                                      'Add Buddy',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: ColorPalette.whitetextcolor),
                                    ),
                            ])),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
