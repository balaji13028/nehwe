import 'package:flutter/material.dart';
import 'package:nehwe/prepare_screen_list/test_screeens/test_screens_list.dart';
import 'package:nehwe/question_pages/test_module/test_screen_status.dart';
import '../../../constants/buttons.dart';
import '../../../constants/color_palettes.dart';
import '../../../models/courses_model.dart';
import '../../../prepare_screen_list/concept_screens/concept_prepare_ScreenList.dart';
import '../../../models/user_details_model.dart';
import '../../concept_screens/concepts_screen_status.dart';

// ignore: must_be_immutable
class TestListening7 extends StatefulWidget {
  ScreenData screendata;
  int index, length;
  TestListening7(
      {Key? key,
      required this.index,
      required this.length,
      required this.screendata})
      : super(key: key);

  @override
  State<TestListening7> createState() => _TestListening7State();
}

class _TestListening7State extends State<TestListening7> {
  UserProfileData user = localUserList[0];
  List<bool> isCardEnabled = [];
  final List<TextEditingController> _controller =
      List.generate(74, (i) => TextEditingController());

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
                SizedBox(
                    height: (widget.screendata.optionset1!.length > 4)
                        ? size.height * 0.17
                        : size.height * 0.1,
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4, crossAxisSpacing: 8),
                        itemCount: widget.screendata.optionset1!.length,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: ((context, index) {
                          return Container(
                            width: 60,
                            decoration: const BoxDecoration(),
                            child: TextFormField(
                              readOnly: true,
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: ColorPalette.textcolor,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                              controller: _controller[index],
                              decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorPalette.textcolor,
                                      width: 1.5),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorPalette.textcolor,
                                      width: 1.5),
                                ),
                              ),
                              onChanged: (value) {
                                FocusScope.of(context).nextFocus();
                              },
                            ),
                          );
                        }))),
                Container(
                  height: size.height * 0.06,
                  margin: EdgeInsets.only(bottom: size.height * 0.02),
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
                SizedBox(
                    height: size.height * 0.22,
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                childAspectRatio: 1.8),
                        physics: const ClampingScrollPhysics(),
                        itemCount: widget.screendata.optionset1!.length,
                        itemBuilder: ((context, index) {
                          isCardEnabled.add(false);
                          return GestureDetector(
                            onTap: () {
                              var value = widget.screendata.optionset1![index];
                              setState(() {
                                isCardEnabled[index] = !isCardEnabled[index];
                                if (isCardEnabled[index] == true) {
                                  for (var i = 0; i < _controller.length; i++) {
                                    if (_controller[i].text.isEmpty) {
                                      _controller[i].text = value;
                                      break;
                                    }
                                  }
                                } else if (isCardEnabled[index] == false) {
                                  for (var i = 0; i < _controller.length; i++) {
                                    if (_controller[i].text == value) {
                                      _controller[i].text = '';
                                      break;
                                    }
                                  }
                                }
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 100,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(bottom: 18),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
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
                                  color: isCardEnabled[index]
                                      ? ColorPalette.primarycolor
                                      : ColorPalette.whitetextcolor),
                              child: Text(
                                widget.screendata.optionset1![index],
                                style: TextStyle(
                                  color: isCardEnabled[index]
                                      ? ColorPalette.whitetextcolor
                                      : ColorPalette.textcolor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          );
                        })))
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
