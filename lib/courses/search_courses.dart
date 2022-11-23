import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nehwe/courses/units_screen.dart';
import 'package:nehwe/models/courses_model.dart';
import 'package:nehwe/models/user_details_model.dart';
import '../api_calls/units_api.dart';
import '../constants/color_palettes.dart';

class SearchCourses extends SearchDelegate {
  // list to show querying
  List<CoursesData> courses = courseList;
  UserProfileData user = localUserList[0];
  var courseimage = [];

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: Colors.black),
        primaryColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: ColorPalette.primarycolor),
          elevation: 0,
          color: ColorPalette.backgroundcolor2,
        ),
        inputDecorationTheme: const InputDecorationTheme(
            isDense: true, border: InputBorder.none));
  }

  // first overwrite to
  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        style: ButtonStyle(
            overlayColor:
                MaterialStateColor.resolveWith((states) => Colors.transparent)),
        onPressed: () {
          query = '';
        },
        icon: const Icon(
          Icons.clear,
          size: 28,
        ),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(
        Icons.arrow_back,
        size: 28,
      ),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    for (var image in courses) {
      courseimage.add(base64Decode(image.courseImage!));
    }
    Size size = MediaQuery.of(context).size;
    List<CoursesData> matchQuery = [];
    for (var course in courses) {
      if (course.courseName!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(course);
      }
    }
    return (matchQuery.length.toString() != '0')
        ? (query != '')
            ? ListView.builder(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: matchQuery.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      await unitsList(matchQuery[index].courseId, user.id);
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                              barrierDismissible: true,
                              pageBuilder:
                                  ((context, animation, secondaryAnimation) =>
                                      Units(
                                        course: matchQuery[index],
                                      ))));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      margin: const EdgeInsets.only(top: 10, bottom: 5),
                      height: size.height * 0.12,
                      width: size.width * 0.36,
                      decoration: BoxDecoration(
                          color: ColorPalette.whitetextcolor,
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 0),
                                blurRadius: 1.5,
                                color: Colors.grey.withOpacity(0.6)),
                          ],
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: size.height * 0.09,
                            width: size.width * 0.22,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: ColorPalette.whitetextcolor,
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(0, 0),
                                      blurRadius: 1.5,
                                      color: Colors.grey.withOpacity(0.6)),
                                ],
                                borderRadius: BorderRadius.circular(8)),
                            child: Image.memory(
                              courseimage[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              matchQuery[index].courseName ?? 'courseName',
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: ColorPalette.textcolor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : const Center(child: Text('Not found'))
        : const SizedBox();
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    for (var image in courses) {
      courseimage.add(base64Decode(image.courseImage!));
    }
    Size size = MediaQuery.of(context).size;
    List<CoursesData> matchQuery = [];

    for (var course in courses) {
      if (course.courseName!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(course);
      }
    }
    var a = query.length;
    return (a > 0 || query != '')
        ? ListView.builder(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: matchQuery.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  await unitsList(matchQuery[index].courseId, user.id);
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          barrierDismissible: true,
                          pageBuilder:
                              ((context, animation, secondaryAnimation) =>
                                  Units(
                                    course: matchQuery[index],
                                  ))));
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: const EdgeInsets.only(top: 10, bottom: 5),
                  height: size.height * 0.12,
                  width: size.width * 0.36,
                  decoration: BoxDecoration(
                      color: ColorPalette.whitetextcolor,
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 0),
                            blurRadius: 1.5,
                            color: Colors.grey.withOpacity(0.6)),
                      ],
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: size.height * 0.09,
                        width: size.width * 0.22,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: ColorPalette.whitetextcolor,
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, 0),
                                  blurRadius: 1.5,
                                  color: Colors.grey.withOpacity(0.6)),
                            ],
                            borderRadius: BorderRadius.circular(8)),
                        child: Image.memory(
                          courseimage[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          matchQuery[index].courseName ?? 'courseName',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: ColorPalette.textcolor),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        : const SizedBox();
  }
}
