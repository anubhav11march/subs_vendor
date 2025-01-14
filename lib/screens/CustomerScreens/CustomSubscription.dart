// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:subs_vendor/Utils/Constants.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:subs_vendor/api/AddSubscription.dart';
import 'package:subs_vendor/api/CustomSubApi.dart';
import 'package:subs_vendor/screens/BlankTargetScreen.dart';
import 'package:subs_vendor/screens/CustomerScreens/HomeScreen.dart';
import 'package:subs_vendor/screens/CustomerScreens/SubSuccessScreen.dart';
import 'package:subs_vendor/shared_preferences/token_profile.dart';

class CustomSubScreen extends StatefulWidget {
  static String routeName = '/custom';

  @override
  _CustomSubScreenState createState() => _CustomSubScreenState();
}

class _CustomSubScreenState extends State<CustomSubScreen> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final prodNameController = TextEditingController();
  final priceController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  bool _isLoading = false;
  int val = 1;
  double quantity = 0.5;
  String unit = 'Kilogram';
  List dropdownItemCategoryList = [
    {'label': 'Milk', 'value': 'Milk'}, // label is required and unique
    {'label': 'Newspaper', 'value': 'Newspaper'},
    {'label': 'Dairy', 'value': 'Dairy'},
    {'label': 'Grocery', 'value': 'Grocery'},
    {'label': 'Custom', 'value': 'Custom'},
  ];
  var category = {'label': 'Milk', 'value': 'Milk'};
  List dropdownItemList = [
    {'label': 'Daily', 'value': 'Daily'}, // label is required and unique
    {'label': 'Weekly', 'value': 'Weekly'},
    {'label': 'Bi-Weekly', 'value': 'Bi-Weekly'},
    {'label': 'Fortnight', 'value': 'Fortnight'},
    {'label': 'Monthly', 'value': 'Monthly'},
  ];
  var interval = {'label': 'Daily', 'value': 'Daily'};
  String dropdownValue = 'Daily';
  @override
  void initState() {
    super.initState();
  }

  _onCustomAdd() async {
    print('add custom called');
    if (_form.currentState!.validate() == true) {
      setState(() {
        _isLoading = true;
      });
      double amount = double.parse(priceController.text) * quantity;
      print(amount);
      var response = await AddCustomSubscriptionApi.addCustomSub(
          tokenProfile?.token,
          category['value'].toString(),
          priceController.text,
          prodNameController.text,
          unit,
          quantity,
          interval['value'].toString(),
          amount,
          phoneController.text,
          nameController.text);
      if (response.statusCode == 200) {
        Navigator.pushNamed(context, SubSuccess.routeName);
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(response.error.toString()),
          duration: Duration(seconds: 4),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("All fields must be filled"),
        duration: Duration(seconds: 4),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    double height, width;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryGrey,
        elevation: 0,
        title: Text("Custom Subscription"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
            )),
      ),
      body: Form(
        key: _form,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15),
          children: [
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Vendor Name :",
                  style: TextStyle(color: AppColors.iconGrey, fontSize: 18),
                ),
                Container(
                  width: width * 0.425,
                  height: height * 0.065,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(width: 1, color: AppColors.iconGrey)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: TextFormField(
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                        controller: nameController,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Contact No. :",
                  style: TextStyle(color: AppColors.iconGrey, fontSize: 18),
                ),
                Container(
                  width: width * .425,
                  height: height * 0.065,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(width: 1, color: AppColors.iconGrey)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: TextFormField(
                          decoration: InputDecoration(
                            errorStyle: const TextStyle(fontSize: 0.01),
                          ),
                          controller: phoneController,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                          validator: (val) {
                            if (val?.length != 10) {
                              return 'Empty';
                            }
                            return null;
                          }),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Category :",
                  style: TextStyle(color: AppColors.iconGrey, fontSize: 18),
                ),
                CoolDropdown(
                  dropdownWidth: width * 0.375,
                  resultWidth: width * 0.425,
                  dropdownHeight: height * 0.325,
                  dropdownList: dropdownItemCategoryList,
                  dropdownItemTopGap: 5,
                  dropdownItemBottomGap: 5,
                  onChange: (a) {
                    category = a;
                  },
                  resultBD: BoxDecoration(
                      border: Border.all(width: 1, color: AppColors.iconGrey),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  dropdownBD: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1, color: AppColors.iconGrey),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  defaultValue: dropdownItemCategoryList[0],
                  dropdownItemReverse: true,
                  isTriangle: false,
                  dropdownItemAlign: Alignment.center,
                  dropdownItemMainAxis: MainAxisAlignment.center,
                  resultMainAxis: MainAxisAlignment.center,
                  gap: 10,
                  resultIcon: Container(
                      width: width * 0.05,
                      height: height * 0.026,
                      child: Center(
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.tileSelectGreen,
                        ),
                      )),
                  selectedItemBD: BoxDecoration(
                      color: AppColors.sideMenuGreen,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  selectedItemTS: TextStyle(color: Colors.black, fontSize: 18),
                  resultTS: TextStyle(color: Colors.black, fontSize: 18),
                  unselectedItemTS:
                      TextStyle(color: Colors.black, fontSize: 18),
                  isAnimation: true,
                )
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Product Name :",
                  style: TextStyle(color: AppColors.iconGrey, fontSize: 18),
                ),
                Container(
                  width: width * 0.425,
                  height: height * 0.065,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(width: 1, color: AppColors.iconGrey)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(fontSize: 0.01),
                        ),
                        controller: prodNameController,
                        style: TextStyle(fontSize: 18),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Empty';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Price :",
                      style: TextStyle(color: AppColors.iconGrey, fontSize: 18),
                    ),
                    Text(
                      "per quantity",
                      style: TextStyle(color: AppColors.iconGrey, fontSize: 12),
                    ),
                  ],
                ),
                Container(
                  width: width * 0.425,
                  height: height * 0.065,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(width: 1, color: AppColors.iconGrey)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: TextFormField(
                          controller: priceController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            errorStyle: const TextStyle(fontSize: 0.01),
                          ),
                          style: TextStyle(fontSize: 18),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Empty';
                            }
                            return null;
                          }),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: height * 0.04),
            Text(
              "SI unit :",
              style: TextStyle(color: AppColors.iconGrey, fontSize: 18),
            ),
            Theme(
              data: Theme.of(context).copyWith(
                  unselectedWidgetColor: AppColors.iconGrey,
                  disabledColor: Colors.blue),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                              value: 1,
                              groupValue: val,
                              onChanged: (index) {
                                setState(() {
                                  val = 1;
                                  unit = 'Kilogram';
                                });
                              },
                              activeColor: AppColors.tileSelectGreen,
                            ),
                            Expanded(
                              child: Text(
                                'Kilogram',
                                style: TextStyle(
                                    color: AppColors.iconGrey, fontSize: 16),
                              ),
                            )
                          ],
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                              value: 2,
                              groupValue: val,
                              onChanged: (index) {
                                setState(() {
                                  val = 2;
                                  unit = 'Litre';
                                });
                              },
                              activeColor: AppColors.tileSelectGreen,
                            ),
                            Expanded(
                                child: Text(
                              'Litre',
                              style: TextStyle(
                                  color: AppColors.iconGrey, fontSize: 16),
                            ))
                          ],
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                              value: 3,
                              groupValue: val,
                              onChanged: (index) {
                                setState(() {
                                  val = 3;

                                  unit = 'Piece';
                                });
                              },
                              activeColor: AppColors.tileSelectGreen,
                            ),
                            Expanded(
                                child: Text(
                              'Piece',
                              style: TextStyle(
                                  color: AppColors.iconGrey, fontSize: 16),
                            ))
                          ],
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Radio(
                              value: 4,
                              groupValue: val,
                              onChanged: (index) {
                                setState(() {
                                  val = 4;
                                  unit = 'Packet';
                                });
                              },
                              activeColor: AppColors.tileSelectGreen,
                            ),
                            Expanded(
                                child: Text(
                              'Packet',
                              style: TextStyle(
                                  color: AppColors.iconGrey, fontSize: 16),
                            ))
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Radio(
                              value: 5,
                              groupValue: val,
                              onChanged: (index) {
                                setState(() {
                                  val = 5;

                                  unit = 'Tray';
                                });
                              },
                              activeColor: AppColors.tileSelectGreen,
                            ),
                            Expanded(
                                child: Text(
                              'Tray',
                              style: TextStyle(
                                  color: AppColors.iconGrey, fontSize: 16),
                            ))
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Radio(
                              value: 6,
                              groupValue: val,
                              onChanged: (index) {
                                setState(() {
                                  val = 6;

                                  unit = 'Other';
                                });
                              },
                              activeColor: AppColors.tileSelectGreen,
                            ),
                            Expanded(
                              child: Text(
                                'Other',
                                style: TextStyle(
                                    color: AppColors.iconGrey, fontSize: 16),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Quantity",
                  style: TextStyle(color: AppColors.iconGrey, fontSize: 18),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                        onTap: () {
                          setState(() {
                            if (quantity != 0.5) {
                              quantity -= 0.5;
                            } else {
                              GetSnackBar(
                                title: "Quantity can't be 0",
                              );
                            }
                          });
                        },
                        child: Container(
                          width: width * 0.1,
                          height: height * 0.052,
                          decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(
                                      5))), //here we set the circular figure
                              color: AppColors.primaryGrey),
                          child: Center(
                              child: Icon(
                            Icons.remove,
                            size: 15,
                            color: Colors.black,
                          )),
                        )),
                    SizedBox(
                      width: width * 0.0125,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border:
                              Border.all(width: 1, color: AppColors.iconGrey)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 18.0, right: 18.0, top: 8.0, bottom: 8.0),
                        child: Center(
                          child: Text(
                            quantity.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.0125,
                    ),
                    InkWell(
                        onTap: () {
                          setState(() {
                            quantity += 0.5;
                          });
                        },
                        child: Container(
                          width: width * 0.1,
                          height: height * 0.052,
                          decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(
                                      5))), //here we set the circular figure
                              color: AppColors.tileSelectGreen),
                          child: Center(
                              child: Icon(
                            Icons.add,
                            size: 15,
                            color: Colors.white,
                          )),
                        )),
                  ],
                )
              ],
            ),
            SizedBox(height: height * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Interval :",
                  style: TextStyle(color: AppColors.iconGrey, fontSize: 18),
                ),
                CoolDropdown(
                  dropdownWidth: width * 0.375,
                  resultWidth: width * 0.425,
                  dropdownHeight: height * 0.325,
                  dropdownList: dropdownItemList,
                  dropdownItemTopGap: 5,
                  dropdownItemBottomGap: 5,
                  onChange: (a) {
                    interval = a;
                  },
                  resultBD: BoxDecoration(
                      border: Border.all(width: 1, color: AppColors.iconGrey),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  dropdownBD: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1, color: AppColors.iconGrey),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  defaultValue: dropdownItemList[0],
                  dropdownItemReverse: true,
                  isTriangle: false,
                  dropdownItemAlign: Alignment.center,
                  dropdownItemMainAxis: MainAxisAlignment.center,
                  resultMainAxis: MainAxisAlignment.center,
                  gap: 10,
                  resultIcon: Container(
                      width: width * 0.05,
                      height: height * 0.026,
                      child: Center(
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.tileSelectGreen,
                        ),
                      )),
                  selectedItemBD: BoxDecoration(
                      color: AppColors.sideMenuGreen,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  selectedItemTS: TextStyle(color: Colors.black, fontSize: 18),
                  resultTS: TextStyle(color: Colors.black, fontSize: 18),
                  unselectedItemTS:
                      TextStyle(color: Colors.black, fontSize: 18),
                  isAnimation: true,
                ),
              ],
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Container(
              width: width,
              height: height * 0.065,
              child: TextButton(
                  onPressed: () async {
                    print('add custom called');
                    _onCustomAdd();
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.tileSelectGreen),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      )),
                  child: _isLoading
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: height * 0.04,
                              width: width * 0.075,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Please Wait...",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )
                          ],
                        )
                      : Text(
                          'Add Subscription',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
            ),
          ],
        ),
      ),
    );
  }
}
