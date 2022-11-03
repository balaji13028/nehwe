import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:nehwe/constants/buttons.dart';
import 'package:nehwe/constants/color_palettes.dart';
import 'package:nehwe/models/courses_model.dart';
import 'package:nehwe/prepare_screen_list/concept_screens/concept_prepare_ScreenList.dart';
import 'package:nehwe/models/user_details_model.dart';
import 'package:nehwe/prepare_screen_list/test_screeens/test_screens_list.dart';
import 'package:nehwe/question_pages/concept_screens/concepts_screen_status.dart';
import 'package:nehwe/question_pages/test_module/test_screen_status.dart';

// ignore: must_be_immutable
class TestSpeaking3 extends StatefulWidget {
  ScreenData screendata;
  int index, length;
  TestSpeaking3(
      {Key? key,
      required this.index,
      required this.length,
      required this.screendata})
      : super(key: key);

  @override
  State<TestSpeaking3> createState() => _TestSpeaking3State();
}

class _TestSpeaking3State extends State<TestSpeaking3> {
  bool _isLoaderVisible = false;
  UserProfileData user = localUserList[0];

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
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Stack(children: [
            Column(
              children: [
                testScreenTopbar(
                    context, user.lifes, widget.index, widget.length),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                    setState(() {
                      _isLoaderVisible = false;
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
