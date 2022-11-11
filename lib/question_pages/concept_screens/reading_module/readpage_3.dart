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
class ReadingModule3 extends StatefulWidget {
  ScreenData screendata;
  int index;
  ReadingModule3({Key? key, required this.index, required this.screendata})
      : super(key: key);
  @override
  State<ReadingModule3> createState() => _ReadingModule3State();
}

class _ReadingModule3State extends State<ReadingModule3> {
  final sliderbar = GlobalKey<ScaffoldState>();
  UserProfileData user = localUserList[0];
  List<bool> isCard = [];
  String value = '';

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
            child: Stack(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  screenTopbar(context, newUser.lifes, widget.index),
                  Container(
                    height: size.height * 0.1,
                    margin: EdgeInsets.only(
                        bottom: size.height * 0.02, top: size.height * 0.04),
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
                      child: Column(children: [
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
                                    value =
                                        widget.screendata.optionset1![index];
                                    isCard.replaceRange(0, isCard.length, [
                                      for (int i = 0; i < isCard.length; i++)
                                        false
                                    ]);
                                    isCard[index] = true;
                                    setState(() {
                                      //isCard[index] = !isCard[index];
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
                  ]))
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
