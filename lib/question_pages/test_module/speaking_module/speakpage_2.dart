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
class TestSpeaking2 extends StatefulWidget {
  ScreenData screendata;
  int index, length;
  TestSpeaking2(
      {Key? key,
      required this.index,
      required this.length,
      required this.screendata})
      : super(key: key);

  @override
  State<TestSpeaking2> createState() => _TestSpeaking2State();
}

class _TestSpeaking2State extends State<TestSpeaking2> {
  UserProfileData user = localUserList[0];
  bool onplaying = false;
  final assetsAudioPlayer = AssetsAudioPlayer();
  late final RecorderController recorderController;
  //final recorder = FlutterSoundRecorder();
  bool isrecorder = false;
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
    recorderController = RecorderController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () async {
                              setState(() {
                                isrecorder != isrecorder;
                              });
                            },
                            child: isrecorder == true
                                ? AudioWaveforms(
                                    backgroundColor: Colors.amber,
                                    recorderController: recorderController,
                                    size: Size(size.width, 800),
                                  )
                                : Image.asset('assets/images/mic_img.png')),
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
