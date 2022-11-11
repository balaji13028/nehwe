import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:intl/intl.dart';
import 'package:nehwe/models/user_intime.dart';
import 'package:nehwe/profile_pages/user_badges.dart';
import 'package:nehwe/profile_pages/user_basic_info.dart';
import 'package:nehwe/profile_pages/user_statistics.dart';
import '../constants/color_palettes.dart';
import '../models/user_details_model.dart';
import 'edit_profile.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({Key? key}) : super(key: key);

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  UserProfileData user = localUserList[0];
  bool oninfo = true;
  bool onstatistic = false;
  bool onbadges = false;
  int pageIndex = 0;
  Timer? timer;
  var intime = DateTime.parse(userTiming.intime.toString());
  String _timeasString = '';
  String minutes = '';
  String seconds = '';

  timerRun() {
    _timeasString = DateFormat("kk:mm:ss").format(intime);
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer t) {
        var life = int.parse(user.lifes!);
        var value = life;

        if (intime.compareTo(DateTime.now()) < 0) {
          intime = intime.add(const Duration(minutes: 5));

          setState(() {
            if (value < 10) {
              if (_timeasString == '-0:00:00') {
                //user.lifes = value.toString();
              }
            } else {
              timer!.cancel();
            }
          });
        }
        _getDuration(intime);
      },
    );
  }

  void _getDuration(time) {
    Duration timeelapsed = DateTime.now().difference(time);
    if (!mounted) return;

    setState(() {
      _timeasString = timeelapsed.toString().split(".")[0];
      minutes = _timeasString.split(':')[1];
      seconds = _timeasString.split(':')[2];
      userTiming.minutes = minutes;
      userTiming.seconds = seconds;
    });
  }

  @override
  void initState() {
    timerRun();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPalette.backgroundcolor2,
          elevation: 0,
          leadingWidth: size.width * 0.15,
          iconTheme:
              const IconThemeData(color: ColorPalette.primarycolor, size: 28),
          title: const Text('Profile'),
          centerTitle: true,
          titleTextStyle: const TextStyle(
              color: ColorPalette.primarycolor,
              letterSpacing: 0.9,
              fontSize: 22,
              fontWeight: FontWeight.bold),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EditProfile(user: localUserList[0])));
                },
                icon: const Icon(
                  Icons.edit,
                  size: 28,
                  color: ColorPalette.primarycolor,
                ),
              ),
            )
          ],
        ),
        body: Column(children: [
          Container(
            color: ColorPalette.backgroundcolor2,
            alignment: Alignment.center,
            padding: EdgeInsets.only(
                top: size.width * 0.06,
                left: 20,
                right: 20,
                bottom: size.width * 0.06),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: ColorPalette.backgroundcolor1,
                      radius: 60,
                      child: SvgPicture.string(
                        user.avatar ?? '',
                        width: size.height * 0.099,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.displayName!,
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: ColorPalette.secondarycolor),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            user.phoneNumber!,
                            style: const TextStyle(
                                fontSize: 18,
                                color: ColorPalette.secondarycolor),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: size.height * 0.1,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: ColorPalette.primarycolor.withOpacity(0.9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (oninfo = !oninfo) {
                        oninfo = true;
                        onstatistic = false;
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
                        color: oninfo
                            ? ColorPalette.whitetextcolor
                            : ColorPalette.primarycolor.withOpacity(0.0)),
                    child: Text(
                      'Info',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.8,
                          color: oninfo
                              ? ColorPalette.secondarycolor
                              : ColorPalette.whitetextcolor),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (onstatistic = !onstatistic) {
                        oninfo = false;
                        onstatistic = true;
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
                        color: onstatistic
                            ? ColorPalette.whitetextcolor
                            : ColorPalette.primarycolor.withOpacity(0.0)),
                    child: Text(
                      'Stats',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.8,
                          color: onstatistic
                              ? ColorPalette.secondarycolor
                              : ColorPalette.whitetextcolor),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (onbadges = !onbadges) {
                        oninfo = false;
                        onstatistic = false;
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
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.8,
                          color: onbadges
                              ? ColorPalette.secondarycolor
                              : ColorPalette.whitetextcolor),
                    ),
                  ),
                )
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                if (oninfo == true)
                  const UserBasicInfo()
                else if (onstatistic == true)
                  UserStatistics(
                    minutesinString: minutes,
                    secondsString: seconds,
                  )
                else if (onbadges == true)
                  const UserBadges()
              ],
            ),
          )
        ]));
  }
}
