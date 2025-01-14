// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:subs_vendor/Utils/Constants.dart';
import 'package:subs_vendor/api/UpdateBankDetailsApi.dart';
import 'package:subs_vendor/shared_preferences/token_profile.dart';

import '../CustomerScreens/HomeScreen.dart';

class BankDetailScreen extends StatefulWidget {
  static String routeName = '/bank';

  const BankDetailScreen({Key? key}) : super(key: key);

  @override
  _BankDetailScreenState createState() => _BankDetailScreenState();
}

class _BankDetailScreenState extends State<BankDetailScreen> {
  final accountHolderNameController = TextEditingController();
  final accountNoController = TextEditingController();
  final ifScCodeController = TextEditingController();
  final upiController = TextEditingController();

  @override
  void dispose() {
    accountHolderNameController.dispose();
    accountNoController.dispose();
    ifScCodeController.dispose();
    upiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const defaultFontSize = 14.0;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.primaryGrey,
          elevation: 0,
          title: Text("Bank Details"),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new_outlined)),
        ),
        body: ListView(
          padding: EdgeInsets.all(width * 0.025),
          children: [
            SizedBox(height: height * 0.02),
            Text(
              "Account Details",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: height * 0.02),
            Align(
                alignment: Alignment.centerLeft,
                child: Text("Account Number:",
                    style: TextStyle(color: AppColors.iconGrey))),
            SizedBox(
              height: height * 0.013,
            ),
            Container(
              height: height * 0.065,
              child: TextField(
                showCursor: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: AppColors.tileSelectGreen, width: 0.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.tileSelectGreen),
                      borderRadius: BorderRadius.circular(15)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.tileSelectGreen),
                      borderRadius: BorderRadius.circular(15)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.tileSelectGreen),
                      borderRadius: BorderRadius.circular(15)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.tileSelectGreen),
                      borderRadius: BorderRadius.circular(15)),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.tileSelectGreen),
                      borderRadius: BorderRadius.circular(15)),
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: TextStyle(
                      color: AppColors.iconGrey, fontSize: defaultFontSize),
                  hintText: "Enter your account number",
                ),
                controller: accountNoController,
              ),
            ),
            SizedBox(
              height: height * 0.013,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text("Account Holder Name :",
                    style: TextStyle(color: AppColors.iconGrey))),
            SizedBox(
              height: height * 0.013,
            ),
            Container(
              height: height * 0.065,
              child: TextField(
                showCursor: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: AppColors.tileSelectGreen, width: 0.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.tileSelectGreen),
                      borderRadius: BorderRadius.circular(15)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.tileSelectGreen),
                      borderRadius: BorderRadius.circular(15)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.tileSelectGreen),
                      borderRadius: BorderRadius.circular(15)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.tileSelectGreen),
                      borderRadius: BorderRadius.circular(15)),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.tileSelectGreen),
                      borderRadius: BorderRadius.circular(15)),
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: TextStyle(
                      color: AppColors.iconGrey, fontSize: defaultFontSize),
                  hintText: "Enter account holder name:",
                ),
                controller: accountHolderNameController,
              ),
            ),
            SizedBox(
              height: height * 0.013,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text("IFSC Code",
                    style: TextStyle(color: AppColors.iconGrey))),
            SizedBox(
              height: height * 0.013,
            ),
            Container(
              height: height * 0.065,
              child: TextField(
                showCursor: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: AppColors.tileSelectGreen, width: 0.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.tileSelectGreen),
                      borderRadius: BorderRadius.circular(15)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.tileSelectGreen),
                      borderRadius: BorderRadius.circular(15)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.tileSelectGreen),
                      borderRadius: BorderRadius.circular(15)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.tileSelectGreen),
                      borderRadius: BorderRadius.circular(15)),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.tileSelectGreen),
                      borderRadius: BorderRadius.circular(15)),
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: TextStyle(
                      color: AppColors.iconGrey, fontSize: defaultFontSize),
                  hintText: "Enter IFSC Code",
                ),
                controller: ifScCodeController,
              ),
            ),
            SizedBox(
              height: height * 0.013,
            ),
            SizedBox(height: 0.006),
            Text(
              "UPI Details",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: height * 0.02),
            Align(
                alignment: Alignment.centerLeft,
                child: Text("UPI ID or Phone Number",
                    style: TextStyle(color: AppColors.iconGrey))),
            SizedBox(
              height: height * 0.013,
            ),
            Container(
              height: height * 0.065,
              child: TextField(
                showCursor: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: AppColors.tileSelectGreen, width: 0.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.tileSelectGreen),
                      borderRadius: BorderRadius.circular(15)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.tileSelectGreen),
                      borderRadius: BorderRadius.circular(15)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.tileSelectGreen),
                      borderRadius: BorderRadius.circular(15)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.tileSelectGreen),
                      borderRadius: BorderRadius.circular(15)),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.tileSelectGreen),
                      borderRadius: BorderRadius.circular(15)),
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: TextStyle(
                      color: AppColors.iconGrey, fontSize: defaultFontSize),
                  hintText: "Enter Upi ID or Phone Number",
                ),
                controller: upiController,
              ),
            ),
            SizedBox(
              height: height * 0.234,
            ),
            SizedBox(
              width: width,
              height: height * 0.065,
              child: TextButton(
                  onPressed: () async {
                    final response = await UpdateBankDetails.updateBank(
                        tokenProfile!.token,
                        accountNoController.text,
                        accountHolderNameController.text,
                        ifScCodeController.text,
                        upiController.text);
                    if (response == 200) {
                      Navigator.pushNamed(context, HomeScreen.routeName);
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.tileSelectGreen),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      )),
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
            ),
          ],
        ));
  }
}
