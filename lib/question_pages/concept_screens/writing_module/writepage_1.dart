import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:nehwe/loadings/loader.dart';
import '../../../bottom_sheets/correct_answer.dart';
import '../../../bottom_sheets/glossary.dart';
import '../../../bottom_sheets/wrong_answer.dart';
import '../../../constants/buttons.dart';
import '../../../constants/color_palettes.dart';
import '../../../constants/text_const.dart';
import '../../../models/courses_model.dart';
import '../../../models/user_details_model.dart';
import '../../../popup_messages/hint_dispaly.dart';
import '../../../slide_drawers/glossary_drawr.dart';
import '../concepts_screen_status.dart';

// ignore: must_be_immutable
class WritingModule1 extends StatefulWidget {
  ScreenData screendata;
  int index;
  WritingModule1({Key? key, required this.index, required this.screendata})
      : super(key: key);

  @override
  State<WritingModule1> createState() => _WritingModule1State();
}

class _WritingModule1State extends State<WritingModule1> {
  final sliderbar = GlobalKey<ScaffoldState>();
  UserProfileData user = localUserList[0];
  List<bool> isCard = [];
  String value = '';
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
    Size size = MediaQuery.of(context).size;
    return GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: const Loader(),
      child: Scaffold(
        key: sliderbar,
        endDrawer: GlossaryDrawer(glossary: widget.screendata),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
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
                        margin: EdgeInsets.only(
                          top: size.height * 0.04,
                        ),
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
                        height: size.height * 0.06,
                        margin:
                            EdgeInsets.symmetric(vertical: size.height * 0.04),
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
                        child: ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            itemCount: widget.screendata.optionset1!.length,
                            itemBuilder: (context, index) {
                              isCard.add(false);
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      isCard.replaceRange(0, isCard.length, [
                                        for (int i = 0; i < isCard.length; i++)
                                          false
                                      ]);
                                      isCard[index] = true;
                                      setState(() {
                                        if (isCard[index] == true) {
                                          value = widget
                                              .screendata.optionset1![index];
                                        } else {
                                          value = '';
                                        }
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
                                          color: isCard[index]
                                              ? ColorPalette.primarycolor
                                              : ColorPalette.whitetextcolor),
                                      child: Text(
                                        widget.screendata.optionset1![index],
                                        style: TextStyle(
                                          color: isCard[index]
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
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                              if (value == widget.screendata.answer!.first) {
                                showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) {
                                      return CorrectAnswer(index: widget.index);
                                    });
                              } else if (value !=
                                  widget.screendata.answer!.first) {
                                showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) {
                                      return WrongAnswer(
                                        index: widget.index,
                                        screendata: widget.screendata,
                                      );
                                    });
                              }
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
      ),
    );
  }
}
