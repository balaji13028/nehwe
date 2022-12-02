import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:nehwe/api_calls/concepts_api.dart';
import 'package:nehwe/api_calls/course_api.dart';
import 'package:nehwe/api_calls/online_status.dart';
import 'package:nehwe/api_calls/xp_api.dart';
import 'package:nehwe/models/user_intime.dart';
import 'package:nehwe/screens/profile_info_1.dart';
import '../api_calls/coins_api.dart';
import '../api_calls/lifes_api.dart';
import '../api_calls/listof_users.dart';
import '../api_calls/login_api.dart';
import '../constants/color_palettes.dart';
import '../loadings/loader.dart';
import '../local_database.dart';
import '../models/user_details_model.dart';
import '../widgets/background.dart';
import 'dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  String phoneNumber = '';

  bool getotp = false;

  String num1 = '';

  String num2 = '';

  String num3 = '';

  String num4 = '';

  String num5 = '';
  String num6 = '';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: GlobalLoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: const Loader(),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Background(
              child: SafeArea(
                child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Welcome!',
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: ColorPalette.secondarycolor),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Login to continue...',
                            style: TextStyle(
                                fontSize: 16, color: ColorPalette.textcolor),
                          ),
                          Stack(
                              clipBehavior: Clip.none,
                              alignment: AlignmentDirectional.bottomCenter,
                              children: [
                                Container(
                                    height: getotp == true
                                        ? size.height * 0.39
                                        : size.height * 0.26,
                                    width: double.infinity,
                                    margin: EdgeInsets.only(
                                        top: size.height * 0.03),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: ColorPalette.gradientbutton1),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Login',
                                            style: TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold,
                                                color: ColorPalette
                                                    .whitetextcolor),
                                          ),
                                          Visibility(
                                            visible:
                                                getotp == true ? false : true,
                                            child: const SizedBox(
                                              height: 10,
                                            ),
                                          ),
                                          Visibility(
                                            visible:
                                                getotp == true ? false : true,
                                            child: RichText(
                                              text: TextSpan(
                                                text: 'You will get ',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: ColorPalette
                                                      .whitetextcolor
                                                      .withOpacity(0.9),
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: 'one time password ',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: ColorPalette
                                                          .whitetextcolor
                                                          .withOpacity(0.9),
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: 'on this number',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: ColorPalette
                                                          .whitetextcolor
                                                          .withOpacity(0.9),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          Form(
                                            key: formKey,
                                            child: Column(children: [
                                              Stack(children: [
                                                Container(
                                                  height: size.height * 0.055,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    color: ColorPalette
                                                        .whitetextcolor
                                                        .withOpacity(0.9),
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 15,
                                                    right: 3,
                                                    bottom: 5,
                                                  ),
                                                  child: TextFormField(
                                                    readOnly: getotp == true
                                                        ? true
                                                        : false,
                                                    cursorHeight: 22,
                                                    cursorColor: ColorPalette
                                                        .secondarycolor,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    style: const TextStyle(
                                                      letterSpacing: 0.9,
                                                      fontSize: 18,
                                                      color: ColorPalette
                                                          .textcolor,
                                                    ),
                                                    inputFormatters: [
                                                      LengthLimitingTextInputFormatter(
                                                          10),
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    decoration: InputDecoration(
                                                      prefixIcon: Container(
                                                        // padding:
                                                        //     const EdgeInsets
                                                        //             .only(
                                                        //         bottom: 10),
                                                        child:
                                                            CountryPickerDropdown(
                                                          initialValue: 'IN',
                                                          itemFilter: (c) => [
                                                            'US',
                                                            'GB',
                                                            'IN',
                                                            'IT'
                                                          ].contains(c.isoCode),
                                                          iconSize: 20,
                                                          onValuePicked:
                                                              (Country
                                                                  country) {},
                                                          itemBuilder: (Country
                                                              country) {
                                                            return Row(
                                                              children: [
                                                                Text(
                                                                  "+${country.phoneCode}",
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          18),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      suffixIcon: Visibility(
                                                        visible: getotp == true
                                                            ? true
                                                            : false,
                                                        child: Container(
                                                          // padding:
                                                          //     const EdgeInsets
                                                          //             .only(
                                                          //         bottom: 8),
                                                          child: TextButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                getotp =
                                                                    !getotp;
                                                              });
                                                            },
                                                            child: const Text(
                                                              'Change',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: ColorPalette
                                                                      .secondarycolor),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      hintText: ' Phone number',
                                                      hintStyle: TextStyle(
                                                          color: ColorPalette
                                                              .textcolor
                                                              .withOpacity(0.5),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      focusedErrorBorder:
                                                          InputBorder.none,
                                                      errorBorder:
                                                          InputBorder.none,
                                                      errorStyle:
                                                          const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              height: 0.1),
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                    ),
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value
                                                              .trim()
                                                              .isEmpty) {
                                                        return 'Please enter your phone number';
                                                      }
                                                      if (value.trim().length <
                                                          10) {
                                                        return 'phone number must be 10 digits';
                                                      }

                                                      return null;
                                                    },
                                                    onChanged: (value) =>
                                                        phoneNumber = value,
                                                  ),
                                                ),
                                              ]),
                                              Visibility(
                                                visible: getotp == true
                                                    ? true
                                                    : false,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            'Please enter 6 digits verification code sent to your mobile number.',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: ColorPalette
                                                                    .whitetextcolor
                                                                    .withOpacity(
                                                                        0.8)),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.02,
                                                    ),
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            height:
                                                                size.height *
                                                                    0.045,
                                                            width: size.width *
                                                                0.1,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6),
                                                              color: ColorPalette
                                                                  .whitetextcolor
                                                                  .withOpacity(
                                                                      0.9),
                                                            ),
                                                            child:
                                                                TextFormField(
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline5,
                                                              cursorHeight: 22,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              inputFormatters: [
                                                                LengthLimitingTextInputFormatter(
                                                                    1),
                                                                FilteringTextInputFormatter
                                                                    .digitsOnly,
                                                              ],
                                                              decoration:
                                                                  const InputDecoration(
                                                                enabledBorder:
                                                                    InputBorder
                                                                        .none,
                                                                focusedBorder:
                                                                    InputBorder
                                                                        .none,
                                                              ),
                                                              onChanged:
                                                                  ((value) {
                                                                if (value
                                                                        .length ==
                                                                    1) {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .nextFocus();
                                                                }
                                                                num1 = value;
                                                              }),
                                                            ),
                                                          ),
                                                          Container(
                                                            height:
                                                                size.height *
                                                                    0.045,
                                                            width: size.width *
                                                                0.1,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6),
                                                                color: ColorPalette
                                                                    .whitetextcolor
                                                                    .withOpacity(
                                                                        0.9)),
                                                            child:
                                                                TextFormField(
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline5,
                                                              cursorHeight: 22,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              inputFormatters: [
                                                                LengthLimitingTextInputFormatter(
                                                                    1),
                                                                FilteringTextInputFormatter
                                                                    .digitsOnly,
                                                              ],
                                                              decoration:
                                                                  const InputDecoration(
                                                                enabledBorder:
                                                                    InputBorder
                                                                        .none,
                                                                focusedBorder:
                                                                    InputBorder
                                                                        .none,
                                                              ),
                                                              onChanged:
                                                                  ((value) {
                                                                if (value
                                                                        .length ==
                                                                    1) {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .nextFocus();
                                                                } else if (value
                                                                    .isEmpty) {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .previousFocus();
                                                                }
                                                                num2 = value;
                                                              }),
                                                            ),
                                                          ),
                                                          Container(
                                                            height:
                                                                size.height *
                                                                    0.045,
                                                            width: size.width *
                                                                0.1,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6),
                                                                color: ColorPalette
                                                                    .whitetextcolor
                                                                    .withOpacity(
                                                                        0.9)),
                                                            child:
                                                                TextFormField(
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline5,
                                                              cursorHeight: 22,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              inputFormatters: [
                                                                LengthLimitingTextInputFormatter(
                                                                    1),
                                                                FilteringTextInputFormatter
                                                                    .digitsOnly,
                                                              ],
                                                              decoration:
                                                                  const InputDecoration(
                                                                enabledBorder:
                                                                    InputBorder
                                                                        .none,
                                                                focusedBorder:
                                                                    InputBorder
                                                                        .none,
                                                              ),
                                                              onChanged:
                                                                  ((value) {
                                                                if (value
                                                                        .length ==
                                                                    1) {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .nextFocus();
                                                                } else if (value
                                                                    .isEmpty) {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .previousFocus();
                                                                }
                                                                num3 = value;
                                                              }),
                                                            ),
                                                          ),
                                                          Container(
                                                            height:
                                                                size.height *
                                                                    0.045,
                                                            width: size.width *
                                                                0.1,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6),
                                                                color: ColorPalette
                                                                    .whitetextcolor
                                                                    .withOpacity(
                                                                        0.9)),
                                                            child:
                                                                TextFormField(
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline5,
                                                              cursorHeight: 22,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              inputFormatters: [
                                                                LengthLimitingTextInputFormatter(
                                                                    1),
                                                                FilteringTextInputFormatter
                                                                    .digitsOnly,
                                                              ],
                                                              decoration:
                                                                  const InputDecoration(
                                                                enabledBorder:
                                                                    InputBorder
                                                                        .none,
                                                                focusedBorder:
                                                                    InputBorder
                                                                        .none,
                                                              ),
                                                              onChanged:
                                                                  ((value) {
                                                                if (value
                                                                        .length ==
                                                                    1) {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .nextFocus();
                                                                } else if (value
                                                                    .isEmpty) {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .previousFocus();
                                                                }
                                                                num4 = value;
                                                              }),
                                                            ),
                                                          ),
                                                          Container(
                                                            height:
                                                                size.height *
                                                                    0.045,
                                                            width: size.width *
                                                                0.1,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6),
                                                                color: ColorPalette
                                                                    .whitetextcolor
                                                                    .withOpacity(
                                                                        0.9)),
                                                            child:
                                                                TextFormField(
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline5,
                                                              cursorHeight: 22,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              inputFormatters: [
                                                                LengthLimitingTextInputFormatter(
                                                                    1),
                                                                FilteringTextInputFormatter
                                                                    .digitsOnly,
                                                              ],
                                                              decoration:
                                                                  const InputDecoration(
                                                                enabledBorder:
                                                                    InputBorder
                                                                        .none,
                                                                focusedBorder:
                                                                    InputBorder
                                                                        .none,
                                                              ),
                                                              onChanged:
                                                                  ((value) {
                                                                if (value
                                                                        .length ==
                                                                    1) {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .nextFocus();
                                                                } else if (value
                                                                    .isEmpty) {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .previousFocus();
                                                                }
                                                                num5 = value;
                                                              }),
                                                            ),
                                                          ),
                                                          Container(
                                                            height:
                                                                size.height *
                                                                    0.045,
                                                            width: size.width *
                                                                0.1,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6),
                                                                color: ColorPalette
                                                                    .whitetextcolor
                                                                    .withOpacity(
                                                                        0.9)),
                                                            child:
                                                                TextFormField(
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline5,
                                                              cursorHeight: 22,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              inputFormatters: [
                                                                LengthLimitingTextInputFormatter(
                                                                    1),
                                                                FilteringTextInputFormatter
                                                                    .digitsOnly,
                                                              ],
                                                              decoration:
                                                                  const InputDecoration(
                                                                enabledBorder:
                                                                    InputBorder
                                                                        .none,
                                                                focusedBorder:
                                                                    InputBorder
                                                                        .none,
                                                              ),
                                                              onChanged:
                                                                  ((value) {
                                                                if (value
                                                                    .isEmpty) {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .previousFocus();
                                                                }
                                                                num6 = value;
                                                              }),
                                                            ),
                                                          ),
                                                        ]),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 30),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () async {
                                                              var otp = await userLogin(
                                                                  phoneNumber,
                                                                  userTiming
                                                                      .devicetoken);
                                                              EasyLoading.showToast(
                                                                  'otp is $otp',
                                                                  duration:
                                                                      const Duration(
                                                                          seconds:
                                                                              10));
                                                            },
                                                            child: const Text(
                                                              'Resend OTP',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  letterSpacing:
                                                                      1.2,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: ColorPalette
                                                                      .whitetextcolor),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ]),
                                          )
                                        ])),
                                Visibility(
                                  visible: getotp == true ? false : true,
                                  child: Positioned(
                                    bottom: -30,
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.deferToChild,
                                      onTap: () async {
                                        if (formKey.currentState!.validate()) {
                                          formKey.currentState?.save();
                                          newUser.phoneNumber = phoneNumber;

                                          var otp = await userLogin(phoneNumber,
                                              userTiming.devicetoken);

                                          EasyLoading.showToast('otp is $otp',
                                              duration:
                                                  const Duration(seconds: 10));

                                          setState(() {
                                            getotp = !getotp;

                                            if (getotp == true) {
                                              getotp = true;
                                            }
                                          });
                                        }
                                      },
                                      child: const CircleAvatar(
                                        radius: 30,
                                        backgroundColor:
                                            ColorPalette.whitetextcolor,
                                        child: CircleAvatar(
                                          radius: 25,
                                          backgroundColor:
                                              ColorPalette.primarycolor,
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            size: 28,
                                            color: ColorPalette.whitetextcolor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                          Visibility(
                              visible: getotp == true ? true : false,
                              child: GestureDetector(
                                onTap: () async {
                                  var values = await verifyOTP(num1, num2, num3,
                                      num4, num5, num6, phoneNumber);

                                  setState(() {
                                    _isLoaderVisible = true;
                                  });
                                  if (num1.isEmpty ||
                                      num2.isEmpty ||
                                      num3.isEmpty ||
                                      num4.isEmpty ||
                                      num5.isEmpty ||
                                      num6.isEmpty) {
                                    EasyLoading.showToast(
                                        'Please enter 6 digit otp');
                                  } else if (values == 'New User!') {
                                    loader();
                                    await lifes(newUser.phoneNumber);
                                    await coins(newUser.phoneNumber);
                                    await userxp(newUser.phoneNumber);
                                    await userconcepts(newUser.phoneNumber);

                                    // ignore: use_build_context_synchronously
                                    Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                            pageBuilder: ((context, animation,
                                                    secondaryAnimation) =>
                                                const ProfileInfo1())));
                                  } else if (values == 'Otp Invalid!') {
                                    EasyLoading.showToast('OTP is invalid');
                                  } else {
                                    loader();
                                    localUserList = values;
                                    localUserList[0].onlineStatus = 'online';
                                    await insertUser(localUserList[0]);
                                    await user();
                                    await coursesList(localUserList[0].id);
                                    await noOfUsers(localUserList[0].id);
                                    await updateOnline(
                                        localUserList[0].id, 'online');
                                    newUser.phoneNumber = phoneNumber;
                                    newUser.id = localUserList[0].id;

                                    // ignore: use_build_context_synchronously
                                    Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                            pageBuilder: ((context, animation,
                                                    secondaryAnimation) =>
                                                const DashBoard())));
                                    setState(() {
                                      _isLoaderVisible = false;
                                    });
                                  }
                                },
                                child: Container(
                                  height: 40,
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      gradient: ColorPalette.gradientbutton1),
                                  child: const Text(
                                    'Verify',
                                    style: TextStyle(
                                        color: ColorPalette.whitetextcolor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        letterSpacing: 1),
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: size.height * 0.1,
                          )
                        ])),
              ),
            )),
      ),
    );
  }
}
