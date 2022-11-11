import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:nehwe/api_calls/test_api.dart';
import 'package:nehwe/courses/test_screeen.dart';
import 'package:nehwe/models/courses_model.dart';
import 'package:nehwe/models/user_details_model.dart';
import 'package:nehwe/prepare_screen_list/test_screeens/test_screens_list.dart';
import '../constants/color_palettes.dart';

bool _isLoaderVisible = false;
loader(BuildContext context) async {
  if (_isLoaderVisible) {
    context.loaderOverlay.show();
  } else {
    context.loaderOverlay.hide();
  }
}

confirmToTakeTEST(BuildContext context, courseId, unitId, userId) {
  Size size = MediaQuery.of(context).size;
  UserProfileData user = localUserList[0];
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: ColorPalette.backgroundcolor2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          title: const Text(
            'Confirmation!',
            textAlign: TextAlign.center,
          ),
          titleTextStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ColorPalette.textcolor),
          content: const Text(
            'Are you sure you want to take test ?',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16,
                //fontWeight: FontWeight.bold,
                color: ColorPalette.textcolor),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => Colors.transparent),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: size.height * 0.035,
                      width: size.width * 0.25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              width: 1, color: ColorPalette.secondarycolor)),
                      child: const Text(
                        'NO',
                        style: TextStyle(
                            fontSize: 18, color: ColorPalette.primarycolor),
                      ),
                    )),
                TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => Colors.transparent),
                    ),
                    onPressed: () async {
                      screenlist = await testapi(courseId, unitId, userId);
                      newscreen.testId = screenlist[0].testId;
                      newscreen.status = screenlist[0].status;
                      if (newscreen.status == '0') {
                        var value = int.parse(user.lifes!);
                        newUser.lifes = (value - 1).toString();
                        user.lifes = newUser.lifes;
                        const idx = 0;
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder:
                                    ((context, animation, secondaryAnimation) =>
                                        TestQuestionPage(
                                            index: idx,
                                            length: screenlist.length))));
                        // testModuleToNavigatetoScreen(context, idx);
                      } else {
                        EasyLoading.showSuccess(
                            'you are already completed this test');
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      height: size.height * 0.035,
                      width: size.width * 0.25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: ColorPalette.primarycolor),
                      child: const Text(
                        'YES',
                        style: TextStyle(
                            fontSize: 18, color: ColorPalette.whitetextcolor),
                      ),
                    ))
              ],
            ),
          ],
        );
      });
}
