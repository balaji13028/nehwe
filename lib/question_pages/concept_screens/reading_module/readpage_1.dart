import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
class ReadingModule1 extends StatefulWidget {
  ScreenData screendata;
  int index;
  ReadingModule1({Key? key, required this.index, required this.screendata})
      : super(key: key);

  @override
  State<ReadingModule1> createState() => _ReadingModule1State();
}

class _ReadingModule1State extends State<ReadingModule1> {
  final sliderbar = GlobalKey<ScaffoldState>();
  UserProfileData user = localUserList[0];
  bool onplaying = false;

  @override
  Widget build(BuildContext context) {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    screenTopbar(context, user.lifes, widget.index),
                    Container(
                      height: size.height * 0.25,
                      width: double.infinity,
                      margin:
                          EdgeInsets.symmetric(vertical: size.height * 0.04),
                      child: SingleChildScrollView(
                        child: Row(
                          children: [
                            Flexible(
                                child: Text(
                              widget.screendata.text!,
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: ColorPalette.textcolor),
                            ))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: size.height * 0.02),
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
                          onPressed: () {
                            var indx = widget.index + 1;
                            navigatetoScreen(context, indx);
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
