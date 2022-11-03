import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nehwe/constants/buttons.dart';
import 'package:nehwe/constants/color_palettes.dart';
import 'package:nehwe/models/courses_model.dart';
import 'package:nehwe/models/user_details_model.dart';
import 'package:nehwe/prepare_screen_list/test_screeens/test_screens_list.dart';
import '../test_screen_status.dart';

// ignore: must_be_immutable
class TestReading5 extends StatefulWidget {
  ScreenData screendata;
  int index, length;
  TestReading5(
      {Key? key,
      required this.screendata,
      required this.length,
      required this.index})
      : super(key: key);

  @override
  State<TestReading5> createState() => _TestReading5State();
}

class _TestReading5State extends State<TestReading5> {
  UserProfileData user = localUserList[0];
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
                      itemPadding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                      itemPadding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                      itemPadding: const EdgeInsets.symmetric(horizontal: 10.0),
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
