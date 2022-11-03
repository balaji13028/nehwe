import 'package:flutter/material.dart';
import 'package:nehwe/constants/buttons.dart';
import 'package:nehwe/constants/color_palettes.dart';
import 'package:nehwe/models/courses_model.dart';
import 'package:nehwe/models/user_details_model.dart';
import 'package:nehwe/prepare_screen_list/test_screeens/test_screens_list.dart';
import '../test_screen_status.dart';

// ignore: must_be_immutable
class TestReading6 extends StatefulWidget {
  ScreenData screendata;
  int index, length;
  TestReading6(
      {Key? key,
      required this.screendata,
      required this.length,
      required this.index})
      : super(key: key);

  @override
  State<TestReading6> createState() => _TestReading6State();
}

class _TestReading6State extends State<TestReading6> {
  UserProfileData user = localUserList[0];
  List<bool> isCard1 = [];
  List<bool> isCard2 = [];
  String value = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Stack(children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                testScreenTopbar(
                    context, user.lifes, widget.index, widget.length),
                Container(
                  height: size.height * 0.1,
                  margin: EdgeInsets.only(
                      bottom: size.height * 0.04, top: size.height * 0.04),
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
                    child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          itemCount: widget.screendata.optionset1!.length,
                          itemBuilder: (context, index) {
                            isCard1.add(false);
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    value =
                                        widget.screendata.optionset1![index];
                                    setState(() {
                                      isCard1[index] = !isCard1[index];
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 130,
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(bottom: 18),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
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
                                        color: isCard1[index]
                                            ? ColorPalette.primarycolor
                                            : ColorPalette.whitetextcolor),
                                    child: Text(
                                      widget.screendata.optionset1![index],
                                      style: TextStyle(
                                        color: isCard1[index]
                                            ? ColorPalette.whitetextcolor
                                            : ColorPalette.textcolor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                    Expanded(
                      child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          itemCount: widget.screendata.optionset2!.length,
                          itemBuilder: (context, index) {
                            isCard2.add(false);
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    value =
                                        widget.screendata.optionset2![index];
                                    setState(() {
                                      isCard2[index] = !isCard2[index];
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 130,
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(bottom: 18),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
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
                                        color: isCard2[index]
                                            ? ColorPalette.primarycolor
                                            : ColorPalette.whitetextcolor),
                                    child: Text(
                                      widget.screendata.optionset2![index],
                                      style: TextStyle(
                                        color: isCard2[index]
                                            ? ColorPalette.whitetextcolor
                                            : ColorPalette.textcolor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  ],
                ))
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
