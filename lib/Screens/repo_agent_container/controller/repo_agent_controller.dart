import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinayak/Screens/1RepoStaff/homeR/homeRepo.dart';
import 'package:vinayak/Screens/profile/profile.dart';
import 'package:vinayak/Screens/reports/reports.dart';

class RepoAgentController extends GetxController {
  List<Widget> screens = [
    const HomeScreenRepoStaff(),
    const Reports(),
    const Profile()
  ];
  RxInt index = 0.obs;

  void setIndex(int i) {
    index.value = i;
  }
}
