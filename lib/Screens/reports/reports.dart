import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinayak/Screens/reports/controller/report_controller.dart';
import 'package:vinayak/core/global_controller/user_controller.dart';

import '../../core/constants/color_constants.dart';
import '../RepoDataReports/repoDataReports.dart';
import '../holdDataReports/holddataReports.dart';
import '../releaseDataReports/releaseDatareports.dart';
import '../searchDataReports/searchdataReports.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  ReportController rc = Get.put(ReportController());
  UserController uc = Get.put(UserController());

  bool showExtra = false;

  int holdDataIndex = 0;
  int repoDataIndex = 1;
  int releaseDataIndex = 2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    uc.loadUserDetails();

    load();
  }

  Future load() async {
    showExtra = uc.userDetails['role'] == 'office-staff' ? true : false;
    rc.index.value = 0;
    holdDataIndex = showExtra ? 1 : 0;
    repoDataIndex = showExtra ? 2 : 1;
    releaseDataIndex = showExtra ? 3 : 2;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorConstants.aqua),
        title: Text(
          'Reports',
          style: TextStyle(
              fontWeight: FontWeight.w500, color: ColorConstants.aqua),
        ),
      ),
      body: DefaultTabController(
        length: showExtra ? 4 : 3,
        child: Column(
          children: [
            Obx(
              () => TabBar(
                  onTap: rc.index,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: ColorConstants.white,
                  dividerHeight: 0,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  tabs: [
                    if (showExtra)
                      Container(
                        width: 120,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                                begin: const Alignment(0.0, 0.9),
                                end: const Alignment(0.9, 1),
                                transform: const GradientRotation(30),
                                colors: [
                                  rc.index.value == 0
                                      ? ColorConstants.aqua
                                      : ColorConstants.deepGrey808080,
                                  rc.index.value != 0
                                      ? ColorConstants.midGreyEAEAEA
                                      : ColorConstants.back
                                ])),
                        child: Center(
                          child: Text(
                            'Search Data',
                            style: TextStyle(
                                color: ColorConstants.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 17),
                          ),
                        ),
                      ),
                    Container(
                      width: 120,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              begin: const Alignment(0.0, 0.9),
                              end: const Alignment(0.9, 1),
                              transform: const GradientRotation(30),
                              colors: [
                                rc.index.value == holdDataIndex
                                    ? ColorConstants.aqua
                                    : ColorConstants.deepGrey808080,
                                rc.index.value != holdDataIndex
                                    ? ColorConstants.midGreyEAEAEA
                                    : ColorConstants.back
                              ])),
                      child: Center(
                        child: Text(
                          'Hold Data',
                          style: TextStyle(
                              color: ColorConstants.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
                        ),
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              begin: const Alignment(0.0, 0.9),
                              end: const Alignment(0.9, 1),
                              transform: const GradientRotation(30),
                              colors: [
                                rc.index.value == repoDataIndex
                                    ? ColorConstants.aqua
                                    : ColorConstants.deepGrey808080,
                                rc.index.value != repoDataIndex
                                    ? ColorConstants.midGreyEAEAEA
                                    : ColorConstants.back
                              ])),
                      child: Center(
                        child: Text(
                          'Repo Data',
                          style: TextStyle(
                              color: ColorConstants.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
                        ),
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              begin: const Alignment(0.0, 0.9),
                              end: const Alignment(0.9, 1),
                              transform: const GradientRotation(30),
                              colors: [
                                rc.index.value == releaseDataIndex
                                    ? ColorConstants.aqua
                                    : ColorConstants.deepGrey808080,
                                rc.index.value != releaseDataIndex
                                    ? ColorConstants.midGreyEAEAEA
                                    : ColorConstants.back
                              ])),
                      child: Center(
                        child: Text(
                          'Release Data',
                          style: TextStyle(
                              color: ColorConstants.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
                        ),
                      ),
                    ),
                  ]),
            ),
            Expanded(
              child: showExtra
                  ? const TabBarView(children: [
                      SearchDataReports(),
                      HoldDataReports(),
                      RepoDataReports(),
                      ReleaseDataReports()
                    ])
                  : const TabBarView(children: [
                      HoldDataReports(),
                      RepoDataReports(),
                      ReleaseDataReports()
                    ]),
            )
          ],
        ),
      ),
    );
  }
}
