import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinayak/Screens/reports/controller/report_controller.dart';

import '../../core/constants/color_constants.dart';
import '../RepoDataReports/repoDataReports.dart';
import '../holdDataReports/holddataReports.dart';
import '../releaseDataReports/releaseDatareports.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  ReportController rc = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorConstants.midBrown),
        title: Text(
          'Reports',
          style: TextStyle(
              fontWeight: FontWeight.w500, color: ColorConstants.midBrown),
        ),
      ),
      body: DefaultTabController(
        length: 3,
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
                    Container(
                      width: 120,
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              begin: const Alignment(0.0, 0.9),
                              end: const Alignment(0.9, 1),
                              transform: const GradientRotation(30),
                              colors: [
                                rc.index.value == 0
                                    ? ColorConstants.midBrown
                                    : ColorConstants.deepGrey808080,
                                ColorConstants.deepGrey808080
                              ])),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 20),
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
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              begin: const Alignment(0.0, 0.9),
                              end: const Alignment(0.9, 1),
                              transform: const GradientRotation(30),
                              colors: [
                                rc.index.value == 1
                                    ? ColorConstants.midBrown
                                    : ColorConstants.deepGrey808080,
                                ColorConstants.midGreyEAEAEA
                              ])),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 20),
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
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              begin: const Alignment(0.0, 0.9),
                              end: const Alignment(0.9, 1),
                              transform: const GradientRotation(30),
                              colors: [
                                rc.index.value == 2
                                    ? ColorConstants.midBrown
                                    : ColorConstants.deepGrey808080,
                                ColorConstants.midGreyEAEAEA
                              ])),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 20),
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
            const Expanded(
              child: TabBarView(children: [
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
