import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:nehwe/models/user_details_model.dart';
import '../constants/color_palettes.dart';

class EditAvatar extends StatefulWidget {
  const EditAvatar({Key? key}) : super(key: key);

  @override
  State<EditAvatar> createState() => _EditAvatarState();
}

class _EditAvatarState extends State<EditAvatar> {
  UserProfileData user = localUserList[0];
  bool saveAvatar = false;
  final FluttermojiController mojicontroller = FluttermojiController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: ColorPalette.backgroundcolor2,
        body: Column(children: [
          Container(
            height: size.height * 0.42,
            padding: EdgeInsets.only(
              top: size.height * 0.06,
              left: 20,
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          style: ButtonStyle(
                              overlayColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.transparent),
                              alignment: Alignment.centerRight),
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Cancle',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: ColorPalette.secondarycolor),
                          )),
                      FluttermojiSaveWidget(
                        onTap: () async {
                          String svgstring = await FluttermojiFunctions()
                              .encodeMySVGtoString();

                          var value = svgstring;
                          newUser.avatar = value;
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: ColorPalette.secondarycolor),
                        ),
                      ),
                    ]),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // CircleAvatar(
                    //   backgroundColor: ColorPalette.backgroundcolor1,
                    //   radius: size.height * 0.12,
                    //   child: SvgPicture.string(
                    //     decodeFluttermojifromString,
                    //     width: size.width * 0.395,
                    //   ),
                    // )
                    FluttermojiCircleAvatar(
                      radius: size.height * 0.125,
                      backgroundColor: ColorPalette.backgroundcolor1,
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              decoration: const BoxDecoration(
                  color: ColorPalette.whitetextcolor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Choose your avatar look :',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: ColorPalette.secondarycolor),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: FluttermojiCustomizer(
                        scaffoldWidth: size.width,
                        autosave: saveAvatar == true ? true : false,
                        theme: FluttermojiThemeData(
                            selectedTileDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 4,
                                    color: ColorPalette.primarycolor)),
                            selectedIconColor: ColorPalette.secondarycolor,
                            secondaryBgColor: ColorPalette.whitetextcolor,
                            labelTextStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorPalette.secondarycolor)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]));
  }
}
