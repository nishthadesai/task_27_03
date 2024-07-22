import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_27_03/custom_widgets/text_styles.dart';

import '../color/app_color.dart';
import '../pages/home_page.dart';
import '../pages/my_orders_page.dart';
import '../pages/profile_page.dart';

class HomeBottomNavigationBar extends StatefulWidget {
  const HomeBottomNavigationBar({super.key});

  @override
  State<HomeBottomNavigationBar> createState() =>
      _HomeBottomNavigationBarState();
}

class _HomeBottomNavigationBarState extends State<HomeBottomNavigationBar> {
  int selectedIndex = 0;
  final List<Widget> _pages = [
    const HomePage(),
    const MyOrdersPage(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColor.white,
      body: _pages[selectedIndex],
      bottomNavigationBar: LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: [
            BottomNavigationBar(
              iconSize: 30.r,
              selectedFontSize: 16.spMin,
              unselectedFontSize: 16.spMin,
              onTap: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
              currentIndex: selectedIndex,
              elevation: 0,
              selectedLabelStyle: TextStyle(color: AppColor.green),
              showSelectedLabels: true,
              backgroundColor: AppColor.notificationColor.withOpacity(0.8),
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.store_mall_directory),
                  label: "Stores",
                ),
                BottomNavigationBarItem(
                  icon: Stack(
                    children: [
                      badges.Badge(
                        badgeStyle:
                            badges.BadgeStyle(badgeColor: AppColor.green),
                        position: BadgePosition.topEnd(),
                        badgeContent: Center(
                          child: Text(
                            "2",
                            style: sfNormal().copyWith(
                                color: AppColor.white, fontSize: 9.sp),
                          ),
                        ),
                        child: Icon(
                          Icons.library_books,
                        ),
                      ),
                    ],
                  ),
                  label: "My Orders",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Profile",
                ),
              ],
            ),
            Positioned(
              bottom: 1,
              left: constraints.maxWidth /
                      3 *
                      (selectedIndex) + //space of current index
                  (constraints.maxWidth / 6) - // minimize the half of it
                  30, // minimize the width of dash
              child: Container(
                width: 60.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: AppColor.green,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
