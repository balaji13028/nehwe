import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nehwe/question_pages/concept_screens/concepts_screen_status.dart';
import '../../../constants/buttons.dart';
import '../../../constants/text_const.dart';
import '../../../models/courses_model.dart';
import '../../../prepare_screen_list/concept_screens/concept_prepare_ScreenList.dart';
import '../../../models/user_details_model.dart';
import '../../../popup_messages/hint_dispaly.dart';
import '../../../slide_drawers/glossary_drawr.dart';

// ignore: must_be_immutable
class WritingModule2 extends StatefulWidget {
  ScreenData screendata;
  int index;
  WritingModule2({Key? key, required this.index, required this.screendata})
      : super(key: key);

  @override
  State<WritingModule2> createState() => _WritingModule2State();
}

class _WritingModule2State extends State<WritingModule2> {
  final sliderbar = GlobalKey<ScaffoldState>();
  UserProfileData user = localUserList[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: sliderbar,
      endDrawer: GlossaryDrawer(glossary: widget.screendata),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Stack(alignment: Alignment.bottomCenter, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    screenTopbar(context, newUser.lifes, widget.index),
                  ],
                ),
                Positioned(
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
