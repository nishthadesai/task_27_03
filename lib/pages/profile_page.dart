import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_share/flutter_share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_27_03/custom_widgets/text_styles.dart';
import 'package:task_27_03/pages/splash_screen.dart';
import 'package:task_27_03/router/my_router.dart';

import '../color/app_color.dart';
import '../custom_widgets/custom_app_bar.dart';
import '../model/profile_data.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String text = "Flutter is cross platform .https://www.flutter.dev";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColor.categoryScaffoldColor,
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
            title: "Walmart",
            action: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, MyRouter.editProfile);
                  },
                  child: Icon(
                    Icons.edit,
                    color: AppColor.black,
                    size: 28.r,
                  ),
                ),
              ),
            ],
          ),
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(8.0).r,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: BouncingScrollPhysics(),
                  itemCount: profileDataList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 150.h,
                  ),
                  itemBuilder: (context, index) {
                    ProfileData data = profileDataList[index];
                    return GestureDetector(
                      onTap: () async {
                        await _goToPage(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 35, right: 25).r,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              15.verticalSpace,
                              data.icon,
                              20.verticalSpace,
                              GestureDetector(
                                onTap: () {
                                  // if (index == 4) shareApp();
                                },
                                child: Text(
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  data.title,
                                  style: sfMedium().copyWith(
                                      fontSize: 18.spMin,
                                      color: AppColor.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _goToPage(int index) async {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, MyRouter.manageAddress);
        break;
      case 1:
        Navigator.pushNamed(context, MyRouter.recentChat);
        break;
      case 2:
        Navigator.pushNamed(context, MyRouter.notification);
        break;
      case 3: //rate
        Navigator.pushNamed(context, MyRouter.rateApp);
        break;
      case 4:
        print("share App");
      case 5:
        Navigator.pushNamed(context, MyRouter.help);
        break;
      case 6:
        Navigator.pushNamed(context, MyRouter.aboutUs);
        break;
      case 7:
        Navigator.pushNamed(context, MyRouter.terms);
        break;
      case 8:
        Navigator.pushNamed(context, MyRouter.policy);
        break;
      case 9:
        Navigator.pushNamed(context, MyRouter.contact);
        break;
      case 10:
        var sharedPref = await SharedPreferences.getInstance();
        sharedPref.setBool(SplashScreenState.keyLogin, false);
        Navigator.pushNamedAndRemoveUntil(
            context, MyRouter.loginPage, (route) => false);
        break;
      default:
    }
  }
}

// Future<void> shareApp() async {
//   await FlutterShare.share(
//     title: 'check out my website https://example.com',
//   );
// }
