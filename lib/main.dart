import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Utils/Constants.dart';
import 'screens/CustomerScreens/HomeScreen.dart';
import 'screens/OnboardingScreens/WelcomeScreen.dart';
import 'screens/VendorScreens/VendorHomeScreen.dart';
import 'shared_preferences/login_preferences.dart';
import 'shared_preferences/token_preferences.dart';
import 'shared_preferences/token_profile.dart';
import 'shared_preferences/type_preference.dart';

import 'Utils/Routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var isType;
  var type;
  @override
  void initState() {
    //initstate() is used to initialize the contents of an already existing object.
    loginPreference = LoginPreference();
    tokenPreference = TokenPreference();
    typePreference = TypePreference();
    getUserData();
    getType();
    super.initState();
  }

  bool isLoggedIn = false;
  getType() async {
    isType = await typePreference!.getTypeStatus();
    print("IS TYPE : $isType");
    type = isType ? 'vendor' : "Customer";
    ConstantType = isType;
    print("ConstantType = $ConstantType");
  }

  getUserData() async {
    if (await loginPreference!.getLoginStatus()) {
      print(await loginPreference!.getLoginStatus());
      tokenProfile =
          TokenProfile.fromJson(await tokenPreference.getTokenPreferenceData());
      //  print(constant.api);
      return tokenProfile;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUserData(),
        builder: (context, AsyncSnapshot<dynamic> token) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              fontFamily: 'Museo',
              primarySwatch: Colors.grey,
            ),
            home: (token.hasData && token.data != null)
                ? type == 'Customer'
                    ? HomeScreen()
                    : VendorHomeScreen()
                : WelcomeScreen(),
            // home: ResetPasswordScreen(phone: "8800128008",),
            routes: routes,
          );
        });
  }
}
