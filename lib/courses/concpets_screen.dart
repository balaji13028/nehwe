import 'dart:async';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexagon/hexagon.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/emojione_monotone.dart';
import 'package:iconify_flutter/icons/zondicons.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:nehwe/api_calls/units_api.dart';
import 'package:nehwe/courses/question_screen.dart';
import 'package:nehwe/courses/units_screen.dart';
import 'package:nehwe/models/user_details_model.dart';
import 'package:nehwe/models/user_intime.dart';
import 'package:nehwe/popup_messages/completed.dart';
import 'package:nehwe/popup_messages/glossary.dart';
import 'package:nehwe/popup_messages/screens_Not_Asssigned.dart';
import '../api_calls/concepts_api.dart';
import '../api_calls/screens_api.dart';
import '../constants/color_palettes.dart';
import '../loadings/loader.dart';
import '../models/courses_model.dart';
import '../screens/buddies.dart';
import '../screens/homepage.dart';
import '../screens/leaderboard.dart';
import '../screens/profile.dart';
import '../slide_drawers/slide_drawer.dart';

// ignore: must_be_immutable
class Lessons extends StatefulWidget {
  UnitData unit;
  LessonData lesson;
  CoursesData course;
  Lessons({
    super.key,
    required this.unit,
    required this.course,
    required this.lesson,
  });

  @override
  State<Lessons> createState() => _LessonsState();
}

class _LessonsState extends State<Lessons> {
  List<ConceptData> concept = conceptlist;
  UserProfileData user = localUserList[0];
  final slidebar = GlobalKey<ScaffoldState>();
  int _currentIndex = -1;
  bool _isLoaderVisible = false;
  String totalXp = '';
  String completedConcepts = '';
  //String value = '';
  Timer? timer;
  var intime = DateTime.parse(userTiming.intime.toString());
  String _timeasString = '';
  String minutes = '';
  String seconds = '';
  //RewardedAd? rewardedAd;

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

  void loadRewardedAd() {
    // RewardedAd.load(
    //   adUnitId: AdHelper.rewardedAdUnitId,
    //   request: const AdRequest(),
    //   rewardedAdLoadCallback: RewardedAdLoadCallback(
    //     onAdLoaded: (ad) {
    //       ad.fullScreenContentCallback = FullScreenContentCallback(
    //         onAdDismissedFullScreenContent: (ad) {
    //           setState(() {
    //             ad.dispose();
    //             rewardedAd = null;
    //           });
    //           loadRewardedAd();
    //         },
    //       );

    //       setState(() {
    //         rewardedAd = ad;
    //       });
    //     },
    //     onAdFailedToLoad: (err) {
    //       print('Failed to load a rewarded ad: ${err.message}');
    //     },
    //   ),
    // );
  }

  @override
  void initState() {
    earnedXp();
    timerRun();
    completedconcepts();
    if (completedConcepts == '6') {
      conceptstatus(
          null, null, widget.lesson.lessonId, '2', null, null, newUser.id);
    } //send to server (concept is completed).
    newUser.lifes = user.lifes;
    loadRewardedAd();
    super.initState();
  }

  ///this function for get the total completed concepts count based on concept status....
  void completedconcepts() {
    var cpt1 = (concept[0].conceptstatus == '1') ? 1 : 0;
    var cpt2 = (concept[1].conceptstatus == '1') ? 1 : 0;
    var cpt3 = (concept[2].conceptstatus == '1') ? 1 : 0;
    var cpt4 = (concept[3].conceptstatus == '1') ? 1 : 0;
    var cpt5 = (concept[4].conceptstatus == '1') ? 1 : 0;
    var cpt6 = (concept.length == 6)
        ? (concept[5].conceptstatus == '1')
            ? 1
            : 0
        : 0;
    setState(() {
      var cpt = cpt1 + cpt2 + cpt3 + cpt4 + cpt5 + cpt6;
      completedConcepts = cpt.toString();
    });
  }

  ///this function for calculateting the total xp based on concept status....
  void earnedXp() {
    var xp1 = (concept[0].conceptstatus == '1') ? int.parse(concept[0].xp!) : 0;
    var xp2 = (concept[1].conceptstatus == '1') ? int.parse(concept[1].xp!) : 0;
    var xp3 = (concept[2].conceptstatus == '1') ? int.parse(concept[2].xp!) : 0;
    var xp4 = (concept[3].conceptstatus == '1') ? int.parse(concept[3].xp!) : 0;
    var xp5 = (concept[4].conceptstatus == '1') ? int.parse(concept[4].xp!) : 0;
    var xp6 = (concept.length == 6)
        ? (concept[5].conceptstatus == '1')
            ? int.parse(concept[5].xp!)
            : 0
        : 0;
    setState(() {
      var xp = xp1 + xp2 + xp3 + xp4 + xp5 + xp6;
      totalXp = xp.toString();
    });
  }

  ///this is for loading when data is load and navigating to next...
  loader() async {
    if (_isLoaderVisible) {
      context.loaderOverlay.show();
    } else {
      context.loaderOverlay.hide();
    }
  }

  @override
  void dispose() {
    //rewardedAd!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var conceptsCount = concept.length;
    Size size = MediaQuery.of(context).size;
    return GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: const Loader(),
      child: Scaffold(
          backgroundColor: ColorPalette.whitetextcolor,
          key: slidebar,
          drawerEnableOpenDragGesture: false,
          drawer: SlideDrawer(slider: slidebar),
          appBar: (_currentIndex == -1)
              ? AppBar(
                  centerTitle: true,
                  backgroundColor: ColorPalette.backgroundcolor2,
                  elevation: 0.0,
                  shadowColor: ColorPalette.backgroundcolor2,
                  automaticallyImplyLeading: false,
                  leading: GestureDetector(
                    onTap: () async {
                      setState(() {
                        _isLoaderVisible = true;
                      });
                      loader();
                      await unitsList(widget.course.courseId, newUser.id);
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                              pageBuilder:
                                  ((context, animation, secondaryAnimation) =>
                                      Units(course: widget.course))));
                      setState(() {
                        _isLoaderVisible = false;
                      });
                    },
                    child: const Icon(Icons.arrow_back_ios,
                        color: ColorPalette.primarycolor, size: 24),
                  ),
                  title: Text((widget.unit.unitName != null)
                      ? widget.unit.unitName!
                      : 'Unit Name'),
                  titleTextStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorPalette.primarycolor),
                )
              : null,
          floatingActionButton: (_currentIndex == -1)
              ? widget.lesson.glossary != 'null'
                  ? FloatingActionButton.extended(
                      backgroundColor: ColorPalette.primarycolor,
                      splashColor: ColorPalette.primarycolor,
                      elevation: 2,
                      onPressed: () {
                        glossaryPopUP(context, widget.lesson.glossary);
                      },
                      icon: SvgPicture.asset(
                        'assets/icons/glossary_icon.svg',
                        color: ColorPalette.whitetextcolor,
                      ),
                      label: const Text(
                        'Glossary',
                        style: TextStyle(
                            fontSize: 14,
                            color: ColorPalette.whitetextcolor,
                            fontWeight: FontWeight.bold),
                      ))
                  : null
              : null,
          body: Column(
            children: [
              if (_currentIndex == -1)
                Container(
                  padding: EdgeInsets.only(top: size.height * 0.03),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              height: 110,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: ColorPalette.backgroundcolor2
                                      .withOpacity(0.8)),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Iconify(
                                      Zondicons.book_reference,
                                      color: ColorPalette.secondarycolor,
                                    ),
                                    Text(
                                      '$completedConcepts/$conceptsCount',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: ColorPalette.textcolor),
                                    ),
                                    const Text(
                                      'Concepts',
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
                                      .withOpacity(0.8)),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/xp_icon.svg',
                                      color: ColorPalette.xpiconcolor,
                                    ),
                                    Text(
                                      '$totalXp / ${widget.lesson.lessonXP}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: ColorPalette.textcolor),
                                    ),
                                    const Text(
                                      'Xp',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: ColorPalette.primarycolor),
                                    )
                                  ])),
                          GestureDetector(
                            onTap: () {
                              var lifes = int.parse(user.lifes!);
                              if (lifes < 10) {
                                //displayADAlert(context, rewardedAd);
                              } else {
                                EasyLoading.showInfo('No More Ads');
                              }
                            },
                            child: Container(
                                height: 110,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ColorPalette.backgroundcolor2
                                        .withOpacity(0.8)),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Iconify(
                                        Zondicons.heart,
                                        size: 30,
                                        color: ColorPalette.lifescolor,
                                      ),
                                      Text(
                                        user.lifes!,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: ColorPalette.textcolor),
                                      ),
                                      const Text(
                                        'Lifes',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: ColorPalette.primarycolor),
                                      )
                                    ])),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.05),
                        child: conceptsHexagon(
                            (widget.lesson.lessonName != null)
                                ? widget.lesson.lessonName!
                                : 'EMPTY',
                            size,
                            concept,
                            context),
                      ),
                    ],
                  ),
                )
              else if (_currentIndex == 0)
                Homepage(
                  slider: slidebar,
                )
              else if (_currentIndex == 2)
                const Buddies()
              else if (_currentIndex == 3)
                Profile(minutesinString: minutes, secondsString: seconds)
              else if (_currentIndex == 1)
                const LeaderBaord()
            ],
          ),
          bottomNavigationBar:
              Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              height: 13.0,
              color: ColorPalette.secondarycolor,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.elliptical(30, 20)),
                    color: (_currentIndex == 3 ||
                            _currentIndex == 1 ||
                            _currentIndex == -1)
                        ? ColorPalette.whitetextcolor.withAlpha(251)
                        : ColorPalette.backgroundcolor1),
              ),
            ),
            _currentIndex >= 0
                ? CustomNavigationBar(
                    iconSize: 35.0,
                    scaleFactor: 0.5,
                    bubbleCurve: Curves.ease,
                    strokeColor: Colors.transparent,
                    selectedColor: ColorPalette.whitetextcolor,
                    unSelectedColor:
                        ColorPalette.whitetextcolor.withOpacity(0.5),
                    backgroundColor: ColorPalette.secondarycolor,
                    items: [
                      CustomNavigationBarItem(
                          icon: const Icon(Icons.home),
                          selectedIcon: const Icon(
                            Icons.home,
                          ),
                          selectedTitle: const Text(
                            "Home",
                            style: TextStyle(
                                fontSize: 12,
                                color: ColorPalette.whitetextcolor),
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
                                fontSize: 12,
                                color: ColorPalette.whitetextcolor),
                          )),
                      CustomNavigationBarItem(
                          icon: const Icon(Icons.people_sharp),
                          selectedIcon: const Icon(
                            Icons.people_sharp,
                          ),
                          selectedTitle: const Text(
                            "Buddies",
                            style: TextStyle(
                                fontSize: 12,
                                color: ColorPalette.whitetextcolor),
                          )),
                      CustomNavigationBarItem(
                          icon: const Icon(Icons.person),
                          selectedIcon: const Icon(
                            Icons.person,
                          ),
                          selectedTitle: const Text(
                            "Profile",
                            style: TextStyle(
                                fontSize: 12,
                                color: ColorPalette.whitetextcolor),
                          )),
                    ],
                    currentIndex: _currentIndex,
                    onTap: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  )
                : CustomNavigationBar(
                    iconSize: 35.0,
                    scaleFactor: 0.5,
                    bubbleCurve: Curves.ease,
                    strokeColor: Colors.transparent,
                    selectedColor: ColorPalette.whitetextcolor.withOpacity(0.5),
                    unSelectedColor:
                        ColorPalette.whitetextcolor.withOpacity(0.5),
                    backgroundColor: ColorPalette.secondarycolor,
                    items: [
                      CustomNavigationBarItem(
                        icon: const Icon(Icons.home),
                        selectedIcon: const Icon(
                          Icons.home,
                        ),
                      ),
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
                                fontSize: 12,
                                color: ColorPalette.whitetextcolor),
                          )),
                      CustomNavigationBarItem(
                        icon: const Icon(Icons.people_sharp),
                        selectedIcon: const Icon(
                          Icons.people_sharp,
                        ),
                      ),
                      CustomNavigationBarItem(
                        icon: const Icon(Icons.person),
                        selectedIcon: const Icon(
                          Icons.person,
                        ),
                      ),
                    ],
                    onTap: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
          ])),
    );
  }

  Widget conceptsHexagon(
      String lessonName, Size size, concepts, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  setState(() {
                    _isLoaderVisible = true;
                  });
                  var life = int.parse(user.lifes!);
                  var value = await screensList(concepts[0].conceptId);
                  if (value == 'concept data is incomplete!') {
                    // ignore: use_build_context_synchronously
                    screenAreNotAsssigned(context);
                  } else if (concepts[0].conceptstatus == '1') {
                    // ignore: use_build_context_synchronously
                    completed(context);
                  } else if (life <= 0) {
                    EasyLoading.showToast(
                        'Sorry, you dont have lifes to take the concept.');
                  } else {
                    loader();
                    newunit = widget.unit;
                    newlesson = widget.lesson;
                    newconpt = concepts[0];
                    const idx = 0;
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder:
                                ((context, animation, secondaryAnimation) =>
                                    QuestionPage(
                                        index: idx,
                                        glossary: widget.lesson.glossary))));
                  }
                  setState(() {
                    _isLoaderVisible = false;
                  });
                },
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor:
                      ColorPalette.backgroundcolor2.withOpacity(0.5),
                  child: HexagonWidget.pointy(
                    width: size.width * 0.26,
                    cornerRadius: 15,
                    color: concepts[0].conceptstatus == '1'
                        ? ColorPalette.backgroundcolor1
                        : ColorPalette.backgroundcolor1.withOpacity(0.2),
                    child: HexagonWidget.pointy(
                      width: size.width * 0.20,
                      cornerRadius: 15,
                      color: concepts[0].conceptstatus == '1'
                          ? ColorPalette.backgroundcolor1
                          : ColorPalette.backgroundcolor2,
                      child: Stack(children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                concepts[0].conceptName ?? 'empty',
                                style: TextStyle(
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.bold,
                                    color: concepts[0].conceptstatus == '1'
                                        ? ColorPalette.whitetextcolor
                                        : ColorPalette.textcolor),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/xp_icon.svg',
                                    width: 15,
                                    color: ColorPalette.xpiconcolor,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    concepts[0].xp!,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: concepts[0].conceptstatus == '1'
                                            ? ColorPalette.whitetextcolor
                                            : ColorPalette.primarycolor),
                                  ),
                                ],
                              ),
                            ]),
                        Positioned(
                            top: 10,
                            left: 8,
                            right: 8,
                            bottom: 10,
                            child: Iconify(
                              EmojioneMonotone.notebook,
                              size: 65,
                              color:
                                  ColorPalette.backgroundcolor1.withAlpha(30),
                            ))
                      ]),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.1,
              ),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    _isLoaderVisible = true;
                  });
                  var value = await screensList(concepts[1].conceptId);
                  if (value == 'concept data is incomplete!') {
                    // ignore: use_build_context_synchronously
                    screenAreNotAsssigned(context);
                  } else if (concepts[1].conceptstatus == '1') {
                    // ignore: use_build_context_synchronously
                    completed(context);
                  } else {
                    loader();
                    const idx = 0;
                    newscreen.gsHeading = widget.lesson.glossary;
                    newunit = widget.unit;
                    newlesson = widget.lesson;
                    newconpt = concepts[1];

                    //navigatetoScreen(context, idx);
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder:
                                ((context, animation, secondaryAnimation) =>
                                    QuestionPage(
                                        index: idx,
                                        glossary: widget.lesson.glossary))));
                    setState(() {
                      _isLoaderVisible = false;
                    });
                  }
                },
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor:
                      ColorPalette.backgroundcolor2.withOpacity(0.5),
                  child: HexagonWidget.pointy(
                    width: size.width * 0.26,
                    cornerRadius: 15,
                    color: concepts[1].conceptstatus == '1'
                        ? ColorPalette.backgroundcolor1
                        : ColorPalette.backgroundcolor1.withOpacity(0.2),
                    child: HexagonWidget.pointy(
                      width: size.width * 0.20,
                      cornerRadius: 15,
                      color: concepts[1].conceptstatus == '1'
                          ? ColorPalette.backgroundcolor1
                          : ColorPalette.backgroundcolor2,
                      child: Stack(children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                concepts[1].conceptName ?? 'empty',
                                style: TextStyle(
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.bold,
                                    color: concepts[1].conceptstatus == '1'
                                        ? ColorPalette.whitetextcolor
                                        : ColorPalette.textcolor),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/xp_icon.svg',
                                    width: 15,
                                    color: ColorPalette.xpiconcolor,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    concepts[1].xp ?? '',
                                    style: TextStyle(
                                        color: concepts[1].conceptstatus == '1'
                                            ? ColorPalette.whitetextcolor
                                            : ColorPalette.primarycolor),
                                  ),
                                ],
                              ),
                            ]),
                        Positioned(
                            top: 10,
                            left: 8,
                            right: 8,
                            bottom: 10,
                            child: Iconify(
                              EmojioneMonotone.notebook,
                              size: 65,
                              color:
                                  ColorPalette.backgroundcolor1.withAlpha(30),
                            ))
                      ]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (concepts.length > 5)
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      _isLoaderVisible = true;
                    });

                    var value = await screensList(concepts[5].conceptId);
                    if (value == 'concept data is incomplete!') {
                      // ignore: use_build_context_synchronously
                      screenAreNotAsssigned(context);
                    } else if (concepts[5].conceptstatus == '1') {
                      // ignore: use_build_context_synchronously
                      completed(context);
                    } else {
                      loader();
                      newunit = widget.unit;
                      newlesson = widget.lesson;
                      const idx = 0;
                      newconpt = concepts[5];
                      newscreen.gsHeading = widget.lesson.glossary;
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                              pageBuilder:
                                  ((context, animation, secondaryAnimation) =>
                                      QuestionPage(
                                          index: idx,
                                          glossary: widget.lesson.glossary))));
                      //navigatetoScreen(context, idx);
                    }
                    setState(() {
                      _isLoaderVisible = false;
                    });
                  },
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor:
                        ColorPalette.backgroundcolor2.withOpacity(0.5),
                    child: HexagonWidget.pointy(
                      width: size.width * 0.26,
                      cornerRadius: 15,
                      color: concepts[5].conceptstatus == '1'
                          ? ColorPalette.backgroundcolor1
                          : ColorPalette.backgroundcolor1.withOpacity(0.2),
                      child: HexagonWidget.pointy(
                        width: size.width * 0.20,
                        cornerRadius: 15,
                        color: concepts[5].conceptstatus == '1'
                            ? ColorPalette.backgroundcolor1
                            : ColorPalette.backgroundcolor2,
                        child: Stack(children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  concepts[5].conceptName ?? 'empty',
                                  style: TextStyle(
                                      fontSize: 12,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                      color: concepts[5].conceptstatus == '1'
                                          ? ColorPalette.whitetextcolor
                                          : ColorPalette.textcolor),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/xp_icon.svg',
                                      width: 15,
                                      color: ColorPalette.xpiconcolor,
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      concepts[5].xp ?? '',
                                      style: TextStyle(
                                          color:
                                              concepts[5].conceptstatus == '1'
                                                  ? ColorPalette.whitetextcolor
                                                  : ColorPalette.primarycolor),
                                    ),
                                  ],
                                ),
                              ]),
                          Positioned(
                              top: 10,
                              left: 8,
                              right: 8,
                              bottom: 10,
                              child: Iconify(
                                EmojioneMonotone.notebook,
                                size: 65,
                                color:
                                    ColorPalette.backgroundcolor1.withAlpha(30),
                              ))
                        ]),
                      ),
                    ),
                  ),
                )
              else
                SizedBox(
                  width: size.width * 0.26,
                  //child: Icon(Icons.arrow),
                ),
              Hero(
                tag: widget.lesson,
                child: HexagonWidget.pointy(
                  width: 130,
                  cornerRadius: 15,
                  color: ColorPalette.secondarycolor,
                  child: HexagonWidget.pointy(
                    width: 110,
                    cornerRadius: 15,
                    color: ColorPalette.whitetextcolor,
                    child: Center(
                      child: Text(
                        lessonName,
                        style: const TextStyle(
                            fontSize: 20,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            color: ColorPalette.textcolor),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    _isLoaderVisible = true;
                  });

                  var value = await screensList(concepts[2].conceptId);
                  if (value == 'concept data is incomplete!') {
                    // ignore: use_build_context_synchronously
                    screenAreNotAsssigned(context);
                  } else if (concepts[2].conceptstatus == '1') {
                    // ignore: use_build_context_synchronously
                    completed(context);
                  } else {
                    loader();
                    const idx = 0;
                    newunit = widget.unit;
                    newlesson = widget.lesson;
                    newconpt = concepts[2];
                    newscreen.gsHeading = widget.lesson.glossary;
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder:
                                ((context, animation, secondaryAnimation) =>
                                    QuestionPage(
                                        index: idx,
                                        glossary: widget.lesson.glossary))));
                    //navigatetoScreen(context, idx);
                  }
                  setState(() {
                    _isLoaderVisible = false;
                  });
                },
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor:
                      ColorPalette.backgroundcolor2.withOpacity(0.5),
                  child: HexagonWidget.pointy(
                    width: size.width * 0.26,
                    cornerRadius: 15,
                    color: concepts[2].conceptstatus == '1'
                        ? ColorPalette.backgroundcolor1
                        : ColorPalette.backgroundcolor1.withOpacity(0.2),
                    child: HexagonWidget.pointy(
                      width: size.width * 0.20,
                      cornerRadius: 15,
                      color: concepts[2].conceptstatus == '1'
                          ? ColorPalette.backgroundcolor1
                          : ColorPalette.backgroundcolor2,
                      child: Stack(children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                concepts[2].conceptName ?? 'empty',
                                style: TextStyle(
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.bold,
                                    color: concepts[2].conceptstatus == '1'
                                        ? ColorPalette.whitetextcolor
                                        : ColorPalette.textcolor),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/xp_icon.svg',
                                    width: 15,
                                    color: ColorPalette.xpiconcolor,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    concepts[2].xp ?? '',
                                    style: TextStyle(
                                        color: concepts[2].conceptstatus == '1'
                                            ? ColorPalette.whitetextcolor
                                            : ColorPalette.primarycolor),
                                  ),
                                ],
                              ),
                            ]),
                        Positioned(
                            top: 10,
                            left: 8,
                            right: 8,
                            bottom: 10,
                            child: Iconify(
                              EmojioneMonotone.notebook,
                              size: 65,
                              color:
                                  ColorPalette.backgroundcolor1.withAlpha(30),
                            ))
                      ]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  setState(() {
                    _isLoaderVisible = true;
                  });
                  var value = await screensList(concepts[4].conceptId);
                  if (value == 'concept data is incomplete!') {
                    // ignore: use_build_context_synchronously
                    screenAreNotAsssigned(context);
                  } else if (concepts[4].conceptstatus == '1') {
                    // ignore: use_build_context_synchronously
                    completed(context);
                  } else {
                    loader();
                    const idx = 0;
                    newunit = widget.unit;
                    newlesson = widget.lesson;
                    newconpt = concepts[4];
                    newscreen.gsHeading = widget.lesson.glossary;
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder:
                                ((context, animation, secondaryAnimation) =>
                                    QuestionPage(
                                        index: idx,
                                        glossary: widget.lesson.glossary))));
                    //navigatetoScreen(context, idx);
                  }
                  setState(() {
                    _isLoaderVisible = false;
                  });
                },
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor:
                      ColorPalette.backgroundcolor2.withOpacity(0.5),
                  child: HexagonWidget.pointy(
                    width: size.width * 0.26,
                    cornerRadius: 15,
                    color: concepts[4].conceptstatus == '1'
                        ? ColorPalette.backgroundcolor1
                        : ColorPalette.backgroundcolor1.withOpacity(0.2),
                    child: HexagonWidget.pointy(
                      width: size.width * 0.20,
                      cornerRadius: 15,
                      color: concepts[4].conceptstatus == '1'
                          ? ColorPalette.backgroundcolor1
                          : ColorPalette.backgroundcolor2,
                      child: Stack(children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                concepts[4].conceptName ?? 'empty',
                                style: TextStyle(
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.bold,
                                    color: concepts[4].conceptstatus == '1'
                                        ? ColorPalette.whitetextcolor
                                        : ColorPalette.textcolor),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/xp_icon.svg',
                                    width: 15,
                                    color: ColorPalette.xpiconcolor,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    concepts[4].xp ?? '',
                                    style: TextStyle(
                                        color: concepts[4].conceptstatus == '1'
                                            ? ColorPalette.whitetextcolor
                                            : ColorPalette.primarycolor),
                                  ),
                                ],
                              ),
                            ]),
                        Positioned(
                            top: 10,
                            left: 8,
                            right: 8,
                            bottom: 10,
                            child: Iconify(
                              EmojioneMonotone.notebook,
                              size: 65,
                              color:
                                  ColorPalette.backgroundcolor1.withAlpha(30),
                            ))
                      ]),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.1,
              ),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    _isLoaderVisible = true;
                  });
                  var value = await screensList(concepts[3].conceptId);
                  if (value == 'concept data is incomplete!') {
                    // ignore: use_build_context_synchronously
                    screenAreNotAsssigned(context);
                  } else if (concepts[3].conceptstatus == '1') {
                    // ignore: use_build_context_synchronously
                    completed(context);
                  } else {
                    loader();
                    const idx = 0;
                    newunit = widget.unit;
                    newlesson = widget.lesson;
                    newconpt = concepts[3];
                    newscreen.gsHeading = widget.lesson.glossary;
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder:
                                ((context, animation, secondaryAnimation) =>
                                    QuestionPage(
                                        index: idx,
                                        glossary: widget.lesson.glossary))));
                    //navigatetoScreen(context, idx);
                  }
                  setState(() {
                    _isLoaderVisible = false;
                  });
                },
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor:
                      ColorPalette.backgroundcolor2.withOpacity(0.5),
                  child: HexagonWidget.pointy(
                    width: size.width * 0.26,
                    cornerRadius: 15,
                    color: concepts[3].conceptstatus == '1'
                        ? ColorPalette.backgroundcolor1
                        : ColorPalette.backgroundcolor1.withOpacity(0.2),
                    child: HexagonWidget.pointy(
                      width: size.width * 0.20,
                      cornerRadius: 15,
                      color: concepts[3].conceptstatus == '1'
                          ? ColorPalette.backgroundcolor1
                          : ColorPalette.backgroundcolor2,
                      child: Stack(children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                concepts[3].conceptName ?? 'empty',
                                style: TextStyle(
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.bold,
                                    color: concepts[3].conceptstatus == '1'
                                        ? ColorPalette.whitetextcolor
                                        : ColorPalette.textcolor),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/xp_icon.svg',
                                    width: 15,
                                    color: ColorPalette.xpiconcolor,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    concepts[3].xp ?? '',
                                    style: TextStyle(
                                        color: concepts[3].conceptstatus == '1'
                                            ? ColorPalette.whitetextcolor
                                            : ColorPalette.primarycolor),
                                  ),
                                ],
                              ),
                            ]),
                        Positioned(
                            top: 10,
                            left: 8,
                            right: 8,
                            bottom: 10,
                            child: Iconify(
                              EmojioneMonotone.notebook,
                              size: 65,
                              color:
                                  ColorPalette.backgroundcolor1.withAlpha(30),
                            ))
                      ]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
