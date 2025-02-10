// features/nav/navbar_page.dart
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/icon_manager.dart';
import 'package:exam_app/features/explore/presentation/pages/explore_page.dart';
import 'package:exam_app/features/profile/presentation/pages/profile_page.dart';
import 'package:exam_app/features/result/presentation/pages/result_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavbarPage extends StatefulWidget {
  const NavbarPage({super.key});

  @override
  State<NavbarPage> createState() => _NavbarPageState();
}

class _NavbarPageState extends State<NavbarPage> {
  int _selectedIndex = 2;
  final List _pages = [
    const ExplorePage(),
    const ResultPage(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.lightBlue,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          _selectedIndex = index;
          setState(() {});
        },
        selectedItemColor: ColorManager.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: _buildNavItem(IconManager.exploreSvg, 0),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: _buildNavItem(IconManager.resultSvg, 1),
            label: "Result",
          ),
          BottomNavigationBarItem(
            icon: _buildNavItem(IconManager.profileSvg, 2),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String assetPath, int index) {
    Size mediaquery = MediaQuery.of(context).size;
    bool isSelected = _selectedIndex == index;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: mediaquery.height * 0.005,
        horizontal: mediaquery.width * 0.01,
      ),
      decoration: BoxDecoration(
        color: isSelected ? ColorManager.selectIconBlue : Colors.transparent,
        borderRadius: BorderRadius.circular(25),
      ),
      child: SvgPicture.asset(
        assetPath,
        colorFilter: ColorFilter.mode(
          isSelected ? ColorManager.blue : Colors.grey,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
