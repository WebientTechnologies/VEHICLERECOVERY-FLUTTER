import 'package:get/get.dart';
import 'package:vinayak/Screens/HomeScreen/model/graph_week_model.dart';
import 'package:vinayak/Screens/HomeScreen/model/homedashoboardModel.dart';
import 'package:vinayak/core/network/network_api.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/response/status.dart';

class HomeController extends GetxController {
  var _api = NetworkApi();

  RxList<Data> weekData = <Data>[].obs;

  RxList<String> greeting =
      <String>['Good Morning', 'Good Afternoon', 'Good Evening'].obs;
  RxInt selectedGreeting = 0.obs;

  final rxRequestDashboardStatus = Status.LOADING.obs;
  void setRxRequestDashboardStatus(Status value) =>
      rxRequestDashboardStatus.value = value;
  final dashboardModel = HomeDashBoardModel().obs;
  void setDashboardList(HomeDashBoardModel value) =>
      dashboardModel.value = value;

  final graphWeekModel = GraphWeekModel().obs;
  void setGraphWeekList(GraphWeekModel value) => graphWeekModel.value = value;

  Future<HomeDashBoardModel> getAllDashboardApi() async {
    // setRxRequestZoneStatus(Status.LOADING);
    var response = await _api.getApi(ApiEndpoints.getHomeDashboard);

    print(response);

    return HomeDashBoardModel.fromJson(response);
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

  Future<GraphWeekModel> _getGraphWeekApi() async {
    // setRxRequestZoneStatus(Status.LOADING);
    var response =
        await _api.getApi('${ApiEndpoints.holdGraphData}?interval=week');

    print(response);

    return GraphWeekModel.fromJson(response);
  }

  void getGraphWeekApiData() {
    _getGraphWeekApi().then((value) {
      setGraphWeekList(value);
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
