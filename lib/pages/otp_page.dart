import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../color/app_color.dart';
import '../custom_widgets/custom_app_bar.dart';
import '../custom_widgets/custom_button.dart';
import '../router/my_router.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController otpController = TextEditingController();
  bool isError = false;
  String currentValue = "";
  final _formKey = GlobalKey<FormState>();
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
              )
            ],
          ),
          child: CustomAppBar(
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: AppColor.black,
                ),
              ),
            ),
            title: "Verification Code",
          ),
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 84,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0).r,
                    child: Text(
                      textAlign: TextAlign.center,
                      "Verification code has been send on your registered mobile number. Enter Verification code here.",
                      style: TextStyle(
                          color: AppColor.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                40.verticalSpace,
                Form(
                  key: _formKey,
                  child: PinCodeTextField(
                    validator: (value) {
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        currentValue = value;
                      });
                    },
                    // autoFocus: true,
                    hintCharacter: "-",
                    textInputAction: TextInputAction.done,
                    cursorColor: Colors.black,
                    animationDuration: Duration(milliseconds: 300),
                    pinTheme: PinTheme(
                      borderWidth: 0,
                      selectedBorderWidth: 0,
                      disabledBorderWidth: 0,
                      inactiveColor: AppColor.fieldGrey,
                      activeColor: AppColor.fieldGrey,
                      selectedColor: AppColor.fieldGrey,
                      selectedFillColor: AppColor.fieldGrey,
                      activeFillColor: AppColor.fieldGrey,
                      inactiveFillColor: AppColor.fieldGrey,
                      shape: PinCodeFieldShape.circle,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 68.h,
                      fieldWidth: 60.w,
                    ),
                    enableActiveFill: true,
                    textStyle: TextStyle(fontSize: 20, height: 1.6),
                    keyboardType: TextInputType.number,
                    controller: otpController,
                    length: 4,
                    appContext: context,
                    obscureText: true,
                    blinkWhenObscuring: true,
                    obscuringCharacter: '*',
                    animationType: AnimationType.fade,
                  ),
                ),
                20.verticalSpace,
                Visibility(
                  visible: isError,
                  child: Text(
                    "Please enter otp !!",
                    style: TextStyle(
                        color: AppColor.red,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                30.verticalSpace,
                SizedBox(
                  height: 50.h,
                  child: CustomButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (currentValue.length != 4) {
                          setState(() {
                            isError = true;
                          });
                        } else {
                          isError = false;
                          Navigator.popAndPushNamed(
                              context, MyRouter.detailsPage);
                        }
                      }
                    },
                    buttonStyle: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(AppColor.green)),
                    child: Center(
                      child: Text(
                        "Verify",
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColor.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                25.verticalSpace,
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isError = false;
                      otpController.clear();
                    });
                  },
                  child: Text(
                    "Resend Code",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      color: AppColor.black,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                60.verticalSpace,
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Opacity(
                    opacity: 0.3,
                    child: Image.asset(
                      "assets/images/logo_noSpace.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }
}
