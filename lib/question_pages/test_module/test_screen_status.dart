import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nehwe/courses/units_screen.dart';
import 'package:nehwe/models/courses_model.dart';
import 'package:nehwe/popup_messages/exit_message.dart';
import '../../constants/color_palettes.dart';

testScreenTopbar(context, lifes, int index, screenlength) {
  final assetsAudioPlayer = AssetsAudioPlayer();
  Size size = MediaQuery.of(context).size;

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      GestureDetector(
        onTap: () async {
          confirmTOExit(context, Units(course: newcourse));
          await assetsAudioPlayer.stop();
        },
        child: const Icon(
          Icons.clear,
          size: 32,
          color: ColorPalette.exiticoncolor,
        ),
      ),
      Container(
        height: 16,
        width: size.height * 0.3015,
        decoration: BoxDecoration(
          color: ColorPalette.statusfillcolor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
                height: 10,
                width: (size.height * 0.3015 / screenlength) * index.toDouble(),
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: ColorPalette.primarycolor,
                  borderRadius: BorderRadius.circular(10),
                ))
          ],
        ),
      ),
      Row(
        children: [
          SvgPicture.asset('assets/icons/lifes_icon.svg'),
          const SizedBox(
            width: 4,
          ),
          Text(
            lifes,
            style: const TextStyle(
                color: ColorPalette.textcolor,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          const SizedBox(
            width: 4,
          ),
        ],
      ),
    ],
  );
}
