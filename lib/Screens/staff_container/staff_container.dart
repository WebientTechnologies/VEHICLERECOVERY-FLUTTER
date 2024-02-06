import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinayak/Screens/staff_container/controller/staff_controller.dart';

import '../../core/constants/color_constants.dart';

class StaffContainer extends StatefulWidget {
  const StaffContainer({super.key});

  @override
  State<StaffContainer> createState() => _StaffContainerState();
}

class _StaffContainerState extends State<StaffContainer> {
  StaffController sc = Get.put(StaffController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Obx(() => sc.screens[sc.index.value])),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            selectedLabelStyle: TextStyle(color: ColorConstants.aqua),
            currentIndex: sc.index.value,
            onTap: sc.setIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_filled,
                    color: sc.index.value == 0
                        ? ColorConstants.aqua
                        : ColorConstants.deepGrey808080,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.insert_chart_rounded,
                      color: sc.index.value == 1
                          ? ColorConstants.aqua
                          : ColorConstants.deepGrey808080),
                  label: 'Reports'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person,
                      color: sc.index.value == 2
                          ? ColorConstants.aqua
                          : ColorConstants.deepGrey808080),
                  label: 'Profile'),
            ]),
      ),
    );
  }
}
