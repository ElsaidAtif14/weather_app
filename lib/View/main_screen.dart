import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:weather/View/Compass_page.dart';
import 'package:weather/View/Search_page.dart';
import 'package:weather/View/home_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late MotionTabBarController _motionTabBarController;
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    _motionTabBarController = MotionTabBarController(
      initialIndex: _tabController.index,
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff04082D),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: const [
          HomePage(),
          SearchPage(),
          FancyCompass(),
        ],
      ),
      bottomNavigationBar: MotionTabBar(
        initialSelectedTab: 'Home',
        controller: _motionTabBarController,
        labels: const ["Home", "Search", "Compass"],
        icons: const [
          Icons.home_outlined,
          Icons.search,
          Icons.explore_outlined,
        ],
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const TextStyle(
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        tabIconColor: Colors.white,
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: const Color(0xFF00C1FF).withOpacity(0.4),
        tabIconSelectedColor: Colors.white,
        tabBarColor: const Color(0xFF1A1A2E),
        onTabItemSelected: (int value) {
          setState(() {
            _tabController.index = value;
            _motionTabBarController.index = value;
          });
        },
      ),
    );
  }
}
