import 'dart:async';

import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:nehwe/api_calls/buddies_api.dart';
import 'package:nehwe/loadings/loader.dart';
import 'package:nehwe/models/user_details_model.dart';
import 'package:nehwe/screens/profile.dart';
import 'package:nehwe/slide_drawers/slide_drawer.dart';
import '../constants/color_palettes.dart';
import '../models/courses_model.dart';
import '../models/user_intime.dart';
import 'buddies.dart';
import 'homepage.dart';
import 'leaderboard.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final slidebar = GlobalKey<ScaffoldState>();
  List<CoursesData> course = courseList;
  UserProfileData user = localUserList[0];
  Timer? timer;
  var intime = DateTime.parse(userTiming.intime.toString());
  String _timeasString = '';
  String minutes = '';
  String seconds = '';
  int _currentIndex = 0;
  bool _isLoaderVisible = false;
  loader() async {
    if (_isLoaderVisible) {
      context.loaderOverlay.show();
    } else {
      context.loaderOverlay.hide();
    }
  }

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
                value = (life + 1);
                user.lifes = value.toString();
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
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: ColorPalette.whitetextcolor,
        body: GlobalLoaderOverlay(
          useDefaultLoading: false,
          overlayWidget: const Loader(),
          child: Column(
            children: [
              if (_currentIndex == 0)
                Homepage(slider: slidebar)
              else if (_currentIndex == 2)
                const Buddies()
              else if (_currentIndex == 3)
                Profile(
                  minutesinString: minutes,
                  secondsString: seconds,
                )
              else if (_currentIndex == 1)
                const LeaderBaord()
            ],
          ),
        ),
        key: slidebar,
        drawerEnableOpenDragGesture: false,
        drawer: SlideDrawer(
          slider: slidebar,
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 13.0,
              color: ColorPalette.secondarycolor,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.elliptical(30, 20)),
                    color: (_currentIndex == 3 || _currentIndex == 1)
                        ? ColorPalette.whitetextcolor.withAlpha(251)
                        : ColorPalette.backgroundcolor1),
              ),
            ),
            CustomNavigationBar(
              iconSize: 35.0,
              scaleFactor: 0.2,
              bubbleCurve: Curves.linear,
              strokeColor: Colors.transparent,
              selectedColor: ColorPalette.whitetextcolor,
              unSelectedColor: ColorPalette.whitetextcolor.withOpacity(0.5),
              backgroundColor: ColorPalette.secondarycolor,
              items: [
                CustomNavigationBarItem(
                    icon: const Icon(Icons.home_rounded),
                    selectedIcon: const Icon(
                      Icons.home_rounded,
                    ),
                    selectedTitle: const Text(
                      "Home",
                      style: TextStyle(
                          fontSize: 12, color: ColorPalette.whitetextcolor),
                    )),
                CustomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/icons/leader_board.svg',
                      color: ColorPalette.whitetextcolor.withOpacity(0.5),
                    ),
                    selectedIcon: SvgPicture.asset(
                      'assets/icons/leader_board.svg',
                      width: 50,
                    ),
                    selectedTitle: const Text(
                      "Leaderboard",
                      style: TextStyle(
                          fontSize: 12, color: ColorPalette.whitetextcolor),
                    )),
                CustomNavigationBarItem(
                    icon: const Icon(Icons.people_rounded),
                    selectedIcon: const Icon(
                      Icons.people_rounded,
                    ),
                    selectedTitle: const Text(
                      "Buddies",
                      style: TextStyle(
                          fontSize: 12, color: ColorPalette.whitetextcolor),
                    )),
                CustomNavigationBarItem(
                    icon: const Icon(Icons.person_rounded),
                    selectedIcon: const Icon(
                      Icons.person_rounded,
                    ),
                    selectedTitle: const Text(
                      "Profile",
                      style: TextStyle(
                          fontSize: 12, color: ColorPalette.whitetextcolor),
                    )),
              ],
              currentIndex: _currentIndex,
              onTap: (index) async {
                if (index == 2) {
                  loader();
                  await buddies(user.id);
                  setState(() {
                    _currentIndex = index;
                  });
                } else {
                  setState(() {
                    _currentIndex = index;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
