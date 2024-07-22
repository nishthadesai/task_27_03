import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:task_27_03/color/app_color.dart';
import 'package:task_27_03/custom_widgets/custom_field.dart';
import 'package:task_27_03/custom_widgets/text_styles.dart';

import '../generated/assets.dart';
import '../provider/chat_provider.dart';

class ChattingPage extends StatefulWidget {
  const ChattingPage({super.key});

  @override
  State<ChattingPage> createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ChatProfile;
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: PreferredSize(
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                offset: Offset(0, 3),
                blurRadius: 3.0,
              ),
            ],
          ),
          child: AppBar(
            scrolledUnderElevation: 0,
            automaticallyImplyLeading: false,
            centerTitle: false,
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: AppColor.black,
              ),
            ),
            title: Row(
              children: [
                Image.asset(
                  args.image,
                  height: 35.h,
                  width: 35.w,
                ),
                10.horizontalSpace,
                Text(args.chatTitle),
              ],
            ),
          ),
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Consumer<ChatProvider>(
        builder: (context, value, child) {
          final chatData = value.chatData(int.parse(args.id));
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  reverse: true,
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0).r,
                    child: chatData.isNotEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: List.generate(chatData.length, (index) {
                              // print(chatData);
                              return Container(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment:
                                      chatData[index]['sender'] == true
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                  children: [
                                    if (index == 0 ||
                                        DateTime.parse(chatData[index]
                                                    ['timeStamp']
                                                .toString()
                                                .substring(0, 10)) !=
                                            DateTime.parse(chatData[index - 1]
                                                    ['timeStamp']
                                                .toString()
                                                .substring(0, 10)))
                                      Center(
                                        child: Text(value.convertDate(
                                            chatData[index]['timeStamp'])),
                                      ),
                                    Container(
                                      margin: chatData[index]['sender'] == true
                                          ? EdgeInsets.only(left: 85).r
                                          : EdgeInsets.zero,
                                      decoration: chatData[index]['sender'] ==
                                              true
                                          ? BoxDecoration(
                                              color: AppColor.lightGreen
                                                  .withOpacity(0.20),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(25),
                                                topRight: Radius.circular(25),
                                                bottomLeft: Radius.circular(25),
                                              ),
                                            )
                                          : BoxDecoration(
                                              color: AppColor.lightGrey,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(25),
                                                topRight: Radius.circular(25),
                                                bottomRight:
                                                    Radius.circular(25),
                                              ),
                                            ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 20)
                                            .r,
                                        child: Text(
                                          chatData[index]['msg'],
                                          textAlign: TextAlign.end,
                                          style: sfNormal()
                                              .copyWith(fontSize: 14.spMin),
                                        ),
                                      ),
                                    ),
                                    5.verticalSpace,
                                    chatData[index]['sender'] == true
                                        ? Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                value.changeTime(
                                                  chatData[index]['timeStamp'],
                                                ),
                                                style: sfBold().copyWith(
                                                    fontSize: 12.spMin),
                                              ),
                                              10.horizontalSpace,
                                              chatData[index]['status'] ==
                                                      "sent"
                                                  ? Icon(
                                                      Icons.circle,
                                                      size: 7.r,
                                                      color: AppColor.grey,
                                                    )
                                                  : chatData[index]['status'] ==
                                                          "delivered"
                                                      ? Row(
                                                          children: [
                                                            Icon(
                                                              Icons.circle,
                                                              size: 7.r,
                                                              color:
                                                                  AppColor.grey,
                                                            ),
                                                            2.horizontalSpace,
                                                            Icon(
                                                              Icons.circle,
                                                              size: 7.r,
                                                              color:
                                                                  AppColor.grey,
                                                            )
                                                          ],
                                                        )
                                                      : chatData[index]
                                                                  ['status'] ==
                                                              "seen"
                                                          ? Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.circle,
                                                                  size: 7.r,
                                                                  color: AppColor
                                                                      .green,
                                                                ),
                                                                2.horizontalSpace,
                                                                Icon(
                                                                  Icons.circle,
                                                                  size: 7.r,
                                                                  color: AppColor
                                                                      .green,
                                                                )
                                                              ],
                                                            )
                                                          : Text(""),
                                            ],
                                          )
                                        : Text(
                                            value.changeTime(
                                                chatData[index]['timeStamp']),
                                            style: sfBold()
                                                .copyWith(fontSize: 12.spMin),
                                          ),
                                    10.verticalSpace,
                                  ],
                                ),
                              );
                            }),
                          )
                        : Center(child: Text("Be the first Message")),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16, right: 16, bottom: 15).r,
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                          contentPadding: EdgeInsets.zero,
                          prefix: Icon(
                            Icons.mic,
                            size: 22.r,
                          ),
                          suffixIcon: Icon(
                            Icons.add_circle_outlined,
                            color: AppColor.black,
                            size: 25.r,
                          ),
                          controller: value.chatController,
                          keyboardType: TextInputType.name,
                          validation: (value) {
                            return;
                          },
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.send,
                          obscureText: false),
                    ),
                    10.horizontalSpace,
                    InkWell(
                      onTap: () {
                        if (value.chatController.text.isNotEmpty) {
                          value.sendMessage(int.parse(args.id));
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: AppColor.green),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            Assets.imagesSendIcon,
                            height: 20.h,
                            width: 20.w,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
