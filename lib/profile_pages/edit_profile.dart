import 'dart:convert';

import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../api_calls/user_details_api.dart';
import '../constants/color_palettes.dart';
import '../local_database.dart';
import '../models/user_details_model.dart';
import '../screens/dashboard.dart';
import 'edit_avatar.dart';
import 'dart:math' as math;

// ignore: must_be_immutable
class EditProfile extends StatefulWidget {
  UserProfileData user;
  EditProfile({Key? key, required this.user}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<CSCPickerState> cscPickerKey = GlobalKey();
  final formKey = GlobalKey<FormState>();
  late final TextEditingController firstController;
  late final TextEditingController lastName;
  late final TextEditingController displayName;
  late final TextEditingController email;
  late final TextEditingController address;
  String city = '';
  String state = '';
  String country = '';
  late final TextEditingController zipcode;
  bool _isLoaderVisible = false;
  loader() async {
    if (_isLoaderVisible) {
      context.loaderOverlay.show();
    } else {
      context.loaderOverlay.hide();
    }
  }

  @override
  void initState() {
    firstController = TextEditingController(text: widget.user.firstName);
    lastName = TextEditingController(text: widget.user.lastName);
    displayName = TextEditingController(text: widget.user.displayName);
    email = (widget.user.emailId != 'null')
        ? TextEditingController(text: widget.user.emailId)
        : TextEditingController(text: '');
    address = (widget.user.address != 'null')
        ? TextEditingController(text: widget.user.address)
        : TextEditingController(text: '');

    zipcode = (widget.user.zipcode != 'null')
        ? TextEditingController(text: widget.user.zipcode)
        : TextEditingController(text: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorPalette.backgroundcolor2,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: ColorPalette.primarycolor,
                        ),
                      ),
                      const Text(
                        'Edit Profile',
                        style: TextStyle(
                            color: ColorPalette.primarycolor,
                            letterSpacing: 0.9,
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                      ),
                      Visibility(
                        visible: false,
                        maintainAnimation: true,
                        maintainState: true,
                        maintainSize: true,
                        child: Container(
                          height: 40,
                          width: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: ColorPalette.whitetextcolor,
                              borderRadius: BorderRadius.circular(6)),
                          child: const Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: ColorPalette.primarycolor,
                          ),
                        ),
                      ),
                    ]),
                SizedBox(height: size.height * 0.115),
                Stack(
                    alignment: Alignment.topCenter,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: size.height * 0.1,
                        ),
                        decoration: BoxDecoration(
                            color: ColorPalette.whitetextcolor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const EditAvatar()));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.rotationY(math.pi),
                                      child: const Icon(
                                        Icons.edit,
                                        size: 28,
                                        color: ColorPalette.primarycolor,
                                      ),
                                    ),
                                    const Text(
                                      'Change profile avatar',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: ColorPalette.secondarycolor,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: size.height * 0.04),
                              Stack(children: [
                                Container(
                                  height: size.height * 0.05,
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      // color: Color(0xffd6dde7)
                                      color: ColorPalette.statusfillcolor
                                          .withOpacity(0.4)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  child: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    controller: firstController,
                                    textAlignVertical: TextAlignVertical.top,
                                    cursorHeight: 18,
                                    cursorColor: ColorPalette.secondarycolor,
                                    keyboardType: TextInputType.name,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    style: const TextStyle(
                                      letterSpacing: 0.9,
                                      fontSize: 18,
                                      color: ColorPalette.textcolor,
                                    ),
                                    decoration: InputDecoration(
                                        hintText: 'First name ',
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 6),
                                        hintStyle: TextStyle(
                                            letterSpacing: 1,
                                            color: ColorPalette.textcolor
                                                .withOpacity(0.4),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w100),
                                        focusedErrorBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        errorStyle: const TextStyle(
                                            fontSize: 10, height: 0.1),
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
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
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      // color: Color(0xffd6dde7)
                                      color: ColorPalette.statusfillcolor
                                          .withOpacity(0.4)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  child: TextFormField(
                                    controller: lastName,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    textAlignVertical: TextAlignVertical.top,
                                    cursorHeight: 18,
                                    cursorColor: ColorPalette.secondarycolor,
                                    keyboardType: TextInputType.name,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    style: const TextStyle(
                                      letterSpacing: 0.9,
                                      fontSize: 18,
                                      color: ColorPalette.textcolor,
                                    ),
                                    decoration: InputDecoration(
                                        hintText: 'Last name ',
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 6,
                                        ),
                                        hintStyle: TextStyle(
                                            letterSpacing: 1,
                                            color: ColorPalette.textcolor
                                                .withOpacity(0.4),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w100),
                                        focusedErrorBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        errorStyle: const TextStyle(
                                            fontSize: 10, height: 0.2),
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
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
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      // color: Color(0xffd6dde7)
                                      color: ColorPalette.statusfillcolor
                                          .withOpacity(0.4)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  child: TextFormField(
                                    controller: displayName,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    textAlignVertical: TextAlignVertical.top,
                                    cursorHeight: 18,
                                    cursorColor: ColorPalette.secondarycolor,
                                    keyboardType: TextInputType.name,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    style: const TextStyle(
                                      letterSpacing: 0.9,
                                      fontSize: 18,
                                      color: ColorPalette.textcolor,
                                    ),
                                    decoration: InputDecoration(
                                        hintText: 'Display name ',
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 6, vertical: 10),
                                        hintStyle: TextStyle(
                                            letterSpacing: 1,
                                            color: ColorPalette.textcolor
                                                .withOpacity(0.4),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w100),
                                        focusedErrorBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        errorStyle: const TextStyle(
                                            fontSize: 10, height: 0.4),
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
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
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      // color: Color(0xffd6dde7)
                                      color: ColorPalette.statusfillcolor
                                          .withOpacity(0.4)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  child: TextFormField(
                                    controller: email,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    textAlignVertical: TextAlignVertical.top,
                                    cursorHeight: 18,
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
                                            const EdgeInsets.symmetric(
                                                horizontal: 6),
                                        hintStyle: TextStyle(
                                            letterSpacing: 1,
                                            color: ColorPalette.textcolor
                                                .withOpacity(0.4),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w100),
                                        focusedErrorBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        errorStyle: const TextStyle(
                                            fontSize: 10, height: 0.1),
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none),
                                  ),
                                ),
                              ]),
                              Stack(children: [
                                Container(
                                  height: size.height * 0.05,
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      // color: Color(0xffd6dde7)
                                      color: ColorPalette.statusfillcolor
                                          .withOpacity(0.4)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  child: TextFormField(
                                    controller: address,
                                    textAlignVertical: TextAlignVertical.top,
                                    cursorHeight: 22,
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
                                            const EdgeInsets.symmetric(
                                          horizontal: 6,
                                        ),
                                        hintStyle: TextStyle(
                                            letterSpacing: 1,
                                            color: ColorPalette.textcolor
                                                .withOpacity(0.4),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w100),
                                        focusedErrorBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        errorStyle: const TextStyle(
                                            fontSize: 10, height: 0.2),
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return '*This field is mandatory';
                                      }

                                      return null;
                                    },
                                  ),
                                ),
                              ]),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                child: CSCPicker(
                                  key: cscPickerKey,
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50)),
                                    color: ColorPalette.statusfillcolor
                                        .withOpacity(0.4),
                                  ),
                                  disabledDropdownDecoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50)),
                                    color: ColorPalette.statusfillcolor
                                        .withOpacity(0.4),
                                  ),
                                  selectedItemStyle: const TextStyle(
                                      letterSpacing: 0.9,
                                      fontSize: 18,
                                      color: ColorPalette.textcolor),
                                  currentCountry:
                                      (widget.user.country == 'null')
                                          ? ''
                                          : '  ${widget.user.country}',
                                  currentState: (widget.user.state == 'null')
                                      ? ''
                                      : '  ${widget.user.state}',
                                  currentCity: (widget.user.city == 'null')
                                      ? ''
                                      : '  ${widget.user.city}',
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
                                      country = value;
                                    });
                                  },
                                  onStateChanged: (value) {
                                    setState(() {
                                      if (value != null) {
                                        state = value;
                                      }
                                    });
                                  },
                                  onCityChanged: (value) {
                                    setState(() {
                                      if (value != null) {
                                        city = value;
                                      }
                                    });
                                  },
                                ),
                              ),
                              Container(
                                height: size.height * 0.05,
                                width: size.width,
                                alignment: Alignment.center,
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    // color: Color(0xffd6dde7)
                                    color: ColorPalette.statusfillcolor
                                        .withOpacity(0.4)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  child: TextFormField(
                                    controller: zipcode,
                                    cursorHeight: 22,
                                    cursorColor: ColorPalette.secondarycolor,
                                    keyboardType: TextInputType.name,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    style: const TextStyle(
                                      letterSpacing: 0.9,
                                      fontSize: 18,
                                      color: ColorPalette.textcolor,
                                    ),
                                    decoration: InputDecoration(
                                        hintText: 'Zip Code ',
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 6, vertical: 15),
                                        hintStyle: TextStyle(
                                            letterSpacing: 1,
                                            color: ColorPalette.textcolor
                                                .withOpacity(0.4),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w100),
                                        focusedErrorBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        errorStyle: const TextStyle(
                                            fontSize: 10, height: 0.2),
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return '*This field is mandatory';
                                      }

                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              TextButton(
                                style: ButtonStyle(
                                  overlayColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.transparent),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    _isLoaderVisible = true;
                                  });

                                  if (address.text.isNotEmpty ||
                                      city.isNotEmpty ||
                                      state.isNotEmpty ||
                                      country.isNotEmpty ||
                                      zipcode.text.isNotEmpty) {
                                    loader();
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      newUser.gender = widget.user.gender;
                                      newUser.dob = widget.user.dob;
                                      newUser.phoneNumber =
                                          widget.user.phoneNumber;
                                      newUser.firstName = firstController.text;
                                      newUser.lastName = lastName.text;
                                      newUser.displayName = displayName.text;
                                      newUser.emailId = email.text;
                                      newUser.address = address.text;
                                      newUser.city = (city.isEmpty)
                                          ? widget.user.city
                                          : city;
                                      newUser.state = (state.isEmpty)
                                          ? widget.user.state
                                          : state;
                                      newUser.country = (country.isEmpty)
                                          ? widget.user.country
                                          : country;
                                      newUser.zipcode = zipcode.text;
                                      newUser.subId = '1';
                                      newUser.id = widget.user.id;
                                      newUser.coins = widget.user.coins;
                                      newUser.xp = widget.user.xp;
                                      newUser.lifes = widget.user.lifes;
                                      newUser.lastused = widget.user.lastused;
                                      newUser.avatar =
                                          (newUser.avatar == 'null' ||
                                                  newUser.avatar == null)
                                              ? widget.user.avatar
                                              : newUser.avatar;
                                      await updateUserProfile(
                                          newUser.phoneNumber,
                                          newUser.firstName,
                                          newUser.lastName,
                                          newUser.displayName,
                                          newUser.emailId,
                                          newUser.address,
                                          newUser.city,
                                          newUser.state,
                                          newUser.country,
                                          newUser.zipcode,
                                          newUser.avatar);
                                      await updateUser(newUser);
                                      localUserList = await user();
                                      // ignore: use_build_context_synchronously
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  const DashBoard())));
                                    }
                                  } else {
                                    loader();
                                    formKey.currentState!.save();
                                    newUser.gender = widget.user.gender;
                                    newUser.dob = widget.user.dob;
                                    newUser.phoneNumber =
                                        widget.user.phoneNumber;
                                    newUser.firstName = firstController.text;
                                    newUser.lastName = lastName.text;
                                    newUser.displayName = displayName.text;
                                    newUser.emailId = email.text;
                                    newUser.address = address.text;
                                    newUser.city = city;
                                    newUser.state = state;
                                    newUser.country = country;
                                    newUser.zipcode = zipcode.text;
                                    newUser.id = widget.user.id;
                                    newUser.coins = widget.user.coins;
                                    newUser.xp = widget.user.xp;
                                    newUser.subId = '1';
                                    newUser.lifes = widget.user.lifes;
                                    newUser.lastused = widget.user.lastused;
                                    newUser.avatar =
                                        (newUser.avatar == 'null' ||
                                                newUser.avatar == null)
                                            ? widget.user.avatar
                                            : newUser.avatar;
                                    await updateUser(newUser);
                                    localUserList = await user();
                                    await updateUserProfile(
                                        newUser.phoneNumber,
                                        newUser.firstName,
                                        newUser.lastName,
                                        newUser.displayName,
                                        newUser.emailId,
                                        newUser.address,
                                        newUser.city,
                                        newUser.state,
                                        newUser.country,
                                        newUser.zipcode,
                                        newUser.avatar);

                                    // ignore: use_build_context_synchronously
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                const DashBoard())));
                                  }
                                  setState(() {
                                    _isLoaderVisible = false;
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(
                                      top: 20, bottom: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: ColorPalette.gradientbutton1),
                                  child: const Text(
                                    'Save',
                                    style: TextStyle(
                                        color: ColorPalette.whitetextcolor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        letterSpacing: 1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      (widget.user.avatar == null ||
                              widget.user.avatar == 'null')
                          ? Positioned(
                              top: -size.height * 0.085,
                              child: FluttermojiCircleAvatar(
                                backgroundColor: ColorPalette.backgroundcolor1,
                                radius: size.height * 0.085,
                              ),
                            )
                          : Positioned(
                              top: -size.height * 0.085,
                              child: CircleAvatar(
                                backgroundColor: ColorPalette.backgroundcolor1,
                                radius: size.height * 0.085,
                                child: SvgPicture.string(
                                  widget.user.avatar!,
                                  width: size.height * 0.13,
                                ),
                              ),
                            ),
                    ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
