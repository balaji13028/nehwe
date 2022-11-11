import 'dart:convert';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../constants/buttons.dart';
import '../../../constants/color_palettes.dart';
import '../../../constants/text_const.dart';
import '../../../models/courses_model.dart';
import '../../../prepare_screen_list/concept_screens/concept_prepare_ScreenList.dart';
import '../../../models/user_details_model.dart';
import '../../../popup_messages/hint_dispaly.dart';
import '../../../slide_drawers/glossary_drawr.dart';
import '../concepts_screen_status.dart';

// ignore: must_be_immutable
class ListeningModule3 extends StatefulWidget {
  ScreenData screendata;
  int index;
  ListeningModule3({Key? key, required this.index, required this.screendata})
      : super(key: key);

  @override
  State<ListeningModule3> createState() => _ListeningModule3State();
}

class _ListeningModule3State extends State<ListeningModule3> {
  final sliderbar = GlobalKey<ScaffoldState>();
  UserProfileData user = localUserList[0];
  bool onlisten = false;
  final assetsAudioPlayer = AssetsAudioPlayer();
  bool onplaying = false;
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
    return Scaffold(
      key: sliderbar,
      endDrawer: GlossaryDrawer(glossary: widget.screendata),
      body: SafeArea(
        child: Stack(children: [
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Stack(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  screenTopbar(context, newUser.lifes, widget.index),
                  Container(
                    height: size.height * 0.25,
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 10),
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
                            onTap: () {
                              setState(() {});
                            },
                            child: Image.asset('assets/images/mic_img.png')),
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
                          var indx = widget.index + 1;
                          navigatetoScreen(context, indx);
                          await assetsAudioPlayer.stop();
                          setState(() {
                            onplaying = false;
                          });
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
    );
  }
}
