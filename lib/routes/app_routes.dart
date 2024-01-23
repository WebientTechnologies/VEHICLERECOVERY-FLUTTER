import 'package:get/get.dart';
import 'package:vinayak/Screens/HomeScreen/homeScreen.dart';
import 'package:vinayak/Screens/LoginScreen/loginScreen.dart';
import 'package:vinayak/Screens/agentRegisteration/agentRegestration.dart';

import '../Screens/searchVehicle/searchedVehicleDetails.dart';
import '../Screens/splashSCreen/splashScreen.dart';
import '../Screens/viewRequest/viewDetails.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String signin = '/signin';

  static const String home = '/home';
  static const String agentRegi = '/agentregistration';
  static const String searchedVehicleDetails = '/searchdetailsld';
  static const String viewRequestDetails = '/viewrequestdetails';
  static List<GetPage> pages = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: signin,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: home,
      page: () => const HomeSCreen(),
    ),
    GetPage(
      name: agentRegi,
      page: () => const AgentReisteration(),
    ),
    GetPage(
      name: searchedVehicleDetails,
      page: () => const SearchLDVehicleDetails(),
    ),
    GetPage(
      name: viewRequestDetails,
      page: () => const ViewRequestDetails(),
    ),
  ];
}
