import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../color/app_color.dart';
import '../custom_widgets/custom_app_bar.dart';
import '../custom_widgets/custom_field.dart';
import '../custom_widgets/text_styles.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  List<String> issue = [
    'App issue',
    'Product issue',
    'Delivery issue',
    'Other issue'
  ];
  String? issueList;
  String? issueName;
  TextEditingController _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            title: "Contact Us",
          ),
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 40, right: 40),
          child: SingleChildScrollView(
            child: Column(
              children: [
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: AppColor.fieldGrey,
                  ),
                  value: issueList,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  hint: Text(
                    'Select issue',
                    style: sfNormal()
                        .copyWith(color: AppColor.grey, fontSize: 16.spMin),
                  ),
                  onChanged: (value) {
                    setState(() {
                      issueList = value;
                    });
                    issueName = issueList;
                  },
                  items: issue.map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  validator: (value) {
                    return null;
                  },
                ),
                15.verticalSpace,
                CustomTextField(
                  maxLines: 5,
                  controller: _descriptionController,
                  textInputAction: TextInputAction.done,
                  validation: (value) {
                    if (value == null) {
                      return "Please Select Issue";
                    }
                    return null;
                  },
                  obscureText: false,
                  keyboardType: TextInputType.multiline,
                  hintText: "Description",
                  textCapitalization: TextCapitalization.words,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30, left: 40, right: 40),
        child: SizedBox(
          height: 50.h,
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(AppColor.green)),
            onPressed: () {},
            child: Center(
              child: Text(
                "Send",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColor.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
