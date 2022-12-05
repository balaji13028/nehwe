import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../constants/color_palettes.dart';
import '../leader_board/rank_level_page.dart';

class MyRewards extends StatefulWidget {
  const MyRewards({super.key});

  @override
  State<MyRewards> createState() => _MyRewardsState();
}

class _MyRewardsState extends State<MyRewards> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.backgroundcolor2,
        elevation: 0,
        iconTheme:
            const IconThemeData(color: ColorPalette.primarycolor, size: 22),
        title: const Text('Rewards'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ColorPalette.primarycolor),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const UserLevelRank())));
            },
            child: Container(
              height: size.height * 0.1,
              width: double.infinity,
              margin: const EdgeInsets.only(
                  bottom: 30, left: 15, right: 15, top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
          ),
        ],
      ),
    );
  }
}
