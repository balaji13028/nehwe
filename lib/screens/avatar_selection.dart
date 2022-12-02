import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:nehwe/api_calls/online_status.dart';
import 'package:nehwe/models/buddies_model.dart';
import 'package:nehwe/popup_messages/coins_bonus.dart';
import '../api_calls/course_api.dart';
import '../api_calls/listof_users.dart';
import '../api_calls/user_details_api.dart';
import '../constants/color_palettes.dart';
import '../loadings/loader.dart';
import '../local_database.dart';
import '../models/user_details_model.dart';
import 'dashboard.dart';

class AvatarSelection extends StatefulWidget {
  const AvatarSelection({Key? key}) : super(key: key);

  @override
  State<AvatarSelection> createState() => _AvatarSelectionState();
}

class _AvatarSelectionState extends State<AvatarSelection> {
  bool _isLoaderVisible = false;
  UserProfileData userdata = localUserList[0];
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
    var totalHeight = size.height;
    var upperContainerheight = size.height * 0.42;

    return GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: const Loader(),
      child: Scaffold(
          backgroundColor: ColorPalette.backgroundcolor2,
          body: Column(children: [
            Container(
              height: upperContainerheight,
              padding: EdgeInsets.only(
                top: size.height * 0.06,
                left: 20,
                right: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                              text: 'Hi, ',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: ColorPalette.secondarycolor),
                              children: [
                                TextSpan(
                                  text: newUser.displayName!,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: ColorPalette.secondarycolor),
                                )
                              ]),
                        ),
                        TextButton(
                            style: ButtonStyle(
                              overlayColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.transparent),
                            ),
                            onPressed: () async {
                              setState(() {
                                _isLoaderVisible = true;
                              });
                              if (_isLoaderVisible == true) {
                                context.loaderOverlay.show();
                              } else {
                                context.loaderOverlay.hide();
                              }
                              String svgstring = await FluttermojiFunctions()
                                  .encodeMySVGtoString();
                              newUser.avatar = svgstring;
                              newUser.subId = '1';
                              newUser.xp = '0';
                              newUser.onlineStatus = 'online';
                              newUser.lifes = userdata.lifes;
                              newUser.coins = userdata.coins;
                              newUser.id = userdata.id;
                              newUser.lastused = DateTime.now().toString();
                              await updateOnline(newUser.id, 'online');
                              await insertUser(
                                  newUser); //used for store at local database.
                              userApi(
                                  newUser.firstName,
                                  newUser.lastName,
                                  newUser.displayName,
                                  newUser.phoneNumber,
                                  newUser.emailId,
                                  newUser.dob,
                                  newUser.address,
                                  newUser.city,
                                  newUser.state,
                                  newUser.country,
                                  newUser.zipcode,
                                  newUser.gender,
                                  newUser
                                      .avatar); //used for send data to server.

                              localUserList =
                                  await user(); //retrieve user data from local database.
                              await coursesList(newUser.id);
                              await noOfUsers(newUser.id);
                              newUser.id = localUserList[0].id;
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                      pageBuilder: ((context, animation,
                                              secondaryAnimation) =>
                                          const DashBoard())));
                              // ignore: use_build_context_synchronously
                              await bounceCoins(context, newUser.coins!);
                              setState(() {
                                _isLoaderVisible = false;
                              });
                            },
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: ColorPalette.secondarycolor),
                            )),
                      ]),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FluttermojiCircleAvatar(
                        backgroundColor: ColorPalette.backgroundcolor1,
                        radius: 100,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: totalHeight - upperContainerheight,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              decoration: const BoxDecoration(
                  color: ColorPalette.whitetextcolor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Choose your avatar look :',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: ColorPalette.secondarycolor),
                  ),
                  FluttermojiCustomizer(
                    scaffoldWidth: size.width,
                    scaffoldHeight: size.height * 0.5,
                    autosave: true,
                    theme: FluttermojiThemeData(
                        selectedTileDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                width: 4, color: ColorPalette.primarycolor)),
                        selectedIconColor: ColorPalette.secondarycolor,
                        secondaryBgColor: ColorPalette.whitetextcolor,
                        labelTextStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorPalette.secondarycolor)),
                  ),
                ],
              ),
            )
          ])),
    );
  }
}
