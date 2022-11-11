import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:nehwe/loadings/loader.dart';
import 'package:nehwe/profile_pages/profile_screen.dart';
import '../api_calls/units_api.dart';
import '../constants/color_palettes.dart';

import '../courses/units_screen.dart';
import '../models/courses_model.dart';
import '../models/user_details_model.dart';

// ignore: must_be_immutable
class Homepage extends StatefulWidget {
  GlobalKey<ScaffoldState> slider;
  Homepage({super.key, required this.slider});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<CoursesData> course = courseList;
  UserProfileData user = localUserList[0];
  var courseImages = [];
  bool _isLoaderVisible = false;
  bool isvisible = true;
  loader(BuildContext context) {
    if (_isLoaderVisible) {
      context.loaderOverlay.show();
    } else {
      context.loaderOverlay.hide();
    }
  }

  @override
  void initState() {
    super.initState();
    for (var c in course) {
      courseImages.add(base64Decode(c.courseImage!));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: GlobalLoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: const Loader(),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/background_img.png',
                    ),
                    fit: BoxFit.cover)),
            child: SafeArea(
              child: Container(
                  margin: const EdgeInsets.only(left: 12, right: 12, top: 10),
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 15),
                  decoration: BoxDecoration(
                    color: ColorPalette.whitetextcolor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isvisible = false;
                                  });
                                  isvisible = true;
                                  widget.slider.currentState?.openDrawer();
                                },
                                child: Container(
                                  height: 30,
                                  width: 40,
                                  alignment: Alignment.topLeft,
                                  color: Colors.transparent,
                                  child: SvgPicture.asset(
                                    'assets/icons/menu_icon.svg',
                                    fit: BoxFit.none,
                                    color: ColorPalette.textcolor,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Hi, ',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        color: ColorPalette.primarycolor),
                                  ),
                                  Text(
                                    user.displayName!,
                                    style: const TextStyle(
                                        fontSize: 22,
                                        color: ColorPalette.textcolor),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                (user.xp == '0')
                                    ? 'Welcome To Nehwe'
                                    : 'Welcome Back',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: ColorPalette.textcolor),
                              )
                            ],
                          ),
                          Visibility(
                            visible: isvisible ? true : false,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                const ProfileDetails())));
                                  },
                                  child: CircleAvatar(
                                    backgroundColor:
                                        ColorPalette.backgroundcolor1,
                                    radius: 30,
                                    child: SvgPicture.string(
                                      user.avatar ?? '',
                                      width: 45,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: size.height * 0.03),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            stats(
                              context,
                              'Xp',
                              user.xp,
                              SvgPicture.asset(
                                'assets/icons/xp_icon.svg',
                                width: 30,
                                color: ColorPalette.xpiconcolor,
                              ),
                            ),
                            stats(
                              context,
                              'Lifes',
                              user.lifes,
                              SvgPicture.asset(
                                'assets/icons/lifes_icon.svg',
                                width: 30,
                                color: ColorPalette.lifescolor,
                              ),
                            ),
                            stats(
                              context,
                              'Coins',
                              user.coins,
                              SvgPicture.asset(
                                'assets/icons/money_icon.svg', width: 35,
                                //fit: BoxFit.none,
                                //color: Color.fromARGB(255, 196, 167, 2),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 20, bottom: 20),
                          padding: const EdgeInsets.only(left: 20, right: 10),
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorPalette.searchbarcolor),
                          child: TextFormField(
                            style: const TextStyle(
                                fontSize: 18, color: ColorPalette.textcolor),
                            cursorColor: const Color.fromARGB(244, 2, 65, 92),
                            decoration: InputDecoration(
                                suffixIcon: const Icon(Icons.search_sharp,
                                    color: ColorPalette.textcolor),
                                hintText: "Search",
                                hintStyle: TextStyle(
                                    height: 1.4,
                                    fontSize: 15,
                                    letterSpacing: 0.9,
                                    color:
                                        ColorPalette.textcolor.withOpacity(0.6),
                                    fontWeight: FontWeight.w500),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none),
                          )),
                      SizedBox(
                        child: Row(
                          children: const [
                            Text(
                              'Choose your course',
                              style: TextStyle(
                                  color: ColorPalette.secondarycolor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: GridView.builder(
                        physics: const ClampingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: size.width * 0.06,
                            mainAxisExtent: (course.length <= 4)
                                ? size.height * 0.235
                                : size.height * 0.23),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        itemCount: course.length,
                        itemBuilder: (context, index) {
                          if (index.isOdd) {
                            return GestureDetector(
                              onTap: () async {
                                setState(() {
                                  _isLoaderVisible = true;
                                });
                                loader(context);
                                //await unitList(course[index].courseId);
                                await unitsList(
                                    course[index].courseId, user.id);
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        barrierDismissible: true,
                                        pageBuilder: ((context, animation,
                                                secondaryAnimation) =>
                                            Units(
                                              course: course[index],
                                            ))));
                                setState(() {
                                  _isLoaderVisible = false;
                                });
                              },
                              child: Padding(
                                padding:
                                    EdgeInsets.only(top: size.height * 0.03),
                                child: courses(
                                    courseImages[index],
                                    (courseList.isNotEmpty)
                                        ? course[index].courseName
                                        : 'Web development',
                                    context),
                              ),
                            );
                          }
                          return GestureDetector(
                            onTap: () async {
                              setState(() {
                                _isLoaderVisible = true;
                              });
                              loader(context);
                              await unitsList(course[index].courseId, user.id);
                              //await unitsList(course[index].courseId, user.id);

                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                      barrierDismissible: true,
                                      pageBuilder: ((context, animation,
                                              secondaryAnimation) =>
                                          Units(
                                            course: course[index],
                                          ))));
                              setState(() {
                                _isLoaderVisible = false;
                              });
                            },
                            child: courses(
                                courseImages[index],
                                (courseList.isNotEmpty)
                                    ? course[index].courseName
                                    : 'Web development',
                                context),
                          );
                        },
                      ))
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  Widget courses(image, course, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: size.height * 0.2,
          width: size.width * 0.36,
          decoration: BoxDecoration(
              gradient: ColorPalette.gradientbutton1,
              borderRadius: BorderRadius.circular(8)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.memory(
                image,
                width: size.width * 0.18,
                height: size.height * 0.09,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 5),
                child: Text(
                  course,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: ColorPalette.whitetextcolor),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Container userStats(
    BuildContext context, String type, value, var icon, Color color) {
  Size size = MediaQuery.of(context).size;
  return Container(
    height: size.height * 0.045,
    width: size.width * 0.28,
    alignment: Alignment.center,
    padding: const EdgeInsets.only(left: 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: color.withOpacity(0.2)),
    child: Row(
      children: [
        icon,
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$type ',
                style: const TextStyle(
                  fontSize: 12,
                  color: ColorPalette.textcolor,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                    fontSize: 15,
                    color: ColorPalette.textcolor,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Container stats(BuildContext context, String type, value, var icon) {
  Size size = MediaQuery.of(context).size;
  return Container(
    height: size.height * 0.06,
    width: size.width * 0.28,
    alignment: Alignment.center,
    padding: const EdgeInsets.only(left: 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorPalette.backgroundcolor1.withOpacity(0.3)),
    child: Row(
      children: [
        icon,
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$type ',
                style: const TextStyle(
                  fontSize: 12,
                  color: ColorPalette.textcolor,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                    fontSize: 15,
                    color: ColorPalette.textcolor,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
