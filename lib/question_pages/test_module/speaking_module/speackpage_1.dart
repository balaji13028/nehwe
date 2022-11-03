import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:nehwe/constants/buttons.dart';
import 'package:nehwe/constants/color_palettes.dart';
import 'package:nehwe/constants/text_const.dart';
import 'package:nehwe/loadings/loader.dart';
import 'package:nehwe/models/courses_model.dart';
import 'package:nehwe/prepare_screen_list/concept_screens/concept_prepare_ScreenList.dart';
import 'package:nehwe/models/user_details_model.dart';
import 'package:nehwe/prepare_screen_list/test_screeens/test_screens_list.dart';
import 'package:nehwe/question_pages/concept_screens/concepts_screen_status.dart';
import 'package:nehwe/question_pages/test_module/test_screen_status.dart';

// ignore: must_be_immutable
class TestSpeaking1 extends StatefulWidget {
  ScreenData screendata;
  int index, length;
  TestSpeaking1(
      {Key? key,
      required this.index,
      required this.length,
      required this.screendata})
      : super(key: key);

  @override
  State<TestSpeaking1> createState() => _TestSpeaking1State();
}

class _TestSpeaking1State extends State<TestSpeaking1> {
  UserProfileData user = localUserList[0];
  bool onplaying = false;
  final assetsAudioPlayer = AssetsAudioPlayer();
  late final RecorderController recorderController;
  late final PlayerController playerController;
  bool isrecorder = false;
  late Directory appDirectory;
  String? path;
  File? audiofile;
  bool _isLoaderVisible = false;
  loader() async {
    if (_isLoaderVisible) {
      context.loaderOverlay.show();
    } else {
      context.loaderOverlay.hide();
    }
  }

  @override
  void initState() {
    super.initState();
    recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 16000;
    playerController = PlayerController();
  }

  @override
  void dispose() {
    recorderController.dispose();
    playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var image = base64.decode(widget.screendata.imagefile!);
    return GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: const Loader(),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Stack(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  testScreenTopbar(
                      context, user.lifes, widget.index, widget.length),
                  SizedBox(
                    height: size.height * 0.25,
                    width: double.infinity,
                    child: Image.memory(image),
                  ),
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
                              await playerController.preparePlayer(path!);
                              await playerController.startPlayer();
                            } catch (t) {
                              const Text(' file not picked');
                            }
                          } else {
                            try {
                              await playerController.stopPlayer();
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
                    height: size.height * 0.08,
                    margin: EdgeInsets.only(bottom: size.height * 0.03),
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
                  Container(
                    height: size.height * 0.30,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              isrecorder = !isrecorder;
                            });
                            if (isrecorder == true) {
                              await recorderController.record();
                            } else {
                              path = await recorderController.stop();
                              print(path);
                            }
                          },
                          child: isrecorder
                              ? BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                                  child: CircleAvatar(
                                    radius: 75,
                                    backgroundColor: const Color(0xff335588),
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
                                              blurStyle: BlurStyle.solid,
                                              color: Color(0xff5B9DD3),
                                            ),
                                            BoxShadow(
                                              blurRadius: 20,
                                              blurStyle: BlurStyle.solid,
                                              color: Color(0xff5B9DD3),
                                            ),
                                            BoxShadow(
                                              blurRadius: 20,
                                              blurStyle: BlurStyle.solid,
                                              color: Color(0xff5B9DD3),
                                            ),
                                            BoxShadow(
                                              blurRadius: 10,
                                              blurStyle: BlurStyle.solid,
                                              color: Color(0xff5B9DD3),
                                            ),
                                            BoxShadow(
                                              blurRadius: 10,
                                              blurStyle: BlurStyle.solid,
                                              color: Color(0xff5B9DD3),
                                            )
                                          ]),
                                      child: AudioWaveforms(
                                        enableGesture: true,
                                        size: Size(size.width / 2, 50),
                                        recorderController: recorderController,
                                        waveStyle: const WaveStyle(
                                          waveColor: Colors.white,
                                          extendWaveform: true,
                                          showMiddleLine: false,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                      ),
                                    ),
                                  ),
                                )
                              : Image.asset('assets/images/mic_img.png'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.025),
                          child: const Text(
                            Consttext.speaktext,
                            style: TextStyle(
                                fontSize: 16,
                                color: ColorPalette.textcolor,
                                fontWeight: FontWeight.w600),
                          ),
                        )
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
                      setState(() {
                        _isLoaderVisible = true;
                      });
                      loader();
                      var indx = widget.index + 1;
                      testModuleToNavigatetoScreen(context, indx);
                      await assetsAudioPlayer.stop();
                      setState(() {
                        onplaying = false;
                        _isLoaderVisible = false;
                      });
                    },
                    child: testSubmitButton(context)),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
