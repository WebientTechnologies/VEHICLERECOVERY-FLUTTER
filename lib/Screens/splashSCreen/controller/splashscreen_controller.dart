import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vinayak/Screens/1RepoStaff/homeR/controller/dashboard_controller.dart';
import 'package:vinayak/Screens/HomeScreen/controller/homeController.dart';
import 'package:vinayak/Screens/searchVehicle/controller/searchController.dart';
import 'package:vinayak/Screens/splashSCreen/model/vehicledata_model.dart';
import 'package:vinayak/core/constants/helper.dart';
import 'package:vinayak/core/constants/shared_preferences_var.dart';
import 'package:vinayak/core/global_controller/user_controller.dart';
import 'package:vinayak/core/network/network_api.dart';
import 'package:vinayak/core/sqlite/vehicledb.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/response/status.dart';
import '../../1RepoStaff/homeR/controller/repoHomeController.dart';

class SplashScreenController extends GetxController {
  final _api = NetworkApi();

  RxBool loadAllData = false.obs;
  RxBool loadPartialData = true.obs;
  RxInt totalPages = 0.obs;
  RxInt currentPage = 1.obs;
  RxInt totalData = 0.obs;
  RxInt downloadedData = 0.obs;
  RxBool isDownloading = false.obs;
  RxDouble progress = 0.0.obs;
  RxString progressString = "".obs;

  UserController uc = Get.put(UserController(), permanent: true);

  final rxRequestStatus = Status.LOADING.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  final getSearchByLastDigitModel = VehicleDataModel().obs;
  void setDashboardList(VehicleDataModel value) =>
      getSearchByLastDigitModel.value = value;

  Future<VehicleDataModel> getAllDashboardApi(
      BuildContext context, String lastId, int limit) async {
    // setRxRequestZoneStatus(Status.LOADING);

    var response =
        await _api.getApi('${ApiEndpoints.getAllVehicleData}?lastId=$lastId');

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

  // void getAllDashboardApiData(BuildContext context, String lastId) {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       });

  //   getAllDashboardApi(context, lastId, 35000).then((value) async {
  //     setDashboardList(value);
  //     downloadedData.value =
  //         await Helper.getIntPreferences(SharedPreferencesVar.offlineCount);
  //     await Helper.setIntPreferences(
  //         SharedPreferencesVar.offlinePageNumber, currentPage.value);

  //     final vehicleDb = VehicleDb();
  //     totalData.value = getSearchByLastDigitModel.value.totalRecords!;
  //     totalPages.value = getSearchByLastDigitModel.value.totalPages!;

  //     if (getSearchByLastDigitModel.value.data != null) {
  //       downloadedData.value += getSearchByLastDigitModel.value.data!.length;
  //       await Helper.setIntPreferences(
  //           SharedPreferencesVar.offlineCount, downloadedData.value);
  //       final db = await DatabaseHelper().database;
  //       var batch = db.batch();
  //       await db.transaction((txn) async {
  //         for (int i = 0;
  //             i < getSearchByLastDigitModel.value.data!.length;
  //             i++) {
  //           txn.rawInsert('''
  //         INSERT OR REPLACE INTO vehicles (dataId,loadStatus,bankName,branch,agreementNo,customerName,regNo,chasisNo,engineNo,callCenterNo1,callCenterNo1Name,callCenterNo2,callCenterNo2Name,lastDigit,month,status,fileName,createdAt,updatedAt) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
  //        ''', [
  //             getSearchByLastDigitModel.value.data![i].sId!,
  //             getSearchByLastDigitModel.value.data![i].loadStatus,
  //             getSearchByLastDigitModel.value.data![i].bankName,
  //             getSearchByLastDigitModel.value.data![i].branch,
  //             getSearchByLastDigitModel.value.data![i].agreementNo,
  //             getSearchByLastDigitModel.value.data![i].customerName,
  //             getSearchByLastDigitModel.value.data![i].regNo,
  //             getSearchByLastDigitModel.value.data![i].chasisNo,
  //             getSearchByLastDigitModel.value.data![i].engineNo,
  //             getSearchByLastDigitModel.value.data![i].callCenterNo1,
  //             getSearchByLastDigitModel.value.data![i].callCenterNo1Name,
  //             getSearchByLastDigitModel.value.data![i].callCenterNo2,
  //             getSearchByLastDigitModel.value.data![i].callCenterNo2Name,
  //             getSearchByLastDigitModel.value.data![i].lastDigit,
  //             getSearchByLastDigitModel.value.data![i].month,
  //             getSearchByLastDigitModel.value.data![i].status,
  //             getSearchByLastDigitModel.value.data![i].fileName,
  //             getSearchByLastDigitModel.value.data![i].createdAt,
  //             getSearchByLastDigitModel.value.data![i].updatedAt
  //           ]);

  //           // batch.rawInsert('');

  //           // await vehicleDb.insertVehicle(
  //           //     getSearchByLastDigitModel.value.data![i].sId!,
  //           //     getSearchByLastDigitModel.value.data![i].loadStatus,
  //           //     getSearchByLastDigitModel.value.data![i].bankName,
  //           //     getSearchByLastDigitModel.value.data![i].branch,
  //           //     getSearchByLastDigitModel.value.data![i].agreementNo,
  //           //     getSearchByLastDigitModel.value.data![i].customerName,
  //           //     getSearchByLastDigitModel.value.data![i].regNo,
  //           //     getSearchByLastDigitModel.value.data![i].chasisNo,
  //           //     getSearchByLastDigitModel.value.data![i].engineNo,
  //           //     getSearchByLastDigitModel.value.data![i].callCenterNo1,
  //           //     getSearchByLastDigitModel.value.data![i].callCenterNo1Name,
  //           //     getSearchByLastDigitModel.value.data![i].callCenterNo2,
  //           //     getSearchByLastDigitModel.value.data![i].callCenterNo2Name,
  //           //     getSearchByLastDigitModel.value.data![i].lastDigit,
  //           //     getSearchByLastDigitModel.value.data![i].month,
  //           //     getSearchByLastDigitModel.value.data![i].status,
  //           //     getSearchByLastDigitModel.value.data![i].fileName,
  //           //     getSearchByLastDigitModel.value.data![i].createdAt,
  //           //     getSearchByLastDigitModel.value.data![i].updatedAt);
  //         }
  //       });
  //       await _updateNotification(totalData.value, downloadedData.value);
  //       if (currentPage.value % 10 == 0 && currentPage.value != 0) {
  //         await DefaultCacheManager().emptyCache();
  //         await db.execute('VACUUM');
  //       }

  //       //await batch.commit();
  //     }

  //     await Helper.setIntPreferences(
  //         SharedPreferencesVar.currentPage, currentPage.value);

  //     if (currentPage.value >= totalPages.value ||
  //         downloadedData.value >= totalData.value) {
  //       var now = DateTime.now();
  //       var formatter = DateFormat('yyyy-MM-dd');
  //       String formattedDate = formatter.format(now);
  //       dynamic currentTime = DateFormat.jm().format(DateTime.now());

  //       print(formattedDate);

  //       await Helper.setIntPreferences(
  //           SharedPreferencesVar.totalData, totalData.value);
  //       await Helper.setStringPreferences(
  //           SharedPreferencesVar.lastUpdateDate, formattedDate);
  //       await Helper.setStringPreferences(
  //           SharedPreferencesVar.lastUpdateTime, currentTime);

  //       // if (uc.userDetails['role'] == 'repo-agent') {
  //       //   Get.offAll(HomeScreenRepoStaff());
  //       // } else {
  //       //   Get.toNamed(AppRoutes.home);
  //       // }
  //       setRxRequestStatus(Status.COMPLETED);
  //     } else {
  //       currentPage.value++;
  //       if (getSearchByLastDigitModel.value.data != null) {
  //         getAllDashboardApiData(context, currentPage.value);
  //       }
  //     }

  //     // await flutterLocalNotificationsPlugin.show(
  //     //   0,
  //     //   'Data downloaded',
  //     //   "Data downloaded successfully",
  //     //   const NotificationDetails(
  //     //     android: AndroidNotificationDetails('channel_id', 'channel_name',
  //     //         channelDescription: 'channel_description',
  //     //         importance: Importance.min,
  //     //         priority: Priority.min,
  //     //         ongoing: true,
  //     //         playSound: false,
  //     //         enableVibration: false),
  //     //   ),
  //     // );
  //   }).onError((error, stackTrace) async {
  //     print(stackTrace);
  //     print('--------------------');
  //     print(error);
  //     await flutterLocalNotificationsPlugin.show(
  //       0,
  //       'Error while downloading data',
  //       "Data downloaded failed",
  //       const NotificationDetails(
  //         android: AndroidNotificationDetails('channel_id', 'channel_name',
  //             channelDescription: 'channel_description',
  //             importance: Importance.min,
  //             priority: Priority.min,
  //             ongoing: true,
  //             playSound: false,
  //             enableVibration: false),
  //       ),
  //     );
  //   });
  // }

  void getAllDashboardApiDataPeriodically(
      BuildContext context, String lastId) async {
    final vehicleDb = VehicleDb();
    downloadedData.value = await vehicleDb.getOfflineCount();

    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    getAllDashboardApi(context, lastId, 5000).then((value) async {
      setDashboardList(value);
      // await Helper.setIntPreferences(
      //     SharedPreferencesVar.offlinePageNumber, currentPage.value);

      final vehicleDb = VehicleDb();
      totalData.value = getSearchByLastDigitModel.value.totalRecords ?? 0;
      totalPages.value = getSearchByLastDigitModel.value.totalPages ?? 0;

      if (getSearchByLastDigitModel.value.data != null) {
        for (int i = 0; i < getSearchByLastDigitModel.value.data!.length; i++) {
          downloadedData.value++;

          await vehicleDb.insertVehicle(
              getSearchByLastDigitModel.value.data![i].sId!,
              getSearchByLastDigitModel.value.data![i].bankName ?? '',
              getSearchByLastDigitModel.value.data![i].branch ?? '',
              getSearchByLastDigitModel.value.data![i].regNo ?? '',
              getSearchByLastDigitModel.value.data![i].loanNo ?? '',
              getSearchByLastDigitModel.value.data![i].customerName ?? '',
              getSearchByLastDigitModel.value.data![i].model ?? '',
              getSearchByLastDigitModel.value.data![i].maker ?? '',
              getSearchByLastDigitModel.value.data![i].chasisNo ?? '',
              getSearchByLastDigitModel.value.data![i].engineNo ?? '',
              getSearchByLastDigitModel.value.data![i].emi ?? '',
              getSearchByLastDigitModel.value.data![i].bucket ?? '',
              getSearchByLastDigitModel.value.data![i].pos ?? '',
              getSearchByLastDigitModel.value.data![i].tos ?? '',
              getSearchByLastDigitModel.value.data![i].allocation ?? '',
              getSearchByLastDigitModel.value.data![i].callCenterNo1 ?? '',
              getSearchByLastDigitModel.value.data![i].callCenterNo1Name ?? '',
              getSearchByLastDigitModel.value.data![i].callCenterNo1Email ?? '',
              getSearchByLastDigitModel.value.data![i].callCenterNo2 ?? '',
              getSearchByLastDigitModel.value.data![i].callCenterNo2Name ?? '',
              getSearchByLastDigitModel.value.data![i].callCenterNo2Email ?? '',
              getSearchByLastDigitModel.value.data![i].callCenterNo3 ?? '',
              getSearchByLastDigitModel.value.data![i].callCenterNo3Name ?? '',
              getSearchByLastDigitModel.value.data![i].callCenterNo3Email ?? '',
              getSearchByLastDigitModel.value.data![i].address ?? '',
              getSearchByLastDigitModel.value.data![i].sec17 ?? '',
              getSearchByLastDigitModel.value.data![i].agreementNo ?? '',
              getSearchByLastDigitModel.value.data![i].dlCode ?? '',
              getSearchByLastDigitModel.value.data![i].color ?? '',
              getSearchByLastDigitModel.value.data![i].lastDigit ?? '',
              getSearchByLastDigitModel.value.data![i].month ?? '',
              getSearchByLastDigitModel.value.data![i].status ?? '',
              '',
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

      //int currPage = currentPage.value++;
      //print('ddddd - $currPage');

      // await Helper.setIntPreferences(
      //     SharedPreferencesVar.currentPage, currPage);
      // await Helper.setIntPreferences(
      //     SharedPreferencesVar.totalData, totalData.value);
      VehicleSearchController sc = Get.put(VehicleSearchController());
      sc.offlineDataCount.value = await VehicleDb().getOfflineCount();
      await Helper.setStringPreferences(
          SharedPreferencesVar.lastUpdateDate, formattedDate);
      await Helper.setStringPreferences(
          SharedPreferencesVar.lastUpdateTime, currentTime);

      Get.back();

      DashboardController dc = Get.put(DashboardController());
      dc.blinkRefresh.value = false;

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

  Future<void> downloadData(BuildContext context) async {
    HomeController hcc = Get.put(HomeController());
    HomeRepoAgentController hc = Get.put(HomeRepoAgentController());
    if (!isDownloading.value) {
      isDownloading.value = true;
      print('downloading - ${DateTime.now()}');
      await flutterLocalNotificationsPlugin.show(
        0,
        'Downloading',
        'Downloading Data',
        NotificationDetails(
          android: AndroidNotificationDetails('channel_id', 'channel_name',
              channelDescription: 'channel_description',
              importance: Importance.high,
              priority: Priority.high,
              ongoing: true,
              playSound: true,
              enableVibration: true),
        ),
      );

      const url =
          'http://195.35.23.185/downloads/export.zip'; // Replace with your file URL
      final request = http.Request('GET', Uri.parse(url));
      final response = await http.Client().send(request);
      final contentLength = response.contentLength;

      if (response.statusCode == 200) {
        Directory appDocumentsDirectory =
            await getApplicationDocumentsDirectory();
        print(appDocumentsDirectory.path);
        final file = File('${appDocumentsDirectory.path}/export.zip');

        final bytes = <int>[];
        int downloadedBytes = 0;

        response.stream.listen(
          (newBytes) {
            bytes.addAll(newBytes);
            downloadedBytes += newBytes.length;
            progress.value = downloadedBytes / contentLength!;

            progressString.value = '${(progress * 100).toStringAsFixed(0)} %';
          },
          onDone: () async {
            await file.writeAsBytes(bytes);
            await DefaultCacheManager().emptyCache();
            progressString.value = "Extracting Data. Please wait..";
            await flutterLocalNotificationsPlugin.show(
              0,
              'Extracting Data',
              '',
              NotificationDetails(
                android: AndroidNotificationDetails(
                    'channel_id', 'channel_name',
                    channelDescription: 'channel_description',
                    importance: Importance.high,
                    priority: Priority.high,
                    ongoing: true,
                    playSound: true,
                    enableVibration: true),
              ),
            );

            try {
              await ZipFile.extractToDirectory(
                zipFile: file,
                destinationDir: appDocumentsDirectory,
              );
              print('File extracted successfully.');
            } catch (e) {
              print('Error extracting file: $e');
            }

            VehicleSearchController sc = Get.put(VehicleSearchController());
            sc.offlineDataCount.value = await VehicleDb().getOfflineCount();

            DashboardController dc = Get.put(DashboardController());
            dc.blinkRefresh.value = false;
            await VehicleDb().createIndex();

            var now = DateTime.now();
            var formatter = DateFormat('yyyy-MM-dd');
            String formattedDate = formatter.format(now);
            dynamic currentTime = DateFormat.jm().format(DateTime.now());

            await Helper.setStringPreferences(
                SharedPreferencesVar.lastUpdateDate, formattedDate);
            await Helper.setStringPreferences(
                SharedPreferencesVar.lastUpdateTime, currentTime);

            progressString.value = "Download Complete";
            isDownloading.value = false;

            await flutterLocalNotificationsPlugin.show(
              0,
              'Downloading Complete',
              '',
              NotificationDetails(
                android: AndroidNotificationDetails(
                    'channel_id', 'channel_name',
                    channelDescription: 'channel_description',
                    importance: Importance.high,
                    priority: Priority.high,
                    ongoing: true,
                    playSound: true,
                    enableVibration: true),
              ),
            );
          },
          onError: (error) {
            progressString.value = "Error: Something went wrong";

            print('Download error: $error');
          },
          cancelOnError: true,
        );
        //await file.writeAsBytes(response.bodyBytes);
      } else {
        isDownloading.value = false;

        await flutterLocalNotificationsPlugin.show(
          0,
          'Error',
          'Error Downloading Data',
          NotificationDetails(
            android: AndroidNotificationDetails('channel_id', 'channel_name',
                channelDescription: 'channel_description',
                importance: Importance.high,
                priority: Priority.high,
                ongoing: true,
                playSound: true,
                enableVibration: true),
          ),
        );
        throw Exception('Failed to download file');
      }
    } else {
      Fluttertoast.showToast(msg: 'Data is already downloading. Please wait');
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
