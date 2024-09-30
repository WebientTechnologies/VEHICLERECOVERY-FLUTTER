import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vinayak/Screens/HomeScreen/model/vehicle_single_modelss.dart';
import 'package:vinayak/Screens/searchVehicle/model/seezer_model.dart';
import 'package:vinayak/core/constants/shared_preferences_var.dart';
import 'package:vinayak/core/network/network_api.dart';
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
    print(DateTime.now());
    getAllSearchByLastDigitApi(lastDigit).then((value) {
      setRxRequestSearchByLastStatus(Status.COMPLETED);
      setsearchbylastList(value);

      firstHalf.clear();
      secondHalf.clear();

      int mid = (searchbylastModel.value.data!.length / 2).ceil();

      firstHalf = searchbylastModel.value.data!.sublist(0, mid);
      secondHalf = searchbylastModel.value.data!.sublist(mid);

      try {
        GetSearchByLastDigitModel ld = GetSearchByLastDigitModel.fromJson({
          "data": [{}]
        });

        if (firstHalf.length > secondHalf.length) {
          secondHalf.add(ld.data![0]);
        } else if (secondHalf.length > firstHalf.length) {
          firstHalf.add(ld.data![0]);
        }
      } catch (e, s) {
        print(e);
        print("---");
        print(s);
      }
      print(DateTime.now());
    }).onError((error, stackTrace) {
      // print(stackTrace);
      // print('--------------------');
      // print(error);
      setRxRequestSearchByLastStatus(Status.ERROR);
    });
  }

  var offlinefirstHalf = [];
  var offlinesecondHalf = [];

  void searchOfflineLastDigitData(String lastDigit) async {
    setRxRequestSearchByChasisNoStatus(Status.LOADING);
    setRxRequestSearchByLastStatus(Status.LOADING);
    print(DateTime.now());

    offlineDataFiltered.value = await vdb.fetchByReg(lastDigit);

    offlinefirstHalf.clear();
    offlinesecondHalf.clear();

    int mid = (offlineDataFiltered.length / 2).ceil();

    offlinefirstHalf = offlineDataFiltered.sublist(0, mid);
    offlinesecondHalf = offlineDataFiltered.sublist(mid);

    try {
      GetSearchByLastDigitModel ld = GetSearchByLastDigitModel.fromJson({
        "data": [{}]
      });

      if (offlinefirstHalf.length > offlinesecondHalf.length) {
        offlinesecondHalf.add(ld.data![0]);
      } else if (offlinesecondHalf.length > offlinefirstHalf.length) {
        offlinefirstHalf.add(ld.data![0]);
      }
    } catch (e, s) {
      print(e);
      print("---");
      print(s);
    }

    setRxRequestSearchByLastStatus(Status.COMPLETED);
    print(DateTime.now());

    //setRxRequestSearchByChasisNoStatus(Status.COMPLETED);
    //print(DateTime.now());
    if (offlineDataFiltered.length == 0) {
      Fluttertoast.showToast(msg: 'No data found');
    }
    // print('offline data ${offlineDataFiltered.length}');
  }

  Future searchOfflineChasisData(String chasisNo) async {
    setRxRequestSearchByChasisNoStatus(Status.LOADING);
    offlineDataFiltered.value = await vdb.fetchByChasis(chasisNo);

    int mid = (offlineDataFiltered.length / 2).ceil();

    offlinefirstHalf = offlineDataFiltered.sublist(0, mid);
    offlinesecondHalf = offlineDataFiltered.sublist(mid);

    try {
      GetSearchByLastDigitModel ld = GetSearchByLastDigitModel.fromJson({
        "data": [{}]
      });

      if (offlinefirstHalf.length > offlinesecondHalf.length) {
        offlinesecondHalf.add(ld.data![0]);
      } else if (offlinesecondHalf.length > offlinefirstHalf.length) {
        offlinefirstHalf.add(ld.data![0]);
      }
    } catch (e, s) {
      print(e);
      print("---");
      print(s);
    }

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

      int mid = (searchbyChasisNoModel.value.data!.length / 2).ceil();

      firstHalf = searchbyChasisNoModel.value.data!.sublist(0, mid);
      secondHalf = searchbyChasisNoModel.value.data!.sublist(mid);

      try {
        GetSearchByLastDigitModel ld = GetSearchByLastDigitModel.fromJson({
          "data": [{}]
        });

        if (firstHalf.length > secondHalf.length) {
          secondHalf.add(ld.data![0]);
        } else if (secondHalf.length > firstHalf.length) {
          firstHalf.add(ld.data![0]);
        }
      } catch (e, s) {
        print(e);
        print("---");
        print(s);
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
      print(stackTrace);
      print('--------------------');
      print(error);
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
      double lat = await Helper.getDoublePreferences(SharedPreferencesVar.lat);
      double long =
          await Helper.getDoublePreferences(SharedPreferencesVar.long);
      var data = null;
      if (isStaff)
        data = {
          "id": id,
          "loadStatus": selectedLoadStatus.value,
          "loadItem": loadItemCont.value.text,
          "latitude": lat,
          "longitude": long,
        };
      if (!isStaff)
        data = {
          "status": "hold",
          "loadStatus": selectedLoadStatus.value,
          "loadItem": loadItemCont.value.text,
          "seezerId": selectedSeezer.value,
          "latitude": lat,
          "longitude": long,
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

    double lat = await Helper.getDoublePreferences(SharedPreferencesVar.lat);
    double longi = await Helper.getDoublePreferences(SharedPreferencesVar.long);
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
        //Fluttertoast.showToast(msg: 'Vehicle status updated to search');
      } else {
        // Handle other status codes or errors
      }
    } catch (error) {
      Fluttertoast.showToast(msg: 'something went wrong');

      print('Error: $error');
      // Handle error
    }
  }
}
