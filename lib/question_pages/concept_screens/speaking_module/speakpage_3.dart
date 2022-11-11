import 'dart:convert';
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
class SpeakingModule3 extends StatefulWidget {
  ScreenData screendata;
  int index;
  SpeakingModule3({Key? key, required this.index, required this.screendata})
      : super(key: key);

  @override
  State<SpeakingModule3> createState() => _SpeakingModule3State();
}

class _SpeakingModule3State extends State<SpeakingModule3> {
  final sliderbar = GlobalKey<ScaffoldState>();
  UserProfileData user = localUserList[0];
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
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Stack(children: [
                Column(
                  children: [
                    screenTopbar(context, newUser.lifes, widget.index),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      height: size.height * 0.3,
                      width: double.infinity,
                      child: Image.memory(image),
                    ),
                    Container(
                      height: size.height * 0.1,
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
                            setState(() {
                              _isLoaderVisible = true;
                            });
                            loader();
                            var indx = widget.index + 1;
                            navigatetoScreen(context, indx);
                            setState(() {
                              _isLoaderVisible = false;
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
          ],
        ),
      ),
    );
  }
}
