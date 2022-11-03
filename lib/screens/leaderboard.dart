import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:nehwe/loadings/loader.dart';
import 'package:nehwe/notifications/notifications.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../constants/color_palettes.dart';
import '../help_support/help_support.dart';
import '../leader_board/rank_level_page.dart';
import '../profile_pages/user_badges.dart';

enum MenuItem { item1, item2 }

class LeaderBaord extends StatefulWidget {
  const LeaderBaord({Key? key}) : super(key: key);

  @override
  State<LeaderBaord> createState() => _LeaderBaordState();
}

class _LeaderBaordState extends State<LeaderBaord> {
  bool onmissions = true;
  bool onbadges = false;
  bool _isLoaderVisible = false;
  loader() async {
    if (_isLoaderVisible) {
      context.loaderOverlay.show();
    } else {
      context.loaderOverlay.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(children: [
      GlobalLoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: const Loader(),
        child: Container(
            height: size.height * 0.25,
            color: ColorPalette.primarycolor,
            padding: EdgeInsets.only(
                left: size.height * 0.02,
                right: size.height * 0.02,
                top: size.height * 0.08,
                bottom: size.height * 0.02),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Leader Board',
                          style: TextStyle(
                              color: ColorPalette.whitetextcolor,
                              letterSpacing: 0.9,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (onmissions = !onmissions) {
                              onmissions = true;
                              onbadges = false;
                            }
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: onmissions
                                  ? ColorPalette.whitetextcolor
                                  : ColorPalette.primarycolor.withOpacity(0.0)),
                          child: Text(
                            'Missions',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.8,
                                color: onmissions
                                    ? ColorPalette.secondarycolor
                                    : ColorPalette.whitetextcolor),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (onbadges = !onbadges) {
                              onmissions = false;
                              onbadges = true;
                            }
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: onbadges
                                  ? ColorPalette.whitetextcolor
                                  : ColorPalette.primarycolor.withOpacity(0.0)),
                          child: Text(
                            'Badges',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.8,
                                color: onbadges
                                    ? ColorPalette.secondarycolor
                                    : ColorPalette.whitetextcolor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ])),
      ),
      SingleChildScrollView(
        child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
            decoration: const BoxDecoration(
                color: ColorPalette.whitetextcolor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Column(children: [
              if (onmissions == true)
                missons()
              else if (onbadges == true)
                const UserBadges()
            ])),
      ),
    ]);
  }

  Widget missons() {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const UserLevelRank())));
      },
      child: Container(
        height: size.height * 0.1,
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 30),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorPalette.backgroundcolor2.withOpacity(0.8),
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
            child: Row(
              children: [
                Image.asset('assets/images/rank1_badge.png'),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'Rank 3',
                        style: TextStyle(
                            fontSize: 18,
                            color: ColorPalette.secondarycolor,
                            fontWeight: FontWeight.w600),
                      ),
                      const Text(
                        'Completed 3/10 levels',
                        style: TextStyle(
                            fontSize: 14,
                            color: ColorPalette.secondarycolor,
                            fontWeight: FontWeight.w500),
                      ),
                      LinearPercentIndicator(
                        width: 200,
                        lineHeight: 10,
                        percent: 0.3,
                        barRadius: const Radius.circular(10),
                        backgroundColor: ColorPalette.statusfillcolor,
                        progressColor: ColorPalette.secondarycolor,
                        padding: const EdgeInsets.symmetric(
                          vertical: 1,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: ColorPalette.secondarycolor,
            size: 18,
          )
        ]),
      ),
    );
  }
}
