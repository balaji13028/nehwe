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
class ListeningModule2 extends StatefulWidget {
  ScreenData screendata;
  int index;
  ListeningModule2({Key? key, required this.index, required this.screendata})
      : super(key: key);

  @override
  State<ListeningModule2> createState() => _ListeningModule2State();
}

class _ListeningModule2State extends State<ListeningModule2> {
  final sliderbar = GlobalKey<ScaffoldState>();
  UserProfileData user = localUserList[0];
  var value = '';
  bool onplaying = false;
  List<bool> isCardEnabled = [];
  final List<TextEditingController> _controller =
      List.generate(74, (i) => TextEditingController());
  final assetsAudioPlayer = AssetsAudioPlayer();
  @override
  void initState() {
    super.initState();
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
                                onChanged: (value) {
                                  FocusScope.of(context).nextFocus();
                                },
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
                      height: size.height * 0.16,
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 12,
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
                          child: submitButton(context))
                    ]),
              ),
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
        ])));
  }
}
