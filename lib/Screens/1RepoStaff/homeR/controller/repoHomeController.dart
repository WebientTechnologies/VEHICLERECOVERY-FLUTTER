import 'package:get/get.dart';
import 'package:vinayak/core/network/network_api.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/response/status.dart';
import '../../../HomeScreen/model/graph_week_model.dart';
import '../model/homeRepoModel.dart';

class HomeRepoAgentController extends GetxController {
  var _api = NetworkApi();
  RxList<Data> weekData = <Data>[].obs;

  RxList<String> greeting =
      <String>['Good Morning', 'Good Afternoon', 'Good Evening'].obs;
  RxInt selectedGreeting = 0.obs;
  RxInt onlineDataCount = 0.obs;

  final rxRequestDashboardStatus = Status.LOADING.obs;
  void setRxRequestDashboardStatus(Status value) =>
      rxRequestDashboardStatus.value = value;
  final dashboardModel = HomeDashboardRepoModel().obs;
  void setDashboardList(HomeDashboardRepoModel value) =>
      dashboardModel.value = value;

  final graphWeekModel = GraphWeekModel().obs;
  void setGraphWeekList(GraphWeekModel value) => graphWeekModel.value = value;

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

      onlineDataCount.value = dashboardModel.value.totalOnlineData ?? 0;
    }).onError((error, stackTrace) {
      print(stackTrace);
      print('--------------------');
      print(error);
      setRxRequestDashboardStatus(Status.ERROR);
    });
  }

  Future<GraphWeekModel> _getGraphWeekApi(String which) async {
    //setRxRequestZoneStatus(Status.LOADING);
    String url = "";
    if (which == "hold") {
      url = '${ApiEndpoints.holdGraphData}?interval=week';
    } else if (which == "search") {
      url = '${ApiEndpoints.searchGraphData}?interval=week';
    } else if (which == "release") {
      url = '${ApiEndpoints.releaseGraphData}?interval=week';
    } else if (which == "repo") {
      url = '${ApiEndpoints.repoGraphData}?interval=week';
    }
    var response = await _api.getApi(url);

    print(response);

    return GraphWeekModel.fromJson(response);
  }

  void getGraphWeekApiData(String which) {
    _getGraphWeekApi(which).then((value) {
      setRxRequestDashboardStatus(Status.COMPLETED);
      setGraphWeekList(value);
      weekData.clear();
      for (int i = 0; i < graphWeekModel.value.data!.length; i++) {
        weekData.add(Data(
            count: i,
            day: graphWeekModel.value.data![i].day,
            totalVehicle: graphWeekModel.value.data![i].totalVehicle));
      }
      setRxRequestDashboardStatus(Status.COMPLETED);
    }).onError((error, stackTrace) {
      print(stackTrace);
      print('--------------------');
      print(error);
      setRxRequestDashboardStatus(Status.ERROR);
    });
  }
}
