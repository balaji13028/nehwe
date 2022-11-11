import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nehwe/api_calls/subscriptions_api.dart';
import 'package:nehwe/models/subscriptions_model.dart';
import 'package:nehwe/subscriptions/upgrade_plans_list.dart';
import '../constants/color_palettes.dart';

class Subscription extends StatefulWidget {
  const Subscription({super.key});

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  SubscriptionData activeplan = subscriptionPlanList[0];

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
                ListTile(
                  title: Text(
                    '${activeplan.planName}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: ColorPalette.secondarycolor),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${activeplan.planAmount} ',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: ColorPalette.textcolor),
                      ),
                      const Icon(
                        Icons.euro,
                        size: 25,
                        color: ColorPalette.textcolor,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Active plan  :  ${activeplan.planName} '),
                        const SizedBox(height: 8),
                        Text('End date     :  ${activeplan.planDuration}'),
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
                onTap: () async {
                  await subscriptionPlans();

                  // ignore: use_build_context_synchronously
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const UpgradePlan())));
                },
                child: Container(
                  height: size.height * 0.05,
                  width: size.width * 0.4,
                  margin: EdgeInsets.only(
                      top: size.height * 0.04, bottom: size.height * 0.02),
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
