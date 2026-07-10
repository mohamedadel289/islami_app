import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActiveNavBarIcon extends StatelessWidget {
  final String iconName;
  const ActiveNavBarIcon({super.key, required this.iconName});
  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
      decoration:BoxDecoration(
        color :Color(0xff202020).withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(66),
      ),
      child: SvgPicture.asset(
        'assets/icons/$iconName.svg',
        width: 22,
        height: 22,
        fit: BoxFit.scaleDown,
        colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
      ),
    );
}}