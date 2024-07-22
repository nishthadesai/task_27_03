import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_27_03/color/app_color.dart';
import 'package:task_27_03/custom_widgets/custom_app_bar.dart';
import 'package:task_27_03/pages/login_page.dart';
import 'package:task_27_03/pages/splash_screen.dart';
import 'package:task_27_03/router/my_router.dart';

import '../custom_widgets/custom_field.dart';
import '../custom_widgets/text_styles.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  static const String KeyBusinessName = "businessName";
  static const String KeyFirstName = "firstName";
  static const String KeyLastName = "lastName";
  static const String KeyEmail = "email";
  static const String KeyNumber = "number";

  final businessNameValidator = MultiValidator(
      [RequiredValidator(errorText: 'Please enter business name')]);
  final firstNameValidator =
      MultiValidator([RequiredValidator(errorText: 'Please enter first name')]);
  final lastNameValidator =
      MultiValidator([RequiredValidator(errorText: 'Please enter last name')]);
  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Please enter email'),
    PatternValidator(
        r"^[a-zA-Z0-9a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
        errorText: 'Please enter valid email')
  ]);
  final zipValidator = MultiValidator([
    RequiredValidator(errorText: 'Please enter zip code'),
    MinLengthValidator(6, errorText: 'Please enter 6 digits code'),
    MaxLengthValidator(6, errorText: 'Please enter 6 digits code')
  ]);
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isChecked = false;
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
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: AppColor.black,
              ),
            ),
            title: "Add More Details",
          ),
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                35.verticalSpace,
                CustomTextField(
                  controller: _businessNameController,
                  textInputAction: TextInputAction.next,
                  validation: businessNameValidator,
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  hintText: "Business Name",
                  textCapitalization: TextCapitalization.words,
                ),
                15.verticalSpace,
                CustomTextField(
                  controller: _firstNameController,
                  textInputAction: TextInputAction.next,
                  validation: firstNameValidator,
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  hintText: "First Name",
                  textCapitalization: TextCapitalization.words,
                ),
                15.verticalSpace,
                CustomTextField(
                  controller: _lastNameController,
                  textInputAction: TextInputAction.next,
                  validation: lastNameValidator,
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  hintText: "Last Name",
                  textCapitalization: TextCapitalization.words,
                ),
                15.verticalSpace,
                CustomTextField(
                  controller: _emailController,
                  textInputAction: TextInputAction.next,
                  validation: emailValidator,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  hintText: "Email Address",
                  textCapitalization: TextCapitalization.none,
                ),
                15.verticalSpace,
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
                          width: 1.w,
                          height: 20.h,
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
                  textInputAction: TextInputAction.next,
                  obscureText: false,
                ),
                15.verticalSpace,
                CustomTextField(
                  maxLength: 6,
                  controller: _zipCodeController,
                  textInputAction: TextInputAction.done,
                  validation: zipValidator,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  hintText: "Zipcode",
                  textCapitalization: TextCapitalization.none,
                  textInputFormat: [FilteringTextInputFormatter.digitsOnly],
                ),
                50.verticalSpace,
                Row(
                  children: [
                    Checkbox(
                      activeColor: AppColor.green,
                      checkColor: AppColor.white,
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    Wrap(
                      textDirection: TextDirection.ltr,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        Text(
                          "I agree to the ",
                          style: sfNormal(),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, MyRouter.terms);
                          },
                          child: Text(
                            " Terms & Condition",
                            style: sfNormal().copyWith(
                              color: AppColor.green,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                70.verticalSpace,
                SizedBox(
                  height: 50.h,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(AppColor.green)),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (isChecked == true) {
                          String businessName = _businessNameController.text;

                          String firstName = _firstNameController.text;
                          String lastName = _lastNameController.text;
                          String email = _emailController.text;
                          String number = _numberController.text;
                          var sharedPreference =
                              await SharedPreferences.getInstance();
                          sharedPreference.setString(
                              KeyBusinessName, businessName);
                          sharedPreference.setString(KeyFirstName, firstName);
                          sharedPreference.setString(KeyLastName, lastName);
                          sharedPreference.setString(KeyEmail, email);
                          sharedPreference.setString(KeyNumber, number);

                          var message = SnackBar(
                            backgroundColor: AppColor.black,
                            content: Text(
                              "Details Added Successfully",
                              style: TextStyle(color: AppColor.green),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(message);
                          var sharedPref =
                              await SharedPreferences.getInstance();
                          sharedPref.setBool(SplashScreenState.keyLogin, true);
                          Navigator.pushReplacementNamed(
                              context, MyRouter.bottomNavigation);
                        } else {
                          var error = SnackBar(
                            backgroundColor: AppColor.white,
                            content: Text(
                              "please Agree with Conditions",
                              style: TextStyle(
                                  color: AppColor.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(error);
                        }
                      } else {
                        return;
                      }
                    },
                    child: Center(
                      child: Text(
                        "Add",
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
    );
  }

  @override
  void dispose() {
    _businessNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _numberController.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }
}
