import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vinayak/Screens/agentRegisteration/model/zoneModel.dart';
import 'package:vinayak/core/constants/helper.dart';
import 'package:vinayak/core/network/network_api.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/response/status.dart';
import '../model/cityModel.dart';
import '../model/stateModel.dart';

class AgentRegistrationController extends GetxController {
  var _api = NetworkApi();
  var zoneIdController = TextEditingController().obs;
  var stateIdController = TextEditingController().obs;
  var cityIdController = TextEditingController().obs;
  var nameController = TextEditingController().obs;
  var mobileController = TextEditingController().obs;
  var alternativeMobileController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var panCardController = TextEditingController().obs;
  var aadharCardController = TextEditingController().obs;
  var addressLine1Controller = TextEditingController().obs;
  var addressLine2Controller = TextEditingController().obs;
  var countryController = TextEditingController().obs;
  var stateController = TextEditingController().obs;
  var cityController = TextEditingController().obs;
  var pincodeController = TextEditingController().obs;
  var usernameController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  final rxRequestZoneStatus = Status.LOADING.obs;
  void setRxRequestZoneStatus(Status value) =>
      rxRequestZoneStatus.value = value;
  final zoneModel = GetZoneModel().obs;
  void setZoneList(GetZoneModel value) => zoneModel.value = value;
//state
  final rxRequestStateStatus = Status.LOADING.obs;
  void setRxRequestStateStatus(Status value) =>
      rxRequestStateStatus.value = value;
  final stateModel = GetStateByZoneModel().obs;
  void setStateList(GetStateByZoneModel value) => stateModel.value = value;
//city
  final rxRequestCityStatus = Status.LOADING.obs;
  void setRxRequestCityStatus(Status value) =>
      rxRequestCityStatus.value = value;
  final cityModel = GetCityByStateModel().obs;
  void setCityList(GetCityByStateModel value) => cityModel.value = value;

  RxString agentId = 'S00'.obs;

  //post repo agent

  Future<void> agentRegister(
      String zoneId, String stateId, String cityId, bool officeStaf) async {
    String url;
    Map<String, String> headers;
    var token = await Helper.getStringPreferences('token');
    if (officeStaf) {
      url = ApiEndpoints.agentRegisterByOfficeStaf;
      headers = {
        'accept': '*/*',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
    } else {
      url = ApiEndpoints.agentRegister;
      headers = {
        'accept': '*/*',
        'Content-Type': 'application/json',
      };
    }

    var body = {
      'zoneId': zoneId,
      'stateId': stateId,
      'cityId': cityId,
      'name': nameController.value.text,
      'mobile': mobileController.value.text,
      'alternativeMobile': alternativeMobileController.value.text,
      'email': emailController.value.text,
      'panCard': panCardController.value.text,
      'aadharCard': aadharCardController.value.text,
      'addressLine1': addressLine1Controller.value.text,
      'addressLine2': addressLine2Controller.value.text,
      'state': stateId,
      'city': cityId,
      'pincode': pincodeController.value.text,
      'username': usernameController.value.text,
      'password': passwordController.value.text,
    };

    print(jsonEncode(body));

    try {
      print(headers);
      print(url);
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: headers,
      );

      print('StatusCode: ${response.statusCode}');
      print('ResponseBody: ${response.body}');

      if (response.statusCode == 201) {
        Get.back();
        Fluttertoast.showToast(msg: 'Agent Registered Successfully!');
      } else {
        Fluttertoast.showToast(msg: jsonDecode(response.body)['message']);
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<GetZoneModel> getAllZoneApi() async {
    // setRxRequestZoneStatus(Status.LOADING);
    var response = await _api.getApiWithoutHead(ApiEndpoints.getZone);

    print(response);

    return GetZoneModel.fromJson(response);
  }

  void getAllZoneApiData() {
    getAllZoneApi().then((value) {
      setRxRequestZoneStatus(Status.COMPLETED);
      setZoneList(value);
    }).onError((error, stackTrace) {
      print(stackTrace);
      print('--------------------');
      print(error);
      setRxRequestZoneStatus(Status.ERROR);
    });
  }

//state
  Future<GetStateByZoneModel> getAllStateApi(String id) async {
    // setRxRequestStateStatus(Status.LOADING);
    var response =
        await _api.getApiWithoutHead(ApiEndpoints.getStateByzone + '/$id');

    print(response);

    return GetStateByZoneModel.fromJson(response);
  }

  void getAllStateApiData(String id) {
    getAllStateApi(id).then((value) {
      setRxRequestStateStatus(Status.COMPLETED);
      setStateList(value);
    }).onError((error, stackTrace) {
      print(stackTrace);
      print('--------------------');
      print(error);
      setRxRequestStateStatus(Status.ERROR);
    });
  }

//city
  Future<GetCityByStateModel> getAllCityApi(String id) async {
    // setRxRequestCityStatus(Status.LOADING);
    var response =
        await _api.getApiWithoutHead(ApiEndpoints.getCityByState + '/$id');

    print(response);

    return GetCityByStateModel.fromJson(response);
  }

  void getAllCityApiData(String id) {
    getAllCityApi(id).then((value) {
      setRxRequestCityStatus(Status.COMPLETED);
      setCityList(value);
    }).onError((error, stackTrace) {
      print(stackTrace);
      print('--------------------');
      print(error);
      setRxRequestCityStatus(Status.ERROR);
    });
  }

  void getLastAgentId() async {
    _api.getApiWithoutHead(ApiEndpoints.getLastAgentId).then((v) {
      agentId.value = jsonDecode(jsonEncode(v))['agentId'];

      int id = int.parse(agentId.value.substring(1)) + 1;

      agentId.value = 'S00$id';

      print(agentId.value);
    });
  }
}
