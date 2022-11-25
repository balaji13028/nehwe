import 'dart:async';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexagon/hexagon.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/emojione_monotone.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:nehwe/loadings/loader.dart';
import 'package:nehwe/models/user_details_model.dart';
import 'package:nehwe/models/user_intime.dart';
import '../api_calls/buddies_api.dart';
import '../api_calls/concepts_api.dart';
import '../constants/color_palettes.dart';
import 'dart:math' as math;
import '../models/courses_model.dart';
import '../popup_messages/take_challenge_confirm_message.dart';
import '../popup_messages/taketest_confirm_message.dart';
import '../screens/buddies.dart';
import '../screens/dashboard.dart';
import '../screens/homepage.dart';
import '../screens/leaderboard.dart';
import '../screens/profile.dart';
import '../slide_drawers/slide_drawer.dart';
import 'concpets_screen.dart';

// ignore: must_be_immutable
class Units extends StatefulWidget {
  CoursesData course;
  Units({super.key, required this.course});

  @override
  State<Units> createState() => _UnitsState();
}

class _UnitsState extends State<Units> {
  List<UnitData> unit = unitlist;
  List<LessonData> lesson = lessonlist;
  UserProfileData user = localUserList[0];
  final slidebar = GlobalKey<ScaffoldState>();
  int _currentIndex = -1;
  PageController controller = PageController(initialPage: 0);
  bool _isLoaderVisible = false;
  Timer? timer;
  var intime = DateTime.parse(userTiming.intime.toString());
  String _timeasString = '';
  String minutes = '';
  String seconds = '';

  @override
  void initState() {
    timerRun();
    if (newunit.unitId == '10') {
      conceptstatus(newunit.unitId, '2', null, null, null, null, newUser.id);
    } //send to server (unit is completed).
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<LessonData> a1 = [];
    for (var element in unit) {
      int a2 = 0;
      int a3 = 0;
      for (var el in lesson) {
        if (element.unitId == el.unitId) {
          a1.add(el);
          if (el.lessonStatus == '2') {
            a2 = a2 + 1;
            a3 = a2 * int.parse(el.lessonXP!);
          }
        }
      }
      element.lessons = a1;
      element.compcount = a2;
      element.completedXP = a3;
      a1 = [];
    }

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
                  onTap: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder:
                                ((context, animation, secondaryAnimation) =>
                                    const DashBoard())));
                  },
                  child: const Icon(Icons.arrow_back_ios_new,
                      color: ColorPalette.primarycolor, size: 24),
                ),
                title: Text((widget.course.courseName == null)
                    ? 'Course Name'
                    : widget.course.courseName!),
                titleTextStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorPalette.primarycolor),
              )
            : null,
        body: Column(
          children: [
            if (_currentIndex == -1)
              Expanded(
                child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    controller: controller,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (unit[index].unitXP != null) {
                        var x = (70 / 100) * int.parse(unit[index].unitXP!);
                        var y = unit[index].completedXP!;
                        if (y >= x) {
                          if (index == 0) {
                            unit[0].status = 1;
                            unit[1].status = 1;
                          } else if (index == 1) {
                            unit[0].status = 1;
                            unit[1].status = 1;
                            unit[2].status = 1;
                          } else if (index == 2) {
                            unit[0].status = 1;
                            unit[1].status = 1;
                            unit[2].status = 1;
                            unit[3].status = 1;
                          } else if (index == 3) {
                            unit[0].status = 1;
                            unit[1].status = 1;
                            unit[2].status = 1;
                            unit[3].status = 1;
                            unit[4].status = 1;
                          } else if (index == 4) {
                            unit[0].status = 1;
                            unit[1].status = 1;
                            unit[2].status = 1;
                            unit[3].status = 1;
                            unit[4].status = 1;
                            unit[5].status = 1;
                          } else if (index == 5) {
                            unit[0].status = 1;
                            unit[1].status = 1;
                            unit[2].status = 1;
                            unit[3].status = 1;
                            unit[4].status = 1;
                            unit[5].status = 1;
                          }
                        }
                      } else {
                        EasyLoading.showError('no more units');
                      }

                      return Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.26,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                index == 0
                                    ? Visibility(
                                        maintainSize: true,
                                        maintainAnimation: true,
                                        maintainState: true,
                                        visible: false,
                                        child: Transform(
                                            alignment: Alignment.center,
                                            transform:
                                                Matrix4.rotationY(math.pi),
                                            child: dotsindication(true)),
                                      )
                                    : Transform(
                                        alignment: Alignment.center,
                                        transform: Matrix4.rotationY(math.pi),
                                        child: dotsindication(true),
                                      ),
                                HexagonWidget.pointy(
                                  width: 150,
                                  cornerRadius: 20,
                                  color: (unit[index].unitStatus == '1' ||
                                          unit[index].unitStatus == '2' ||
                                          unit[index] == unit.first)
                                      ? ColorPalette.secondarycolor
                                      : ColorPalette.statusfillcolor,
                                  child: HexagonWidget.pointy(
                                    width: 130,
                                    cornerRadius: 20,
                                    color: (unit[index].unitStatus == '2')
                                        ? ColorPalette.secondarycolor
                                        : ColorPalette.whitetextcolor,
                                    child: Center(
                                        child: (unit[index] == unit.first ||
                                                unit[index].status == 1)
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    (unit[index].unitName !=
                                                            null)
                                                        ? unit[index].unitName!
                                                        : 'empty',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        overflow:
                                                            TextOverflow.fade,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: (unit[index]
                                                                    .unitStatus ==
                                                                '2')
                                                            ? ColorPalette
                                                                .whitetextcolor
                                                            : ColorPalette
                                                                .secondarycolor),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/icons/xp_icon.svg',
                                                        width: 15,
                                                        color: ColorPalette
                                                            .xpiconcolor,
                                                      ),
                                                      const SizedBox(
                                                        width: 6,
                                                      ),
                                                      RichText(
                                                        text: TextSpan(
                                                          text:
                                                              '${unit[index].completedXP}/',
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              color: (unit[index]
                                                                          .unitStatus ==
                                                                      '2')
                                                                  ? ColorPalette
                                                                      .whitetextcolor
                                                                  : ColorPalette
                                                                      .primarycolor),
                                                          children: [
                                                            TextSpan(
                                                              text: unit[index]
                                                                  .unitXP!,
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  color: (unit[index]
                                                                              .unitStatus ==
                                                                          '2')
                                                                      ? ColorPalette
                                                                          .whitetextcolor
                                                                      : ColorPalette
                                                                          .primarycolor),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            : const Icon(
                                                Icons.lock,
                                                size: 55,
                                                color: ColorPalette
                                                    .statusfillcolor,
                                              )),
                                  ),
                                ),
                                (unit.length == 1)
                                    ? Visibility(
                                        visible: false,
                                        maintainAnimation: true,
                                        maintainState: true,
                                        maintainSize: true,
                                        child: dotsindication(true))
                                    : dotsindication(true)
                              ],
                            ),
                          ),
                          (unit[index].status == 1 || unit[index] == unit.first)
                              ? Expanded(
                                  child: Container(
                                      width: size.width,
                                      padding: EdgeInsets.only(
                                          left: size.width * 0.05,
                                          right: size.width * 0.05,
                                          top: size.height * 0.025),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Lessons : ${unit[index].compcount}/${unit[index].lessons!.length}',
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: ColorPalette.textcolor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextButton(
                                                  style: ButtonStyle(
                                                    overlayColor: MaterialStateColor
                                                        .resolveWith((states) =>
                                                            Colors.transparent),
                                                  ),
                                                  onPressed: (() {
                                                    newcourse = widget.course;
                                                    newunit = unit[index];
                                                    newUser.id = user.id;
                                                    confirmToTakeTEST(
                                                      context,
                                                      widget.course.courseId,
                                                      unit[index].unitId,
                                                      user.id,
                                                    );
                                                  }),
                                                  child: Container(
                                                    height: size.height * 0.05,
                                                    width: size.width * 0.4,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: ColorPalette
                                                            .backgroundcolor2
                                                            .withOpacity(0.5)),
                                                    child: const Text(
                                                      'Take Test',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: ColorPalette
                                                              .primarycolor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  )),
                                              TextButton(
                                                  style: ButtonStyle(
                                                    overlayColor: MaterialStateColor
                                                        .resolveWith((states) =>
                                                            Colors.transparent),
                                                  ),
                                                  onPressed: (() {
                                                    confirmToChallenge(context);
                                                  }),
                                                  child: Container(
                                                    height: size.height * 0.05,
                                                    width: size.width * 0.4,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: ColorPalette
                                                            .backgroundcolor2
                                                            .withOpacity(0.5)),
                                                    child: const Text(
                                                      'Take Challange',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: ColorPalette
                                                              .primarycolor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                          Expanded(
                                            child: GridView.builder(
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 2,
                                                        childAspectRatio: (unit[
                                                                        index]
                                                                    .lessons!
                                                                    .length <=
                                                                4)
                                                            ? 1
                                                            : 1.1),
                                                controller: ScrollController(
                                                    keepScrollOffset: false),
                                                physics:
                                                    const ClampingScrollPhysics(),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        size.height * 0.025),
                                                itemCount:
                                                    unit[index].lessons!.length,
                                                itemBuilder: (context, i) {
                                                  return GestureDetector(
                                                    onTap: () async {
                                                      setState(() {
                                                        _isLoaderVisible = true;
                                                      });

                                                      if (unit[index]
                                                                  .lessons![i]
                                                                  .lessonStatus ==
                                                              '1' ||
                                                          unit[index]
                                                                  .lessons![i]
                                                                  .lessonStatus ==
                                                              '0') {
                                                        loader();
                                                        conceptlist =
                                                            await conceptsList(
                                                                widget.course
                                                                    .courseId,
                                                                unit[index]
                                                                    .unitId,
                                                                unit[index]
                                                                    .lessons![i]
                                                                    .lessonId,
                                                                user.id);
                                                        newcourse =
                                                            widget.course;
                                                        newunit = unit[index];
                                                        newUser.id = user.id;
                                                        // ignore: use_build_context_synchronously
                                                        Navigator.push(
                                                            context,
                                                            PageRouteBuilder(
                                                                pageBuilder: ((context,
                                                                        animation,
                                                                        secondaryAnimation) =>
                                                                    Lessons(
                                                                      unit: unit[
                                                                          index],
                                                                      course: widget
                                                                          .course,
                                                                      lesson: unit[
                                                                              index]
                                                                          .lessons![i],
                                                                    ))));
                                                      } else {
                                                        EasyLoading.showSuccess(
                                                            'You are already completed this lesson!');
                                                      }
                                                      setState(() {
                                                        _isLoaderVisible =
                                                            false;
                                                      });
                                                    },
                                                    child: Hero(
                                                        tag: unit[index]
                                                            .lessons![i],
                                                        child: lessonPane(
                                                          unit[index]
                                                              .lessons![i]
                                                              .lessonName!,
                                                          unit[index]
                                                              .lessons![i]
                                                              .lessonXP,
                                                          unit[index]
                                                              .lessons![i]
                                                              .lessonStatus!,
                                                        )),
                                                  );
                                                }),
                                          ),
                                        ],
                                      )),
                                )
                              : lockedUnit(context)
                        ],
                      );
                    }),
              )
            else if (_currentIndex == 0)
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
        bottomNavigationBar: Column(mainAxisSize: MainAxisSize.min, children: [
          Column(
            children: [
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
                              color:
                                  ColorPalette.whitetextcolor.withOpacity(0.5),
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
                      onTap: (index) async {
                        if (index == 2) {
                          await getbuddies(user.id);
                          setState(() {
                            _currentIndex = index;
                            _isLoaderVisible = true;
                            loader();
                          });
                        } else {
                          setState(() {
                            _currentIndex = index;
                          });
                        }
                      },
                    )
                  : CustomNavigationBar(
                      iconSize: 35.0,
                      scaleFactor: 0.5,
                      bubbleCurve: Curves.ease,
                      strokeColor: Colors.transparent,
                      selectedColor:
                          ColorPalette.whitetextcolor.withOpacity(0.5),
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
                              color:
                                  ColorPalette.whitetextcolor.withOpacity(0.5),
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
                      onTap: (index) async {
                        if (index == 2) {
                          await getbuddies(user.id);
                          setState(() {
                            _currentIndex = index;
                            loader();
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
        ]),
      ),
    );
  }

  Widget lessonPane(String lessonname, lessonxp, lessonStatus) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 55,
          backgroundColor: ColorPalette.backgroundcolor2.withOpacity(0.5),
          child: HexagonWidget.pointy(
            width: 120,
            cornerRadius: 15,
            color: (lessonStatus == '1' || lessonStatus == '2')
                ? ColorPalette.backgroundcolor1
                : ColorPalette.backgroundcolor1.withOpacity(0.2),
            child: HexagonWidget.pointy(
              width: 80,
              cornerRadius: 15,
              color: (lessonStatus == '2')
                  ? ColorPalette.backgroundcolor1
                  : ColorPalette.backgroundcolor2,
              child: Stack(children: [
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    lessonname,
                    style: TextStyle(
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                        color: (lessonStatus == '2')
                            ? ColorPalette.whitetextcolor
                            : ColorPalette.textcolor),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                      RichText(
                        text: TextSpan(
                          text: '$lessonxp',
                          style: TextStyle(
                              fontSize: 13,
                              color: (lessonStatus == '2')
                                  ? ColorPalette.whitetextcolor
                                  : ColorPalette.primarycolor),
                          // children: [
                          //   TextSpan(
                          //     text: '$lessonxp',
                          //     style: TextStyle(
                          //         fontSize: 9,
                          //         color: (lessonStatus == '2')
                          //             ? ColorPalette.whitetextcolor
                          //             : ColorPalette.primarycolor),
                          //   )
                          // ],
                        ),
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
                      EmojioneMonotone.light_bulb,
                      size: 65,
                      color: ColorPalette.backgroundcolor1.withAlpha(30),
                    ))
              ]),
            ),
          ),
        ),
        (lessonStatus == '1')
            ? const Text(
                'Started',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorPalette.textcolor,
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            : (lessonStatus == '2')
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.check_circle,
                        size: 18,
                        color: ColorPalette.rightAnstextlcolor,
                      ),
                      Text(
                        'Completed',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ColorPalette.textcolor,
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )
                : const Text(
                    'Not Started',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorPalette.textcolor,
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
      ],
    );
  }

  Widget lockedUnit(context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
        alignment: Alignment.bottomLeft,
        clipBehavior: Clip.none,
        children: [
          Container(
              height: size.height * 0.28,
              width: size.width,
              margin: EdgeInsets.only(
                  left: 20, right: 20, top: size.height * 0.085),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: ColorPalette.backgroundcolor1.withOpacity(0.4),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Lessons are locked',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: ColorPalette.textcolor),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'To unlock this unit you have to complete at least 70% of the before unit.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                  Text(
                    '------ OR ------',
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    'Completed the test ',
                    style: TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                ],
              )),
          Positioned(
              top: size.height * 0.045,
              left: size.height * 0.05,
              right: size.height * 0.05,
              child: Container(
                height: size.height * 0.08,
                width: size.width * 0.4,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: ColorPalette.secondarycolor),
                child: const Text(
                  '!',
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
              )),
          Positioned(
              bottom: -size.height * 0.065,
              child: Image.asset(
                'assets/mascots/telling.png',
                width: size.width * 0.35,
              )),
          Positioned(
              bottom: -size.height * 0.05,
              left: 20,
              child: Container(
                height: 2,
                width: size.height * 0.1,
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.grey, blurRadius: 5, offset: Offset(1, 5))
                ]),
              ))
        ]);
  }

  Row dotsindication(bool status) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          height: 12,
          width: 12,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: ColorPalette.secondarycolor),
        ),
        Container(
          height: 8,
          width: 8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorPalette.secondarycolor),
        ),
        Container(
          height: 4,
          width: 4,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorPalette.secondarycolor),
        ),
      ],
    );
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

  loader() async {
    if (_isLoaderVisible) {
      context.loaderOverlay.show();
    } else {
      context.loaderOverlay.hide();
    }
  }
}
