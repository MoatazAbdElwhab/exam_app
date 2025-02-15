// features/nav/navbar_page.dart
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/icon_manager.dart';
import 'package:exam_app/features/explore/presentation/pages/explore_page.dart';
import 'package:exam_app/features/profile/profile_page.dart';
import 'package:exam_app/features/result/result_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavbarPage extends StatefulWidget {
  const NavbarPage({super.key});

  @override
  State<NavbarPage> createState() => _NavbarPageState();
}

class _NavbarPageState extends State<NavbarPage> {
  int _selectedIndex = 2;

  final List<Widget> _pages = const [
    ExplorePage(),
    ResultPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final Size mediaquery = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorManager.lightBlue,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (_selectedIndex != index) {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
        selectedItemColor: ColorManager.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          _buildBottomNavItem(IconManager.exploreSvg, "Explore", 0, mediaquery),
          _buildBottomNavItem(IconManager.resultSvg, "Result", 1, mediaquery),
          _buildBottomNavItem(IconManager.profileSvg, "Profile", 2, mediaquery),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavItem(
      String assetPath, String label, int index, Size mediaquery) {
    return BottomNavigationBarItem(
      icon: _buildNavItem(assetPath, index, mediaquery),
      label: label,
    );
  }

  Widget _buildNavItem(String assetPath, int index, Size mediaquery) {
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
