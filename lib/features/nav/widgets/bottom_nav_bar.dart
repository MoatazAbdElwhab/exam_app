import 'package:flutter/material.dart';

import '../../../core/resources/color_manager.dart';
import '../../../core/resources/icon_manager.dart';
import 'navbar_item.dart';

class BottomNavBar extends StatefulWidget {
  final Function(ValueNotifier<int>) onClicked;
  final ValueNotifier<int> index;
  const BottomNavBar({super.key, required this.index, required this.onClicked});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late ValueNotifier<int> _selectedIndex;
  @override
  void initState() {
    _selectedIndex = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
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
            icon: NavBarItem(
              assetPath: IconManager.exploreSvg,
              isSelected: index == 0,
              selectedColor: ColorManager.blue,
              unselectedColor: Colors.grey,
            ),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: NavBarItem(
              assetPath: IconManager.resultSvg,
              isSelected: index == 1,
              selectedColor: ColorManager.blue,
              unselectedColor: Colors.grey,
            ),
            label: "Result",
          ),
          BottomNavigationBarItem(
            icon: NavBarItem(
              assetPath: IconManager.profileSvg,
              isSelected: index == 2,
              selectedColor: ColorManager.blue,
              unselectedColor: Colors.grey,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
