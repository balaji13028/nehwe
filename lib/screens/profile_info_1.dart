import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nehwe/screens/profile_info_2.dart';
import '../constants/color_palettes.dart';
import '../models/user_details_model.dart';
import '../widgets/background.dart';

class ProfileInfo1 extends StatefulWidget {
  const ProfileInfo1({Key? key}) : super(key: key);

  @override
  State<ProfileInfo1> createState() => _ProfileInfo1State();
}

class _ProfileInfo1State extends State<ProfileInfo1> {
  TextEditingController dateinput = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final List<String> items = [
    'Male',
    'Female',
    'Others',
  ];
  String? gender;
  final TextEditingController firstController = TextEditingController();
  final TextEditingController displayName = TextEditingController();
  String lastName = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Background(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/profile_img.svg',
                    width: size.width * 0.4,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'We need a few details about you to start with nehwe!',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: ColorPalette.primarycolor),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Fill the details...',
                    style:
                        TextStyle(fontSize: 14, color: ColorPalette.textcolor),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Stack(children: [
                    Container(
                      height: size.height * 0.05,
                      width: double.infinity,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: ColorPalette.statusfillcolor.withOpacity(0.4)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: firstController,
                        cursorHeight: 20,
                        cursorColor: ColorPalette.secondarycolor,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        style: const TextStyle(
                          letterSpacing: 0.9,
                          fontSize: 18,
                          color: ColorPalette.textcolor,
                        ),
                        decoration: InputDecoration(
                            hintText: 'First name ',
                            hintStyle: TextStyle(
                                letterSpacing: 1,
                                color: ColorPalette.textcolor.withOpacity(0.4),
                                fontSize: 15,
                                fontWeight: FontWeight.w100),
                            focusedErrorBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            errorStyle:
                                const TextStyle(fontSize: 10, height: 0.1),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return '*This field is mandatory';
                          }

                          return null;
                        },
                      ),
                    ),
                  ]),
                  Stack(children: [
                    Container(
                      height: size.height * 0.05,
                      width: double.infinity,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: ColorPalette.statusfillcolor.withOpacity(0.4)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textAlignVertical: TextAlignVertical.top,
                        cursorColor: ColorPalette.secondarycolor,
                        keyboardType: TextInputType.name,
                        cursorHeight: 20,
                        textCapitalization: TextCapitalization.words,
                        style: const TextStyle(
                          letterSpacing: 0.9,
                          fontSize: 18,
                          color: ColorPalette.textcolor,
                        ),
                        decoration: InputDecoration(
                            hintText: 'Last name ',
                            hintStyle: TextStyle(
                                letterSpacing: 1,
                                color: ColorPalette.textcolor.withOpacity(0.4),
                                fontSize: 15,
                                fontWeight: FontWeight.w100),
                            focusedErrorBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            errorStyle:
                                const TextStyle(fontSize: 10, height: 0.2),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return '*This field is mandatory';
                          }

                          return null;
                        },
                        onChanged: (value) => lastName = value,
                      ),
                    ),
                  ]),
                  Stack(children: [
                    Container(
                      height: size.height * 0.05,
                      width: double.infinity,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: ColorPalette.statusfillcolor.withOpacity(0.4)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 2),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: displayName,
                        cursorHeight: 20,
                        cursorColor: ColorPalette.secondarycolor,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        style: const TextStyle(
                          letterSpacing: 0.9,
                          fontSize: 18,
                          color: ColorPalette.textcolor,
                        ),
                        decoration: InputDecoration(
                            hintText: 'Display name ',
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 10),
                            hintStyle: TextStyle(
                                letterSpacing: 1,
                                color: ColorPalette.textcolor.withOpacity(0.4),
                                fontSize: 15,
                                fontWeight: FontWeight.w100),
                            focusedErrorBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            errorStyle:
                                const TextStyle(fontSize: 10, height: 0.4),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return '*This field is mandatory';
                          }

                          return null;
                        },
                      ),
                    ),
                  ]),
                  Container(
                    height: size.height * 0.05,
                    width: double.infinity,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: ColorPalette.statusfillcolor.withOpacity(0.4)),
                    child: GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: dateinput,
                          readOnly: true,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textAlignVertical: TextAlignVertical.top,
                          cursorHeight: 20,
                          cursorColor: ColorPalette.secondarycolor,
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                          style: const TextStyle(
                            letterSpacing: 0.9,
                            fontSize: 17,
                            color: ColorPalette.textcolor,
                          ),
                          onTap: () async {
                            final DateTime? datePick = await showDatePicker(
                                context: context,
                                initialDatePickerMode: DatePickerMode.day,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now());

                            if (datePick != null) {
                              String formattedDate =
                                  DateFormat('dd-MM-yyyy').format(datePick);

                              setState(() {
                                dateinput.text = formattedDate;
                              });
                            }
                          },
                          decoration: InputDecoration(
                              suffixIcon: const Icon(
                                Icons.calendar_month,
                                size: 22,
                              ),
                              hintText: 'Date Of Birth',
                              hintStyle: TextStyle(
                                  letterSpacing: 1,
                                  color:
                                      ColorPalette.textcolor.withOpacity(0.4),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w100),
                              focusedErrorBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              errorStyle:
                                  const TextStyle(fontSize: 10, height: 0.2),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return '*This field is mandatory';
                            }

                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                      height: size.height * 0.05,
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.only(left: 20, right: size.width * 0.08),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: ColorPalette.statusfillcolor.withOpacity(0.4)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          hint: Text(
                            'Gender',
                            style: TextStyle(
                                letterSpacing: 1,
                                color: ColorPalette.textcolor.withOpacity(0.4),
                                fontSize: 15,
                                fontWeight: FontWeight.w100),
                          ),
                          items: items
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1,
                                          color: ColorPalette.textcolor),
                                    ),
                                  ))
                              .toList(),
                          value: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value as String;
                            });
                          },
                          buttonHeight: 40,
                          buttonWidth: double.infinity,
                        ),
                      )),
                  SizedBox(height: size.height * 0.06),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            newUser.firstName = firstController.text;
                            newUser.lastName = lastName;
                            newUser.displayName = displayName.text;
                            newUser.dob = dateinput.text;
                            newUser.gender = gender;

                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                    pageBuilder: ((context, animation,
                                            secondaryAnimation) =>
                                        const ProfileInfo2())));
                          }
                        },
                        child: Container(
                          height: size.height * 0.045,
                          width: size.width * 0.25,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: ColorPalette.primarycolor),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                'Next',
                                style: TextStyle(
                                    color: ColorPalette.whitetextcolor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    letterSpacing: 1),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 15,
                                color: ColorPalette.whitetextcolor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
          ),
        )),
      ),
    ));
  }
}
