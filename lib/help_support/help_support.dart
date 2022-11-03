import 'package:flutter/material.dart';

import '../constants/color_palettes.dart';

class HelpSupport extends StatefulWidget {
  const HelpSupport({Key? key}) : super(key: key);

  @override
  State<HelpSupport> createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ColorPalette.backgroundcolor2,
          elevation: 0.0,
          shadowColor: ColorPalette.backgroundcolor2,
          iconTheme:
              const IconThemeData(color: ColorPalette.primarycolor, size: 22),
          title: const Text('Help & Support'),
          titleTextStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ColorPalette.primarycolor),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hi, How can we help you?',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: ColorPalette.primarycolor),
              ),
              Container(
                height: size.height * 0.15,
                width: size.width,
                margin: const EdgeInsets.only(top: 15),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorPalette.searchbarcolor),
                child: TextFormField(
                  maxLines: 5,
                  decoration: const InputDecoration(
                      hintText: 'Type here..',
                      isCollapsed: true,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      // if (formKey.currentState!.validate()) {
                      //   formKey.currentState!.save();
                    },
                    child: Container(
                      height: 30,
                      width: 100,
                      margin: const EdgeInsets.only(top: 10, bottom: 40),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: ColorPalette.primarycolor),
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                            color: ColorPalette.whitetextcolor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 1),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
