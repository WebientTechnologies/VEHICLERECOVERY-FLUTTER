import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinayak/core/constants/api_endpoints.dart';
import 'package:vinayak/core/network/network_api.dart';

import '../../../core/response/status.dart';
import '../model/holddataReportModel.dart';

class HoldDataController extends GetxController {
  var _api = NetworkApi();
  var searchCont = TextEditingController().obs;
  final rxRequestHoldRepoStatus = Status.LOADING.obs;
  void setRxRequestAllRepoStatus(Status value) =>
      rxRequestHoldRepoStatus.value = value;
  final holdRepoModel = HoldReportModel().obs;
  void setHoldReportList(HoldReportModel value) => holdRepoModel.value = value;
  List<VehiclesList> data = <VehiclesList>[].obs;

  Future<HoldReportModel> getAllHoldReports(
      String search, int pageNo, bool isRefresh, bool onChange) async {
    if (isRefresh) {
      setRxRequestAllRepoStatus(Status.LOADING);
    }
    var url = '${ApiEndpoints.holdreport}?search=$search&page=$pageNo';
    var response = await _api.getApi(url);
    print(response);
    return HoldReportModel.fromJson(response);
  }

  void getHoldRepoData(
      String search, int pageNo, bool isRefresh, bool onChange) async {
    try {
      var value = await getAllHoldReports(search, pageNo, isRefresh, onChange);
      setHoldReportList(value);
      if (onChange) {
        data.clear();
      }
      for (VehiclesList b in holdRepoModel.value.vehiclesList!) {
        data.add(b);
      }
      setRxRequestAllRepoStatus(Status.COMPLETED);
    } catch (e) {
      print(e);
    }
  }
}
