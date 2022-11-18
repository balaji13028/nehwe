import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:nehwe/loadings/loader.dart';
import 'package:nehwe/models/buddies_model.dart';
import '../buddies_profiles/buddie_add.dart';
import '../buddies_profiles/buddie_added_profile.dart';
import '../constants/color_palettes.dart';

class Buddies extends StatefulWidget {
  const Buddies({Key? key}) : super(key: key);

  @override
  State<Buddies> createState() => _BuddiesState();
}

class _BuddiesState extends State<Buddies> {
  List<BuddyProfileData> buddies = buddiesList;
  bool _isLoaderVisible = false;
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
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${buddies.length}',
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
                      margin:
                          EdgeInsets.symmetric(vertical: size.height * 0.015),
                      padding: EdgeInsets.only(
                          left: size.height * 0.015,
                          right: size.height * 0.002),
                      height: size.height * 0.05,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorPalette.searchbarcolor.withOpacity(0.7)),
                      child: TextFormField(
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
                                color: ColorPalette.textcolor.withOpacity(0.6),
                                fontWeight: FontWeight.w500),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none),
                      )),
                  Row(
                    children: [
                      Text(
                        'Your Buddies ',
                        style: TextStyle(
                          color: ColorPalette.textcolor.withOpacity(0.8),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox();
                        },
                        itemCount: buddies.length,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          const BuddieProfile())));
                            },
                            child: Container(
                              height: size.height * 0.06,
                              width: double.infinity,
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: ColorPalette.backgroundcolor2,
                                  boxShadow: const [
                                    BoxShadow(
                                        offset: Offset(0, 0),
                                        color: Colors.black45),
                                  ]),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                                ColorPalette.backgroundcolor1,
                                            radius: size.height * 0.03,
                                            child: SvgPicture.string(
                                              buddies[index].buddyAvatar!,
                                              width: size.width * 0.088,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              buddies[index].buddyName ??
                                                  'buddy',
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color:
                                                      ColorPalette.primarycolor,
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
                        }),
                  ),
                  // Row(
                  //   children: [
                  //     Text(
                  //       'Suggestions ',
                  //       style: TextStyle(
                  //         color: ColorPalette.textcolor.withOpacity(0.8),
                  //         fontSize: 13,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Expanded(
                  //   child: ListView.builder(
                  //     itemCount: 4,
                  //     physics: const ClampingScrollPhysics(),
                  //     itemBuilder: (context, index) {
                  //       return GestureDetector(
                  //         onTap: () {
                  //           Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                   builder: ((context) => const BuddieAdd())));
                  //         },
                  //         child: Container(
                  //           height: size.height * 0.06,
                  //           width: double.infinity,
                  //           margin: const EdgeInsets.only(top: 10, bottom: 10),
                  //           padding: const EdgeInsets.symmetric(
                  //               horizontal: 10, vertical: 5),
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(10),
                  //             color: ColorPalette.backgroundcolor2
                  //                 .withOpacity(0.8),
                  //           ),
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               SizedBox(
                  //                 child: Row(
                  //                   children: [
                  //                     CircleAvatar(
                  //                       radius: 20,
                  //                       child: Image.asset(
                  //                           'assets/images/avatar1.png'),
                  //                     ),
                  //                     const Padding(
                  //                       padding: EdgeInsets.only(left: 10),
                  //                       child: Text(
                  //                         'Mahamadou_Lovel',
                  //                         style: TextStyle(
                  //                             fontSize: 18,
                  //                             color: ColorPalette.primarycolor,
                  //                             fontWeight: FontWeight.w600),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //               Container(
                  //                 height: 35,
                  //                 width: 35,
                  //                 margin: const EdgeInsets.symmetric(
                  //                     horizontal: 5, vertical: 5),
                  //                 decoration: BoxDecoration(
                  //                     borderRadius: BorderRadius.circular(5),
                  //                     color: ColorPalette.secondarycolor),
                  //                 child: const Icon(
                  //                   Icons.add,
                  //                   color: ColorPalette.whitetextcolor,
                  //                   size: 28,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
