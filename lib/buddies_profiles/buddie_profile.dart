import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/emojione_monotone.dart';
import 'package:nehwe/api_calls/buddies_api.dart';
import 'package:nehwe/models/buddies_model.dart';
import 'package:nehwe/models/user_details_model.dart';
import '../constants/color_palettes.dart';

// ignore: must_be_immutable
class BuddieProfile extends StatefulWidget {
  BuddyProfileData buddy;
  BuddieProfile({Key? key, required this.buddy}) : super(key: key);

  @override
  State<BuddieProfile> createState() => _BuddieProfileState();
}

class _BuddieProfileState extends State<BuddieProfile> {
  bool statusBuddy = false;
  UserProfileData user = localUserList[0];
  @override
  Widget build(BuildContext context) {
    print(widget.buddy.requestStatus);
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
                SizedBox(height: size.height * 0.02),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  CircleAvatar(
                    backgroundColor: ColorPalette.backgroundcolor1,
                    radius: size.height * 0.08,
                    child: SvgPicture.string(
                      widget.buddy.buddyAvatar ?? '',
                      width: size.height * 0.12,
                    ),
                  ),
                ]),
                SizedBox(height: size.height * 0.02),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    '${widget.buddy.buddyFirstName} ${widget.buddy.buddyLastName}',
                    style: const TextStyle(
                        fontSize: 24,
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
                                  Text(
                                    (widget.buddy.buddyStreak == 'null')
                                        ? '0'
                                        : widget.buddy.buddyStreak!,
                                    style: const TextStyle(
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
                                  Text(
                                    widget.buddy.buddyXp ?? '',
                                    style: const TextStyle(
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
                                children: [
                                  const Iconify(
                                    EmojioneMonotone.money_bag,
                                    color: Color.fromARGB(255, 196, 167, 2),
                                  ),
                                  Text(
                                    widget.buddy.buddyCoins ?? '',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: ColorPalette.secondarycolor),
                                  ),
                                  const Text(
                                    'Coins',
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
              (widget.buddy.status != '1')
                  ? (widget.buddy.requestStatus == '0')
                      ? Positioned(
                          top: -size.height * 0.028,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await friendRequestResponse(
                                      widget.buddy.buddyId, user.id, '2');
                                  setState(() {
                                    widget.buddy.status = '-1';
                                  });
                                },
                                child: Card(
                                  borderOnForeground: false,
                                  semanticContainer: false,
                                  color:
                                      const Color.fromARGB(255, 154, 197, 128),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    height: size.height * 0.046,
                                    width: size.width * 0.3,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            width: 0.4,
                                            color: ColorPalette.lifescolor),
                                        color: ColorPalette.whitetextcolor),
                                    child: const Text(
                                      'Reject',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: ColorPalette.lifescolor),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              GestureDetector(
                                onTap: () async {
                                  await friendRequestResponse(
                                      widget.buddy.buddyId, user.id, '1');
                                },
                                child: Card(
                                  borderOnForeground: false,
                                  semanticContainer: false,
                                  color:
                                      const Color.fromARGB(255, 154, 197, 128),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    height: size.height * 0.046,
                                    width: size.width * 0.3,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: ColorPalette.greenColor),
                                    child: const Text(
                                      'Accept',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: ColorPalette.whitetextcolor),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Positioned(
                          top: -28,
                          child: GestureDetector(
                            onTap: (widget.buddy.status == '0')
                                ? null
                                : () async {
                                    setState(() {
                                      widget.buddy.status = '0';
                                      statusBuddy = true;
                                    });
                                    if (statusBuddy == true) {
                                      await friendRequestResponse(
                                          user.id, widget.buddy.buddyId, '0');
                                    }
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
                                      color: (widget.buddy.status == '0')
                                          ? ColorPalette.rightAnsFillcolor
                                          : ColorPalette.greenColor),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        (widget.buddy.status == '0')
                                            ? const Icon(Icons.check,
                                                size: 28,
                                                color: ColorPalette.greenColor)
                                            : const Icon(Icons.add,
                                                size: 28,
                                                color: ColorPalette
                                                    .whitetextcolor),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        (widget.buddy.status == '0')
                                            ? const Text(
                                                'Request sent',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: ColorPalette
                                                        .greenColor),
                                              )
                                            : const Text(
                                                'Add Buddy',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                    color: ColorPalette
                                                        .whitetextcolor),
                                              ),
                                      ])),
                            ),
                          ),
                        )
                  : const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }

  Widget acceptandreject() {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        GestureDetector(
          onTap: () async {
            await friendRequestResponse(widget.buddy.buddyId, user.id, '2');
            setState(() {
              widget.buddy.status = '-1';
            });
          },
          child: Card(
            borderOnForeground: false,
            semanticContainer: false,
            color: const Color.fromARGB(255, 154, 197, 128),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              height: size.height * 0.046,
              width: size.width * 0.3,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(width: 0.4, color: ColorPalette.lifescolor),
                  color: ColorPalette.whitetextcolor),
              child: const Text(
                'Reject',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: ColorPalette.lifescolor),
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: () async {
            await friendRequestResponse(widget.buddy.buddyId, user.id, '1');
          },
          child: Card(
            borderOnForeground: false,
            semanticContainer: false,
            color: const Color.fromARGB(255, 154, 197, 128),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              height: size.height * 0.046,
              width: size.width * 0.3,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorPalette.greenColor),
              child: const Text(
                'Accept',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: ColorPalette.whitetextcolor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
