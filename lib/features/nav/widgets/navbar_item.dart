import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/resources/color_manager.dart';

class NavBarItem extends StatelessWidget {
  final String assetPath;
  final bool isSelected;
  final Color selectedColor;
  final Color unselectedColor;

  const NavBarItem({
    super.key,
    required this.assetPath,
    required this.isSelected,
    required this.selectedColor,
    required this.unselectedColor,
  });

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: mediaQuery.height * 0.005,
        horizontal: mediaQuery.width * 0.01,
      ),
      decoration: BoxDecoration(
        color: isSelected ? ColorManager.selectIconBlue : Colors.transparent,
        borderRadius: BorderRadius.circular(25),
      ),
      child: SvgPicture.asset(
        assetPath,
        colorFilter: ColorFilter.mode(
          isSelected ? selectedColor : unselectedColor,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}