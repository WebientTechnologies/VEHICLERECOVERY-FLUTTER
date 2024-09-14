import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vinayak/core/global_controller/user_controller.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/constants/helper.dart';

class PasswordController extends GetxController {
  UserController uc = Get.put(UserController());
  Future<void> updatePassword(
      String oldPass, String newPass, String confirmPass) async {
    var url;
    if (uc.userDetails['role'] == 'repo-agent') {
      url = Uri.parse(ApiEndpoints.updatePassByRepoAgent);
    } else {
      url = Uri.parse(ApiEndpoints.updatePassByOff);
    }
    print(url);

    var data = {
      //'oldPassword': oldPass,
      'newPassword': newPass,
      'confirmPassword': confirmPass
    };

    var token = await Helper.getStringPreferences('token');
    print(token);

    try {
      var response = await http.put(
        url,
        body: jsonEncode(data),
        headers: {
          'Authorization': 'Bearer $token',
          // 'Content-Type': 'application/json',
        },
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 201) {
        // Handle success
      } else {
        // Handle other status codes or errors
      }
    } catch (error) {
      print('Error: $error');
      // Handle error
    }
  }
}
