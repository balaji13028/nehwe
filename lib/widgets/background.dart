import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height,
      child: Stack(
        children: [
          Positioned(
            top: 44,
            right: 0,
            child: Image.asset(
              'assets/images/top2.png',
              fit: BoxFit.fill,
              width: size.width,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/images/top1.png',
              width: size.width,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: 60,
            right: 35,
            child: SvgPicture.asset(
              'assets/images/company_logo.svg',
              width: size.width * 0.22,
            ),
          ),
          Positioned(
            bottom: 26,
            left: 0,
            child: Image.asset(
              'assets/images/bottom2.png',
              width: size.width,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/images/bottom1.png',
              width: size.width,
              fit: BoxFit.fill,
            ),
          ),
          child
        ],
      ),
    );
  }
}
