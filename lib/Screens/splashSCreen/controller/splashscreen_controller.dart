import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vinayak/Screens/splashSCreen/model/vehicledata_model.dart';
import 'package:vinayak/core/constants/helper.dart';
import 'package:vinayak/core/constants/shared_preferences_var.dart';
import 'package:vinayak/core/global_controller/user_controller.dart';
import 'package:vinayak/core/network/network_api.dart';
import 'package:vinayak/core/sqlite/vehicledb.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/response/status.dart';
import '../../../routes/app_routes.dart';
import '../../1RepoStaff/homeR/homeRepo.dart';
import '../../searchVehicle/model/searchLastmodel.dart';

class SplashScreenController extends GetxController {
  final _api = NetworkApi();

  RxBool loadAllData = false.obs;
  RxBool loadPartialData = true.obs;
  RxInt totalPages = 50.obs;
  RxInt currentPage = 1.obs;
  RxInt totalData = 5000.obs;
  RxInt downloadedData = 0.obs;

  UserController uc = Get.find<UserController>();

  final rxRequestStatus = Status.LOADING.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  final getSearchByLastDigitModel = VehicleDataModel().obs;
  void setDashboardList(VehicleDataModel value) =>
      getSearchByLastDigitModel.value = value;

  Future<VehicleDataModel> getAllDashboardApi(int pageNo) async {
    // setRxRequestZoneStatus(Status.LOADING);
    var response = await _api
        .getApi('${ApiEndpoints.getAllVehicleData}?page=$pageNo&limit=100');

    print(response);

    return VehicleDataModel.fromJson(response);
  }

  void getAllDashboardApiData(int pageNo) {
    getAllDashboardApi(pageNo).then((value) async {
      setDashboardList(value);

      final vehicleDb = VehicleDb();
      // totalData.value = getSearchByLastDigitModel.value.totalRecords!;
      // totalPages.value = getSearchByLastDigitModel.value.totalPages!;

      if (getSearchByLastDigitModel.value.data != null) {
        for (int i = 0; i < getSearchByLastDigitModel.value.data!.length; i++) {
          downloadedData.value++;
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
        }
      }

      if (totalPages == currentPage) {
        setRxRequestStatus(Status.COMPLETED);

        var now = DateTime.now();
        var formatter = DateFormat('yyyy-MM-dd');
        String formattedDate = formatter.format(now);

        print(formattedDate);

        Helper.setStringPreferences(
            SharedPreferencesVar.lastUpdateDate, formattedDate);
        if (uc.userDetails['role'] == 'repo-agent') {
          Get.offAll(HomeScreenRepoStaff());
        } else {
          Get.toNamed(AppRoutes.home);
        }
        setRxRequestStatus(Status.COMPLETED);
      } else {
        currentPage.value++;
        getAllDashboardApiData(currentPage.value);
      }
    }).onError((error, stackTrace) {
      print(stackTrace);
      print('--------------------');
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }
}
