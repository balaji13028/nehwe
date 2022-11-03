import 'package:flutter/material.dart';
import 'package:nehwe/constants/buttons.dart';
import 'package:nehwe/prepare_screen_list/test_screeens/test_screens_list.dart';
import '../../../constants/color_palettes.dart';
import '../../../constants/text_const.dart';
import '../../../models/courses_model.dart';
import '../../../models/user_details_model.dart';
import '../test_screen_status.dart';

// ignore: must_be_immutable
class TestReading1 extends StatefulWidget {
  ScreenData screendata;
  int index, length;

  TestReading1(
      {Key? key,
      required this.index,
      required this.length,
      required this.screendata})
      : super(key: key);

  @override
  State<TestReading1> createState() => _TestReading1State();
}

class _TestReading1State extends State<TestReading1> {
  UserProfileData user = localUserList[0];
  bool onplaying = false;

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
                  height: size.height * 0.25,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: size.height * 0.04),
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
                        padding:
                            EdgeInsets.symmetric(vertical: size.height * 0.025),
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
