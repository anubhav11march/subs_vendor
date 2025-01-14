import 'package:shared_preferences/shared_preferences.dart';

TypePreference? typePreference;

class TypePreference {
  static const _Type_STATUS = 'TypeSTATUS';

  Future<void> setTypeStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_Type_STATUS, status);
  }

  Future<void> clearTypeStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<bool> getTypeStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      return prefs.getBool(_Type_STATUS) ?? false;
    } catch (e) {
      print('Error in Type preference : $e');
      return false;
    }
  }
}
