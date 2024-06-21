import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinayak/Screens/loginDeviceChange/profile/profile.dart';
import 'package:vinayak/Screens/reports/reports.dart';

import '../../HomeScreen/homeScreen.dart';

class StaffController extends GetxController {
  List<Widget> screens = [const HomeSCreen(), const Reports(), const Profile()];
  RxInt index = 0.obs;

  void setIndex(int i) {
    index.value = i;
  }
}
