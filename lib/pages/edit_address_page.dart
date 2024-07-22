import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_27_03/custom_widgets/custom_field.dart';

import '../color/app_color.dart';
import '../custom_widgets/custom_app_bar.dart';

class EditAddressPage extends StatefulWidget {
  final int index;
  const EditAddressPage({super.key, required this.index});

  @override
  State<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  final addressValidator =
      MultiValidator([RequiredValidator(errorText: 'Please enter address')]);
  final unitNumberValidator = MultiValidator(
      [RequiredValidator(errorText: 'Please enter unit number')]);
  final cityValidator =
      MultiValidator([RequiredValidator(errorText: 'Please enter city')]);
  final stateValidator = MultiValidator([
    RequiredValidator(errorText: 'Please enter state'),
  ]);
  final zipValidator = MultiValidator([
    RequiredValidator(errorText: 'Please enter zip code'),
    MinLengthValidator(6, errorText: 'Please enter 6 digits zip code'),
    MaxLengthValidator(6, errorText: 'Please enter 6 digits zip code')
  ]);
  final deliveryValidator = MultiValidator([
    RequiredValidator(errorText: 'Please enter delivery instruction'),
  ]);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController _addressController = TextEditingController();
  TextEditingController _unitNumberController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _zipCodeController = TextEditingController();
  TextEditingController _deliveryInstructionController =
      TextEditingController();

  Future<void> getAddress() async {
    var box = await Hive.openBox('user_address');
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    String? number = sharedPref.getString("loginNumber");
    List<dynamic>? address = await box.get(number);
    if (address![widget.index] != null) {
      _addressController.text = address[widget.index]['address'];
      _unitNumberController.text = address[widget.index]['unitNumber'];
      _cityController.text = address[widget.index]['city'];
      _stateController.text = address[widget.index]['state'];
      _zipCodeController.text = address[widget.index]['zipCode'];
      _deliveryInstructionController.text = address[widget.index]['delivery'];
    }
  }

  @override
  void initState() {
    super.initState();
    getAddress();
  }

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
            title: "Edit Address",
          ),
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                30.verticalSpace,
                CustomTextField(
                  hintText: "Address",
                  contentPadding: EdgeInsets.all(8),
                  icon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.location_on,
                      color: AppColor.grey,
                    ),
                  ),
                  controller: _addressController,
                  textInputAction: TextInputAction.next,
                  validation: addressValidator,
                  obscureText: false,
                  keyboardType: TextInputType.streetAddress,
                  textCapitalization: TextCapitalization.none,
                ),
                15.verticalSpace,
                CustomTextField(
                    hintText: "Enter Unit Number",
                    contentPadding: EdgeInsets.all(8),
                    controller: _unitNumberController,
                    keyboardType: TextInputType.number,
                    validation: unitNumberValidator,
                    textCapitalization: TextCapitalization.none,
                    textInputAction: TextInputAction.next,
                    textInputFormat: [FilteringTextInputFormatter.digitsOnly],
                    obscureText: false),
                15.verticalSpace,
                CustomTextField(
                  hintText: "City",
                  contentPadding: EdgeInsets.all(8),
                  controller: _cityController,
                  textInputAction: TextInputAction.next,
                  validation: cityValidator,
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                ),
                15.verticalSpace,
                CustomTextField(
                  hintText: "State",
                  contentPadding: EdgeInsets.all(8),
                  controller: _stateController,
                  textInputAction: TextInputAction.next,
                  validation: stateValidator,
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                ),
                15.verticalSpace,
                CustomTextField(
                  maxLength: 6,
                  controller: _zipCodeController,
                  textInputAction: TextInputAction.next,
                  validation: zipValidator,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  hintText: "Zipcode",
                  textCapitalization: TextCapitalization.none,
                  textInputFormat: [FilteringTextInputFormatter.digitsOnly],
                ),
                15.verticalSpace,
                CustomTextField(
                  maxLines: 5,
                  controller: _deliveryInstructionController,
                  textInputAction: TextInputAction.newline,
                  validation: deliveryValidator,
                  obscureText: false,
                  keyboardType: TextInputType.multiline,
                  hintText: "Delivery Instruction",
                  textCapitalization: TextCapitalization.none,
                ),
                80.verticalSpace,
                SizedBox(
                  height: 50.h,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(AppColor.green)),
                    onPressed: () async {
                      SharedPreferences sharedPref =
                          await SharedPreferences.getInstance();
                      String? loginNumber = sharedPref.getString("loginNumber");
                      print(loginNumber);
                      if (formKey.currentState!.validate()) {
                        if (loginNumber != null) {
                          var box = await Hive.openBox('user_address');
                          print(box.values); //box name
                          List<Map<dynamic, dynamic>>? userAddress = box
                              .get(loginNumber) //key
                              ?.cast<Map<dynamic, dynamic>>();
                          print(userAddress);
                          userAddress = userAddress ?? [];
                          userAddress[widget.index] = {
                            'address': _addressController.text,
                            'unitNumber': _unitNumberController.text,
                            'city': _cityController.text,
                            'state': _stateController.text,
                            'zipCode': _zipCodeController.text,
                            'delivery': _deliveryInstructionController.text
                          };
                          box.put(loginNumber, userAddress);
                          print(box.get(loginNumber));
                          var message = SnackBar(
                            backgroundColor: AppColor.black,
                            content: Text(
                              "Address updated!",
                              style: TextStyle(color: AppColor.green),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(message);
                          Navigator.pop(context);
                        } else {
                          print('Not in if');
                        }
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

  @override
  void dispose() {
    _addressController.dispose();
    _unitNumberController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    _deliveryInstructionController.dispose();
    super.dispose();
  }
}
