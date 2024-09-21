import 'package:get/get.dart';
import 'package:vinayak/Screens/1RepoStaff/homeR/model/dashboardModel.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/network_api.dart';
import '../../../../core/response/status.dart';
import '../../../../core/sqlite/vehicledb.dart';

class DashboardController extends GetxController {
  var _api = NetworkApi();

  RxInt onlineDataCount = 0.obs;
  RxBool showRefresh = false.obs;
  RxBool blinkRefresh = false.obs;

  final rxRequestDashboardStatus = Status.LOADING.obs;
  void setRxRequestDashboardStatus(Status value) =>
      rxRequestDashboardStatus.value = value;
  final dashboardModel = DashboardModel().obs;
  void setDashboardList(DashboardModel value) => dashboardModel.value = value;

  Future<DashboardModel> getAllDashboardApi() async {
    // setRxRequestZoneStatus(Status.LOADING);
    var response = await _api.getApi(ApiEndpoints.getDashboard);

    print(response);

    return DashboardModel.fromJson(response);
  }

  void getAllDashboardApiData() async {
    getAllDashboardApi().then((value) async {
      setRxRequestDashboardStatus(Status.COMPLETED);
      setDashboardList(value);

      showRefresh.value = true;
      onlineDataCount.value =
          dashboardModel.value.dashboard![0].onlineDataCount ?? 0;

      final vehicleDb = VehicleDb();
      int count = await vehicleDb.getOfflineCount();

      if (count != onlineDataCount.value) {
        blinkRefresh.value = true;
      }

      //ssc.currentPage.value = (onlineDataCount.value / 100).ceil() + 1;
    }).onError((error, stackTrace) {
      print(stackTrace);
      print('--------------------');
      print(error);
      setRxRequestDashboardStatus(Status.ERROR);
    });
  }
}
