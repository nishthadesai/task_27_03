import 'package:flutter/material.dart';

import '../color/app_color.dart';

class NotificationData {
  final Icon icon;
  final String title;
  final String subtitle;
  final String time;

  NotificationData(this.icon, this.title, this.subtitle, this.time);
}

List notificationList = [
  NotificationData(
      Icon(
        Icons.notifications,
        color: AppColor.white,
      ),
      "Your order has been successfully placed!",
      "Order Id : ABC1234",
      "3:00 pm"),
  NotificationData(
      Icon(
        Icons.notifications,
        color: AppColor.white,
      ),
      "Admin was Deleted unnecessary product",
      "",
      "12:00 pm"),
];
