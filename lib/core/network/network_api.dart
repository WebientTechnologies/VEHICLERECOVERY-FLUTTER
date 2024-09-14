import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vinayak/core/utils/routes/app_routes.dart';

import '../constants/helper.dart';
import '../errors/app_exceptions.dart';
import '../global_controller/user_controller.dart';
import 'base_api.dart';

class NetworkApi extends BaseApi {
  @override
  Future getApi(String url) async {
    print(url);
    dynamic responseJson;
    String token = await Helper.getStringPreferences('token');

    try {
      print(url);
      final response = await http
          .get(Uri.parse(url), headers: {"Authorization": "Bearer $token"});
      print(response.statusCode.toString());
      responseJson = returnResponse(response);
    } on SocketException {
      throw NoInternetException('');
    }

    return responseJson;
  }

  @override
  Future getApiBody(String url, int id, String role) async {
    dynamic responseJson;
    print(url);
    var params = {"id": id.toString(), "role": role};
    print(params);
    var uri = Uri.parse(url);
    var uii = uri.replace(queryParameters: params);

    try {
      final response = await http.get(uii);
      responseJson = returnResponse(response);
      print(responseJson);
    } on SocketException {
      throw NoInternetException('');
    }

    return responseJson;
  }

  Future getApiWithoutHead(String url) async {
    print(url);
    dynamic responseJson;
    // String token = await Helper.getStringPreferences('token');

    try {
      print(url);
      final response = await http.get(Uri.parse(url), headers: {});
      print(response.statusCode.toString());
      responseJson = returnResponse(response);
    } on SocketException {
      throw NoInternetException('');
    }

    return responseJson;
  }

  @override
  Future postApi(String url, dynamic data) async {
    print(url);
    print('man - ${data}');
    dynamic responseJson;
    String token = await Helper.getStringPreferences('token');
    try {
      final response = await http.post(Uri.parse(url), body: data, headers: {
        "Authorization": "Bearer $token",
        'Content-Type': 'application/json',
        'accept': '*/*'
      });
      responseJson = returnResponse(response);
      print(response);
    } on SocketException {
      throw NoInternetException('');
    }

    return responseJson;
  }

  Future postApiHeader(String url, dynamic data) async {
    print(url);
    print('man - ${data}');
    dynamic responseJson;
    String token = await Helper.getStringPreferences('token');
    try {
      final response = await http.post(Uri.parse(url), body: data, headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "*/*"
      });

      responseJson = returnResponse(response);
    } on SocketException {
      throw NoInternetException('');
    }

    return responseJson;
  }

  Future postApiWithoutHeader(String url, dynamic data) async {
    print(url);
    print('man - ${data}');
    dynamic responseJson;
    // String token = await Helper.getStringPreferences('token');
    try {
      final response = await http.post(Uri.parse(url), body: data, headers: {
        // "Authorization": "Bearer $token",
        // "Content-Type": "application/json",
        "Accept": "*/*"
      });
      print(response.body);
      responseJson = returnResponse(response);
    } on SocketException {
      throw NoInternetException('');
    }

    return responseJson;
  }

  Future postExContentApi(String url, dynamic data) async {
    print(url);
    print('man - ${data}');
    dynamic responseJson;
    String token = await Helper.getStringPreferences('token');
    try {
      final response = await http.post(Uri.parse(url), body: data, headers: {
        "Authorization": "Bearer $token",
        // 'Content-Type': 'application/json',
        'accept': '*/*'
      });
      responseJson = returnResponse(response);
      print(response);
    } on SocketException {
      throw NoInternetException('');
    }

    return responseJson;
  }

  @override
  Future putApi(String url, dynamic data) async {
    dynamic responseJson;
    print(url);
    print(data);
    try {
      final response = await http.put(Uri.parse(url),
          body: data, headers: {'Content-Type': 'application/json'});
      responseJson = returnResponse(response);
    } on SocketException {
      throw NoInternetException('');
    }

    return responseJson;
  }

  @override
  Future putWOHeadApi(String url, dynamic data) async {
    dynamic responseJson;
    print(url);
    print(data);
    try {
      final response = await http.put(Uri.parse(url),
          body: data, headers: {'Content-Type': 'application/json'});
      responseJson = returnResponse(response);
    } on SocketException {
      throw NoInternetException('');
    }

    return responseJson;
  }

  @override
  Future putWOBodyApi(String url) async {
    dynamic responseJson;
    String token = await Helper.getStringPreferences('token');
    print(url);
    try {
      final response = await http.put(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token",
      });
      responseJson = returnResponse(response);
    } on SocketException {
      throw NoInternetException('');
    }

    return responseJson;
  }

  @override
  Future deleteApi(String url) async {
    print(url);
    dynamic responseJson;
    try {
      final response = await http.delete(Uri.parse(url));
      responseJson = returnResponse(response);
    } on SocketException {
      throw NoInternetException('');
    }

    return responseJson;
  }

  @override
  Future loginApi(BuildContext context, String url, dynamic data) async {
    print(url);
    print('man - ${data}');
    dynamic responseJson;
    try {
      // showDialog(
      //   context: context,
      //   builder: (context) {
      //     return const Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   },
      // );
      final response = await http.post(Uri.parse(url),
          body: jsonEncode(data),
          headers: {"Content-Type": "application/json"});
      responseJson = returnResponse(response);
    } on SocketException {
      //Get.back();

      throw NoInternetException('');
    }

    //Get.back();

    return responseJson;
  }

  @override
  Future registerApi(BuildContext context, String url, data) async {
    dynamic responseJson;
    try {
      print(url);
      // showDialog(
      //   context: context,
      //   builder: (context) {
      //     return const Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   },
      // );
      final response = await http.post(Uri.parse(url),
          body: jsonEncode(data),
          headers: {"Content-Type": "application/json"});
      responseJson = returnResponse(response);
    } on SocketException {
      //Get.back();

      throw NoInternetException('');
    }

    //Get.back();

    return responseJson;
  }

  dynamic returnResponse(http.Response response) async {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      case 409:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 401:
        dynamic responseJson = jsonDecode(response.body);
        // Fluttertoast.showToast(msg: 'Session expired. please login again');
        UserController uc = Get.find<UserController>();
        uc.deleteUserDetails();
        await Helper.setStringPreferences('token', '');
        await FirebaseAuth.instance.signOut();
        Get.offAllNamed(AppRoutes.signin);
        return responseJson;
      case 403:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 500:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      default:
        print('${response.statusCode} : ${response.body}');
        throw FetchDataException(
            '${response.statusCode} : ${response.body}  : Error occured while communicating with server');
    }
  }
}
