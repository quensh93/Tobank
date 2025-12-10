import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../util/theme/theme_util.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({
    required this.icon,
    required this.title,
    required this.description,
    super.key,
  });

  final String icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(icon),
            ],
          ),
          const SizedBox(height: 40.0),
          Text(
            title,
            style: TextStyle(
              color: ThemeUtil.textTitleColor,
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            description,
            style: TextStyle(
              color: ThemeUtil.textSubtitleColor,
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
