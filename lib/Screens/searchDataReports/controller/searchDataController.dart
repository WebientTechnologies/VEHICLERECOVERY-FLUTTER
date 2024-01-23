import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/network_api.dart';
import '../../../core/response/status.dart';
import '../model/searchDataModel.dart';

class SearchDataReportController extends GetxController {
  var _api = NetworkApi();
  var searchCont = TextEditingController().obs;
  final rxSearchReportRequestStatus = Status.LOADING.obs;
  void setRxSearchRepoStatus(Status value) =>
      rxSearchReportRequestStatus.value = value;
  final searchReportModel = SearchDataReport().obs;
  void setSearchRepoReportList(SearchDataReport value) =>
      searchReportModel.value = value;
  List<VehiclesList> data = <VehiclesList>[].obs;

  Future<SearchDataReport> getAllSearchDataRepoApi(
      String search, int pageNo, bool isRefresh, bool onChange) async {
    var url = ApiEndpoints.searchDataReport + '?search=$search&page=$pageNo';
    var response = await _api.getApi(url);
    print(response);
    return SearchDataReport.fromJson(response);
  }

  void getAllSearchDataRepoData(
      String search, int pageNo, bool isRefresh, bool onChange) async {
    try {
      var value =
          await getAllSearchDataRepoApi(search, pageNo, isRefresh, onChange);
      setSearchRepoReportList(value);
      if (onChange) {
        data.clear();
      }
      for (VehiclesList b in searchReportModel.value.vehiclesList!) {
        data.add(b);
      }
      setRxSearchRepoStatus(Status.COMPLETED);
    } catch (e) {
      print(e);
    }
  }
}
