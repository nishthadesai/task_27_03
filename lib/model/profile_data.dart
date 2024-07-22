import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_share/flutter_share.dart';
import 'package:task_27_03/color/app_color.dart';

class ProfileData {
  final Widget icon;
  final String title;
  ProfileData(
    this.icon,
    this.title,
  );
}

List profileDataList = [
  ProfileData(
    Icon(
      Icons.location_on_outlined,
      color: AppColor.green,
      size: 50.r,
    ),
    "Manage Address",
  ),
  ProfileData(
    Icon(
      Icons.chat_bubble_outline_sharp,
      color: AppColor.green,
      size: 50.r,
    ),
    "Recent Chat",
  ),
  ProfileData(
    Icon(
      Icons.notifications_none,
      color: AppColor.green,
      size: 50.r,
    ),
    "Notification",
  ),
  ProfileData(
    Icon(
      Icons.star_border_purple500_outlined,
      color: AppColor.green,
      size: 50.r,
    ),
    "Rate the App",
  ),
  ProfileData(
    GestureDetector(
      onTap: () {
        // shareApp();
      },
      child: Icon(
        Icons.share,
        color: AppColor.green,
        size: 50.r,
      ),
    ),
    "Share App",
  ),
  ProfileData(
    Icon(
      Icons.help_outline,
      color: AppColor.green,
      size: 50.r,
    ),
    "Help & FAQ",
  ),
  ProfileData(
    Icon(
      Icons.person_2_outlined,
      color: AppColor.green,
      size: 50.r,
    ),
    "About Us",
  ),
  ProfileData(
    Icon(
      Icons.my_library_books,
      color: AppColor.green,
      size: 50.r,
    ),
    "Terms and condition",
  ),
  ProfileData(
    Icon(
      Icons.privacy_tip_outlined,
      color: AppColor.green,
      size: 50.r,
    ),
    "Privacy Policy",
  ),
  ProfileData(
    Icon(
      Icons.contacts_outlined,
      color: AppColor.green,
      size: 50.r,
    ),
    "Contact Us",
  ),
  ProfileData(
    Icon(
      Icons.logout_outlined,
      color: AppColor.green,
      size: 50.r,
    ),
    "Logout",
  ),
];
// Future<void> shareApp() async {
//   await FlutterShare.share(
//     title: 'check out my website',
//   );
// }
