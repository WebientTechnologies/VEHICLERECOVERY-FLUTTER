import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:vinayak/core/constants/helper.dart';
import 'package:vinayak/core/network/network_api.dart';
import 'package:http/http.dart' as http;
import '../../../core/constants/api_endpoints.dart';
import '../../../core/response/status.dart';
import '../model/allRepoAgentModel.dart';

class RepoAgentController extends GetxController {
  var _api = NetworkApi();
  final rxRequestAllRepoStatus = Status.LOADING.obs;
  int currentPage = 1;

  void setRxRequestAllRepoStatus(Status value) =>
      rxRequestAllRepoStatus.value = value;
  final allRepoModel = GetAllRepoAgentModel().obs;
  void setAllRepoList(GetAllRepoAgentModel value) => allRepoModel.value = value;

  Future<GetAllRepoAgentModel> getAllRepoAgent(int pageNo) async {
    setRxRequestAllRepoStatus(Status.LOADING);
    var response = await _api.getApi('${ApiEndpoints.getAllRepo}?page=$pageNo');

    print(response);

    return GetAllRepoAgentModel.fromJson(response);
  }

  void getAllRepoAgentData(int pageNo) {
    getAllRepoAgent(pageNo).then((value) {
      setRxRequestAllRepoStatus(Status.COMPLETED);
      setAllRepoList(value);
    }).onError((error, stackTrace) {
      // print(stackTrace);
      // print('--------------------');
      // print(error);
      setRxRequestAllRepoStatus(Status.ERROR);
    });
  }

  Future<void> updateStatus(String id, String status) async {
    var url = Uri.parse('${ApiEndpoints.updateRepoStatus}/$id');
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

      if (response.statusCode == 201) {
        // If the request is successful, call getAllRepoAgentData()
        getAllRepoAgentData(1);
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  //password update
  Future<void> updatePassword(
      String id, String newPass, String confirmPass) async {
    var url = Uri.parse(ApiEndpoints.updateRepoPassword + '/$id');
    print(url);
    var data = {'password': newPass, 'confirmPassword': confirmPass};
    print(jsonEncode(data));
    var token = await Helper.getStringPreferences('token');
    print(token);

    try {
      var response = await http.put(
        url,
        body: jsonEncode(data),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': '*/*',
          'Connection': 'keep-alive'
          // 'Content-Type': 'application/json',
        },
      );

      print(response.statusCode);

      if (response.statusCode == 201) {
        print(response.body);

        Get.back();
        Fluttertoast.showToast(msg: 'Password Updated');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  //update device id
  Future<void> updateDeviceId(
    String id,
  ) async {
    var url = Uri.parse(ApiEndpoints.updatedeviceid + '/$id');
    print(url);
    // var data = {'password': newPass, 'confirmPassword': confirmPass};
    // print(jsonEncode(data));
    var token = await Helper.getStringPreferences('token');
    print(token);

    try {
      var response = await http.put(
        url,
        // body: jsonEncode(data),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': '*/*',
          'Connection': 'keep-alive'
          // 'Content-Type': 'application/json',
        },
      );

      print(response.statusCode);

      if (response.statusCode == 201) {
        print(response.body);

        // Get.back();
        Fluttertoast.showToast(msg: 'Device Id Updated');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
