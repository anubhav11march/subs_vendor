
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfile {
  static Future<int?> updateProfile(String token, String name, String email, String address,
      String pincode, String type, String shopname, String desc) async {
    final dio = Dio();
    final formData = FormData.fromMap({
      'name': name,
      'email': email,
      'address': address,
      'pincode': pincode,
      'type': type,
      'shopname': shopname,
      'bio': desc
    });

    final prefs = await SharedPreferences.getInstance();
    final response =
        await dio.post('https://subs-app1.herokuapp.com/user/updatedetails',
            data: formData,
            options: Options(
                headers: {
                  "Authorization": "Bearer " + token,
                },
                validateStatus: (status) {
                  return status! < 500;
                }));
    // print(response.data);
    if (response.statusCode == 200) {
      // print(response.data);
      // /*SharedPrefsService().setUserToken(response.data.toString());
      // String token = SharedPrefsService().getUserToken().toString();
      // print(' the user token is $token'); */
      // // Map<String, dynamic> jsonResponse = convert.jsonDecode(response.data) as Map<String, dynamic>;
      return response.statusCode;
    } else if (response.statusCode == 400) {
      return response.statusCode;
    } else {
      return null;
    }
  }
}
