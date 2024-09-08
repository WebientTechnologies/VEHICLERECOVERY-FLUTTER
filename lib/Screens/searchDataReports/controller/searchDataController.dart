import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinayak/Screens/searchDataReports/model/searchModel.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/network_api.dart';
import '../../../core/response/status.dart';

class SearchDataReportController extends GetxController {
  var _api = NetworkApi();
  var searchCont = TextEditingController().obs;
  final rxSearchReportRequestStatus = Status.LOADING.obs;
  void setRxSearchRepoStatus(Status value) =>
      rxSearchReportRequestStatus.value = value;
  final searchReportModel = SearchData().obs;
  void setSearchRepoReportList(SearchData value) =>
      searchReportModel.value = value;
  List<Search> data = <Search>[].obs;

  Future<SearchData> getAllSearchDataRepoApi(
      String search, int pageNo, bool isRefresh, bool onChange) async {
    if (isRefresh || onChange) {
      setRxSearchRepoStatus(Status.LOADING);
    }
    var url = ApiEndpoints.getSearch;
    var response = await _api.getApi(url);
    print(response);
    return SearchData.fromJson(response);
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
      for (Search b in searchReportModel.value.search!) {
        data.add(b);
      }
      setRxSearchRepoStatus(Status.COMPLETED);
    } catch (e, s) {
      print(s);
      print(e);
    }
  }
}
