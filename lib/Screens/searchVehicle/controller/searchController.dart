import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:vinayak/core/network/network_api.dart';
import 'package:http/http.dart' as http;
import '../../../core/constants/api_endpoints.dart';
import '../../../core/constants/helper.dart';
import '../../../core/response/status.dart';
import '../model/chasisnoModel.dart';
import '../model/searchLastmodel.dart';

class VehicleSearchController extends GetxController {
  var _api = NetworkApi();
  final rxRequestsearchbyLastStatus = Status.LOADING.obs;
  void setRxRequestSearchByLastStatus(Status value) =>
      rxRequestsearchbyLastStatus.value = value;
  final searchbylastModel = GetSearchByLastDigitModel().obs;
  void setsearchbylastList(GetSearchByLastDigitModel value) =>
      searchbylastModel.value = value;
//chasis no
  final rxRequestsearchbyChasisNoStatus = Status.LOADING.obs;
  void setRxRequestSearchByChasisNoStatus(Status value) =>
      rxRequestsearchbyChasisNoStatus.value = value;
  final searchbyChasisNoModel = GetVehicleByChasisNoModel().obs;
  void setsearchbyChasisNoList(GetVehicleByChasisNoModel value) =>
      searchbyChasisNoModel.value = value;

  Future<GetSearchByLastDigitModel> getAllSearchByLastDigitApi(
      String lastDigit) async {
    setRxRequestSearchByLastStatus(Status.LOADING);
    var response =
        await _api.getApi(ApiEndpoints.searchvehicle + '?lastDigit=$lastDigit');

    print(response);

    return GetSearchByLastDigitModel.fromJson(response);
  }

  void getAllSearchByLastDigitData(String lastDigit) {
    getAllSearchByLastDigitApi(lastDigit).then((value) {
      setRxRequestSearchByLastStatus(Status.COMPLETED);
      setsearchbylastList(value);
    }).onError((error, stackTrace) {
      // print(stackTrace);
      // print('--------------------');
      // print(error);
      setRxRequestSearchByLastStatus(Status.ERROR);
    });
  }

//chasis no
  Future<GetVehicleByChasisNoModel> getAllSearchByChasisApi(
      String lastDigit) async {
    setRxRequestSearchByChasisNoStatus(Status.LOADING);
    var response =
        await _api.getApi(ApiEndpoints.searchvehicle + '?chasisNo=$lastDigit');

    print(response);

    return GetVehicleByChasisNoModel.fromJson(response);
  }

  void getAllSearchByChasisApiData(String lastDigit) {
    getAllSearchByChasisApi(lastDigit).then((value) {
      setRxRequestSearchByChasisNoStatus(Status.COMPLETED);
      setsearchbyChasisNoList(value);
    }).onError((error, stackTrace) {
      // print(stackTrace);
      // print('--------------------');
      // print(error);
      setRxRequestSearchByChasisNoStatus(Status.ERROR);
    });
  }

  Future<void> updateVehicleHoldRepo(String id) async {
    var url = Uri.parse('${ApiEndpoints.holdvehicleByrepoagent}/$id');

    print(url);

    var token = await Helper.getStringPreferences('token');
    print(token);

    try {
      var response = await http.put(
        url,
        // body: jsonEncode(),
        headers: {
          'Authorization': 'Bearer $token',
          // 'Content-Type': 'application/json',
        },
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        // Handle success
        Fluttertoast.showToast(msg: 'Status Updated Sucessfully');
      } else {
        // Handle other status codes or errors
      }
    } catch (error) {
      Fluttertoast.showToast(msg: 'Status not Updated');

      print('Error: $error');
      // Handle error
    }
  }

//search list update by repo agent
  Future<void> updateSearchList(String id) async {
    var url = Uri.parse('${ApiEndpoints.updateSearchRepoList}/$id');

    print(url);

    var token = await Helper.getStringPreferences('token');
    print(token);

    try {
      var response = await http.put(
        url,
        // body: jsonEncode(),
        headers: {
          'Authorization': 'Bearer $token',
          // 'Content-Type': 'application/json',
        },
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        // Handle success
        Fluttertoast.showToast(msg: 'Message sent Sucessfully');
      } else {
        // Handle other status codes or errors
      }
    } catch (error) {
      Fluttertoast.showToast(msg: 'Message sent not Updated');

      print('Error: $error');
      // Handle error
    }
  }
}
