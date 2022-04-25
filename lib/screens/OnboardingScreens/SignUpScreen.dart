import 'package:flutter/material.dart';

import '../../Utils/Constants.dart';
import '../../api/SignUpapi.dart';
import 'UserInfoScreen.dart';
import '../../shared_preferences/login_preferences.dart';
import '../../shared_preferences/type_preference.dart';

import 'LoginScreen.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName = "/signUp";
  final String phone;

  const SignUpScreen({
    Key? key,
    required this.phone,
  }) : super(key: key);
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final phoneTextController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final isLoading = ValueNotifier<bool>(false);
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  var isType;
  var type;

  @override
  void initState() {
    super.initState();
    getType;
    typePreference = TypePreference();
    phoneTextController.text = widget.phone;
  }

  Future<void> get getType async {
    final isType = await typePreference!.getTypeStatus();
    type = isType ? 'Vendor' : "Customer";
  }

  Future<void> onSignUp() async {
    print(type);
    if (_form.currentState!.validate() == true) {
      isLoading.value = true;
      final response = await SignUp.signUp(
          phoneTextController.text, passwordController.text, type.toString());
      if (response == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Something went wrong"),
          duration: Duration(seconds: 4),
        ));
      } else if (response.statusCode == 200) {
        loginPreference?.setLoginStatus(true);
        Navigator.pushNamed(context, ProfilePage.routeName);
      } else {
        isLoading.value = false;
        loginPreference?.setLoginStatus(false);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Number is already registered"),
          duration: Duration(seconds: 4),
        ));
      }
      isLoading.value = false;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Password doesn't match"),
        duration: Duration(seconds: 4),
      ));
    }
  }

  @override
  void dispose() {
    phoneTextController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double defaultFontSize = 14;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            SizedBox(height: height * 0.09),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "hello!",
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: height * 0.04),
                SizedBox(
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
                          borderSide: const BorderSide(
                              color: AppColors.tileSelectGreen),
                          borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: AppColors.tileSelectGreen),
                          borderRadius: BorderRadius.circular(15)),
                      errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: AppColors.tileSelectGreen),
                          borderRadius: BorderRadius.circular(15)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: AppColors.tileSelectGreen),
                          borderRadius: BorderRadius.circular(15)),
                      disabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: AppColors.tileSelectGreen),
                          borderRadius: BorderRadius.circular(15)),
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: const TextStyle(
                          color: AppColors.iconGrey, fontSize: defaultFontSize),
                      hintText: "Enter you Phone Number",
                    ),
                    controller: phoneTextController,
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                SizedBox(
                  height: height * 0.065,
                  child: TextFormField(
                      showCursor: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: AppColors.tileSelectGreen, width: 0.5),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.tileSelectGreen),
                            borderRadius: BorderRadius.circular(15)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.tileSelectGreen),
                            borderRadius: BorderRadius.circular(15)),
                        errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.tileSelectGreen),
                            borderRadius: BorderRadius.circular(15)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.tileSelectGreen),
                            borderRadius: BorderRadius.circular(15)),
                        disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.tileSelectGreen),
                            borderRadius: BorderRadius.circular(15)),
                        filled: true,
                        fillColor: Colors.white,
                        hintStyle: const TextStyle(
                            color: AppColors.iconGrey,
                            fontSize: defaultFontSize),
                        hintText: "Enter you password",
                      ),
                      controller: passwordController,
                      obscureText: true,
                      validator: (val) => (val!.isEmpty) ? 'Empty' : null),
                ),
                SizedBox(height: height * 0.02),
                TextFormField(
                  showCursor: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
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
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(color: AppColors.tileSelectGreen),
                    ),
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
                    hintText: "Confirm password",
                  ),
                  controller: confirmController,
                  obscureText: true,
                  validator: (val) => (val!.isEmpty)
                      ? 'Empty'
                      : (val != passwordController.text)
                          ? "Password doesn't match"
                          : null,
                ),
                SizedBox(height: height * 0.006),
                SizedBox(height: height * 0.052),
                SizedBox(
                  width: width,
                  height: height * 0.065,
                  child: TextButton(
                      onPressed: () async => await onSignUp(),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              AppColors.tileSelectGreen),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          )),
                      child: ValueListenableBuilder<bool>(
                        valueListenable: isLoading,
                        builder: (context, value, child) => value
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: height * 0.04,
                                    width: width * 0.075,
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.05,
                                  ),
                                  const Text(
                                    "Please Wait...",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  )
                                ],
                              )
                            : const Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                      )),
                ),
                SizedBox(
                  height: height * 0.013,
                ),
              ],
            ),
            SizedBox(height: height * 0.364),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(
                      color: Color(0xFF666666),
                      fontSize: defaultFontSize,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  InkWell(
                    onTap: () => {
                      //TODO : Navigate all back to login page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      )
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: AppColors.tileSelectGreen,
                        fontSize: defaultFontSize,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
