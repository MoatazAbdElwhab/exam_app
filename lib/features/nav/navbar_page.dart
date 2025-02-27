// features/nav/navbar_page.dart
import 'package:exam_app/features/result/presentation/pages/results_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/logger/app_logger.dart';
import '../../core/resources/color_manager.dart';
import '../../core/resources/icon_manager.dart';
import '../explore/presentation/pages/explore_page.dart';
import '../profile/presentation/pages/profile_page.dart';

class NavItem extends StatelessWidget {
  final String assetPath;
  final bool isSelected;
  final Color selectedColor;
  final Color unselectedColor;

  const NavItem({
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

class NavbarPage extends StatefulWidget {
  const NavbarPage({super.key});

  @override
  State<NavbarPage> createState() => _NavbarPageState();
}

class _NavbarPageState extends State<NavbarPage> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);

  // Making pages static and const to prevent recreating them
  static const List<Widget> _pages = [
    ExplorePage(),
    ResultsPage(),
    ProfilePage(),
  ];

  @override
  void dispose() {
    Log.i('disposing selected index in navbar');
    _selectedIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Log.i('build called in nav bar');
    return Scaffold(
      backgroundColor: ColorManager.lightBlue,
      // Using ValueListenableBuilder to only rebuild the body when index changes
      body: ValueListenableBuilder<int>(
        valueListenable: _selectedIndex,
        builder: (context, index, _) => _pages[index],
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _selectedIndex,
        builder: (context, index, _) => BottomNavigationBar(
          currentIndex: index,
          type: BottomNavigationBarType.fixed,
          onTap: (newIndex) => _selectedIndex.value = newIndex,
          selectedItemColor: ColorManager.blue,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: NavItem(
                assetPath: IconManager.exploreSvg,
                isSelected: index == 0,
                selectedColor: ColorManager.blue,
                unselectedColor: Colors.grey,
              ),
              label: "Explore",
            ),
            BottomNavigationBarItem(
              icon: NavItem(
                assetPath: IconManager.resultSvg,
                isSelected: index == 1,
                selectedColor: ColorManager.blue,
                unselectedColor: Colors.grey,
              ),
              label: "Result",
            ),
            BottomNavigationBarItem(
              icon: NavItem(
                assetPath: IconManager.profileSvg,
                isSelected: index == 2,
                selectedColor: ColorManager.blue,
                unselectedColor: Colors.grey,
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
