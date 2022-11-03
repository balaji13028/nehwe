import 'package:flutter/material.dart';

import '../constants/color_palettes.dart';
import '../models/notifications_model.dart';

class Notifiactions extends StatefulWidget {
  const Notifiactions({Key? key}) : super(key: key);

  @override
  State<Notifiactions> createState() => _NotifiactionsState();
}

class _NotifiactionsState extends State<Notifiactions> {
  List<NotificationData> details = notifyDetails;
  bool isSwitched = false;

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.backgroundcolor2,
        elevation: 0,
        iconTheme:
            const IconThemeData(color: ColorPalette.primarycolor, size: 22),
        title: const Text('Notifications'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ColorPalette.primarycolor),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Pause Notifications',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: ColorPalette.primarycolor),
                ),
                Switch(
                    activeColor: ColorPalette.secondarycolor,
                    inactiveThumbColor: ColorPalette.textcolor,
                    value: isSwitched,
                    onChanged: toggleSwitch)
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: details.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const Notifiactions())));
                    },
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorPalette.backgroundcolor2.withOpacity(0.7),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              details[index].title!,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: ColorPalette.primarycolor,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              details[index].descripation!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                color: ColorPalette.textcolor,
                              ),
                            ),
                          ]),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
