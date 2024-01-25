import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinayak/Screens/1RepoStaff/homeR/homeRepo.dart';
import 'package:vinayak/Screens/splashSCreen/controller/splashscreen_controller.dart';
import 'package:vinayak/core/constants/color_constants.dart';

import '../../core/constants/helper.dart';
import '../../core/constants/shared_preferences_var.dart';
import '../../core/global_controller/user_controller.dart';
import '../../routes/app_routes.dart';

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

      if (lastUpdateDate.length > 4) {
        ssc.loadPartialData.value = true;
        if (uc.userDetails['role'] == 'repo-agent') {
          Get.offAll(HomeScreenRepoStaff());
        } else {
          Get.toNamed(AppRoutes.home);
        }
      } else {
        ssc.loadAllData.value = true;
        ssc.getAllDashboardApiData(1);
      }
    } else {
      Get.offAllNamed(AppRoutes.signin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.aqua,
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Image.asset('assets/images/logo.jpg'),
          const SizedBox(
            height: 100,
          ),
          Obx(() {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    'Loading all data please wait. This will only happen once if its get completed. And do not press back button.',
                    style: TextStyle(
                      color: ColorConstants.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                    'Downloading ${ssc.downloadedData.value}/${ssc.totalData.value}',
                    style: TextStyle(
                      color: ColorConstants.white,
                    )),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: CircularProgressIndicator(
                    color: ColorConstants.white,
                  ),
                )
              ],
            );
          })
        ],
      ),
    );
  }
}
