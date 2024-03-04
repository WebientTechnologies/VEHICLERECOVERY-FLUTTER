import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinayak/core/constants/api_endpoints.dart';
import 'package:vinayak/core/network/network_api.dart';
import 'package:vinayak/core/response/status.dart';

import '../model/releaseReportModel.dart';

class ReleaseRepoReportController extends GetxController {
  var _api = NetworkApi();
  List<VehiclesList> data = <VehiclesList>[].obs;

  var searchCont = TextEditingController().obs;
  final rxReleaseReportRequestStatus = Status.LOADING.obs;
  void setRxRequestReleaseRepoStatus(Status value) =>
      rxReleaseReportRequestStatus.value = value;
  final releaseReportModel = ReleaseReportModel().obs;
  void setReleaseRepoReportList(ReleaseReportModel value) =>
      releaseReportModel.value = value;

  Future<ReleaseReportModel> getAllReleaseRepoApi(
      String search, int pageNo, bool isRefresh, bool onChange) async {
    if (isRefresh || onChange) {
      setRxRequestReleaseRepoStatus(Status.LOADING);
    }
    var url = ApiEndpoints.releaseDataReport + '?search=$search&page=$pageNo';
    var response = await _api.getApi(url);
    print(response);
    return ReleaseReportModel.fromJson(response);
  }

  void getAllReleaseReportData(
      String search, int pageNo, bool isRefresh, bool onChange) async {
    try {
      var value =
          await getAllReleaseRepoApi(search, pageNo, isRefresh, onChange);
      setReleaseRepoReportList(value);
      if (onChange) {
        data.clear();
      }

      for (VehiclesList b in releaseReportModel.value.vehiclesList!) {
        data.add(b);
      }
      setRxRequestReleaseRepoStatus(Status.COMPLETED);
    } catch (e) {
      print(e);
    }
  }
}
