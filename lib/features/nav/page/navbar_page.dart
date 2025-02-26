import 'package:exam_app/features/nav/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import '../../../core/logger/app_logger.dart';
import '../../../core/resources/color_manager.dart';
import '../../explore/presentation/pages/explore_page.dart';
import '../../profile/presentation/pages/profile_page.dart';
import '../../result/presentation/pages/result_page.dart';

class NavbarPage extends StatefulWidget {
  const NavbarPage({super.key});

  @override
  State<NavbarPage> createState() => _NavbarPageState();
}

class _NavbarPageState extends State<NavbarPage> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);
  late final List<Widget> _pages;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pages = const [
      ExplorePage(),
      ResultPage(),
      ProfilePage(),
    ];
  }

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
        body: ValueListenableBuilder<int>(
          valueListenable: _selectedIndex,
          builder: (context, index, _) {
            Log.i('built in navbody index: $index');
            return _pages[index];
          },
        ),
        bottomNavigationBar: BottomNavBar(
            index: _selectedIndex,
            onClicked: (index) => _selectedIndex.value = index.value));
  }
}
