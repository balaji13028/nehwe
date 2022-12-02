import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:nehwe/api_calls/buddies_api.dart';
import 'package:nehwe/api_calls/push_notification.dart';
import 'package:nehwe/loadings/loader.dart';
import 'package:nehwe/models/buddies_model.dart';
import 'package:nehwe/models/user_details_model.dart';
import '../buddies_profiles/buddie_profile.dart';
import '../buddies_profiles/search_buddies_globally.dart';
import '../constants/color_palettes.dart';

class Buddies extends StatefulWidget {
  const Buddies({Key? key}) : super(key: key);

  @override
  State<Buddies> createState() => _BuddiesState();
}

class _BuddiesState extends State<Buddies> {
  List<BuddyProfileData> buddies = buddiesList;
  List<BuddyProfileData> listusers = listofusers;
  List<FriendRequestsData> requets = requestsList;
  List<FriendRequestsData> suggestions = suggestionsList;
  List<bool> ontap = [];
  UserProfileData user = localUserList[0];
  bool isLoaderVisible = false;
  List<bool> rejected = [];
  List<bool> accepted = [];
  List<bool> addBuddy = [];
  List<bool> remove = [];
  var friendRequests = [];
  List<BuddyProfileData> friends = [];
  List<BuddyProfileData> friendsuggestions = [];
  loader() async {
    if (isLoaderVisible) {
      context.loaderOverlay.show();
    } else {
      context.loaderOverlay.hide();
    }
  }

  @override
  void initState() {
    for (var values in buddies) {
      if (values.status == '1') {
        friends.add(values);
      }
    } //to get friends list

    for (var data in requets) {
      if (data.requetsedUserId == user.id) {
        for (var value in listusers) {
          if (data.friendStatus == '0' && value.buddyId == data.senderUesrId) {
            value.requestStatus = data.friendStatus;
            friendRequests.add(value);
          }
        }
      }
    } // to get friend requests.

    for (var a in suggestions) {
      for (var b in listusers) {
        if (a.suggestionId == b.buddyId && b.status != '0') {
          friendsuggestions.add(b);
        }
      }
    } // to get suggestions friend details from listofusers compare to suggestions ids.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: GlobalLoaderOverlay(
        overlayWidget: const Loader(),
        useDefaultLoading: false,
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
              padding: const EdgeInsets.only(top: 10, bottom: 5),
              decoration: BoxDecoration(
                color: ColorPalette.whitetextcolor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: CustomScrollView(
                  physics: const ClampingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      backgroundColor: ColorPalette.whitetextcolor,
                      toolbarHeight: size.height * 0.12,
                      elevation: 0,
                      pinned: true,
                      automaticallyImplyLeading: false,
                      centerTitle: false,
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Buddies',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: ColorPalette.primarycolor),
                              ),
                              SizedBox(
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.people_alt,
                                      size: 28,
                                      color: ColorPalette.primarycolor,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      '${friends.length}',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: ColorPalette.primarycolor),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(
                                vertical: size.height * 0.015),
                            padding: EdgeInsets.only(
                                left: size.height * 0.015,
                                right: size.height * 0.002),
                            height: size.height * 0.05,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorPalette.searchbarcolor
                                    .withOpacity(0.7)),
                            child: TextFormField(
                              readOnly: true,
                              onTap: () async {
                                showSearch(
                                  context: context,
                                  query: '',
                                  delegate: CustomSearchDelegate(),
                                );
                              },
                              style: const TextStyle(
                                  fontSize: 18, color: ColorPalette.textcolor),
                              cursorColor: const Color.fromARGB(244, 2, 65, 92),
                              cursorHeight: 18,
                              decoration: InputDecoration(
                                  suffixIcon: const Icon(Icons.search_sharp,
                                      color: ColorPalette.textcolor),
                                  hintText: "Search for buddies",
                                  hintStyle: TextStyle(
                                      height: 1.4,
                                      fontSize: 14,
                                      letterSpacing: 0.9,
                                      color: ColorPalette.textcolor
                                          .withOpacity(0.6),
                                      fontWeight: FontWeight.w500),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(children: [
                          (friendRequests.length.toString() != '0')
                              ? Row(
                                  children: [
                                    Text(
                                      'Friend Requests',
                                      style: TextStyle(
                                        color: ColorPalette.textcolor
                                            .withOpacity(0.8),
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                          (friendRequests.length.toString() != '0')
                              ? ListTileTheme.merge(
                                  dense: true,
                                  child: ListView.builder(
                                    itemCount: friendRequests.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      ontap.add(false);
                                      rejected.add(false);
                                      accepted.add(false);
                                      return GestureDetector(
                                        onTap: () async {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      BuddieProfile(
                                                          buddy: friendRequests[
                                                              index]))));
                                        },
                                        child: (rejected[index] == true)
                                            ? const SizedBox()
                                            : Container(
                                                height: size.height * 0.06,
                                                width: double.infinity,
                                                margin: const EdgeInsets.only(
                                                    top: 10),
                                                padding: const EdgeInsets.only(
                                                    left: 10,
                                                    top: 2,
                                                    bottom: 2),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: ColorPalette
                                                      .whitetextcolor,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      child: Row(
                                                        children: [
                                                          CircleAvatar(
                                                            backgroundColor:
                                                                ColorPalette
                                                                    .backgroundcolor1,
                                                            radius:
                                                                size.height *
                                                                    0.03,
                                                            child: SvgPicture
                                                                .string(
                                                              friendRequests[
                                                                      index]
                                                                  .buddyAvatar!,
                                                              width:
                                                                  size.width *
                                                                      0.088,
                                                            ),
                                                          ),
                                                          Container(
                                                            width: size.width *
                                                                0.3,
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10),
                                                            child: Text(
                                                              friendRequests[
                                                                          index]
                                                                      .buddyDisplayName ??
                                                                  'buddy',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: const TextStyle(
                                                                  fontSize: 18,
                                                                  color: ColorPalette
                                                                      .textcolor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    (accepted[index] == true)
                                                        ? const Icon(
                                                            Icons.check,
                                                            color: ColorPalette
                                                                .greenColor,
                                                            size: 24,
                                                          )
                                                        : Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              TextButton(
                                                                style:
                                                                    ButtonStyle(
                                                                  overlayColor:
                                                                      MaterialStateColor.resolveWith(
                                                                          (states) =>
                                                                              Colors.transparent),
                                                                ),
                                                                onPressed:
                                                                    () async {
                                                                  setState(() {
                                                                    ontap[index] =
                                                                        true;
                                                                    rejected[
                                                                            index] =
                                                                        true;
                                                                  });
                                                                  if (ontap[
                                                                          index] ==
                                                                      true) {
                                                                    // await friendRequestResponse(
                                                                    //     friendRequests[index]
                                                                    //         .buddyId,
                                                                    //     user.id,
                                                                    //     '2');
                                                                    await sendFriendNotifation(
                                                                        user.id,
                                                                        friendRequests[
                                                                            index],
                                                                        'challenge');
                                                                  }
                                                                },
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      size.height *
                                                                          0.03,
                                                                  width:
                                                                      size.width *
                                                                          0.16,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                      border: Border.all(
                                                                          width:
                                                                              0.4,
                                                                          color:
                                                                              ColorPalette.secondarycolor)),
                                                                  child:
                                                                      const Text(
                                                                    'Reject',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: ColorPalette
                                                                            .primarycolor),
                                                                  ),
                                                                ),
                                                              ),
                                                              TextButton(
                                                                style:
                                                                    ButtonStyle(
                                                                  overlayColor:
                                                                      MaterialStateColor.resolveWith(
                                                                          (states) =>
                                                                              Colors.transparent),
                                                                ),
                                                                onPressed:
                                                                    () async {
                                                                  setState(() {
                                                                    ontap[index] =
                                                                        true;
                                                                    accepted[
                                                                            index] =
                                                                        true;
                                                                  });
                                                                  if (ontap[
                                                                          index] ==
                                                                      true) {
                                                                    // await friendRequestResponse(
                                                                    //     friendRequests[index]
                                                                    //         .buddyId,
                                                                    //     user.id,
                                                                    //     '1');
                                                                    await sendFriendNotifation(
                                                                        user.id,
                                                                        friendRequests[index]
                                                                            .buddyId,
                                                                        'challenge');
                                                                  }
                                                                },
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      size.height *
                                                                          0.03,
                                                                  width:
                                                                      size.width *
                                                                          0.16,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                      color: ColorPalette
                                                                          .primarycolor),
                                                                  child:
                                                                      const Text(
                                                                    'Accept',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: ColorPalette
                                                                            .whitetextcolor),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                  ],
                                                ),
                                              ),
                                      );
                                    },
                                  ),
                                )
                              : const SizedBox(),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                'Buddies '.trim(),
                                style: TextStyle(
                                  color:
                                      ColorPalette.textcolor.withOpacity(0.8),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          (friends.isNotEmpty)
                              ? ListTileTheme.merge(
                                  dense: true,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: friends.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        BuddieProfile(
                                                            buddy: friends[
                                                                index]))));
                                          },
                                          child: Container(
                                            height: size.height * 0.06,
                                            width: double.infinity,
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 2),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color:
                                                  ColorPalette.whitetextcolor,
                                            ),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    child: Row(
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundColor:
                                                              ColorPalette
                                                                  .backgroundcolor1,
                                                          radius: size.height *
                                                              0.03,
                                                          child:
                                                              SvgPicture.string(
                                                            friends[index]
                                                                .buddyAvatar!,
                                                            width: size.width *
                                                                0.088,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: Text(
                                                            friends[index]
                                                                    .buddyDisplayName ??
                                                                'buddy',
                                                            style: const TextStyle(
                                                                fontSize: 18,
                                                                color: ColorPalette
                                                                    .primarycolor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: ColorPalette
                                                        .secondarycolor,
                                                    size: 18,
                                                  )
                                                ]),
                                          ),
                                        );
                                      }),
                                )
                              : const Center(
                                  child: Text("No buddies"),
                                ),
                          const SizedBox(height: 10),
                          (friendsuggestions.isNotEmpty)
                              ? Row(
                                  children: [
                                    Text(
                                      'Suggestions'.trim(),
                                      style: TextStyle(
                                        color: ColorPalette.textcolor
                                            .withOpacity(0.8),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                          (friendsuggestions.isNotEmpty)
                              ? ListTileTheme.merge(
                                  dense: true,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: friendsuggestions.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, j) {
                                        remove.add(false);
                                        addBuddy.add(false);
                                        return Container(
                                          height: size.height * 0.06,
                                          width: double.infinity,
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 5,
                                              top: 2,
                                              bottom: 2),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: ColorPalette.whitetextcolor,
                                          ),
                                          child: (remove[j] == true)
                                              ? const SizedBox()
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                      GestureDetector(
                                                        onTap: () async {
                                                          if (addBuddy[j] ==
                                                              true) {
                                                            setState(() {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: ((context) =>
                                                                          BuddieProfile(
                                                                              buddy: friendsuggestions[j]))));
                                                            });
                                                          } else {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: ((context) =>
                                                                        BuddieProfile(
                                                                            buddy:
                                                                                friendsuggestions[j]))));
                                                          }
                                                        },
                                                        child: SizedBox(
                                                          child: Row(
                                                            children: [
                                                              CircleAvatar(
                                                                backgroundColor:
                                                                    ColorPalette
                                                                        .backgroundcolor1,
                                                                radius:
                                                                    size.height *
                                                                        0.03,
                                                                child:
                                                                    SvgPicture
                                                                        .string(
                                                                  friendsuggestions[
                                                                          j]
                                                                      .buddyAvatar!,
                                                                  width:
                                                                      size.width *
                                                                          0.088,
                                                                ),
                                                              ),
                                                              Container(
                                                                width:
                                                                    size.width *
                                                                        0.35,
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10),
                                                                child: Text(
                                                                  friendsuggestions[
                                                                              j]
                                                                          .buddyDisplayName ??
                                                                      'buddy',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      color: ColorPalette
                                                                          .primarycolor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      (addBuddy[j] == true)
                                                          ? Row(
                                                              children: const [
                                                                Icon(
                                                                  Icons.check,
                                                                  size: 24,
                                                                  color: ColorPalette
                                                                      .greenColor,
                                                                ),
                                                                Text(
                                                                  'Request Sent',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: ColorPalette
                                                                          .textcolor),
                                                                ),
                                                              ],
                                                            )
                                                          : Row(
                                                              children: [
                                                                TextButton(
                                                                  style:
                                                                      ButtonStyle(
                                                                    overlayColor:
                                                                        MaterialStateColor.resolveWith((states) =>
                                                                            Colors.transparent),
                                                                  ),
                                                                  onPressed:
                                                                      () async {
                                                                    setState(
                                                                        () {
                                                                      addBuddy[
                                                                              j] =
                                                                          true;
                                                                      friendsuggestions[
                                                                              j]
                                                                          .status = '0';
                                                                    });
                                                                    // await friendRequestResponse(
                                                                    //     user.id,
                                                                    //     friendsuggestions[j]
                                                                    //         .buddyId,
                                                                    //     '0');
                                                                    await sendFriendNotifation(
                                                                        user.id,
                                                                        friendsuggestions[j]
                                                                            .buddyId,
                                                                        'add friend');
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    height: size
                                                                            .height *
                                                                        0.034,
                                                                    width: size
                                                                            .width *
                                                                        0.22,
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                6),
                                                                        color: ColorPalette
                                                                            .primarycolor),
                                                                    child:
                                                                        const Text(
                                                                      'Add Buddy',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              ColorPalette.whitetextcolor),
                                                                    ),
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      remove[j] =
                                                                          true;
                                                                    });
                                                                  },
                                                                  child: const Icon(
                                                                      Icons
                                                                          .clear,
                                                                      size: 22,
                                                                      color: ColorPalette
                                                                          .exiticoncolor),
                                                                )
                                                              ],
                                                            ),
                                                    ]),
                                        );
                                      }),
                                )
                              : const SizedBox()
                        ]),
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
