import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_27_03/color/app_color.dart';
import 'package:task_27_03/custom_widgets/custom_app_bar.dart';

import '../custom_widgets/custom_field.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  static const String KeyBusinessName = "businessName";
  static const String KeyFirstName = "firstName";
  static const String KeyLastName = "lastName";
  static const String KeyEmail = "email";
  static const String KeyNumber = "number";
  static const String KeyAddress = "address";

  final emailValidator = MultiValidator([
    PatternValidator(
        r"^[a-zA-Z0-9a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
        errorText: 'Please enter valid email')
  ]);

  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    getValue();
  }

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
            title: "Edit Profile",
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
                  contentPadding: EdgeInsets.all(8),
                  // initialValue: businessName,
                  controller: _businessNameController,
                  textInputAction: TextInputAction.next,
                  validation: (value) {
                    return;
                  },
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                ),
                15.verticalSpace,
                CustomTextField(
                  contentPadding: EdgeInsets.all(8),
                  controller: _firstNameController,
                  textInputAction: TextInputAction.next,
                  validation: (value) {
                    return;
                  },
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                ),
                15.verticalSpace,
                CustomTextField(
                  contentPadding: EdgeInsets.all(8),
                  controller: _lastNameController,
                  textInputAction: TextInputAction.next,
                  validation: (value) {
                    return null;
                  },
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                ),
                15.verticalSpace,
                CustomTextField(
                  contentPadding: EdgeInsets.all(8),
                  controller: _emailController,
                  textInputAction: TextInputAction.next,
                  validation: emailValidator,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                ),
                15.verticalSpace,
                CustomTextField(
                  contentPadding: EdgeInsets.all(8),
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
                  contentPadding: EdgeInsets.all(8),
                  icon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.location_on,
                      color: AppColor.grey,
                    ),
                  ),
                  controller: _addressController,
                  textInputAction: TextInputAction.done,
                  validation: (value) {
                    return;
                  },
                  obscureText: false,
                  keyboardType: TextInputType.streetAddress,
                  textCapitalization: TextCapitalization.none,
                ),
                190.verticalSpace,
                SizedBox(
                  height: 50.h,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(AppColor.green)),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString(
                            KeyBusinessName, _businessNameController.text);
                        prefs.setString(
                            KeyFirstName, _firstNameController.text);
                        prefs.setString(KeyLastName, _lastNameController.text);
                        prefs.setString(KeyEmail, _emailController.text);
                        prefs.setString(KeyNumber, _numberController.text);
                        prefs.setString(KeyAddress, _addressController.text);
                        var message = SnackBar(
                          backgroundColor: AppColor.black,
                          content: Text(
                            "Details Updated Successfully",
                            style: TextStyle(color: AppColor.green),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(message);
                      } else {
                        return;
                      }
                    },
                    child: Center(
                      child: Text(
                        "Update",
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

  void getValue() async {
    var sharedPreference = await SharedPreferences.getInstance();
    _businessNameController.text = sharedPreference.getString(KeyBusinessName)!;
    _firstNameController.text = sharedPreference.getString(KeyFirstName)!;
    _lastNameController.text = sharedPreference.getString(KeyLastName)!;
    _numberController.text = sharedPreference.getString(KeyNumber)!;
    _emailController.text = sharedPreference.getString(KeyEmail)!;
    _addressController.text = sharedPreference.getString(KeyAddress)!;
  }

  @override
  void dispose() {
    _businessNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _numberController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
