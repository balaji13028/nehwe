import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/color_palettes.dart';
import '../models/user_details_model.dart';
import '../profile_pages/edit_profile.dart';
import '../profile_pages/user_badges.dart';
import '../profile_pages/user_basic_info.dart';
import '../profile_pages/user_statistics.dart';

// ignore: must_be_immutable
class Profile extends StatefulWidget {
  String minutesinString;
  String secondsString;
  Profile(
      {Key? key, required this.minutesinString, required this.secondsString})
      : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserProfileData user = localUserList[0];
  bool oninfo = true;
  bool onstatistic = false;
  bool onbadges = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var upperContainerheight = size.height * 0.31;
    var middleContainerHeight = size.height * 0.1;
    return Column(children: [
      Container(
        height: upperContainerheight,
        width: double.infinity,
        color: ColorPalette.backgroundcolor2,
        padding: EdgeInsets.only(top: size.height * 0.06, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditProfile(user: localUserList[0])));
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: ColorPalette.whitetextcolor,
                        borderRadius: BorderRadius.circular(6)),
                    child: const Icon(
                      Icons.edit,
                      size: 28,
                      color: ColorPalette.primarycolor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
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
                      Row(
                        children: [
                          Text(
                            user.phoneNumber!,
                            style: const TextStyle(
                                fontSize: 18,
                                color: ColorPalette.secondarycolor),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
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
        height: middleContainerHeight,
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
                minutesinString: widget.minutesinString,
                secondsString: widget.secondsString,
              )
            else if (onbadges == true)
              const UserBadges()
          ],
        ),
      )
    ]);
  }
}
