// ignore_for_file: unused_import, file_names

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subs_vendor/shared_preferences/token_profile.dart';

class SignUp {
  static Future<Response?> signUp(
      String phoneNo, String password, String type) async {
    final dio = Dio();
    final formData = FormData.fromMap({
      'phoneno': phoneNo,
      'password': password,
      'type': type.toLowerCase(),
    });
    final response = await dio
        .post('https://subs-app1.herokuapp.com/user/signup', data: formData,
            options: Options(validateStatus: (status) {
      return status! < 500;
    }));
    if (response.statusCode == 200) {
      TokenProfile.fromJson(json.decode('"${response.data['data']}"'));
      return response;
    } else if (response.statusCode == 400) {
      return response;
    } else {
      return null;
    }
  }
}

//json.decode("${response.data['data']}"
