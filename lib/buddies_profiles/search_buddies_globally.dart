import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nehwe/models/buddies_model.dart';
import 'package:nehwe/models/user_details_model.dart';
import '../constants/color_palettes.dart';
import 'buddie_profile.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<bool> onTap = [];
  // list to show querying
  List<BuddyProfileData> listusers = listofusers;
  UserProfileData user = localUserList[0];
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
    Size size = MediaQuery.of(context).size;
    List<BuddyProfileData> matchQuery = [];
    for (var buddy in listusers) {
      if (user.id != buddy.buddyId) {
        if (buddy.buddyDisplayName!
            .toLowerCase()
            .contains(query.toLowerCase())) {
          matchQuery.add(buddy);
        }
      }
    }
    return (matchQuery.length.toString() != '0')
        ? (query != '')
            ? ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: ColorPalette.textcolor,
                    thickness: 0.1,
                  );
                },
                itemCount: matchQuery.length,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                itemBuilder: (context, index) {
                  var result = matchQuery[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  BuddieProfile(buddy: matchQuery[index]))));
                    },
                    child: Container(
                      color: Colors.transparent,
                      width: double.infinity,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        ColorPalette.backgroundcolor1,
                                    radius: size.height * 0.03,
                                    child: SvgPicture.string(
                                      result.buddyAvatar!,
                                      width: size.width * 0.088,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      result.buddyDisplayName!,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: ColorPalette.primarycolor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: ColorPalette.secondarycolor,
                              size: 18,
                            )
                          ]),
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
    Size size = MediaQuery.of(context).size;
    List<BuddyProfileData> matchQuery = [];

    for (var buddy in listusers) {
      if (user.id != buddy.buddyId) {
        if (buddy.buddyDisplayName!
            .toLowerCase()
            .contains(query.toLowerCase())) {
          matchQuery.add(buddy);
        }
      }
    }
    var a = query.length;
    return (a > 0 || query != '')
        ? ListView.separated(
            separatorBuilder: (context, index) {
              return const Divider(
                color: ColorPalette.textcolor,
                thickness: 0.1,
              );
            },
            itemCount: matchQuery.length,
            padding: EdgeInsets.only(
                left: size.width * 0.04, right: size.width * 0.04, top: 10),
            itemBuilder: (context, index) {
              onTap.add(false);
              var result = matchQuery[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => BuddieProfile(
                                buddy: matchQuery[index],
                              ))));
                },
                child: Container(
                  color: Colors.transparent,
                  width: size.width,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: ColorPalette.backgroundcolor1,
                                radius: size.height * 0.025,
                                child: SvgPicture.string(
                                  result.buddyAvatar!,
                                  width: size.width * 0.078,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  result.buddyDisplayName!,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: ColorPalette.primarycolor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: ColorPalette.secondarycolor,
                          size: 18,
                        )
                      ]),
                ),
              );
            },
          )
        : const SizedBox();
  }
}
