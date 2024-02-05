import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinayak/Screens/1RepoStaff/homeR/homeRepo.dart';
import 'package:vinayak/Screens/profile/profile.dart';

class RepoAgentController extends GetxController {
  List<Widget> screens = [HomeScreenRepoStaff(), Text('report'), Profile()];
  RxInt index = 0.obs;

  void setIndex(int i) {
    index.value = i;
  }
}
