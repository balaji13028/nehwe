import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:nehwe/api_calls/subscriptions_api.dart';
import '../constants/color_palettes.dart';
import '../help_support/help_support.dart';
import '../local_database.dart';
import '../models/user_details_model.dart';
import '../notifications/notifications.dart';
import '../profile_pages/profile_screen.dart';
import '../subscriptions/subscription_page.dart';
import '../screens/login_screen.dart';

// ignore: must_be_immutable
class SlideDrawer extends StatelessWidget {
  GlobalKey<ScaffoldState> slider;
  SlideDrawer({super.key, required this.slider});
  UserProfileData user = localUserList[0];
  String decodeFluttermojifromString = '';
  bool _isLoaderVisible = false;
  loader(BuildContext context) async {
    if (_isLoaderVisible) {
      context.loaderOverlay.show();
    } else {
      context.loaderOverlay.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      width: size.width * 0.55,
      backgroundColor: ColorPalette.primarycolor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25), topRight: Radius.circular(25))),
      child: Container(
        padding: EdgeInsets.only(top: size.height * 0.11, left: 10),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () async {},
                      child: CircleAvatar(
                        radius: 31,
                        backgroundColor:
                            ColorPalette.whitetextcolor.withOpacity(0.8),
                        child: CircleAvatar(
                          backgroundColor: ColorPalette.backgroundcolor1,
                          radius: 30,
                          child: SvgPicture.string(
                            user.avatar ?? '',
                            width: 45,
                          ),
                        ),
                      )),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.displayName ?? '',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.9,
                            color: ColorPalette.whitetextcolor),
                      ),
                      Text(
                        user.phoneNumber ?? '',
                        style: const TextStyle(
                            fontSize: 14,
                            letterSpacing: 0.9,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ListTile(
                title: const Text(
                  "My Profile",
                  style: TextStyle(
                      fontSize: 16, color: ColorPalette.whitetextcolor),
                ),
                leading: const Icon(
                  Icons.person,
                  size: 35,
                  color: ColorPalette.whitetextcolor,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const ProfileDetails())));
                }),
            SizedBox(
              height: 0,
              width: size.width * 0.45,
              child: const Divider(
                color: ColorPalette.whitetextcolor,
              ),
            ),
            ListTile(
                title: const Text(
                  "Subscriptions",
                  style: TextStyle(
                      fontSize: 16, color: ColorPalette.whitetextcolor),
                ),
                leading: const Icon(
                  Icons.payment,
                  size: 35,
                  color: ColorPalette.whitetextcolor,
                ),
                onTap: () async {
                  loader(context);
                  await activePlan(user.subId, user.id);

                  // ignore: use_build_context_synchronously
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Subscription()));
                }),
            SizedBox(
              height: 0,
              width: size.width * 0.45,
              child: const Divider(
                color: ColorPalette.whitetextcolor,
              ),
            ),
            ListTile(
                title: const Text(
                  "Notifications",
                  style: TextStyle(
                      fontSize: 16, color: ColorPalette.whitetextcolor),
                ),
                leading: const Icon(
                  Icons.notifications,
                  size: 35,
                  color: ColorPalette.whitetextcolor,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Notifiactions()));
                }),
            SizedBox(
              height: 0,
              width: size.width * 0.45,
              child: const Divider(
                color: ColorPalette.whitetextcolor,
              ),
            ),
            SizedBox(
              height: 0,
              width: size.width * 0.45,
              child: const Divider(
                color: ColorPalette.whitetextcolor,
              ),
            ),
            ListTile(
                title: const Text(
                  "Help & Support",
                  style: TextStyle(
                      fontSize: 16, color: ColorPalette.whitetextcolor),
                ),
                leading: const Icon(
                  Icons.help,
                  size: 35,
                  color: ColorPalette.whitetextcolor,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HelpSupport()));
                }),
            Container(
              margin:
                  EdgeInsets.only(top: size.height * 0.38, left: 10, right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: ColorPalette.whitetextcolor),
              child: ListTile(
                title: const Text(
                  "LogOut",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorPalette.secondarycolor),
                ),
                leading: const Icon(
                  Icons.logout_rounded,
                  size: 35,
                  color: ColorPalette.secondarycolor,
                ),
                onTap: () async {
                  await deleteUserDetails();
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder:
                              ((context, animation, secondaryAnimation) =>
                                  const LoginScreen())));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
