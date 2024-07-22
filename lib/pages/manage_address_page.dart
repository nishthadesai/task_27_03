import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_27_03/custom_widgets/text_styles.dart';
import 'package:task_27_03/router/my_router.dart';

import '../color/app_color.dart';
import '../custom_widgets/custom_app_bar.dart';
import 'edit_address_page.dart';

class ManageAddressPage extends StatefulWidget {
  const ManageAddressPage({super.key});

  @override
  State<ManageAddressPage> createState() => _ManageAddressPageState();
}

class _ManageAddressPageState extends State<ManageAddressPage> {
  List<Map<dynamic, dynamic>>? userAddress;
  int currentIndex = 0;
  late ValueNotifier<List<Map<dynamic, dynamic>>> _value;
  late ValueNotifier<int> _valueNotifier;
  @override
  void initState() {
    _valueNotifier = ValueNotifier(currentIndex);
    _value = ValueNotifier(userAddress ?? []);
    super.initState();
  }

  Future<String?> getNumber() async {
    SharedPreferences numberPref = await SharedPreferences.getInstance();
    return numberPref.getString("loginNumber");
  }

  Future<List<Map<dynamic, dynamic>>?> getAddress() async {
    var box = await Hive.openBox('user_address');
    String? phoneNo =
        await getNumber(); //function banavi ne call kre tyare ek var ma store krvanu if return any datatype
    List<dynamic>? addressList = await box.get(phoneNo);
    if (addressList != null) {
      List<Map<dynamic, dynamic>> convertedAddress =
          addressList.cast<Map<dynamic, dynamic>>().toList();
      return convertedAddress;
    } else {
      return null;
    }
  }

  Future<void> fetchAddress() async {
    List<Map<dynamic, dynamic>>? addressList = await getAddress();
    if (addressList != null) {
      setState(() {
        _value.value = addressList;
      });
    } else {
      debugPrint('No user data found');
    }
  }

  Future<void> deleteAddress(int index) async {
    var box = await Hive.openBox('user_address');
    String? phoneNo = await getNumber();
    List<dynamic>? addressList = await box.get(phoneNo);
    if (addressList != null && index >= 0 && index < addressList.length) {
      addressList.removeAt(index);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: AppColor.black,
              ),
            ),
            title: "Manage Address",
          ),
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: FutureBuilder(
            future: fetchAddress(),
            builder: (context, snapshot) {
              return Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        16.verticalSpace,
                        ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          reverse: true,
                          itemCount: _value.value.length,
                          itemBuilder: (context, index) {
                            var address = _value.value[index];
                            return Card(
                              margin: EdgeInsets.all(8),
                              elevation: 2,
                              surfaceTintColor: AppColor.white,
                              color: AppColor.white,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            _valueNotifier.value = index;
                                            _valueNotifier.notifyListeners();
                                          },
                                          child: ValueListenableBuilder(
                                            valueListenable: _valueNotifier,
                                            builder: (BuildContext context,
                                                int value, Widget? child) {
                                              return Icon(
                                                Icons.album_rounded,
                                                color: _valueNotifier.value ==
                                                        index
                                                    ? AppColor.green
                                                    : AppColor.grey,
                                              );
                                            },
                                          ),
                                        ),
                                        14.horizontalSpace,
                                        Flexible(
                                          child: Column(
                                            children: [
                                              Text(
                                                maxLines: 2,
                                                "${address['unitNumber']} ${address['address']}, ${address['city']}, ${address['state']}, ${address['zipCode']}",
                                                style: sfNormal().copyWith(
                                                    fontSize: 16.spMin,
                                                    color: AppColor.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 40,
                                    ),
                                    child: IntrinsicHeight(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15),
                                            child: GestureDetector(
                                              onTap: () async {
                                                await deleteAddress(index);
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .delete_outline_rounded,
                                                    color: Colors.red,
                                                  ),
                                                  5.horizontalSpace,
                                                  Text(
                                                    "Delete",
                                                    style: sfNormal().copyWith(
                                                        fontSize: 16.spMin,
                                                        color: AppColor.black),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          VerticalDivider(
                                            thickness: 0.5,
                                            color: AppColor.grey,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    EditAddressPage(
                                                  index: index,
                                                ),
                                              ));
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.edit,
                                                ),
                                                5.horizontalSpace,
                                                Text(
                                                  "Change",
                                                  style: sfNormal().copyWith(
                                                      fontSize: 16.spMin,
                                                      color: AppColor.black),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  15.verticalSpace,
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, MyRouter.addNewAddress);
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_circle_outline,
                            color: AppColor.green,
                          ),
                          4.horizontalSpace,
                          Text(
                            "Add New",
                            style: sfBold().copyWith(
                                fontSize: 18.spMin, color: AppColor.green),
                          ),
                        ],
                      ),
                    ),
                  ),
                  20.verticalSpace,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
