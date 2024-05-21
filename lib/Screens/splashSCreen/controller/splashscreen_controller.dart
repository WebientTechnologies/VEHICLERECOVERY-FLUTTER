import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vinayak/Screens/searchVehicle/controller/searchController.dart';
import 'package:vinayak/Screens/splashSCreen/model/vehicledata_model.dart';
import 'package:vinayak/core/constants/helper.dart';
import 'package:vinayak/core/constants/shared_preferences_var.dart';
import 'package:vinayak/core/global_controller/user_controller.dart';
import 'package:vinayak/core/network/network_api.dart';
import 'package:vinayak/core/sqlite/vehicledb.dart';
import 'package:http/http.dart' as http;
import '../../../core/constants/api_endpoints.dart';
import '../../../core/global_controller/hive_service.dart';
import '../../../core/response/status.dart';
import '../../../core/sqlite/database_helper.dart';
import '../../../routes/app_routes.dart';
import '../../1RepoStaff/homeR/homeRepo.dart';
import '../../HomeScreen/model/vehicle_single_modelss.dart';
import '../../HomeScreen/model/vehicle_sm_hive.dart';
import '../../searchVehicle/model/searchLastmodel.dart';

class SplashScreenController extends GetxController {
  final _api = NetworkApi();

  RxBool loadAllData = false.obs;
  RxBool loadPartialData = true.obs;
  RxInt totalPages = 0.obs;
  RxInt currentPage = 1.obs;
  RxInt totalData = 0.obs;
  RxInt downloadedData = 0.obs;

  UserController uc = Get.put(UserController(), permanent: true);

  final rxRequestStatus = Status.LOADING.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  final getSearchByLastDigitModel = VehicleDataModel().obs;
  void setDashboardList(VehicleDataModel value) =>
      getSearchByLastDigitModel.value = value;

  Future<VehicleDataModel> getAllDashboardApi(int pageNo, int limit) async {
    // setRxRequestZoneStatus(Status.LOADING);
    var response = await _api
        .getApi('${ApiEndpoints.getAllVehicleData}?page=$pageNo&limit=$limit');

    print(response);

    return VehicleDataModel.fromJson(response);
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future _updateNotification(int totalData, int uploadedData) async {
    // int offlineCount =
    //     await Helper.getIntPreferences(SharedPreferencesVar.offlineCount);
    String title = 'Downloading data (' +
        (uploadedData / totalData * 100).toStringAsFixed(2) +
        '%)';
    String content = "Downloaded $uploadedData of $totalData data";
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      content,
      NotificationDetails(
        android: AndroidNotificationDetails('channel_id', 'channel_name',
            channelDescription: 'channel_description',
            importance: Importance.min,
            priority: Priority.min,
            ongoing: true,
            showProgress: true,
            maxProgress: totalData,
            progress: uploadedData,
            playSound: false,
            enableVibration: false),
      ),
    );
  }

  void getAllDashboardApiData(int pageNo) {
    getAllDashboardApi(pageNo, 35000).then((value) async {
      setDashboardList(value);
      downloadedData.value =
          await Helper.getIntPreferences(SharedPreferencesVar.offlineCount);
      await Helper.setIntPreferences(
          SharedPreferencesVar.offlinePageNumber, currentPage.value);

      final vehicleDb = VehicleDb();
      totalData.value = getSearchByLastDigitModel.value.totalRecords!;
      totalPages.value = getSearchByLastDigitModel.value.totalPages!;

      if (getSearchByLastDigitModel.value.data != null) {
        downloadedData.value += getSearchByLastDigitModel.value.data!.length;
        await Helper.setIntPreferences(
            SharedPreferencesVar.offlineCount, downloadedData.value);
        final db = await DatabaseHelper().database;
        var batch = db.batch();
        await db.transaction((txn) async {
          for (int i = 0;
              i < getSearchByLastDigitModel.value.data!.length;
              i++) {
            txn.rawInsert('''
          INSERT OR REPLACE INTO vehicles (dataId,loadStatus,bankName,branch,agreementNo,customerName,regNo,chasisNo,engineNo,callCenterNo1,callCenterNo1Name,callCenterNo2,callCenterNo2Name,lastDigit,month,status,fileName,createdAt,updatedAt) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
         ''', [
              getSearchByLastDigitModel.value.data![i].sId!,
              getSearchByLastDigitModel.value.data![i].loadStatus,
              getSearchByLastDigitModel.value.data![i].bankName,
              getSearchByLastDigitModel.value.data![i].branch,
              getSearchByLastDigitModel.value.data![i].agreementNo,
              getSearchByLastDigitModel.value.data![i].customerName,
              getSearchByLastDigitModel.value.data![i].regNo,
              getSearchByLastDigitModel.value.data![i].chasisNo,
              getSearchByLastDigitModel.value.data![i].engineNo,
              getSearchByLastDigitModel.value.data![i].callCenterNo1,
              getSearchByLastDigitModel.value.data![i].callCenterNo1Name,
              getSearchByLastDigitModel.value.data![i].callCenterNo2,
              getSearchByLastDigitModel.value.data![i].callCenterNo2Name,
              getSearchByLastDigitModel.value.data![i].lastDigit,
              getSearchByLastDigitModel.value.data![i].month,
              getSearchByLastDigitModel.value.data![i].status,
              getSearchByLastDigitModel.value.data![i].fileName,
              getSearchByLastDigitModel.value.data![i].createdAt,
              getSearchByLastDigitModel.value.data![i].updatedAt
            ]);

            // batch.rawInsert('');

            // await vehicleDb.insertVehicle(
            //     getSearchByLastDigitModel.value.data![i].sId!,
            //     getSearchByLastDigitModel.value.data![i].loadStatus,
            //     getSearchByLastDigitModel.value.data![i].bankName,
            //     getSearchByLastDigitModel.value.data![i].branch,
            //     getSearchByLastDigitModel.value.data![i].agreementNo,
            //     getSearchByLastDigitModel.value.data![i].customerName,
            //     getSearchByLastDigitModel.value.data![i].regNo,
            //     getSearchByLastDigitModel.value.data![i].chasisNo,
            //     getSearchByLastDigitModel.value.data![i].engineNo,
            //     getSearchByLastDigitModel.value.data![i].callCenterNo1,
            //     getSearchByLastDigitModel.value.data![i].callCenterNo1Name,
            //     getSearchByLastDigitModel.value.data![i].callCenterNo2,
            //     getSearchByLastDigitModel.value.data![i].callCenterNo2Name,
            //     getSearchByLastDigitModel.value.data![i].lastDigit,
            //     getSearchByLastDigitModel.value.data![i].month,
            //     getSearchByLastDigitModel.value.data![i].status,
            //     getSearchByLastDigitModel.value.data![i].fileName,
            //     getSearchByLastDigitModel.value.data![i].createdAt,
            //     getSearchByLastDigitModel.value.data![i].updatedAt);
          }
        });
        await _updateNotification(totalData.value, downloadedData.value);
        if (currentPage.value % 10 == 0 && currentPage.value != 0) {
          await DefaultCacheManager().emptyCache();
          await db.execute('VACUUM');
        }

        //await batch.commit();
      }

      await Helper.setIntPreferences(
          SharedPreferencesVar.currentPage, currentPage.value);

      if (currentPage.value >= totalPages.value ||
          downloadedData.value >= totalData.value) {
        var now = DateTime.now();
        var formatter = DateFormat('yyyy-MM-dd');
        String formattedDate = formatter.format(now);
        dynamic currentTime = DateFormat.jm().format(DateTime.now());

        print(formattedDate);

        await Helper.setIntPreferences(
            SharedPreferencesVar.totalData, totalData.value);
        await Helper.setStringPreferences(
            SharedPreferencesVar.lastUpdateDate, formattedDate);
        await Helper.setStringPreferences(
            SharedPreferencesVar.lastUpdateTime, currentTime);

        // if (uc.userDetails['role'] == 'repo-agent') {
        //   Get.offAll(HomeScreenRepoStaff());
        // } else {
        //   Get.toNamed(AppRoutes.home);
        // }
        setRxRequestStatus(Status.COMPLETED);
      } else {
        currentPage.value++;
        if (getSearchByLastDigitModel.value.data != null) {
          getAllDashboardApiData(currentPage.value);
        }
      }

      // await flutterLocalNotificationsPlugin.show(
      //   0,
      //   'Data downloaded',
      //   "Data downloaded successfully",
      //   const NotificationDetails(
      //     android: AndroidNotificationDetails('channel_id', 'channel_name',
      //         channelDescription: 'channel_description',
      //         importance: Importance.min,
      //         priority: Priority.min,
      //         ongoing: true,
      //         playSound: false,
      //         enableVibration: false),
      //   ),
      // );
    }).onError((error, stackTrace) async {
      print(stackTrace);
      print('--------------------');
      print(error);
      await flutterLocalNotificationsPlugin.show(
        0,
        'Error while downloading data',
        "Data downloaded failed",
        const NotificationDetails(
          android: AndroidNotificationDetails('channel_id', 'channel_name',
              channelDescription: 'channel_description',
              importance: Importance.min,
              priority: Priority.min,
              ongoing: true,
              playSound: false,
              enableVibration: false),
        ),
      );
    });
  }

  void getAllDashboardApiDataPeriodically(int pageNo) {
    getAllDashboardApi(pageNo, 1000).then((value) async {
      setDashboardList(value);
      downloadedData.value =
          await Helper.getIntPreferences(SharedPreferencesVar.offlineCount);
      await Helper.setIntPreferences(
          SharedPreferencesVar.offlinePageNumber, currentPage.value);

      final vehicleDb = VehicleDb();
      totalData.value = getSearchByLastDigitModel.value.totalRecords!;
      totalPages.value = getSearchByLastDigitModel.value.totalPages!;

      if (getSearchByLastDigitModel.value.data != null) {
        for (int i = 0; i < getSearchByLastDigitModel.value.data!.length; i++) {
          downloadedData.value++;
          await Helper.setIntPreferences(
              SharedPreferencesVar.offlineCount, downloadedData.value);
          await vehicleDb.insertVehicle(
              getSearchByLastDigitModel.value.data![i].sId!,
              getSearchByLastDigitModel.value.data![i].loadStatus,
              getSearchByLastDigitModel.value.data![i].bankName,
              getSearchByLastDigitModel.value.data![i].branch,
              getSearchByLastDigitModel.value.data![i].agreementNo,
              getSearchByLastDigitModel.value.data![i].customerName,
              getSearchByLastDigitModel.value.data![i].regNo,
              getSearchByLastDigitModel.value.data![i].chasisNo,
              getSearchByLastDigitModel.value.data![i].engineNo,
              getSearchByLastDigitModel.value.data![i].callCenterNo1,
              getSearchByLastDigitModel.value.data![i].callCenterNo1Name,
              getSearchByLastDigitModel.value.data![i].callCenterNo2,
              getSearchByLastDigitModel.value.data![i].callCenterNo2Name,
              getSearchByLastDigitModel.value.data![i].lastDigit,
              getSearchByLastDigitModel.value.data![i].month,
              getSearchByLastDigitModel.value.data![i].status,
              getSearchByLastDigitModel.value.data![i].fileName,
              getSearchByLastDigitModel.value.data![i].createdAt,
              getSearchByLastDigitModel.value.data![i].updatedAt);
          // _updateNotification(totalData.value, downloadedData.value);
        }
      }

      //if (totalPages == currentPage) {
      var now = DateTime.now();
      var formatter = DateFormat('yyyy-MM-dd');
      String formattedDate = formatter.format(now);
      dynamic currentTime = DateFormat.jm().format(DateTime.now());

      //print(formattedDate);

      int currPage = currentPage.value++;
      //print('ddddd - $currPage');

      await Helper.setIntPreferences(
          SharedPreferencesVar.currentPage, currPage);
      await Helper.setIntPreferences(
          SharedPreferencesVar.totalData, totalData.value);
      await Helper.setStringPreferences(
          SharedPreferencesVar.lastUpdateDate, formattedDate);
      await Helper.setStringPreferences(
          SharedPreferencesVar.lastUpdateTime, currentTime);

      // if (uc.userDetails['role'] == 'repo-agent') {
      //   Get.offAll(HomeScreenRepoStaff());
      // } else {
      //   Get.toNamed(AppRoutes.home);
      // }
      // setRxRequestStatus(Status.COMPLETED);
      // } else {
      //   currentPage.value++;
      //   if (getSearchByLastDigitModel.value.data != null) {
      //     getAllDashboardApiData(currentPage.value);
      //   }
      // }

      // await flutterLocalNotificationsPlugin.show(
      //   0,
      //   'Data downloaded',
      //   "Data downloaded successfully",
      //   const NotificationDetails(
      //     android: AndroidNotificationDetails('channel_id', 'channel_name',
      //         channelDescription: 'channel_description',
      //         importance: Importance.min,
      //         priority: Priority.min,
      //         ongoing: true,
      //         playSound: false,
      //         enableVibration: false),
      //   ),
      // );
    }).onError((error, stackTrace) async {
      print(stackTrace);
      print('--------------------');
      print(error);
      await flutterLocalNotificationsPlugin.show(
        0,
        'Error while downloading data',
        "Data downloaded failed",
        const NotificationDetails(
          android: AndroidNotificationDetails('channel_id', 'channel_name',
              channelDescription: 'channel_description',
              importance: Importance.min,
              priority: Priority.min,
              ongoing: true,
              playSound: false,
              enableVibration: false),
        ),
      );
    });
  }

  Future<void> downloadData() async {
    print('downloading - ${DateTime.now()}');
    await flutterLocalNotificationsPlugin.show(
      0,
      'Downloading',
      'Downloading Data',
      NotificationDetails(
        android: AndroidNotificationDetails('channel_id', 'channel_name',
            channelDescription: 'channel_description',
            importance: Importance.min,
            priority: Priority.min,
            ongoing: true,
            playSound: false,
            enableVibration: false),
      ),
    );
    //print(DateTime.now());
    final response =
        await http.get(Uri.parse('http://93.127.195.102/downloads/export.zip'));

    try {
      if (response.statusCode == 200) {
        Directory appDocumentsDirectory =
            await getApplicationDocumentsDirectory();
        //print(appDocumentsDirectory.path);
        final file = File('${appDocumentsDirectory.path}/export.zip');
        await file.writeAsBytes(response.bodyBytes);
        //print('File downloaded to: ${appDocumentsDirectory.path}');
        final directory = Directory(appDocumentsDirectory.path);
        // List<FileSystemEntity> files = await directory.list().toList();
        // for (var file in files) {
        //   print(file.path);
        // }
        await flutterLocalNotificationsPlugin.show(
          0,
          'Extracting Data',
          '',
          NotificationDetails(
            android: AndroidNotificationDetails('channel_id', 'channel_name',
                channelDescription: 'channel_description',
                importance: Importance.min,
                priority: Priority.min,
                ongoing: true,
                playSound: false,
                enableVibration: false),
          ),
        );
        try {
          await ZipFile.extractToDirectory(
            zipFile: file,
            destinationDir: appDocumentsDirectory,
          );
          print('File extracted successfully.');
        } catch (e) {
          await flutterLocalNotificationsPlugin.show(
            0,
            'Error extracting file',
            '$e',
            NotificationDetails(
              android: AndroidNotificationDetails('channel_id', 'channel_name',
                  channelDescription: 'channel_description',
                  importance: Importance.min,
                  priority: Priority.min,
                  ongoing: true,
                  playSound: false,
                  enableVibration: false),
            ),
          );
          print('Error extracting file: $e');
        }
        await file.delete();
        await DefaultCacheManager().emptyCache();

        await flutterLocalNotificationsPlugin.show(
          0,
          'Compiling Resources',
          '',
          NotificationDetails(
            android: AndroidNotificationDetails('channel_id', 'channel_name',
                channelDescription: 'channel_description',
                importance: Importance.min,
                priority: Priority.min,
                ongoing: true,
                playSound: false,
                enableVibration: false),
          ),
        );

        await DefaultCacheManager().emptyCache();

        final jsonFile = File('${appDocumentsDirectory.path}/export.json');

        Stream<String> f = jsonFile
            .openRead()
            .transform(utf8.decoder)
            .transform(LineSplitter());
        int i = 0;
        await f.forEach((String line) async {
          i++;
          VehicleSingleModelss vsm =
              VehicleSingleModelss.fromJson(jsonDecode(line));

          try {
            HiveService().myBox!.add(VehicleSingleModel(
                vsm.iId!.oid ?? '',
                vsm.bankName ?? '',
                vsm.branch ?? '',
                vsm.agreementNo ?? '',
                vsm.customerName ?? '',
                vsm.regNo ?? '',
                vsm.chasisNo ?? '',
                vsm.engineNo ?? '',
                vsm.maker ?? '',
                vsm.dlCode ?? '',
                vsm.bucket ?? '',
                vsm.emi ?? '',
                vsm.color ?? '',
                vsm.callCenterNo1 ?? '',
                vsm.callCenterNo1Name ?? '',
                vsm.callCenterNo2 ?? '',
                vsm.callCenterNo2Name ?? '',
                vsm.lastDigit ?? '',
                vsm.month ?? '',
                vsm.status ?? '',
                vsm.loadStatus ?? '',
                vsm.fileName ?? '',
                vsm.iV ?? 0,
                vsm.createdAt!.date ?? '',
                vsm.updatedAt!.date ?? ''));

            int length = await f.length;

            await flutterLocalNotificationsPlugin.show(
              0,
              'Compiling Resources',
              '',
              NotificationDetails(
                android: AndroidNotificationDetails(
                    'channel_id', 'channel_name',
                    channelDescription: 'channel_description',
                    progress: i,
                    maxProgress: length,
                    playSound: false,
                    enableVibration: false),
              ),
            );
          } catch (e) {
            Fluttertoast.showToast(msg: 'Compiling Resources Failed');
            await flutterLocalNotificationsPlugin.show(
              0,
              'Compiling Resources Failed',
              '$e',
              NotificationDetails(
                android: AndroidNotificationDetails(
                    'channel_id', 'channel_name',
                    channelDescription: 'channel_description',
                    importance: Importance.min,
                    priority: Priority.min,
                    ongoing: true,
                    playSound: false,
                    enableVibration: false),
              ),
            );
          }

          // Insert batch into the database when it reaches the batch size
        });

        await DefaultCacheManager().emptyCache();
        //await jsonFile.delete();

        VehicleSearchController sc = Get.put(VehicleSearchController());
        sc.offlineDataCount.value = HiveService().myBox!.length;
        //sc.offlineDataHive.value = HiveService().myBox;

        var now = DateTime.now();
        var formatter = DateFormat('yyyy-MM-dd');
        String formattedDate = formatter.format(now);
        dynamic currentTime = DateFormat.jm().format(DateTime.now());

        await Helper.setStringPreferences(
            SharedPreferencesVar.lastUpdateDate, formattedDate);
        await Helper.setStringPreferences(
            SharedPreferencesVar.lastUpdateTime, currentTime);

        await flutterLocalNotificationsPlugin.show(
          0,
          'Downloaded Successfully',
          'Downloading Complete',
          NotificationDetails(
            android: AndroidNotificationDetails('channel_id', 'channel_name',
                channelDescription: 'channel_description',
                importance: Importance.max,
                priority: Priority.high,
                ongoing: true,
                playSound: false,
                enableVibration: false),
          ),
        );

        print('downloading complete - ${DateTime.now()}');
      } else {
        await flutterLocalNotificationsPlugin.show(
          0,
          'Error',
          'Error Downloading Data',
          NotificationDetails(
            android: AndroidNotificationDetails('channel_id', 'channel_name',
                channelDescription: 'channel_description',
                importance: Importance.min,
                priority: Priority.min,
                ongoing: true,
                playSound: false,
                enableVibration: false),
          ),
        );
        throw Exception('Failed to download file');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }

    print(DateTime.now());
  }

  Future<List<Map<String, dynamic>>> parseJsonLinesFile(String filePath) async {
    try {
      final file = File(filePath);
      List<Map<String, dynamic>> jsonDataList = [];

      await for (String line in file
          .openRead()
          .transform(utf8.decoder)
          .transform(LineSplitter())) {
        final jsonData = jsonDecode(line);
        jsonDataList.add(jsonData);
      }

      return jsonDataList;
    } catch (e) {
      print('Error parsing JSON lines file: $e');
      return [];
    }
  }
}
