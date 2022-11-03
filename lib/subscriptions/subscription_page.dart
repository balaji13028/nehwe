import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/color_palettes.dart';

class Subscription extends StatefulWidget {
  const Subscription({super.key});

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.backgroundcolor2,
        elevation: 0,
        iconTheme:
            const IconThemeData(color: ColorPalette.primarycolor, size: 22),
        title: const Text('Subscription'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ColorPalette.primarycolor),
      ),
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.25,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const ListTile(
                  title: Text(
                    'Free trial',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: ColorPalette.secondarycolor),
                  ),
                  subtitle: Text(
                    '\u{20B9}0',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: ColorPalette.textcolor),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Active plan  :  Free plan '),
                        SizedBox(height: 8),
                        Text('End date     :  25-12-2022'),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/images/active_plan.svg')
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: size.height * 0.05,
                  width: size.width * 0.4,
                  margin: const EdgeInsets.only(top: 10, bottom: 40),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: ColorPalette.primarycolor),
                  child: const Text(
                    'Upgrade plan',
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
          Expanded(child: SvgPicture.asset('assets/images/enjoy_plan.svg'))
        ],
      ),
    );
  }
}
