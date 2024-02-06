import 'package:get/get.dart';
import 'package:vinayak/Screens/HomeScreen/model/homedashoboardModel.dart';
import 'package:vinayak/core/network/network_api.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/response/status.dart';
import '../model/homeRepoModel.dart';

class HomeRepoAgentController extends GetxController {
  var _api = NetworkApi();

  RxList<String> greeting =
      <String>['Good Morning', 'Good Afternoon', 'Good Evening'].obs;
  RxInt selectedGreeting = 0.obs;

  final rxRequestDashboardStatus = Status.LOADING.obs;
  void setRxRequestDashboardStatus(Status value) =>
      rxRequestDashboardStatus.value = value;
  final dashboardModel = HomeDashboardRepoModel().obs;
  void setDashboardList(HomeDashboardRepoModel value) =>
      dashboardModel.value = value;

  Future<HomeDashboardRepoModel> getAllDashboardApi() async {
    // setRxRequestZoneStatus(Status.LOADING);
    var response = await _api.getApi(ApiEndpoints.getHomeDashboardRepoStaff);

    print(response);

    return HomeDashboardRepoModel.fromJson(response);
  }

  void getAllDashboardApiData() {
    getAllDashboardApi().then((value) {
      setRxRequestDashboardStatus(Status.COMPLETED);
      setDashboardList(value);
    }).onError((error, stackTrace) {
      print(stackTrace);
      print('--------------------');
      print(error);
      setRxRequestDashboardStatus(Status.ERROR);
    });
  }
}
