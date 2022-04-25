// ignore_for_file: unused_import, file_names

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateBankDetails {
  static Future updateBank(String token, String holderName, String accNo,
      String ifsc, String upi) async {
    final dio = Dio();
    FormData formData = FormData.fromMap({
      'accountno': accNo,
      'accountholdername': holderName,
      'ifsccode': ifsc,
      'upidetails': upi,
    });

    final prefs = await SharedPreferences.getInstance();
    final response = await dio.post(
        'https://subs-app1.herokuapp.com/vendor/updatebankdetails',
        data: formData,
        options: Options(
            headers: {
              "Authorization": "Bearer " + token,
            },
            validateStatus: (status) {
              return status! < 500;
            }));
    // print(response.data);
    // print(response.statusCode);
    if (response.statusCode == 200) {
      // print(response.data);
      /*SharedPrefsService().setUserToken(response.data.toString());
      String token = SharedPrefsService().getUserToken().toString();
      print(' the user token is $token'); */
      // Map<String, dynamic> jsonResponse = convert.jsonDecode(response.data) as Map<String, dynamic>;
      return response.statusCode;
    } else if (response.statusCode == 400) {
      return response.statusCode;
    } else {
      return null;
    }
  }
}
