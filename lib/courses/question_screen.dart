import 'dart:convert';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nehwe/models/courses_model.dart';
import 'package:nehwe/slide_drawers/glossary_drawer.dart';
import 'package:speech_to_text/speech_to_text.dart' as speechToText;
import '../bottom_sheets/correct_answer.dart';
import '../bottom_sheets/wrong_answer.dart';
import '../constants/buttons.dart';
import '../constants/color_palettes.dart';
import '../constants/text_const.dart';
import '../models/user_details_model.dart';
import '../popup_messages/concept_report_card.dart';
import '../popup_messages/exit_message.dart';
import '../popup_messages/hint_dispaly.dart';
import 'concpets_screen.dart';

// ignore: must_be_immutable
class QuestionPage extends StatefulWidget {
  int index;
  String glossary;
  QuestionPage({Key? key, required this.index, required this.glossary})
      : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  final sliderbar = GlobalKey<ScaffoldState>();
  late List<TextEditingController> _controller;
  late ScreenData screen;
  late final RecorderController recorderController;
  UserProfileData user = localUserList[0];
  List<bool> isCard = [];
  List<bool> isCard2 = [];
  List<String> answerlist = [];
  var result = '';
  var match1 = '';
  var match2 = '';
  var disp;
  var disp2;
  bool isrecorder = false;
  bool onplaying = false;
  final assetsAudioPlayer = AssetsAudioPlayer();
  late speechToText.SpeechToText speech;

  void listen() async {
    if (!isrecorder) {
      bool avail = await speech.initialize();
      if (avail) {
        setState(() {
          isrecorder = true;
        });

        speech.listen(onResult: (value) {
          setState(() {
            result = value.recognizedWords.toLowerCase();

            print(value.recognizedWords);
            print(result);
          });
        });
      }
    } else {
      setState(() {
        isrecorder = false;
      });

      speech.stop();
    }
  }

  @override
  void initState() {
    speech = speechToText.SpeechToText();
    screen = screenlist[widget.index];

    _controller = List.generate(
        screen.optionset1!.length, (i) => TextEditingController());
    disp = List.generate(screen.optionset1!.length, (index) => 1);
    disp2 = List.generate(screen.optionset2!.length, (index) => 1);
    recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 16000;
    super.initState();
    answerlist = screen.answer!.split(',');
  }

  @override
  void dispose() {
    recorderController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var image = base64Decode(screen.imagefile!);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: sliderbar,
      endDrawer: GlossarySlideBar(path: widget.glossary),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///this is for questions status indication..
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            confirmTOExit(
                                context,
                                Lessons(
                                    unit: newunit,
                                    course: newcourse,
                                    lesson: newlesson));
                            await assetsAudioPlayer.stop();
                          },
                          child: const Icon(
                            Icons.clear,
                            size: 32,
                            color: ColorPalette.exiticoncolor,
                          ),
                        ),
                        Container(
                          height: 16,
                          width: size.height * 0.3015,
                          decoration: BoxDecoration(
                            color: ColorPalette.statusfillcolor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Container(
                                  height: 10,
                                  width: (size.height * 0.3015 / 6) *
                                      widget.index.toDouble(),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  decoration: BoxDecoration(
                                    color: ColorPalette.primarycolor,
                                    borderRadius: BorderRadius.circular(10),
                                  ))
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset('assets/icons/lifes_icon.svg'),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              user.lifes!,
                              style: const TextStyle(
                                  color: ColorPalette.textcolor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        children: [
                          ///this is to dispaly image...
                          (screen.imageStatus == '0')
                              ? const SizedBox()
                              : SizedBox(height: size.height * 0.02),
                          Visibility(
                            visible: (screen.imageStatus == '0') ? false : true,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: size.height * 0.25,
                                    child: Image.memory(
                                      image,
                                      fit: BoxFit.cover,
                                    )),
                              ],
                            ),
                          ),
                          //this is for to display audio to listen the sentence and displayed when there is no image.
                          (screen.audioStatus == '0')
                              ? const SizedBox()
                              : SizedBox(height: size.height * 0.02),
                          Visibility(
                            visible: (screen.audioStatus == '1' &&
                                        screen.imageStatus == '1' ||
                                    screen.audioStatus == '0' &&
                                        screen.imageStatus == '0' ||
                                    screen.audioStatus == '0' &&
                                        screen.imageStatus == '1')
                                ? false
                                : true,
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
                                              assetsAudioPlayer
                                                  .currentPosition.value;

                                          debugPrint('$position');

                                          await assetsAudioPlayer.open(
                                            Audio.network(screen.audiofile!),
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
                                        animate:
                                            (onplaying == true) ? true : false,
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

                          ///this is for to display audio to listen the sentence.
                          Visibility(
                            visible: (screen.audioStatus == '1' &&
                                        screen.imageStatus == '0' ||
                                    screen.audioStatus == '0' &&
                                        screen.imageStatus == '0' ||
                                    screen.audioStatus == '0' &&
                                        screen.imageStatus == '1')
                                ? false
                                : true,
                            child: Row(
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
                                          Audio.network(screen.audiofile!),
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
                          ),

                          //this is for to display text on content.
                          (screen.textStatus == '0')
                              ? const SizedBox()
                              : SizedBox(height: size.height * 0.02),
                          Visibility(
                            visible: (screen.textStatus == '0') ? false : true,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                    '${screen.text}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: ColorPalette.textcolor),
                                  ),
                                )
                              ],
                            ),
                          ),

                          //this is displayed when given data is in the form of fill in the blanks
                          Visibility(
                            visible: (screen.answertype == '4') ? true : false,
                            child: SizedBox(
                                height: (screen.optionset1!.length > 4)
                                    ? size.height * 0.17
                                    : size.height * 0.1,
                                child: GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                            crossAxisSpacing: 8),
                                    itemCount: screen.optionset1!.length,
                                    physics: const ClampingScrollPhysics(),
                                    itemBuilder: ((context, index) {
                                      if (screen.optionset1!.length < 5) {
                                        result =
                                            '${_controller[0].text},${_controller[1].text},${_controller[2].text},${_controller[3].text}';
                                      } else {
                                        result =
                                            '${_controller[0].text} ${_controller[1].text} ${_controller[2].text} ${_controller[3].text} ${_controller[4].text} ${_controller[5].text} ${_controller[6].text} ${_controller[7].text}';
                                      }
                                      return Container(
                                        width: 60,
                                        decoration: const BoxDecoration(),
                                        child: TextFormField(
                                          readOnly: true,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: ColorPalette.textcolor,
                                              fontWeight: FontWeight.w700),
                                          textAlign: TextAlign.center,
                                          controller: _controller[index],
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: ColorPalette.textcolor,
                                                  width: 1.5),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: ColorPalette.textcolor,
                                                  width: 1.5),
                                            ),
                                          ),
                                          onChanged: (i) {
                                            FocusScope.of(context).nextFocus();
                                          },
                                        ),
                                      );
                                    }))),
                          ),
                          SizedBox(height: size.height * 0.02),
                          //this is for to display question releted to the given screen.
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  'Q :- ${screen.question}',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: ColorPalette.textcolor),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: size.height * 0.02),
                          //dispalyed when answer type is multiple choice.
                          Visibility(
                            visible: (screen.answertype == '1') ? true : false,
                            child: SizedBox(
                              height: size.height * 0.25,
                              width: size.width,
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: screen.optionset1!.length,
                                itemBuilder: (context, index) {
                                  isCard.add(false);
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          isCard.replaceRange(
                                              0, isCard.length, [
                                            for (int i = 0;
                                                i < isCard.length;
                                                i++)
                                              false
                                          ]);
                                          isCard[index] = true;
                                          setState(() {
                                            if (isCard[index] == true) {
                                              result =
                                                  screen.optionset1![index];
                                            } else {
                                              result = '';
                                            }
                                          });
                                        },
                                        child: Container(
                                          height: size.height * 0.045,
                                          width: size.width * 0.4,
                                          alignment: Alignment.center,
                                          margin:
                                              const EdgeInsets.only(bottom: 18),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  color: ColorPalette
                                                      .primarycolor),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: ColorPalette
                                                      .secondarycolor,
                                                  offset: Offset(1.5, 1.5),
                                                )
                                              ],
                                              color: isCard[index]
                                                  ? ColorPalette.primarycolor
                                                  : ColorPalette
                                                      .whitetextcolor),
                                          child: Text(
                                            screen.optionset1![index].trim(),
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
                                },
                              ),
                            ),
                          ),
                          //displayed answer type is matching the sentence.
                          Visibility(
                            visible: (screen.answertype == '2') ? true : false,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: size.height * 0.28,
                                      width: size.width * 0.42,
                                      child: ListView.builder(
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount: screen.optionset1!.length,
                                          itemBuilder: (context, index) {
                                            isCard.add(false);
                                            return Column(
                                              children: [
                                                disp[index] == 1
                                                    ? GestureDetector(
                                                        onTap: () {
                                                          isCard.replaceRange(0,
                                                              isCard.length, [
                                                            for (int i = 0;
                                                                i <
                                                                    isCard
                                                                        .length;
                                                                i++)
                                                              false
                                                          ]);
                                                          setState(() {
                                                            isCard[index] =
                                                                true;
                                                            if (isCard[index] ==
                                                                true) {
                                                              match1 = screen
                                                                      .optionset1![
                                                                  index];
                                                            } else {
                                                              result = '';
                                                            }
                                                          });
                                                        },
                                                        child: Container(
                                                          height: size.height *
                                                              0.045,
                                                          width:
                                                              size.width * 0.35,
                                                          alignment:
                                                              Alignment.center,
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 18),
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          decoration:
                                                              BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  border: Border.all(
                                                                      color: ColorPalette
                                                                          .primarycolor),
                                                                  boxShadow: const [
                                                                    BoxShadow(
                                                                      color: ColorPalette
                                                                          .secondarycolor,
                                                                      offset: Offset(
                                                                          1.5,
                                                                          1.5),
                                                                    )
                                                                  ],
                                                                  color: isCard[
                                                                          index]
                                                                      ? ColorPalette
                                                                          .primarycolor
                                                                      : ColorPalette
                                                                          .whitetextcolor),
                                                          child: Text(
                                                            screen.optionset1![
                                                                    index]
                                                                .trim(),
                                                            style: TextStyle(
                                                              color: isCard[
                                                                      index]
                                                                  ? ColorPalette
                                                                      .whitetextcolor
                                                                  : ColorPalette
                                                                      .textcolor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : const SizedBox(),
                                              ],
                                            );
                                          }),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.28,
                                      width: size.width * 0.42,
                                      child: ListView.builder(
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount: screen.optionset2!.length,
                                          itemBuilder: (context, index) {
                                            isCard2.add(false);
                                            return Column(
                                              children: [
                                                if (disp2[index] == 1)
                                                  GestureDetector(
                                                    onTap: () {
                                                      isCard2.replaceRange(
                                                          0, isCard2.length, [
                                                        for (int i = 0;
                                                            i < isCard2.length;
                                                            i++)
                                                          false
                                                      ]);
                                                      setState(() {
                                                        isCard2[index] = true;
                                                        if (isCard2[index] ==
                                                            true) {
                                                          match2 = screen
                                                                  .optionset2![
                                                              index];
                                                          var match =
                                                              '$match1-$match2';

                                                          var matchid =
                                                              answerlist
                                                                  .indexWhere(
                                                                      (x) =>
                                                                          x ==
                                                                          match);
                                                          if (matchid != -1) {
                                                            var idx = screen
                                                                .optionset1!
                                                                .indexWhere(
                                                                    (x) =>
                                                                        x ==
                                                                        match1);
                                                            disp[idx] = 0;
                                                            disp2[index] = 0;
                                                            var x = disp
                                                                .where((i) =>
                                                                    i == 0)
                                                                .toList();
                                                            if (x.length ==
                                                                disp.length) {
                                                              showModalBottomSheet(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return Correct(
                                                                      index: widget
                                                                          .index,
                                                                      glossary:
                                                                          widget
                                                                              .glossary,
                                                                    );
                                                                  });
                                                            }
                                                          } else if (matchid ==
                                                              -1) {
                                                            showModalBottomSheet(
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return WrongAnswer(
                                                                    screendata:
                                                                        screen,
                                                                    index: widget
                                                                        .index,
                                                                  );
                                                                });
                                                            // for (var i = 0;
                                                            //     i < disp.length;
                                                            //     i++) {
                                                            //   if (disp[i] ==
                                                            //       0) {
                                                            //     disp[i] = 1;
                                                            //   }
                                                            // }
                                                            // for (var i = 0;
                                                            //     i <
                                                            //         disp2
                                                            //             .length;
                                                            //     i++) {
                                                            //   if (disp2[i] ==
                                                            //       0) {
                                                            //     disp2[i] = 1;
                                                            //   }
                                                            // }

                                                            // var idx = screen
                                                            //     .optionset1!
                                                            //     .indexWhere(
                                                            //         (x) =>
                                                            //             x ==
                                                            //             match1);
                                                            // isCard[idx] = false;
                                                            // isCard2[index] =
                                                            //     false;

                                                            // EasyLoading
                                                            //     .showError(
                                                            //         'Wrong');
                                                          }
                                                        } else {
                                                          result = '';
                                                        }
                                                      });
                                                    },
                                                    child: Container(
                                                      height:
                                                          size.height * 0.045,
                                                      width: size.width * 0.35,
                                                      alignment:
                                                          Alignment.center,
                                                      margin:
                                                          const EdgeInsets.only(
                                                        bottom: 18,
                                                      ),
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          border: Border.all(
                                                              color: ColorPalette
                                                                  .primarycolor),
                                                          boxShadow: const [
                                                            BoxShadow(
                                                              color: ColorPalette
                                                                  .secondarycolor,
                                                              offset: Offset(
                                                                  1.5, 1.5),
                                                            )
                                                          ],
                                                          color: isCard2[index]
                                                              ? ColorPalette
                                                                  .primarycolor
                                                              : ColorPalette
                                                                  .whitetextcolor),
                                                      child: Text(
                                                        screen
                                                            .optionset2![index]
                                                            .trim(),
                                                        style: TextStyle(
                                                          color: isCard2[index]
                                                              ? ColorPalette
                                                                  .whitetextcolor
                                                              : ColorPalette
                                                                  .textcolor,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                else
                                                  const SizedBox(),
                                              ],
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                                SizedBox(height: size.height * 0.05)
                              ],
                            ),
                          ),
                          //displayed answertype to prounce the given sentence.
                          Visibility(
                            visible: (screen.answertype == '3') ? true : false,
                            child: Container(
                              height: size.height * 0.30,
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      listen();
                                    },
                                    child: isrecorder
                                        ? CircleAvatar(
                                            radius: 65,
                                            backgroundColor:
                                                const Color(0xff335588),
                                            child: AvatarGlow(
                                              endRadius: 80,
                                              glowColor:
                                                  ColorPalette.whitetextcolor,
                                              child: Container(
                                                  height: 95,
                                                  width: 95,
                                                  alignment: Alignment.center,
                                                  decoration:
                                                      const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color:
                                                              Color(0xff5B9DD3),
                                                          boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 10,
                                                          blurStyle:
                                                              BlurStyle.solid,
                                                          color:
                                                              Color(0xff5B9DD3),
                                                        ),
                                                        BoxShadow(
                                                          blurRadius: 20,
                                                          blurStyle:
                                                              BlurStyle.solid,
                                                          color:
                                                              Color(0xff5B9DD3),
                                                        ),
                                                        BoxShadow(
                                                          blurRadius: 20,
                                                          blurStyle:
                                                              BlurStyle.solid,
                                                          color:
                                                              Color(0xff5B9DD3),
                                                        ),
                                                        BoxShadow(
                                                          blurRadius: 10,
                                                          blurStyle:
                                                              BlurStyle.solid,
                                                          color:
                                                              Color(0xff5B9DD3),
                                                        ),
                                                        BoxShadow(
                                                          blurRadius: 10,
                                                          blurStyle:
                                                              BlurStyle.solid,
                                                          color:
                                                              Color(0xff5B9DD3),
                                                        )
                                                      ]),
                                                  child: AvatarGlow(
                                                    endRadius: 40,
                                                    curve: Curves.easeOut,
                                                    glowColor:
                                                        const Color(0xff335588),
                                                    child: Icon(
                                                        Icons
                                                            .record_voice_over_rounded,
                                                        size:
                                                            size.height * 0.06,
                                                        color: ColorPalette
                                                            .whitetextcolor),
                                                  )),
                                            ),
                                          )
                                        : CircleAvatar(
                                            radius: 75,
                                            backgroundColor:
                                                const Color(0xff335588),
                                            child: Container(
                                              height: 95,
                                              width: 95,
                                              alignment: Alignment.center,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color(0xff5B9DD3),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 10,
                                                      blurStyle:
                                                          BlurStyle.solid,
                                                      color: Color(0xff5B9DD3),
                                                    ),
                                                    BoxShadow(
                                                      blurRadius: 20,
                                                      blurStyle:
                                                          BlurStyle.solid,
                                                      color: Color(0xff5B9DD3),
                                                    ),
                                                    BoxShadow(
                                                      blurRadius: 20,
                                                      blurStyle:
                                                          BlurStyle.solid,
                                                      color: Color(0xff5B9DD3),
                                                    ),
                                                    BoxShadow(
                                                      blurRadius: 10,
                                                      blurStyle:
                                                          BlurStyle.solid,
                                                      color: Color(0xff5B9DD3),
                                                    ),
                                                    BoxShadow(
                                                      blurRadius: 10,
                                                      blurStyle:
                                                          BlurStyle.solid,
                                                      color: Color(0xff5B9DD3),
                                                    )
                                                  ]),
                                              child: Icon(Icons.mic,
                                                  size: size.height * 0.06,
                                                  color: ColorPalette
                                                      .whitetextcolor),
                                            ),
                                          ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: size.height * 0.025),
                                    child: Text(
                                      isrecorder
                                          ? 'Tap here to stop'
                                          : Consttext.speaktext,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: ColorPalette.textcolor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          //displayed whrn answer type is filling the blanks model.
                          Visibility(
                            visible: (screen.answertype == '4') ? true : false,
                            child: SizedBox(
                              height: size.height * 0.16,
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 12,
                                        childAspectRatio: 1.8),
                                physics: const ClampingScrollPhysics(),
                                itemCount: screen.optionset1!.length,
                                itemBuilder: ((context, index) {
                                  isCard.add(false);
                                  return GestureDetector(
                                    onTap: () {
                                      var selected = screen.optionset1![index];
                                      setState(() {
                                        isCard[index] = !isCard[index];
                                        if (isCard[index] == true) {
                                          for (var i = 0;
                                              i < _controller.length;
                                              i++) {
                                            if (_controller[i].text.isEmpty) {
                                              _controller[i].text = selected;
                                              break;
                                            }
                                          }
                                        } else if (isCard[index] == false) {
                                          for (var i = 0;
                                              i < _controller.length;
                                              i++) {
                                            if (_controller[i].text ==
                                                selected) {
                                              _controller[i].text = '';
                                              break;
                                            }
                                          }
                                        }
                                      });
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 100,
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.only(bottom: 18),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: ColorPalette.primarycolor),
                                          boxShadow: const [
                                            BoxShadow(
                                              color:
                                                  ColorPalette.secondarycolor,
                                              offset: Offset(1.5, 1.5),
                                            )
                                          ],
                                          color: isCard[index]
                                              ? ColorPalette.primarycolor
                                              : ColorPalette.whitetextcolor),
                                      child: Text(
                                        screen.optionset1![index].trim(),
                                        style: TextStyle(
                                          color: isCard[index]
                                              ? ColorPalette.whitetextcolor
                                              : ColorPalette.textcolor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                          //displayed when given ating to the given sentece.
                          Visibility(
                            visible: (screen.answertype == '5') ? true : false,
                            child: Container(
                                margin:
                                    EdgeInsets.only(bottom: size.height * 0.06),
                                height: size.height * 0.04,
                                alignment: Alignment.center,
                                width: double.infinity,
                                child: RatingBar.builder(
                                  unratedColor: ColorPalette.primarycolor
                                      .withOpacity(0.2),
                                  itemSize: 50,
                                  initialRating: 0,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Color.fromARGB(255, 241, 181, 3),
                                  ),
                                  onRatingUpdate: (rating) {
                                    result = '';
                                  },
                                )),
                          ),
                          //dispalyed to write the correct sentence.
                          Visibility(
                            visible: (screen.answertype == '6') ? true : false,
                            child: Container(
                              height: size.height * 0.18,
                              width: size.width,
                              margin: EdgeInsets.only(top: size.height * 0.04),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
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
                                    onChanged: (value) => result = value,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //sumbit button and hint button.
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
                                hintDisplay(context, screen.hint);
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
                            onPressed: (screen.answertype == '2')
                                ? null
                                : () async {
                                    print(screen.answer);
                                    print(result);
                                    await assetsAudioPlayer.stop();
                                    setState(() {
                                      onplaying = false;
                                    });
                                    if (widget.index <= 4) {
                                      if (result.trim() == screen.answer!) {
                                        showModalBottomSheet(
                                            backgroundColor: Colors.transparent,
                                            context: context,
                                            builder: (context) {
                                              return Correct(
                                                index: widget.index,
                                                glossary: widget.glossary,
                                              );
                                            });
                                      } else if (result != screen.answer) {
                                        showModalBottomSheet(
                                            backgroundColor: Colors.transparent,
                                            context: context,
                                            builder: (context) {
                                              return WrongAnswer(
                                                screendata: screen,
                                                index: widget.index,
                                              );
                                            });
                                      } else {
                                        int index = widget.index + 1;
                                        // ignore: use_build_context_synchronously
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                pageBuilder: ((context,
                                                        animation,
                                                        secondaryAnimation) =>
                                                    QuestionPage(
                                                      index: index,
                                                      glossary: widget.glossary,
                                                    ))));
                                      }
                                    } else {
                                      // ignore: use_build_context_synchronously
                                      await conceptReport(context);
                                    }
                                  },
                            child: submitButton(context)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //glossary button
            Align(
                alignment: Alignment.centerRight,
                child: (widget.glossary.isNotEmpty)
                    ? (widget.glossary != 'null')
                        ? GestureDetector(
                            onTap: () {
                              sliderbar.currentState!.openEndDrawer();
                            },
                            child: glossaryButton(context))
                        : null
                    : null),
          ],
        ),
      ),
    );
  }
}
