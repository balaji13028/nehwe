import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexagon/hexagon.dart';
import '../constants/color_palettes.dart';
import '../models/buddies_model.dart';

class LocalRank extends StatefulWidget {
  const LocalRank({super.key});

  @override
  State<LocalRank> createState() => _LocalRankState();
}

class _LocalRankState extends State<LocalRank> {
  List<BuddyProfileData> localusers = buddiesList;
  List<BuddyProfileData> friends = [];
  BuddyProfileData user = userBuddy[0];
  List<BuddyProfileData> sortedList = [];
  late int indexrank;
  @override
  void initState() {
    super.initState();
    for (var frd in localusers) {
      if (frd.status == '1') {
        friends.add(frd);
      }
    }
    //sorted list by xp
    friends.add(user);
    sortedList = friends
      ..sort(
          ((a, b) => int.parse(b.buddyXp!).compareTo(int.parse(a.buddyXp!))));

    //to get user rank value
    indexrank = sortedList.indexWhere((b) => b.buddyId == user.buddyId) + 1;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Card(
          color: ColorPalette.backgroundcolor2,
          elevation: 4,
          shadowColor: ColorPalette.backgroundcolor2,
          child: Container(
            height: size.height * 0.07,
            width: size.width,
            padding: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: ColorPalette.backgroundcolor2,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: size.width * 0.1,
                      child: Text(
                        indexrank.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 18, color: ColorPalette.textcolor),
                      ),
                    ),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: ColorPalette.backgroundcolor2,
                      child: HexagonWidget.pointy(
                        cornerRadius: 10,
                        height: 50,
                        width: 50,
                        color: ColorPalette.backgroundcolor1,
                        child: SvgPicture.string(
                          user.buddyAvatar!,
                          width: size.width * 0.088,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        user.buddyDisplayName ?? 'buddy',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 18,
                            color: ColorPalette.textcolor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Total xp',
                          style: TextStyle(
                              fontSize: 12,
                              color: ColorPalette.textcolor.withOpacity(0.6)),
                        ),
                        Text(
                          user.buddyXp ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: ColorPalette.secondarycolor),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    SvgPicture.asset(
                      'assets/icons/xp_icon.svg',
                      fit: BoxFit.none,
                      color: ColorPalette.xpiconcolor,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: size.height - size.height * 0.25 - size.height * 0.203,
          width: size.width,
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return (index + 1) == indexrank
                  ? const SizedBox()
                  : const Divider(thickness: 0.5);
            },
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: sortedList.length,
            padding: const EdgeInsets.only(left: 5, right: 15, top: 5),
            itemBuilder: (context, index) {
              var length = (localusers.length >= 1000);
              return (index + 1) == indexrank
                  ? const SizedBox()
                  : Container(
                      height: size.height * 0.06,
                      width: size.width,
                      decoration: const BoxDecoration(
                        color: ColorPalette.whitetextcolor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: length
                                    ? size.width * 0.14
                                    : size.width * 0.1,
                                child: Text(
                                  (index + 1).toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: ColorPalette.textcolor),
                                ),
                              ),
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: ColorPalette.backgroundcolor2,
                                child: HexagonWidget.pointy(
                                  cornerRadius: 10,
                                  height: 50,
                                  width: 50,
                                  color: ColorPalette.backgroundcolor1,
                                  child: SvgPicture.string(
                                    sortedList[index].buddyAvatar!,
                                    width: size.width * 0.088,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  sortedList[index].buddyDisplayName ?? 'buddy',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: ColorPalette.textcolor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Total xp',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: ColorPalette.textcolor
                                            .withOpacity(0.6)),
                                  ),
                                  Text(
                                    sortedList[index].buddyXp ?? '',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: ColorPalette.secondarycolor),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 10),
                              SvgPicture.asset(
                                'assets/icons/xp_icon.svg',
                                fit: BoxFit.none,
                                color: ColorPalette.xpiconcolor,
                              ),
                            ],
                          )
                        ],
                      ),
                    );
            },
          ),
        ),
      ],
    );
  }
}
