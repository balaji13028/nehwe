import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:nehwe/constants/buttons.dart';
import 'package:nehwe/constants/color_palettes.dart';
import 'package:nehwe/loadings/loader.dart';
import 'package:nehwe/models/courses_model.dart';
import 'package:nehwe/prepare_screen_list/concept_screens/concept_prepare_ScreenList.dart';
import 'package:nehwe/models/user_details_model.dart';
import 'package:nehwe/prepare_screen_list/test_screeens/test_screens_list.dart';
import 'package:nehwe/question_pages/concept_screens/concepts_screen_status.dart';
import 'package:nehwe/question_pages/test_module/test_screen_status.dart';

// ignore: must_be_immutable
class TestSpeaking4 extends StatefulWidget {
  ScreenData screendata;
  int index, length;
  TestSpeaking4(
      {Key? key,
      required this.index,
      required this.length,
      required this.screendata})
      : super(key: key);

  @override
  State<TestSpeaking4> createState() => _TestSpeaking4State();
}

class _TestSpeaking4State extends State<TestSpeaking4> {
  UserProfileData user = localUserList[0];
  bool onplaying = false;
  List<bool> isCardEnabled = [];
  final List<TextEditingController> _controller =
      List.generate(74, (i) => TextEditingController());
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
  void initState() {
    super.initState();
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
                          'Listen to the sentence',
                          style: TextStyle(
                              fontSize: 16,
                              color: ColorPalette.textcolor,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      height: (widget.screendata.optionset1!.length > 4)
                          ? size.height * 0.17
                          : size.height * 0.1,
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4, crossAxisSpacing: 8),
                          itemCount: widget.screendata.optionset1!.length,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: ((context, index) {
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
                              ),
                            );
                          }))),
                  Container(
                    height: size.height * 0.06,
                    margin: EdgeInsets.only(bottom: size.height * 0.02),
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
                  SizedBox(
                      height: size.height * 0.22,
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 1.8),
                          physics: const ClampingScrollPhysics(),
                          itemCount: widget.screendata.optionset1!.length,
                          itemBuilder: ((context, index) {
                            isCardEnabled.add(false);
                            return GestureDetector(
                              onTap: () {
                                var value =
                                    widget.screendata.optionset1![index];
                                setState(() {
                                  isCardEnabled[index] = !isCardEnabled[index];
                                  if (isCardEnabled[index] == true) {
                                    for (var i = 0;
                                        i < _controller.length;
                                        i++) {
                                      if (_controller[i].text.isEmpty) {
                                        _controller[i].text = value;
                                        break;
                                      }
                                    }
                                  } else if (isCardEnabled[index] == false) {
                                    for (var i = 0;
                                        i < _controller.length;
                                        i++) {
                                      if (_controller[i].text == value) {
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
                                    color: isCardEnabled[index]
                                        ? ColorPalette.primarycolor
                                        : ColorPalette.whitetextcolor),
                                child: Text(
                                  widget.screendata.optionset1![index],
                                  style: TextStyle(
                                    color: isCardEnabled[index]
                                        ? ColorPalette.whitetextcolor
                                        : ColorPalette.textcolor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            );
                          })))
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
