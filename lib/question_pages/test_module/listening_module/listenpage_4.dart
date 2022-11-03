import 'dart:convert';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:nehwe/prepare_screen_list/test_screeens/test_screens_list.dart';
import 'package:nehwe/question_pages/test_module/test_screen_status.dart';
import '../../../constants/buttons.dart';
import '../../../constants/color_palettes.dart';
import '../../../models/courses_model.dart';
import '../../../prepare_screen_list/concept_screens/concept_prepare_ScreenList.dart';
import '../../../models/user_details_model.dart';
import '../../concept_screens/concepts_screen_status.dart';

// ignore: must_be_immutable
class TestListening4 extends StatefulWidget {
  ScreenData screendata;
  int index, length;
  TestListening4(
      {Key? key,
      required this.index,
      required this.length,
      required this.screendata})
      : super(key: key);

  @override
  State<TestListening4> createState() => _TestListening4State();
}

class _TestListening4State extends State<TestListening4> {
  UserProfileData user = localUserList[0];
  List<bool> isCard1 = [];
  List<bool> isCard2 = [];
  bool onplaying = false;
  var value = '';
  final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  Widget build(BuildContext context) {
    var image = base64Decode(widget.screendata.imagefile!);
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
                    height: size.height * 0.25,
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 10),
                    child: Image.memory(image)),
                Row(
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
                                  final Object? duration = asyncSnapshot.data;
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
                        endRadius: 50,
                        animate: (onplaying == true) ? true : false,
                        shape: BoxShape.circle,
                        curve: Curves.decelerate,
                        glowColor: Colors.black,
                        child: SizedBox(
                          height: 60,
                          width: 60,
                          child: Image.asset(
                            'assets/images/speaker_img.png',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: size.height * 0.1,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          'Q :- ${widget.screendata.question!}',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: ColorPalette.textcolor),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          itemCount: widget.screendata.optionset1!.length,
                          itemBuilder: (context, index) {
                            isCard1.add(false);
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    value =
                                        widget.screendata.optionset1![index];
                                    setState(() {
                                      isCard1[index] = !isCard1[index];
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 130,
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(bottom: 18),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: ColorPalette.primarycolor),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: ColorPalette.secondarycolor,
                                            offset: Offset(1.5, 1.5),
                                          )
                                        ],
                                        color: isCard1[index]
                                            ? ColorPalette.primarycolor
                                            : ColorPalette.whitetextcolor),
                                    child: Text(
                                      widget.screendata.optionset1![index],
                                      style: TextStyle(
                                        color: isCard1[index]
                                            ? ColorPalette.whitetextcolor
                                            : ColorPalette.textcolor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                    Expanded(
                      child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          itemCount: widget.screendata.optionset2!.length,
                          itemBuilder: (context, index) {
                            isCard2.add(false);
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    value =
                                        widget.screendata.optionset2![index];
                                    setState(() {
                                      isCard2[index] = !isCard2[index];
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 130,
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(bottom: 18),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: ColorPalette.primarycolor),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: ColorPalette.secondarycolor,
                                            offset: Offset(1.5, 1.5),
                                          )
                                        ],
                                        color: isCard2[index]
                                            ? ColorPalette.primarycolor
                                            : ColorPalette.whitetextcolor),
                                    child: Text(
                                      widget.screendata.optionset2![index],
                                      style: TextStyle(
                                        color: isCard2[index]
                                            ? ColorPalette.whitetextcolor
                                            : ColorPalette.textcolor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  ],
                ))
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
