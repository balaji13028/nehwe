import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math' as math;

class Background2 extends StatelessWidget {
  final Widget child;
  const Background2({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Stack(
        children: [
          Positioned(
            top: 40,
            right: 0,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: Image.asset(
                'assets/images/top2.png',
                fit: BoxFit.fill,
                width: size.width,
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: Image.asset(
                'assets/images/top1.png',
                width: size.width,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 35,
            child: SvgPicture.asset(
              'assets/images/company_logo.svg',
              width: size.width * 0.22,
            ),
          ),
          Positioned(
            bottom: 26,
            left: 0,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: Image.asset(
                'assets/images/bottom2.png',
                width: size.width,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: Image.asset(
                'assets/images/bottom1.png',
                width: size.width,
                fit: BoxFit.fill,
              ),
            ),
          ),
          child
        ],
      ),
    );
  }
}
