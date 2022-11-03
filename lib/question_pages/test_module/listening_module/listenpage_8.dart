import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:nehwe/models/user_details_model.dart';
import 'package:nehwe/prepare_screen_list/test_screeens/test_screens_list.dart';
import 'package:nehwe/question_pages/test_module/test_screen_status.dart';
import '../../../constants/buttons.dart';
import '../../../constants/color_palettes.dart';
import '../../../models/courses_model.dart';
import '../../../prepare_screen_list/concept_screens/concept_prepare_ScreenList.dart';

// ignore: must_be_immutable
class TestListening8 extends StatefulWidget {
  ScreenData screendata;
  int index, length;
  TestListening8(
      {Key? key,
      required this.index,
      required this.length,
      required this.screendata})
      : super(key: key);

  @override
  State<TestListening8> createState() => _TestListening8State();
}

class _TestListening8State extends State<TestListening8> {
  UserProfileData user = localUserList[0];
  bool onplaying = false;
  List<bool> isCardEnabled = [];
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
                  height: size.height * 0.15,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          widget.screendata.text!,
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
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 25,
                                childAspectRatio: 2.5),
                        physics: const ClampingScrollPhysics(),
                        itemCount: widget.screendata.optionset1!.length,
                        itemBuilder: ((context, index) {
                          isCardEnabled.add(false);
                          return GestureDetector(
                            onTap: () {
                              isCardEnabled.replaceRange(
                                  0, isCardEnabled.length, [
                                for (int i = 0; i < isCardEnabled.length; i++)
                                  false
                              ]);
                              isCardEnabled[index] = true;
                              setState(() {});
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
