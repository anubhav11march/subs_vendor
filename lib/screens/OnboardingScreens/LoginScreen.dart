import 'dart:convert';

import 'package:flutter/material.dart';
import '../../Utils/Constants.dart';
import '../../api/LoginApi.dart';
import 'ChooseTypeScreen.dart';
import '../CustomerScreens/HomeScreen.dart';
import 'SignUpOtpScreen.dart';
import '../VendorScreens/VendorHomeScreen.dart';
import '../../shared_preferences/login_preferences.dart';
import '../../shared_preferences/token_preferences.dart';
import '../../shared_preferences/type_preference.dart';

import 'OTPcontrollerScreen.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "/login";

  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final isLoading = ValueNotifier<bool>(false);
  static const double defaultFontSize = 14;

  @override
  void initState() {
    loginPreference = LoginPreference();
    tokenPreference = TokenPreference();
    typePreference = TypePreference();
    super.initState();
  }

  Future<void> onSubmit() async {
    isLoading.value = true;
    final response =
        await LoginApi.login(usernameController.text, passwordController.text);
    if (response.statusCode == 200) {
      loginPreference?.setLoginStatus(true);
      (json.decode('"${response.data['data']['type']}"') == "vendor")
          ? Navigator.pushNamedAndRemoveUntil(
              context,
              VendorHomeScreen.routeName,
              (Route<dynamic> route) => false,
            )
          : Navigator.pushNamedAndRemoveUntil(
              context,
              HomeScreen.routeName,
              (Route<dynamic> route) => false,
            );
    } else {
      isLoading.value = false;
      loginPreference?.setLoginStatus(false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Username or Password doesn't match"),
        duration: Duration(seconds: 4),
      ));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              loginField,
              registerText,
            ],
          ),
        ),
      );

  Align get registerText => Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Don't have an account? ",
              style: TextStyle(
                color: Color(0xFF666666),
                fontSize: defaultFontSize,
                fontStyle: FontStyle.normal,
              ),
            ),
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ChooseTypeScreen()),
              ),
              child: const Text(
                "Register",
                style: TextStyle(
                  color: AppColors.tileSelectGreen,
                  fontSize: defaultFontSize,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ],
        ),
      );

  Widget get loginField => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 70),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "hello!",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 30),
          TextField(
            showCursor: true,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: AppColors.tileSelectGreen, width: 0.5),
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColors.tileSelectGreen),
                  borderRadius: BorderRadius.circular(15)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColors.tileSelectGreen),
                  borderRadius: BorderRadius.circular(15)),
              errorBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColors.tileSelectGreen),
                  borderRadius: BorderRadius.circular(15)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColors.tileSelectGreen),
                  borderRadius: BorderRadius.circular(15)),
              disabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColors.tileSelectGreen),
                  borderRadius: BorderRadius.circular(15)),
              filled: true,
              fillColor: Colors.white,
              hintStyle: const TextStyle(
                  color: AppColors.iconGrey, fontSize: defaultFontSize),
              hintText: "Enter your Phone Number",
            ),
            controller: usernameController,
          ),
          const SizedBox(height: 10),
          TextField(
            obscureText: true,
            showCursor: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: AppColors.tileSelectGreen, width: 0.5),
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColors.tileSelectGreen),
                  borderRadius: BorderRadius.circular(15)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColors.tileSelectGreen),
                  borderRadius: BorderRadius.circular(15)),
              errorBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColors.tileSelectGreen),
                  borderRadius: BorderRadius.circular(15)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColors.tileSelectGreen),
                  borderRadius: BorderRadius.circular(15)),
              disabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColors.tileSelectGreen),
                  borderRadius: BorderRadius.circular(15)),
              filled: true,
              fillColor: Colors.white,
              hintStyle: const TextStyle(
                  color: AppColors.iconGrey, fontSize: defaultFontSize),
              hintText: "Enter your password",
            ),
            controller: passwordController,
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignUpOtpScreen(
                            type: OTPScreenType.forgetPassword,
                          ))),
              child: const Text(
                "Forgot your password?",
                style: TextStyle(
                  color: AppColors.tileSelectGreen,
                  fontSize: defaultFontSize,
                  fontStyle: FontStyle.normal,
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 55,
            child: TextButton(
                onPressed: () => onSubmit(),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.tileSelectGreen),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    )),
                child: ValueListenableBuilder<bool>(
                  valueListenable: isLoading,
                  builder: (context, _isLoading, child) => _isLoading
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                              width: MediaQuery.of(context).size.width * 0.075,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                            const Text(
                              "Please Wait...",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )
                          ],
                        )
                      : const Text(
                          'Login',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                )),
          ),
          const SizedBox(height: 15),
        ],
      );
}
