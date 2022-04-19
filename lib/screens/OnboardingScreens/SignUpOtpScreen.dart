// ignore_for_file: file_names, prefer_const_constructors

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:subs_vendor/Utils/Constants.dart';
import 'package:subs_vendor/screens/OnboardingScreens/OTPcontrollerScreen.dart';

class SignUpOtpScreen extends StatefulWidget {
  final OTPScreenType type;
  const SignUpOtpScreen({
    required this.type,
    Key? key,
  }) : super(key: key);
  static String routeName = '/loginOTP';

  @override
  _SignUpOtpScreenState createState() => _SignUpOtpScreenState();
}

class _SignUpOtpScreenState extends State<SignUpOtpScreen> {
  final dialCodeDigits = ValueNotifier<String>('+91');
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    dialCodeDigits.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: height * 0.13),
            Container(
                margin: EdgeInsets.all(10),
                child: Center(
                  child: Text("Phone (OTP) Verification",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                )),
            SizedBox(height: height * 0.065),
            SizedBox(
              width: width,
              height: height * 0.08,
              child: CountryCodePicker(
                onChanged: (country) =>
                    dialCodeDigits.value = country.dialCode!,
                initialSelection: 'IN',
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                favorite: const ["+91", "IN"],
              ),
            ),
            Container(
              height: height * 0.1,
              margin: EdgeInsets.only(left: 15, right: 15),
              child: TextField(
                showCursor: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.tileSelectGreen, width: 0.5),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.tileSelectGreen),
                        borderRadius: BorderRadius.circular(15)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.tileSelectGreen),
                        borderRadius: BorderRadius.circular(15)),
                    errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.tileSelectGreen),
                        borderRadius: BorderRadius.circular(15)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.tileSelectGreen),
                        borderRadius: BorderRadius.circular(15)),
                    disabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.tileSelectGreen),
                        borderRadius: BorderRadius.circular(15)),
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle:
                        TextStyle(color: AppColors.iconGrey, fontSize: 18),
                    hintText: "Phone Number",
                    prefix: Padding(
                      padding: EdgeInsets.all(4),
                      child: ValueListenableBuilder<String>(
                          valueListenable: dialCodeDigits,
                          builder: (context, value, child) => Text(value)),
                    )),
                maxLength: 10,
                keyboardType: TextInputType.number,
                controller: _controller,
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              height: height * 0.065,
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.tileSelectGreen),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      )),
                  onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (c) => OtpControllerScreen(
                            phone: _controller.text,
                            codeDigits: dialCodeDigits.value,
                            type: widget.type,
                          ),
                        ),
                      ),
                  child: Text(
                    "Next",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
