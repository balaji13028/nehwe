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
class ReadingModule7 extends StatefulWidget {
  ScreenData screendata;
  int index;
  ReadingModule7({Key? key, required this.screendata, required this.index})
      : super(key: key);

  @override
  State<ReadingModule7> createState() => _ReadingModule7State();
}

class _ReadingModule7State extends State<ReadingModule7> {
  final sliderbar = GlobalKey<ScaffoldState>();
  UserProfileData user = localUserList[0];
  List<bool> isCard1 = [];
  List<bool> isCard2 = [];
  var value = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: sliderbar,
      endDrawer: GlossaryDrawer(glossary: widget.screendata),
      body: SafeArea(
        child: Stack(children: [
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Stack(children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  screenTopbar(context, newUser.lifes, widget.index),
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
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: ColorPalette.primarycolor),
                                          boxShadow: const [
                                            BoxShadow(
                                              color:
                                                  ColorPalette.secondarycolor,
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
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: ColorPalette.primarycolor),
                                          boxShadow: const [
                                            BoxShadow(
                                              color:
                                                  ColorPalette.secondarycolor,
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
        ]),
      ),
    );
  }
}
