import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:vinayak/Screens/1RepoStaff/homeR/homeRepo.dart';
import 'package:vinayak/core/network/network_api.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/constants/helper.dart';
import '../../../core/constants/shared_preferences_var.dart';
import '../../../core/global_controller/user_controller.dart';
import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final _api = NetworkApi();
  var emailcont = TextEditingController().obs;
  var passcont = TextEditingController().obs;
  final RxString emailError = RxString('');
  UserController uc = Get.put(UserController());

  Future<bool> login(BuildContext context) async {
    try {
      showLoadingDialog(context);

      //var deviceId = await Helper.getStringPreferences('deviceId');
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      String deviceId = androidInfo.id;

      print(deviceId);

      var data = {
        'username': emailcont.value.text,
        'password': passcont.value.text.trim(),
        'deviceId': 'null',
      };
      print(jsonEncode(data));

      var response = await http.post(
        Uri.parse(ApiEndpoints.login),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      print(response.body);

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);

        if (responseBody.toString().contains('staf')) {
          await handleLoginSuccess(responseBody);
          Get.offAllNamed(AppRoutes.home);
          return true;
        } else {
          if (responseBody.toString().contains('agent')) {
            await handleAgentLoginSuccess(responseBody);
            // print('reggggggggggggggggggggggg');
          }
          print('login -------------');
          // Fluttertoast.showToast(msg: responseBody['status']);
          return false;
        }
      } else {
        handleLoginError(response);
        return false;
      }
    } catch (e) {
      handleLoginError(e);
      return false;
    }
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Future<void> handleLoginSuccess(Map<String, dynamic> responseBody) async {
    await Helper.setStringPreferences(
      SharedPreferencesVar.token,
      responseBody['staf']['token'].toString(),
    );

    uc.saveUserDetails(responseBody);
    print(uc.userDetails['name']);
    if (responseBody['role'] == 'office-staff') {
      print('hommmemem');
    }
  }

  Future<void> handleAgentLoginSuccess(
      Map<String, dynamic> responseBody) async {
    await Helper.setStringPreferences(
      SharedPreferencesVar.token,
      responseBody['agent']['token'].toString(),
    );

    uc.saveUserDetails(responseBody);
    Get.offAll(HomeScreenRepoStaff());
  }

  void handleLoginError(dynamic error) {
    Get.back();
    if (error is http.Response) {
      Fluttertoast.showToast(msg: jsonDecode(error.body)['message']);
      print('Error: ${error.statusCode}');
    } else {
      print(error);
    }
  }
}
