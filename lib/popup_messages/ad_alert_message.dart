import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:nehwe/models/user_details_model.dart';
import '../constants/color_palettes.dart';

bool _isLoaderVisible = false;
loader(BuildContext context) async {
  if (_isLoaderVisible) {
    context.loaderOverlay.show();
  } else {
    context.loaderOverlay.hide();
  }
}

displayADAlert(BuildContext context, rewardedAd) {
  Size size = MediaQuery.of(context).size;
  UserProfileData user = localUserList[0];
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: ColorPalette.backgroundcolor2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          title: const Text(
            'Alert!',
            textAlign: TextAlign.center,
          ),
          titleTextStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ColorPalette.textcolor),
          content: const Text(
            'Watch the AD to get lifes',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16,
                //fontWeight: FontWeight.bold,
                color: ColorPalette.textcolor),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => Colors.transparent),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: size.height * 0.035,
                      width: size.width * 0.25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              width: 1, color: ColorPalette.secondarycolor)),
                      child: const Text(
                        'NO',
                        style: TextStyle(
                            fontSize: 18, color: ColorPalette.primarycolor),
                      ),
                    )),
                TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => Colors.transparent),
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                      rewardedAd?.show(
                        onUserEarnedReward: (_, reward) {
                          var lifes = int.parse(user.lifes!);
                          newUser.lifes = (lifes + 1).toString();
                          user.lifes = newUser.lifes;
                          reward = user.lifes as RewardItem;
                        },
                      );
                    },
                    child: Container(
                      height: size.height * 0.035,
                      width: size.width * 0.25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: ColorPalette.primarycolor),
                      child: const Text(
                        'YES',
                        style: TextStyle(
                            fontSize: 18, color: ColorPalette.whitetextcolor),
                      ),
                    ))
              ],
            ),
          ],
        );
      });
}
