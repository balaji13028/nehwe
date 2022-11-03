import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:nehwe/question_pages/test_module/test_screen_status.dart';
import '../../../bottom_sheets/correct_answer.dart';
import '../../../bottom_sheets/wrong_answer.dart';
import '../../../constants/buttons.dart';
import '../../../constants/color_palettes.dart';
import '../../../models/courses_model.dart';
import '../../../models/user_details_model.dart';
import '../../concept_screens/concepts_screen_status.dart';

// ignore: must_be_immutable
class TestListening5 extends StatefulWidget {
  ScreenData screendata;
  int index, length;
  TestListening5(
      {Key? key,
      required this.index,
      required this.length,
      required this.screendata})
      : super(key: key);

  @override
  State<TestListening5> createState() => _TestListening5State();
}

class _TestListening5State extends State<TestListening5> {
  UserProfileData user = localUserList[0];
  List<bool> isCard = [];
  var value = '';
  bool onplaying = false;
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
                  height: size.height * 0.3,
                  width: double.infinity,
                  margin: EdgeInsets.only(
                      top: size.height * 0.04, bottom: size.height * 0.02),
                  child: Center(
                      child: Column(
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
                        'Listen to the sentence',
                        style: TextStyle(
                            fontSize: 16,
                            color: ColorPalette.textcolor,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
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
                                  for (int i = 0; i < isCard.length; i++) false
                                ]);
                                isCard[index] = true;
                                setState(() {
                                  if (isCard[index] == true) {
                                    value =
                                        widget.screendata.optionset1![index];
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
              child: TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateColor.resolveWith(
                        (states) => Colors.transparent),
                  ),
                  onPressed: () async {
                    await assetsAudioPlayer.stop();
                    setState(() {
                      onplaying = false;
                    });
                    if (value == widget.screendata.answer!.first) {
                      showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            return CorrectAnswer(
                              index: widget.index,
                            );
                          });
                    } else if (value != widget.screendata.answer!.first) {
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
                  child: testSubmitButton(context)),
            )
          ]),
        ),
      ),
    );
  }
}
