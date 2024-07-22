import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:task_27_03/custom_widgets/text_styles.dart';
import 'package:task_27_03/provider/chat_provider.dart';
import 'package:task_27_03/router/my_router.dart';

import '../color/app_color.dart';
import '../custom_widgets/custom_app_bar.dart';

class RecentChatPage extends StatefulWidget {
  const RecentChatPage({super.key});

  @override
  State<RecentChatPage> createState() => _RecentChatPageState();
}

class _RecentChatPageState extends State<RecentChatPage> {
  @override
  Widget build(BuildContext context) {
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
          child: CustomAppBar(
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: AppColor.black,
              ),
            ),
            title: "Recent Chat",
          ),
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10).r,
          child: Consumer<ChatProvider>(
            //provider
            builder: (context, value, child) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: value.chatProfile.length,
                      itemBuilder: (context, index) {
                        final chatData =
                            value.chatData(value.chatProfile[index]['id']);
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 6)
                              .r,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, MyRouter.chatPage,
                                      arguments: ChatProfile(
                                          value.chatProfile[index]['id']
                                              .toString(),
                                          value.chatProfile[index]['image'],
                                          value.chatProfile[index]
                                              ['chatTitle']));
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      value.chatProfile[index]['image'],
                                      height: 70.h,
                                      width: 70.w,
                                    ),
                                    15.horizontalSpace,
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                value.chatProfile[index]
                                                    ['chatTitle'],
                                                style: sfMedium().copyWith(
                                                    fontSize: 18.spMin),
                                              ),
                                              Text(
                                                value.chatProfile[index]
                                                    ['time'],
                                                style: sfNormal().copyWith(
                                                    fontSize: 14.spMin,
                                                    color: AppColor.grey),
                                              ),
                                            ],
                                          ),
                                          8.verticalSpace,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                              right: 40)
                                                          .r,
                                                  child: Text(
                                                    chatData.length != 0
                                                        ? chatData.last['msg']
                                                        : value.chatProfile[
                                                                index]
                                                            ['chatDescription'],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: sfMedium().copyWith(
                                                        fontSize: 14.spMin,
                                                        color: AppColor.grey),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.black,
                                                    shape: BoxShape.circle),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "1",
                                                    style: sfMedium().copyWith(
                                                        fontSize: 14.spMin,
                                                        color: AppColor.white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              3.verticalSpace,
                              Divider(
                                indent: 85.w,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
