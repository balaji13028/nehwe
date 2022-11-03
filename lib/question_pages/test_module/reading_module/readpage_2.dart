import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nehwe/prepare_screen_list/test_screeens/test_screens_list.dart';
import 'package:nehwe/question_pages/test_module/test_screen_status.dart';

import '../../../constants/buttons.dart';
import '../../../constants/color_palettes.dart';
import '../../../models/courses_model.dart';
import '../../../prepare_screen_list/concept_screens/concept_prepare_ScreenList.dart';
import '../../../models/user_details_model.dart';
import '../../concept_screens/concepts_screen_status.dart';

// ignore: must_be_immutable
class TestReading2 extends StatefulWidget {
  ScreenData screendata;
  int index, length;
  TestReading2(
      {Key? key,
      required this.index,
      required this.length,
      required this.screendata})
      : super(key: key);
  @override
  State<TestReading2> createState() => _TestReading2State();
}

class _TestReading2State extends State<TestReading2> {
  bool onplaying = false;
  UserProfileData user = localUserList[0];
  final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                testScreenTopbar(
                    context, user.lifes, widget.index, widget.length),
                Container(
                  margin: EdgeInsets.only(
                      bottom: size.height * 0.05, top: size.height * 0.02),
                  height: size.height * 0.25,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () async {
                            setState(() {
                              onplaying = !onplaying;
                            });
                            if (onplaying == true) {
                              try {
                                final Duration position =
                                    assetsAudioPlayer.currentPosition.value;
                                StreamBuilder(
                                    stream: assetsAudioPlayer.currentPosition,
                                    builder: (context, asyncSnapshot) {
                                      final Object? duration =
                                          asyncSnapshot.data;
                                      return Text(duration.toString());
                                    });
                                debugPrint('$position');

                                await assetsAudioPlayer.open(
                                  Audio.network(widget.screendata.audiofile!),
                                );
                              } catch (t) {
                                const Text(' unreachable');
                              }
                            } else {
                              try {
                                await assetsAudioPlayer.stop();
                              } catch (t) {
                                const Text(' notStopped');
                              }
                            }
                          },
                          child: AvatarGlow(
                              endRadius: 78,
                              animate: (onplaying == true) ? true : false,
                              shape: BoxShape.circle,
                              curve: Curves.decelerate,
                              glowColor: ColorPalette.primarycolor,
                              child: Image.asset(
                                  'assets/images/speaker_img.png'))),
                      const Text(
                        'Opponent sentence will play',
                        style: TextStyle(
                            fontSize: 16,
                            color: ColorPalette.textcolor,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.06,
                  width: double.infinity,
                  child: Text(
                    widget.screendata.question!,
                    style: const TextStyle(
                        fontSize: 18,
                        color: ColorPalette.textcolor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(bottom: size.height * 0.06),
                    height: size.height * 0.04,
                    width: double.infinity,
                    child: RatingBar.builder(
                      unratedColor:
                          ColorPalette.backgroundcolor1.withOpacity(0.2),
                      itemSize: 50,
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Color.fromARGB(255, 241, 181, 3),
                      ),
                      onRatingUpdate: (rating) {},
                    )),
                const Text(
                  'Feedback and Suggestions for the opponent',
                  style: TextStyle(
                      fontSize: 16,
                      color: ColorPalette.textcolor,
                      fontWeight: FontWeight.w600),
                ),
                Container(
                  height: size.height * 0.18,
                  width: size.width,
                  margin: EdgeInsets.only(top: size.height * 0.04),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorPalette.searchbarcolor),
                  child: Column(
                    children: [
                      TextFormField(
                        maxLines: 6,
                        decoration: const InputDecoration(
                            hintText: 'Type here..',
                            isCollapsed: true,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateColor.resolveWith(
                        (states) => Colors.transparent),
                  ),
                  onPressed: () async {
                    var indx = widget.index + 1;
                    testModuleToNavigatetoScreen(context, indx);
                    await assetsAudioPlayer.stop();
                    setState(() {
                      onplaying = false;
                    });
                  },
                  child: testSubmitButton(context)),
            )
          ]),
        ),
      ),
    );
  }
}
