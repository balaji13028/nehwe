import 'dart:convert';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:nehwe/constants/text_const.dart';
import 'package:nehwe/loadings/loader.dart';
import 'package:nehwe/models/user_details_model.dart';
import 'package:nehwe/popup_messages/hint_dispaly.dart';
import 'package:nehwe/question_pages/concept_screens/concepts_screen_status.dart';
import '../../../bottom_sheets/correct_answer.dart';
import '../../../bottom_sheets/wrong_answer.dart';
import '../../../constants/buttons.dart';
import '../../../constants/color_palettes.dart';
import '../../../models/courses_model.dart';
import '../../../slide_drawers/glossary_drawr.dart';

// ignore: must_be_immutable
class ListeningModule1 extends StatefulWidget {
  ScreenData screendata;
  int index;
  ListeningModule1({Key? key, required this.screendata, required this.index})
      : super(key: key);

  @override
  State<ListeningModule1> createState() => _ListeningModule1State();
}

class _ListeningModule1State extends State<ListeningModule1> {
  final sliderbar = GlobalKey<ScaffoldState>();
  UserProfileData user = localUserList[0];
  List<bool> isCard = [];
  var value = '';
  bool onplaying = false;
  final assetsAudioPlayer = AssetsAudioPlayer();
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
    var image = base64Decode(widget.screendata.imagefile!);
    Size size = MediaQuery.of(context).size;
    return GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: const Loader(),
      child: Scaffold(
        key: sliderbar,
        endDrawer: GlossaryDrawer(glossary: widget.screendata),
        body: SafeArea(
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Stack(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    screenTopbar(context, newUser.lifes, widget.index),
                    SizedBox(
                        height: size.height * 0.25,
                        width: double.infinity,
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
                    SizedBox(
                      height: size.height * 0.1,
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
                      child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          itemCount: widget.screendata.optionset1!.length,
                          itemBuilder: (context, index) {
                            isCard.add(false);
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    isCard.replaceRange(0, isCard.length, [
                                      for (int i = 0; i < isCard.length; i++)
                                        false
                                    ]);
                                    isCard[index] = true;
                                    setState(() {
                                      if (isCard[index] == true) {
                                        value = widget
                                            .screendata.optionset1![index];
                                      } else {
                                        value = '';
                                      }
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
                                        color: isCard[index]
                                            ? ColorPalette.primarycolor
                                            : ColorPalette.whitetextcolor),
                                    child: Text(
                                      widget.screendata.optionset1![index],
                                      style: TextStyle(
                                        color: isCard[index]
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
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () async {
                            if (newUser.lifes != '0') {
                              setState(() {
                                var lifes = int.parse(newUser.lifes!);
                                newUser.lifes = (lifes - 1).toString();
                                user.lifes = newUser.lifes;
                              });
                              hintDisplay(context, widget.screendata.hint);
                            } else {
                              EasyLoading.showToast(Consttext.noLifes);
                            }
                          },
                          child: hintButton(context)),
                      TextButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStateColor.resolveWith(
                                (states) => Colors.transparent),
                          ),
                          onPressed: () async {
                            await assetsAudioPlayer.stop();
                            setState(() {
                              onplaying = false;
                              _isLoaderVisible = true;
                            });

                            if (value == widget.screendata.answer![0]) {
                              showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) {
                                    return CorrectAnswer(
                                      index: widget.index,
                                    );
                                  });
                            } else if (value != widget.screendata.answer![0]) {
                              showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) {
                                    return WrongAnswer(
                                      screendata: widget.screendata,
                                      index: widget.index,
                                    );
                                  });
                            } else {
                              const Text('');
                            }
                          },
                          child: submitButton(context)),
                    ],
                  ),
                )
              ]),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                  onTap: () {
                    sliderbar.currentState!.openEndDrawer();
                  },
                  child: glossaryButton(context)),
            ),
          ]),
        ),
      ),
    );
  }
}
