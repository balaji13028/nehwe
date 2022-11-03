import 'package:flutter/material.dart';
import '../constants/color_palettes.dart';

class UserBadges extends StatefulWidget {
  const UserBadges({Key? key}) : super(key: key);

  @override
  State<UserBadges> createState() => _UserBadgesState();
}

class _UserBadgesState extends State<UserBadges> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      crossAxisCount: 3,
      shrinkWrap: true,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 2,
      physics: const ClampingScrollPhysics(),
      controller: ScrollController(keepScrollOffset: false),
      children: [
        GestureDetector(
            onTap: () {
              displayPopup('assets/badges/level_1.png');
            },
            child: badgesgridView('assets/badges/rank_1.png', 1)),
        GestureDetector(
            onTap: () {
              displayPopup('assets/badges/level_2.png');
            },
            child: badgesgridView('assets/badges/rank_2.png', 2)),
        GestureDetector(
            onTap: () {
              displayPopup('assets/badges/level_3.png');
            },
            child: badgesgridView('assets/badges/rank_3.png', 3)),
        GestureDetector(
            onTap: () {
              displayPopup('assets/badges/level_4.png');
            },
            child: badgesgridView('assets/badges/rank_4.png', 4)),
        GestureDetector(
            onTap: () {
              displayPopup('assets/badges/level_5.png');
            },
            child: badgesgridView('assets/badges/rank_5.png', 5)),
      ],
    );
  }

  Container badgesgridView(String image, int rankNo) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorPalette.backgroundcolor2.withOpacity(1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 25,
          ),
          const SizedBox(
            width: 6,
          ),
          Text(
            'Rank $rankNo',
            style: const TextStyle(
                fontSize: 14,
                color: ColorPalette.secondarycolor,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Future displayPopup(String badge) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: ColorPalette.backgroundcolor2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: 260,
                    width: 300,
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 60, bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Congratulations',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: ColorPalette.greenColor),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 15, bottom: 40),
                          child: Text(
                            'You have earned this badge by completing level 1 successfully.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14, color: ColorPalette.textcolor),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 35,
                            width: 140,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(220),
                              color: ColorPalette.primarycolor,
                            ),
                            child: const Text(
                              'Done',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: ColorPalette.whitetextcolor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(top: -80, child: Image.asset(badge))
                ]),
          );
        });
  }
}
