import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Get.to(const HoldDataReports());
              },
              child: Container(
                width: Get.width * 1,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                        begin: const Alignment(0.0, 0.9),
                        end: const Alignment(0.9, 1),
                        transform: const GradientRotation(30),
                        colors: [
                          ColorConstants.midBrown,
                          ColorConstants.coalBlack
                        ])),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hold Data',
                        style: TextStyle(
                            color: ColorConstants.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Get.to(const RepoDataReports());
              },
              child: Container(
                width: Get.width * 1,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                        begin: const Alignment(0.0, 0.9),
                        end: const Alignment(0.9, 1),
                        transform: const GradientRotation(30),
                        colors: [
                          ColorConstants.midBrown,
                          ColorConstants.coalBlack
                        ])),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Repo Data',
                        style: TextStyle(
                            color: ColorConstants.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Get.to(const ReleaseDataReports());
              },
              child: Container(
                width: Get.width * 1,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                        begin: const Alignment(0.0, 0.9),
                        end: const Alignment(0.9, 1),
                        transform: const GradientRotation(30),
                        colors: [
                          ColorConstants.midBrown,
                          ColorConstants.coalBlack
                        ])),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Release Data',
                        style: TextStyle(
                            color: ColorConstants.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
