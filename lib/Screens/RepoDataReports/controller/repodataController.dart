import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinayak/core/constants/api_endpoints.dart';
import 'package:vinayak/core/network/network_api.dart';
import 'package:vinayak/core/response/status.dart';

import '../model/repoDataModel.dart';

class RepoDataReportController extends GetxController {
  var _api = NetworkApi();
  var searchCont = TextEditingController().obs;
  final rxRepoRequestStatus = Status.LOADING.obs;
  void setRxRequestRepoStatus(Status value) =>
      rxRepoRequestStatus.value = value;
  final repoReportModel = RepoReportModel().obs;
  void setRepoReportList(RepoReportModel value) =>
      repoReportModel.value = value;
  List<VehiclesList> data = <VehiclesList>[].obs;

  Future<RepoReportModel> getRepoReportApi(
      String search, int pageNo, bool isRefresh, bool onChange) async {
    if (isRefresh) {
      setRxRequestRepoStatus(Status.LOADING);
    }

    var url = '${ApiEndpoints.repoDataReport}?search=$search&page=$pageNo';
    var response = await _api.getApi(url);
    print(response);
    return RepoReportModel.fromJson(response);
  }

  void getRepoReportData(
      String search, int pageNo, bool isRefresh, bool onChange) async {
    try {
      var value = await getRepoReportApi(search, pageNo, isRefresh, onChange);
      setRepoReportList(value);
      if (onChange) {
        data.clear();
      }
      for (VehiclesList b in repoReportModel.value.vehiclesList!) {
        data.add(b);
      }
      setRxRequestRepoStatus(Status.COMPLETED);
    } catch (e) {
      print(e);
      setRxRequestRepoStatus(Status.ERROR);
    }
  }
}
