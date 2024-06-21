import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:vinayak/Screens/1RepoStaff/homeR/homeRepo.dart';
import 'package:vinayak/Screens/repo_agent_container/repo_agent_container.dart';
import 'package:vinayak/Screens/splashSCreen/controller/splashscreen_controller.dart';
import 'package:vinayak/Screens/staff_container/staff_container.dart';
import 'package:vinayak/core/constants/color_constants.dart';

import '../../core/constants/helper.dart';
import '../../core/constants/shared_preferences_var.dart';
import '../../core/global_controller/user_controller.dart';
import '../../core/utils/routes/app_routes.dart';
import '../HomeScreen/model/vehicle_sm_hive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserController uc = Get.put(UserController(), permanent: true);
  SplashScreenController ssc = Get.put(SplashScreenController());
  @override
  void initState() {
    super.initState();
    loadUserDetail();
    // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    //     FlutterLocalNotificationsPlugin();
    // flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()
    //     ?.requestNotificationsPermission();

    Timer(const Duration(milliseconds: 1500), () {
      checkSignin();
    });
  }

  Future loadUserDetail() async {
    await uc.loadUserDetails();

    // print()
    print(uc.userDetails);
  }

  Future checkSignin() async {
    String token =
        await Helper.getStringPreferences(SharedPreferencesVar.token);
    if (token.length > 5) {
      String lastUpdateDate = await Helper.getStringPreferences(
          SharedPreferencesVar.lastUpdateDate);

      print(lastUpdateDate);

      // if (lastUpdateDate.length > 4) {
      ssc.loadPartialData.value = true;
      if (uc.userDetails['role'] == 'repo-agent') {
        Get.offAll(const RepoAgentContainer());
      } else {
        Get.offAll(const StaffContainer());
      }
      // } else {
      //ssc.loadAllData.value = true;
      //ssc.getAllDashboardApiData(1);
      // }
    } else {
      Get.offAllNamed(AppRoutes.signin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.aqua,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/vad.png',
                width: 200,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Vinayak Recovery',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.white,
                    fontSize: 22),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ));
  }
}
