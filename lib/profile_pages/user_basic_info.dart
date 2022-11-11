import 'package:flutter/material.dart';
import '../constants/color_palettes.dart';
import '../models/user_details_model.dart';

class UserBasicInfo extends StatefulWidget {
  const UserBasicInfo({Key? key}) : super(key: key);

  @override
  State<UserBasicInfo> createState() => _UserBasicInfoState();
}

class _UserBasicInfoState extends State<UserBasicInfo> {
  UserProfileData user = localUserList[0];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
      child: Column(
        children: [
          Visibility(
            visible: (user.emailId!.isEmpty || user.emailId == 'null')
                ? false
                : true,
            child: Container(
              height: size.height * 0.06,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorPalette.whitetextcolor,
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 0),
                        blurRadius: 1,
                        color: Colors.grey.withOpacity(0.6)),
                  ]),
              child: Row(children: [
                Container(
                  height: size.height * 0.048,
                  width: size.width * 0.11,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorPalette.backgroundcolor1.withOpacity(0.35)),
                  child: const Icon(
                    Icons.mail,
                    color: ColorPalette.secondarycolor,
                    size: 28,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Email :',
                        style: TextStyle(
                            fontSize: 12,
                            letterSpacing: 0.7,
                            color: ColorPalette.textcolor.withOpacity(0.7)),
                      ),
                      Text(
                        user.emailId!,
                        style: const TextStyle(
                            fontSize: 18,
                            color: ColorPalette.textcolor,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                )
              ]),
            ),
          ),
          Container(
            height: size.height * 0.06,
            width: double.infinity,
            margin: (user.emailId!.isEmpty || user.emailId == 'null')
                ? null
                : const EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorPalette.whitetextcolor,
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 0),
                      blurRadius: 1,
                      color: Colors.grey.withOpacity(0.6)),
                ]),
            child: Row(children: [
              Container(
                height: size.height * 0.048,
                width: size.width * 0.11,
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffD9E7FD),
                ),
                child: const Icon(
                  Icons.calendar_month,
                  color: Color(0xff4285F4),
                  size: 30,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Date of birth :',
                      style: TextStyle(
                          fontSize: 12,
                          letterSpacing: 0.7,
                          color: ColorPalette.textcolor.withOpacity(0.7)),
                    ),
                    Text(
                      user.dob!,
                      style: const TextStyle(
                          fontSize: 18,
                          color: ColorPalette.textcolor,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              )
            ]),
          ),
          Container(
            height: size.height * 0.06,
            width: double.infinity,
            margin: const EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorPalette.whitetextcolor,
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 0),
                      blurRadius: 1,
                      color: Colors.grey.withOpacity(0.6)),
                ]),
            child: Row(children: [
              Container(
                height: size.height * 0.048,
                width: size.width * 0.11,
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorPalette.xpiconcolor.withOpacity(0.2)),
                child: Icon(
                  (user.gender == 'Male')
                      ? Icons.male
                      : (user.gender == 'Female')
                          ? Icons.female
                          : Icons.transgender,
                  color: ColorPalette.xpiconcolor,
                  size: 30,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Gender :',
                      style: TextStyle(
                          fontSize: 12,
                          letterSpacing: 0.7,
                          color: ColorPalette.textcolor.withOpacity(0.7)),
                    ),
                    Text(
                      user.gender!,
                      style: const TextStyle(
                          fontSize: 18,
                          color: ColorPalette.textcolor,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              )
            ]),
          ),
          Visibility(
            visible: (user.address == 'null' ||
                    user.address!.isEmpty && user.city == 'null' ||
                    user.city!.isEmpty && user.state == 'null' ||
                    user.state!.isEmpty && user.country == 'null' ||
                    user.country!.isEmpty && user.zipcode == 'null' ||
                    user.zipcode!.isEmpty)
                ? false
                : true,
            child: Container(
              height: size.height * 0.16,
              width: double.infinity,
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorPalette.whitetextcolor,
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 0),
                        blurRadius: 1,
                        color: Colors.grey.withOpacity(0.6)),
                  ]),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  height: size.height * 0.048,
                  width: size.width * 0.11,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffCCEFD8)),
                  child: const Icon(
                    Icons.location_on,
                    color: Color(0xff02B03E),
                    size: 35,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Address :',
                          style: TextStyle(
                            fontSize: 12,
                            color: ColorPalette.textcolor.withOpacity(0.7),
                          ),
                        ),
                        Text(
                          user.address!,
                          style: const TextStyle(
                              fontSize: 16,
                              color: ColorPalette.textcolor,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '${user.city!},',
                          style: const TextStyle(
                              fontSize: 16,
                              color: ColorPalette.textcolor,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '${user.state!},',
                          style: const TextStyle(
                              fontSize: 16,
                              color: ColorPalette.textcolor,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '${user.country!},',
                          style: const TextStyle(
                              fontSize: 15,
                              color: ColorPalette.textcolor,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '${user.zipcode!}.',
                          style: const TextStyle(
                              fontSize: 15,
                              color: ColorPalette.textcolor,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ))
              ]),
            ),
          )
        ],
      ),
    );
  }
}
