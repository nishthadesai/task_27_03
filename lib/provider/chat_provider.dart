import 'dart:core';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_27_03/generated/assets.dart';

class ChatProfile {
  final String id;
  final String image;
  final String chatTitle;

  ChatProfile(this.id, this.image, this.chatTitle);
}

class ChatProvider extends ChangeNotifier {
  TextEditingController chatController = TextEditingController();
  List<Map<dynamic, dynamic>> chatProfile = [
    {
      "id": 0,
      "image": Assets.imagesWalmartLogo3x,
      "chatTitle": "Walmart",
      "chatDescription":
          "Next Time we will provide best service with same product",
      "time": "5 min",
    },
    {
      "id": 1,
      "image": Assets.imagesJioMart,
      "chatTitle": "Stop & Shop",
      "chatDescription":
          "I really find the subject very Interesting. I'm enjoying all my..",
      "time": "5 min",
    },
  ];
  List<Map<dynamic, dynamic>> chats = [
    {
      "id": 0,
      "msg": "Can you help me ?",
      "timeStamp": "2024-05-14 12:13",
      "sender": true,
      "status": "seen",
    },
    {
      "id": 0,
      "msg": "Yes sure",
      "timeStamp": "2024-05-15 14:00",
      "sender": false,
    },
  ];

  //function for send message
  void sendMessage(int id) {
    chats.add({
      "id": id,
      "msg": chatController.text,
      "timeStamp": DateTime.now().toString(),
      "sender": true,
      "status": "sent",
    });

    notifyListeners();
    chatController.text = "";
  }

  //function for converting time of chats
  String changeTime(String timeStamp) {
    String formattedDate = DateFormat('hh:mm a')
        .format(
          DateTime.parse(timeStamp),
        )
        .toLowerCase();
    // print(timeStamp);
    // print(formattedDate);
    return formattedDate;
  }

  //function for date and month time
  String convertDate(String timeStamp) {
    DateTime now = DateTime.now();
    DateTime yesterday = DateTime(now.year, now.month, now.day - 1);
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime date = DateFormat('yyyy-MM-dd').parse(timeStamp);
    if (date.day == today.day &&
        date.month == today.month &&
        date.year == today.year) {
      return 'TODAY';
    } else if (date.day == yesterday.day &&
        date.month == yesterday.month &&
        date.year == yesterday.year) {
      return 'YESTERDAY';
    } else {
      return '${DateFormat.d().format(date)} ${DateFormat.MMMM().format(date)}';
    }
  }

  //function for different stores diff chats
  List<Map<dynamic, dynamic>> chatData(int profileIndex) {
    final profileId = chatProfile[profileIndex]['id'];
    return chats.where((data) => data['id'] == profileId).toList();
  }
}
