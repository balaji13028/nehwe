import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nehwe/constants/buttons.dart';
import 'package:nehwe/constants/color_palettes.dart';
import 'package:nehwe/models/courses_model.dart';
import 'package:nehwe/prepare_screen_list/concept_screens/concept_prepare_ScreenList.dart';
import 'package:nehwe/prepare_screen_list/test_screeens/test_screens_list.dart';
import 'package:nehwe/question_pages/concept_screens/concepts_screen_status.dart';
import 'package:nehwe/question_pages/test_module/test_screen_status.dart';

import '../../../models/user_details_model.dart';

// ignore: must_be_immutable
class TestWriting3 extends StatefulWidget {
  ScreenData screendata;
  int index, length;
  TestWriting3(
      {Key? key,
      required this.index,
      required this.length,
      required this.screendata})
      : super(key: key);

  @override
  State<TestWriting3> createState() => _TestWriting3State();
}

class _TestWriting3State extends State<TestWriting3> {
  UserProfileData user = localUserList[0];
  bool onchange1 = false;
  bool onchange2 = false;
  bool onchange3 = false;
  bool onchange4 = false;
  bool onplaying = false;

  @override
  Widget build(BuildContext context) {
    var image = base64.decode(widget.screendata.imagefile!);
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
                SizedBox(
                  height: size.height * 0.3,
                  width: double.infinity,
                  child: Image.memory(image),
                ),
                Container(
                  height: size.height * 0.06,
                  margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
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
              child: TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateColor.resolveWith(
                        (states) => Colors.transparent),
                  ),
                  onPressed: () {
                    var indx = widget.index + 1;
                    testModuleToNavigatetoScreen(context, indx);
                  },
                  child: testSubmitButton(context)),
            )
          ]),
        ),
      ),
    );
  }
}
