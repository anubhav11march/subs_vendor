import 'package:flutter/material.dart';
import '../screens/CommonScreens.dart/AlertsScreen.dart';
import '../screens/CommonScreens.dart/ProfileScreen.dart';
import '../screens/CustomerScreens/MySubscriptionsScreen.dart';
import '../screens/CustomerScreens/SubSuccessScreen.dart';
import '../screens/OnboardingScreens/BankDetailsScreen.dart';
import '../screens/BlankTargetScreen.dart';
import '../screens/OnboardingScreens/ChooseTypeScreen.dart';
import '../screens/CustomerScreens/CustomSubscription.dart';
import '../screens/CustomerScreens/HomeScreen.dart';
import '../screens/CommonScreens.dart/SettingsScreen.dart';
import '../screens/OnboardingScreens/SignUpOtpScreen.dart';
import '../screens/OnboardingScreens/LoginScreen.dart';
import '../screens/VendorScreens/MyCustomers.dart';
import '../screens/OnboardingScreens/OTPcontrollerScreen.dart';
import '../screens/VendorScreens/OverviewScreen.dart';
import '../screens/OnboardingScreens/WelcomeScreen.dart';
import '../screens/OnboardingScreens/UserInfoScreen.dart';

final Map<String, WidgetBuilder> routes = {
  WelcomeScreen.routeName: (context) => const WelcomeScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  ProfilePage.routeName: (context) => const ProfilePage(),
  BankDetailScreen.routeName: (context) => const BankDetailScreen(),
  MyCustomerScreen.routeName: (context) => const MyCustomerScreen(),
  SignUpOtpScreen.routeName: (context) => SignUpOtpScreen(
        type: ModalRoute.of(context)!.settings.arguments as OTPScreenType,
      ),
  AlertsScreen.routeName: (context) => const AlertsScreen(),
  SettingsScreen.routeName: (context) => const SettingsScreen(),
  CustomSubScreen.routeName: (context) => CustomSubScreen(),
  ChooseTypeScreen.routeName: (context) => const ChooseTypeScreen(),
  OverviewScreen.routeName: (context) => const OverviewScreen(),
  SubSuccess.routeName: (context) => const SubSuccess(),
  MySubScreen.routeName: (context) => const MySubScreen(),
  DisplayProfile.routeName: (context) => const DisplayProfile(),
  blank.routeName: (context) => const blank(),
};
