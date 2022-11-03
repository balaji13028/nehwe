import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/emojione_monotone.dart';
import 'package:nehwe/models/user_details_model.dart';
import 'package:nehwe/models/user_intime.dart';
import 'package:nehwe/popup_messages/ad_alert_message.dart';
import 'package:nehwe/widgets/ad_helper.dart';
import '../constants/color_palettes.dart';

// ignore: must_be_immutable
class UserStatistics extends StatefulWidget {
  String minutesinString;
  String secondsString;
  UserStatistics(
      {Key? key, required this.minutesinString, required this.secondsString})
      : super(key: key);

  @override
  State<UserStatistics> createState() => _UserStatisticsState();
}

class _UserStatisticsState extends State<UserStatistics> {
  UserProfileData user = localUserList[0];
  Timer? timer;
  var intime = DateTime.parse(userTiming.intime.toString());
  RewardedAd? rewardedAd;

  @override
  void initState() {
    loadRewardedAd();
    super.initState();
  }

  void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              setState(() {
                ad.dispose();
                rewardedAd = null;
              });
              loadRewardedAd();
            },
          );

          setState(() {
            rewardedAd = ad;
          });
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewarded ad: ${err.message}');
        },
      ),
    );
  }

  @override
  void dispose() {
    rewardedAd?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        children: [
          Container(
            height: size.height * 0.06,
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorPalette.whitetextcolor,
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 0),
                      blurRadius: 1,
                      color: Colors.grey.withOpacity(0.6)),
                ]),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        Container(
                          height: 45,
                          width: 45,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorPalette.xpiconcolor.withOpacity(0.2)),
                          child: SvgPicture.asset(
                            'assets/icons/xp_icon.svg',
                            fit: BoxFit.none,
                            color: ColorPalette.xpiconcolor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Xp ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color:
                                      ColorPalette.textcolor.withOpacity(0.7),
                                ),
                              ),
                              Text(
                                user.xp!,
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: ColorPalette.textcolor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 45,
                    width: 45,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorPalette.backgroundcolor2),
                    child: Icon(
                      Icons.add,
                      color: ColorPalette.primarycolor.withOpacity(0.6),
                      size: 35,
                    ),
                  ),
                ]),
          ),
          Container(
            height: size.height * 0.06,
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorPalette.whitetextcolor,
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 0),
                      blurRadius: 1,
                      color: Colors.grey.withOpacity(0.6)),
                ]),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        Container(
                            height: 45,
                            width: 45,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:
                                    ColorPalette.lifescolor.withOpacity(0.12)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Iconify(
                                EmojioneMonotone.red_heart,
                                color:
                                    ColorPalette.lifescolor.withOpacity(0.85),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Lifes ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color:
                                      ColorPalette.textcolor.withOpacity(0.7),
                                ),
                              ),
                              Text(
                                user.lifes!,
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: ColorPalette.textcolor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: user.lifes == '10' ? false : true,
                    child: Text(
                      'Next life in ${widget.minutesinString} : ${widget.secondsString} ',
                      style: const TextStyle(
                        fontSize: 14,
                        color: ColorPalette.textcolor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      var lifes = int.parse(user.lifes!);
                      if (lifes < 10) {
                        displayADAlert(context, rewardedAd);
                      } else {
                        EasyLoading.showInfo('No More Ads');
                      }
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorPalette.backgroundcolor2),
                      child: Icon(
                        Icons.add,
                        color: ColorPalette.primarycolor.withOpacity(0.6),
                        size: 35,
                      ),
                    ),
                  ),
                ]),
          ),
          Container(
            height: size.height * 0.06,
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorPalette.whitetextcolor,
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 0),
                      blurRadius: 1,
                      color: Colors.grey.withOpacity(0.6)),
                ]),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        Container(
                          height: 45,
                          width: 45,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xffFFF7CC).withOpacity(0.8)),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Iconify(
                              EmojioneMonotone.money_bag,
                              color: Color.fromARGB(255, 196, 167, 2),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Coins ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color:
                                      ColorPalette.textcolor.withOpacity(0.7),
                                ),
                              ),
                              Text(
                                user.coins!,
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: ColorPalette.textcolor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 45,
                    width: 45,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorPalette.backgroundcolor2),
                    child: Icon(
                      Icons.add,
                      color: ColorPalette.primarycolor.withOpacity(0.6),
                      size: 35,
                    ),
                  ),
                ]),
          ),
          Container(
            height: size.height * 0.06,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorPalette.whitetextcolor,
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 0),
                      blurRadius: 1,
                      color: Colors.grey.withOpacity(0.6)),
                ]),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        Container(
                          height: 45,
                          width: 45,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xffFF4D00).withOpacity(0.1)),
                          child: SvgPicture.asset(
                            'assets/icons/steak_icon.svg',
                            fit: BoxFit.none,
                            color: const Color(0xffFF4D00).withOpacity(0.8),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Streak ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color:
                                      ColorPalette.textcolor.withOpacity(0.7),
                                ),
                              ),
                              const Text(
                                '520',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: ColorPalette.textcolor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
