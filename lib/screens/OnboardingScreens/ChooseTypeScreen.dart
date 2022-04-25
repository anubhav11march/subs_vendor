import 'package:flutter/material.dart';
import '../../Utils/Constants.dart';
import 'SignUpOtpScreen.dart';
import '../../shared_preferences/type_preference.dart';

import 'OTPcontrollerScreen.dart';
import 'SignUpScreen.dart';

class ChooseTypeScreen extends StatefulWidget {
  static const String routeName = '/choose';

  const ChooseTypeScreen({Key? key}) : super(key: key);

  @override
  _ChooseTypeScreenState createState() => _ChooseTypeScreenState();
}

class _ChooseTypeScreenState extends State<ChooseTypeScreen> {
  @override
  void initState() {
    super.initState();
    typePreference = TypePreference();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            const SizedBox(height: 80),
            const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Describe Yourself!",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                )),
            SizedBox(height: MediaQuery.of(context).size.height * 0.26),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: TextButton(
                  onPressed: () async {
                    await typePreference?.setTypeStatus(false);
                    ConstantType = false;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpOtpScreen(
                                  type: OTPScreenType.signup,
                                )));
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.tileSelectGreen),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      )),
                  child: const Text(
                    'Customer',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: TextButton(
                  onPressed: () async {
                    await typePreference?.setTypeStatus(true);
                    ConstantType = true;
                    // TODO
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const SignUpOtpScreen(
                    //               type: OTPScreenType.signup,
                    //             )));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen(
                                  phone: '+917250723796',
                                )));
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.tileSelectGreen),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      )),
                  child: const Text(
                    'Vendor',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
            )
          ],
        ),
      );
}
