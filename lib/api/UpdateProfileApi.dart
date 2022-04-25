import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfile {
  static Future<int?> updateProfile(
      String token,
      String name,
      String email,
      String address,
      String pinCode,
      String type,
      String shopName,
      String desc) async {
    final dio = Dio();

    print(token);
    print(name);
    print(email);
    print(address);
    print(pinCode);
    print(type);
    print(shopName);
    print(desc);

    final formData = FormData.fromMap({
      'name': name,
      'email': email,
      'address': address,
      'pincode': pinCode,
      'type': type.toLowerCase(),
      'shopname': shopName,
      'bio': desc,
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
    print(response.statusCode);
    print(response.statusMessage);
    print(response.data);
    if (response.statusCode == 200) {
      return response.statusCode;
    } else if (response.statusCode == 400) {
      return response.statusCode;
    } else {
      return null;
    }
  }
}
