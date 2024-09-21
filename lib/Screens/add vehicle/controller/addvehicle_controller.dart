import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:vinayak/core/constants/api_endpoints.dart';
import 'package:vinayak/core/network/network_api.dart';

class AddvehicleController extends GetxController {
  final _api = NetworkApi();

  var bankCont = TextEditingController().obs;
  var regNoCont = TextEditingController().obs;
  var customerNameCont = TextEditingController().obs;
  var makeCont = TextEditingController().obs;
  var confirmByCont = TextEditingController().obs;
  var mobileCont = TextEditingController().obs;

  void addVehicle(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      var data = {
        "bankName": bankCont.value.text,
        "regNo": regNoCont.value.text,
        "lastDigit":
            regNoCont.value.text.substring(regNoCont.value.text.length - 4),
        "customerName": customerNameCont.value.text,
        "maker": makeCont.value.text,
        "confirmBy": confirmByCont.value.text,
        "mobNo": mobileCont.value.text
      };
      var response =
          await _api.postApi(ApiEndpoints.addVehicle, jsonEncode(data));

      Get.back();

      if (response.toString().contains('message')) {
        Fluttertoast.showToast(msg: 'Vehicle Added Successfully');
      } else {
        Fluttertoast.showToast(msg: 'something went wrong');
      }
    } catch (e) {
      Get.back();
      print(e);
    }
  }
}
