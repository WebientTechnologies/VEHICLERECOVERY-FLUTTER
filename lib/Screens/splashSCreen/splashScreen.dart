import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinayak/Screens/1RepoStaff/homeR/homeRepo.dart';
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
      if (uc.userDetails['role'] == 'repo-agent') {
        print(token);
        Get.offAll(HomeScreenRepoStaff());
      } else {
        Get.toNamed(AppRoutes.home);
        print(token);
      }
    } else {
      Get.offAllNamed(AppRoutes.signin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.aqua,
      body: Center(
        child: Image.asset('assets/images/logo.jpg'),
      ),
    );
  }
}
