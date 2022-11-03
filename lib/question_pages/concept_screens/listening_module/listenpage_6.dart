import 'dart:convert';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../bottom_sheets/glossary.dart';
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
class ListeningModule6 extends StatefulWidget {
  ScreenData screendata;
  int index;
  ListeningModule6({Key? key, required this.index, required this.screendata})
      : super(key: key);

  @override
  State<ListeningModule6> createState() => _ListeningModule6State();
}

class _ListeningModule6State extends State<ListeningModule6> {
  final sliderbar = GlobalKey<ScaffoldState>();
  UserProfileData user = localUserList[0];
  bool onplaying = false;
  var value = '';
  List<bool> isCardEnabled = [];
  final assetsAudioPlayer = AssetsAudioPlayer();

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
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
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
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 1.8),
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
