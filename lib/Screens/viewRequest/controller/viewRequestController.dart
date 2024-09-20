import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vinayak/core/constants/api_endpoints.dart';
import 'package:vinayak/core/network/network_api.dart';

import '../../../core/constants/helper.dart';
import '../../../core/response/status.dart';
import '../model/viewRequestModel.dart';

class ViewRequestByOfficeController extends GetxController {
  var _api = NetworkApi();
  var searchCont = TextEditingController().obs;
  final rxViewReportRequestStatus = Status.LOADING.obs;
  void setRxViewRepoStatus(Status value) =>
      rxViewReportRequestStatus.value = value;
  final viewReportModel = ViewRequestDataModel().obs;
  void setViewReportList(ViewRequestDataModel value) =>
      viewReportModel.value = value;
  List<Requests> data = <Requests>[].obs;

  Future<ViewRequestDataModel> getViewRequest(
      String search, int pageNo, bool isRefresh, bool onChange) async {
    if (isRefresh) {
      setRxViewRepoStatus(Status.LOADING);
    }
    var url = '${ApiEndpoints.viewRequest}?search=$search&page=$pageNo';
    var response = await _api.getApi(url);
    print(response);
    return ViewRequestDataModel.fromJson(response);
  }

  void getViewRequestData(
      String search, int pageNo, bool isRefresh, bool onChange) async {
    try {
      var value = await getViewRequest(search, pageNo, isRefresh, onChange);
      if (onChange) {
        data.clear();
      }

      setViewReportList(value);
      for (Requests b in viewReportModel.value.requests!) {
        data.add(b);
      }
      setRxViewRepoStatus(Status.COMPLETED);
    } catch (e) {
      print(e);
      setRxViewRepoStatus(Status.ERROR);
    }
  }

  Future<void> updateStatus(String id, String status) async {
    var url = Uri.parse(ApiEndpoints.updateHoldVehicleStatus + '/$id');
    print(url);
    var data = {'status': status};
    print(jsonEncode(data));
    var token = await Helper.getStringPreferences('token');
    print(token);

    try {
      var response = await http.put(
        url,
        body: jsonEncode(data),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Status Updated Successfully');
        // If the request is successful, call getAllRepoAgentData()

        getViewRequestData('', 1, false, true);
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
