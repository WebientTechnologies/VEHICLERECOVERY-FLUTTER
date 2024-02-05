import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinayak/Screens/repo_agent_container/controller/repo_agent_controller.dart';
import 'package:vinayak/core/constants/color_constants.dart';

class RepoAgentContainer extends StatefulWidget {
  const RepoAgentContainer({super.key});

  @override
  State<RepoAgentContainer> createState() => _RepoAgentContainerState();
}

class _RepoAgentContainerState extends State<RepoAgentContainer> {
  RepoAgentController rac = Get.put(RepoAgentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Obx(() => rac.screens[rac.index.value])),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            selectedLabelStyle: TextStyle(color: ColorConstants.midBrown),
            currentIndex: rac.index.value,
            onTap: rac.setIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_filled,
                    color: rac.index.value == 0
                        ? ColorConstants.midBrown
                        : ColorConstants.deepGrey808080,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.insert_chart_rounded,
                      color: rac.index.value == 1
                          ? ColorConstants.midBrown
                          : ColorConstants.deepGrey808080),
                  label: 'Reports'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person,
                      color: rac.index.value == 2
                          ? ColorConstants.midBrown
                          : ColorConstants.deepGrey808080),
                  label: 'Profile'),
            ]),
      ),
    );
  }
}
