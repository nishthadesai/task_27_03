import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_27_03/color/app_color.dart';
import 'package:task_27_03/custom_widgets/custom_field.dart';
import 'package:task_27_03/router/my_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static const String KeyNumber = "loginNumber";
  TextEditingController _numberController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // getValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 80.h,
                  ),
                  SizedBox(
                    height: 200.h,
                    child: Image.asset(
                      "assets/images/logo_noSpace.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  40.verticalSpace,
                  CustomTextField(
                    prefix: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CountryCodePicker(
                          initialSelection: 'US',
                          favorite: const ['+91', 'IN'],
                          showFlag: false,
                          padding: EdgeInsets.only(left: 20),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Container(
                            width: 1,
                            height: 20,
                            color: AppColor.black,
                          ),
                        ),
                      ],
                    ),
                    maxLength: 10,
                    hintText: "Phone Number",
                    controller: _numberController,
                    keyboardType: TextInputType.number,
                    validation: (phone) {
                      if (phone!.isEmpty) {
                        return "Please enter number";
                      } else if (phone.length != 10) {
                        return "Please enter valid number";
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.none,
                    textInputAction: TextInputAction.done,
                    obscureText: false,
                  ),
                  20.verticalSpace,
                  SizedBox(
                    height: 50.h,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(AppColor.green)),
                      onPressed: () async {
                        if (_formKey.currentState!.validate() == true) {
                          Navigator.pushReplacementNamed(
                              context, MyRouter.otpPage);
                          var prefs = await SharedPreferences.getInstance();
                          prefs.setString(
                              KeyNumber, _numberController.text.toString());
                        } else {
                          return;
                        }
                      },
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColor.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> getValue() async {
  //   var prefs = await SharedPreferences.getInstance();
  //   var getNumber = prefs.getString(KeyNumber);
  //   print(getNumber);
  // }

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }
}
