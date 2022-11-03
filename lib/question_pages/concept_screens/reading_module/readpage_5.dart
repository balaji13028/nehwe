import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
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
class ReadingModule5 extends StatefulWidget {
  ScreenData screendata;
  int index;
  ReadingModule5({Key? key, required this.screendata, required this.index})
      : super(key: key);

  @override
  State<ReadingModule5> createState() => _ReadingModule5State();
}

class _ReadingModule5State extends State<ReadingModule5> {
  final sliderbar = GlobalKey<ScaffoldState>();
  UserProfileData user = localUserList[0];
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
                  SizedBox(
                    height: size.height * 0.05,
                    width: double.infinity,
                    child: Text(
                      widget.screendata.question!,
                      style: const TextStyle(
                          fontSize: 18,
                          color: ColorPalette.textcolor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(bottom: size.height * 0.06),
                      height: size.height * 0.04,
                      width: double.infinity,
                      child: RatingBar.builder(
                        unratedColor:
                            ColorPalette.backgroundcolor1.withOpacity(0.2),
                        itemSize: 50,
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 10.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Color.fromARGB(255, 241, 181, 3),
                        ),
                        onRatingUpdate: (rating) {},
                      )),
                  SizedBox(
                    height: size.height * 0.05,
                    width: double.infinity,
                    child: Text(
                      widget.screendata.question!,
                      style: const TextStyle(
                          fontSize: 18,
                          color: ColorPalette.textcolor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(bottom: size.height * 0.06),
                      height: size.height * 0.04,
                      width: double.infinity,
                      child: RatingBar.builder(
                        unratedColor:
                            ColorPalette.backgroundcolor1.withOpacity(0.2),
                        itemSize: 50,
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 10.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Color.fromARGB(255, 241, 181, 3),
                        ),
                        onRatingUpdate: (rating) {},
                      )),
                  SizedBox(
                    height: size.height * 0.05,
                    width: double.infinity,
                    child: Text(
                      widget.screendata.question!,
                      style: const TextStyle(
                          fontSize: 18,
                          color: ColorPalette.textcolor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(bottom: size.height * 0.06),
                      height: size.height * 0.04,
                      width: double.infinity,
                      child: RatingBar.builder(
                        unratedColor:
                            ColorPalette.backgroundcolor1.withOpacity(0.2),
                        itemSize: 50,
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 10.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Color.fromARGB(255, 241, 181, 3),
                        ),
                        onRatingUpdate: (rating) {},
                      )),
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
