import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:vinayak/Screens/HomeScreen/model/vehicle_single_modelss.dart';
import 'package:vinayak/Screens/HomeScreen/model/vehicle_sm_hive.dart';
import 'package:vinayak/Screens/searchVehicle/model/seezer_model.dart';
import 'package:vinayak/core/constants/shared_preferences_var.dart';
import 'package:vinayak/core/global_controller/hive_service.dart';
import 'package:vinayak/core/network/network_api.dart';
import 'package:http/http.dart' as http;
import 'package:vinayak/core/sqlite/vehicledb.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/constants/helper.dart';
import '../../../core/response/status.dart';
import '../../../core/sqlite/models/vehicle_model.dart';
import '../model/chasisnoModel.dart';
import '../model/searchLastmodel.dart';

class VehicleSearchController extends GetxController {
  var _api = NetworkApi();
  VehicleDb vdb = VehicleDb();

  var loadItemCont = TextEditingController().obs;

  RxInt offlineDataCount = 0.obs;
  RxInt onlineDataCount = 0.obs;
  //final offlineDataHive = HiveService().myBox.obs;
  //final offlineDataFilteredHive = <Box>[].obs;
  RxList<VehicleModel> offlineData = <VehicleModel>[].obs;
  RxList<dynamic> offlineDataFiltered = <dynamic>[].obs;
  RxList<VehicleSingleModelss> singleOfflineData = <VehicleSingleModelss>[].obs;

  RxString selectedLoadStatus = "empty".obs;
  RxString selectedSeezer = "".obs;
  List<DropdownMenuItem> loadStatus = [
    const DropdownMenuItem(
      value: "empty",
      child: Text('Empty'),
    ),
    const DropdownMenuItem(
      value: "goods",
      child: Text('Goods'),
    ),
  ];

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

  final rxSeezerListStatus = Status.LOADING.obs;
  void setRxSeezerListStatus(Status value) => rxSeezerListStatus.value = value;
  final seezerModel = SeezerModel().obs;
  void setSeezerModel(SeezerModel value) => seezerModel.value = value;

  Future<GetSearchByLastDigitModel> getAllSearchByLastDigitApi(
      String lastDigit) async {
    setRxRequestSearchByLastStatus(Status.LOADING);
    var response =
        await _api.getApi(ApiEndpoints.searchvehicle + '?lastDigit=$lastDigit');

    print(response);

    return GetSearchByLastDigitModel.fromJson(response);
  }

  var firstHalf = [];
  var secondHalf = [];

  void getAllSearchByLastDigitData(String lastDigit) {
    getAllSearchByLastDigitApi(lastDigit).then((value) {
      setRxRequestSearchByLastStatus(Status.COMPLETED);
      setsearchbylastList(value);

      firstHalf.clear();
      secondHalf.clear();

      int length = searchbylastModel.value.data!.length;
      int halfLength = (searchbylastModel.value.data!.length / 2).round();

      for (int i = 0; i < halfLength; i++) {
        firstHalf.add(searchbylastModel.value.data![i]);
      }

      for (int i = halfLength + 1; i < length; i++) {
        secondHalf.add(searchbylastModel.value.data![i]);
      }
    }).onError((error, stackTrace) {
      // print(stackTrace);
      // print('--------------------');
      // print(error);
      setRxRequestSearchByLastStatus(Status.ERROR);
    });
  }

  void searchOfflineLastDigitData(String lastDigit) async {
    setRxRequestSearchByChasisNoStatus(Status.LOADING);
    setRxRequestSearchByLastStatus(Status.LOADING);
    //print(DateTime.now());

    offlineDataFiltered.value = await vdb.fetchByReg(lastDigit);
    setRxRequestSearchByLastStatus(Status.COMPLETED);
    setRxRequestSearchByChasisNoStatus(Status.COMPLETED);
    //print(DateTime.now());
    if (offlineDataFiltered.length == 0) {
      Fluttertoast.showToast(msg: 'No data found');
    }
    // print('offline data ${offlineDataFiltered.length}');
  }

  void searchOfflineLastDigitDataHive(String lastDigit) {
    setRxRequestSearchByChasisNoStatus(Status.LOADING);
    setRxRequestSearchByLastStatus(Status.LOADING);
    // final hive = HiveService().myBox!;
    // print(hive.length);
    // print('searching');
    //offlineDataFiltered.clear();
    // for (int i = 0; i < hive.length; i++) {
    //   if (hive.getAt(i).lastDigit!.toLowerCase().contains(lastDigit)) {
    //     setRxRequestSearchByLastStatus(Status.COMPLETED);
    //     setRxRequestSearchByChasisNoStatus(Status.COMPLETED);
    //     print('offline data ${offlineDataFiltered.length}');
    //     offlineDataFiltered.add(VehicleModel(
    //       hive.getAt(i).iId ?? '',
    //       agreementNo: hive.getAt(i).agreementNo ?? '',
    //       bankName: hive.getAt(i).bankName ?? '',
    //       branch: hive.getAt(i).branch ?? '',
    //       callCenterNo1: hive.getAt(i).callCenterNo1 ?? '',
    //       callCenterNo1Name: hive.getAt(i).callCenterNo1Name ?? '',
    //       callCenterNo2: hive.getAt(i).callCenterNo2 ?? '',
    //       callCenterNo2Name: hive.getAt(i).callCenterNo2Name ?? '',
    //       chasisNo: hive.getAt(i).chasisNo ?? '',
    //       createdAt: hive.getAt(i).createdAt ?? '',
    //       customerName: hive.getAt(i).customerName ?? '',
    //       dataId: '',
    //       engineNo: hive.getAt(i).engineNo ?? '',
    //       fileName: hive.getAt(i).fileName ?? '',
    //       lastDigit: hive.getAt(i).lastDigit ?? '',
    //       loadStatus: hive.getAt(i).loadStatus ?? '',
    //       month: hive.getAt(i).month ?? '',
    //       regNo: hive.getAt(i).regNo ?? '',
    //       status: hive.getAt(i).status ?? '',
    //       updatedAt: hive.getAt(i).updatedAt ?? '',
    //     ));
    //   }
    // }

    // print('search complete');
    print('hive length - ${HiveService().myBox!.length}');

    offlineDataFiltered.value = HiveService()
        .myBox!
        .values
        .where((p0) => p0.lastDigit!.toLowerCase().contains(lastDigit))
        .toList();
    print(offlineDataFiltered.length);

    setRxRequestSearchByChasisNoStatus(Status.COMPLETED);
    setRxRequestSearchByLastStatus(Status.COMPLETED);
  }

  Future searchOfflineChasisData(String chasisNo) async {
    setRxRequestSearchByChasisNoStatus(Status.LOADING);
    offlineDataFiltered.value = await vdb.fetchByChasis(chasisNo);

    // offlineDataFiltered.value = offlineData
    //     .where((p0) => p0.chasisNo!.toLowerCase().contains(chasisNo))
    //     .toList();
    setRxRequestSearchByChasisNoStatus(Status.COMPLETED);
    print('offline data ${offlineDataFiltered.length}');
    if (offlineDataFiltered.length == 0) {
      Fluttertoast.showToast(msg: 'No data found');
    }
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

      firstHalf.clear();
      secondHalf.clear();

      int length = searchbyChasisNoModel.value.data!.length;
      int halfLength = (searchbyChasisNoModel.value.data!.length / 2).round();

      for (int i = 0; i < halfLength; i++) {
        firstHalf.add(searchbyChasisNoModel.value.data![i]);
      }

      for (int i = halfLength + 1; i < length; i++) {
        secondHalf.add(searchbyChasisNoModel.value.data![i]);
      }
    }).onError((error, stackTrace) {
      // print(stackTrace);
      // print('--------------------');
      // print(error);
      setRxRequestSearchByChasisNoStatus(Status.ERROR);
    });
  }

  Future<SeezerModel> _getAllSeezerApi() async {
    setRxRequestSearchByChasisNoStatus(Status.LOADING);
    var response = await _api.getApi(ApiEndpoints.getAllRepoAgents);

    print(response);

    return SeezerModel.fromJson(response);
  }

  void getAllSeezerData() {
    _getAllSeezerApi().then((value) {
      setSeezerModel(value);
      if (value.agents != null) {
        selectedSeezer.value = value.agents![0].sId!;
      }
      setRxSeezerListStatus(Status.COMPLETED);
    }).onError((error, stackTrace) {
      // print(stackTrace);
      // print('--------------------');
      // print(error);
      setRxSeezerListStatus(Status.ERROR);
    });
  }

  Future<void> updateVehicleHoldRepo(
      BuildContext context, String id, bool isStaff) async {
    var url = Uri.parse(!isStaff
        ? '${ApiEndpoints.changeVehicleStatusByStaff}$id'
        : '${ApiEndpoints.holdvehicleByrepoagent}');

    print(url);

    var token = await Helper.getStringPreferences('token');
    print(token);
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      var data = null;
      if (isStaff)
        data = {
          "id": id,
          "loadStatus": selectedLoadStatus.value,
          "loadItem": loadItemCont.value.text
        };
      if (!isStaff)
        data = {
          "status": "hold",
          "loadStatus": selectedLoadStatus.value,
          "loadItem": loadItemCont.value.text,
          "seezerId": selectedSeezer.value
        };
      print(data);
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
      Get.back();

      if (response.statusCode == 200) {
        // Handle success
        Fluttertoast.showToast(msg: 'Status Updated Sucessfully');
      } else {
        // Handle other status codes or errors
      }
    } catch (error) {
      Fluttertoast.showToast(msg: 'Status not Updated');
      Get.back();

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

    String lat = await Helper.getStringPreferences(SharedPreferencesVar.lat);
    String longi = await Helper.getStringPreferences(SharedPreferencesVar.long);
    var body = {"latitude": lat, "longitude": longi};
    print(body);
    try {
      var response = await http.put(
        url,
        body: jsonEncode(body),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
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
      Fluttertoast.showToast(msg: 'Message sending failed');

      print('Error: $error');
      // Handle error
    }
  }
}
