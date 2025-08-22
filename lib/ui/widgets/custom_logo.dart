import 'package:flutter/material.dart';
import 'package:flutter_blog/_core/constants/size.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomLogo extends StatelessWidget {
  final String title;

  const CustomLogo(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: xlargeGap),
        SvgPicture.asset(
          "assets/logo.svg",
          height: 70,
          width: 70,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: largeGap),
      ],
    );
  }
}
