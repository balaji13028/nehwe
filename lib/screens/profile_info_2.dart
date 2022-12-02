import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nehwe/api_calls/login_api.dart';
import '../constants/color_palettes.dart';
import '../models/user_details_model.dart';
import '../widgets/background_2.dart';
import 'avatar_selection.dart';

class ProfileInfo2 extends StatefulWidget {
  const ProfileInfo2({Key? key}) : super(key: key);

  @override
  State<ProfileInfo2> createState() => _ProfileInfo2State();
}

class _ProfileInfo2State extends State<ProfileInfo2> {
  final formKey = GlobalKey<FormState>();
  GlobalKey<CSCPickerState> cscPickerKey = GlobalKey();
  String email = '';
  String address = '';
  String city = '';
  String state = '';
  String country = '';
  String zipcode = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Background2(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgPicture.asset(
                        'assets/images/profile_img.svg',
                        width: size.width * 0.35,
                      ),
                    ],
                  ),
                  const Text(
                    'Personal Information',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: ColorPalette.secondarycolor),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Fill the details...(optional)',
                    style:
                        TextStyle(fontSize: 16, color: ColorPalette.textcolor),
                  ),
                  const SizedBox(height: 20),
                  Stack(children: [
                    Container(
                      height: size.height * 0.045,
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: ColorPalette.statusfillcolor.withOpacity(0.4)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.top,
                        cursorHeight: 20,
                        cursorColor: ColorPalette.secondarycolor,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(
                          letterSpacing: 0.9,
                          fontSize: 18,
                          color: ColorPalette.textcolor,
                        ),
                        decoration: InputDecoration(
                            hintText: 'Email ID ',
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 1),
                            hintStyle: TextStyle(
                                letterSpacing: 1,
                                height: 2.5,
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
                        onChanged: (value) => email = value,
                      ),
                    ),
                  ]),
                  Stack(children: [
                    Container(
                      height: size.height * 0.045,
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 8, top: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: ColorPalette.statusfillcolor.withOpacity(0.4)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.top,
                        cursorHeight: 20,
                        cursorColor: ColorPalette.secondarycolor,
                        keyboardType: TextInputType.streetAddress,
                        style: const TextStyle(
                          letterSpacing: 0.9,
                          fontSize: 18,
                          color: ColorPalette.textcolor,
                        ),
                        decoration: InputDecoration(
                            hintText: 'Address ',
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 1),
                            hintStyle: TextStyle(
                                letterSpacing: 1,
                                height: 2.5,
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
                        onChanged: (value) => address = value,
                      ),
                    ),
                  ]),
                  CSCPicker(
                    key: cscPickerKey,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      color: ColorPalette.statusfillcolor.withOpacity(0.4),
                    ),
                    disabledDropdownDecoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      color: ColorPalette.statusfillcolor.withOpacity(0.4),
                    ),
                    selectedItemStyle: TextStyle(
                        letterSpacing: 0.9,
                        fontSize: (country.isEmpty) ? 15 : 18,
                        color: (country.isEmpty)
                            ? ColorPalette.textcolor.withOpacity(0.4)
                            : ColorPalette.textcolor),

                    searchBarRadius: 50,
                    layout: Layout.vertical,
                    flagState: CountryFlag.DISABLE,
                    dropdownDialogRadius: 20,
                    countrySearchPlaceholder: "Country",
                    stateSearchPlaceholder: "State",
                    citySearchPlaceholder: "City",

                    ///labels for dropdown
                    countryDropdownLabel: " Country",
                    stateDropdownLabel: " State",
                    cityDropdownLabel: " City",
                    onCountryChanged: (value) {
                      setState(() {
                        country = '  $value';
                      });
                    },
                    onStateChanged: (value) {
                      setState(() {
                        if (value != null) {
                          state = '  $value';
                        }
                      });
                    },
                    onCityChanged: (value) {
                      setState(() {
                        if (value != null) {
                          city = '  $value';
                        }
                      });
                    },
                  ),
                  Stack(children: [
                    Container(
                      height: size.height * 0.045,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: ColorPalette.statusfillcolor.withOpacity(0.4)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.top,
                        cursorHeight: 20,
                        cursorColor: ColorPalette.secondarycolor,
                        keyboardType: TextInputType.streetAddress,
                        style: const TextStyle(
                          letterSpacing: 0.9,
                          fontSize: 18,
                          color: ColorPalette.textcolor,
                        ),
                        decoration: InputDecoration(
                            hintText: 'Zipcode ',
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 0.2),
                            hintStyle: TextStyle(
                                letterSpacing: 1,
                                height: 2.5,
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
                        onChanged: (value) => zipcode = value,
                      ),
                    ),
                  ]),
                  SizedBox(height: size.height * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          try {
                            await coinslifes(newUser.phoneNumber);
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                    pageBuilder: ((context, animation,
                                            secondaryAnimation) =>
                                        const AvatarSelection())));
                          } catch (e) {
                            print('skiped');
                          }
                        },
                        child: Container(
                          height: size.height * 0.045,
                          width: size.width * 0.25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  width: 1,
                                  color: ColorPalette.secondarycolor)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                'Skip',
                                style: TextStyle(
                                    color: ColorPalette.secondarycolor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    letterSpacing: 1),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            newUser.emailId = email.trim();
                            newUser.address = address.trim();
                            newUser.city = city.trim();
                            newUser.state = state.trim();
                            newUser.country = country.trim();
                            newUser.zipcode = zipcode.trim();
                            await coinslifes(newUser.phoneNumber);
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                    pageBuilder: ((context, animation,
                                            secondaryAnimation) =>
                                        const AvatarSelection())));
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
        ),
      ),
    ));
  }
}
