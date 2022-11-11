import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nehwe/models/subscriptions_model.dart';

import '../constants/color_palettes.dart';

class UpgradePlan extends StatefulWidget {
  const UpgradePlan({super.key});

  @override
  State<UpgradePlan> createState() => _UpgradePlanState();
}

class _UpgradePlanState extends State<UpgradePlan> {
  List<bool> ontap = [];
  var selected;
  List<SubscriptionData> plans = subscriptionPlanList;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.backgroundcolor2,
        elevation: 0,
        iconTheme:
            const IconThemeData(color: ColorPalette.primarycolor, size: 22),
        title: const Text('Subscription Plans'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ColorPalette.secondarycolor),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: size.height * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select your plan ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ColorPalette.textcolor,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: plans.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  ontap.add(false);
                  return GestureDetector(
                    onTap: () {
                      ontap.replaceRange(0, ontap.length,
                          [for (int i = 0; i < ontap.length; i++) false]);
                      ontap[index] = true;
                      setState(() {
                        if (ontap[index] == true) {
                          selected = plans[index];
                        } else {
                          selected = ' plan is not selected';
                        }
                      });
                    },
                    child: Card(
                      elevation: ontap[index] ? 2 : 0.2,
                      color: Colors.transparent,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ontap[index]
                                ? ColorPalette.primarycolor.withOpacity(0.9)
                                : ColorPalette.backgroundcolor2),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${plans[index].planName}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: ontap[index]
                                        ? ColorPalette.whitetextcolor
                                        : ColorPalette.secondarycolor,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  '(${plans[index].planDuration})',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: ontap[index]
                                        ? ColorPalette.whitetextcolor
                                        : ColorPalette.secondarycolor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Text(
                                  '${plans[index].planAmount}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: ontap[index]
                                        ? ColorPalette.whitetextcolor
                                        : ColorPalette.textcolor,
                                  ),
                                ),
                                Icon(
                                  Icons.euro,
                                  size: 12,
                                  color: ontap[index]
                                      ? ColorPalette.whitetextcolor
                                      : ColorPalette.textcolor,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '(${plans[index].planDesc})',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: ontap[index]
                                        ? ColorPalette.whitetextcolor
                                        : ColorPalette.secondarycolor,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
                height: size.height * 0.3,
                width: size.width,
                color: Colors.red,
                child: SvgPicture.asset('assets/images/enjoy_plan.svg'))
          ],
        ),
      ),
    );
  }
}
