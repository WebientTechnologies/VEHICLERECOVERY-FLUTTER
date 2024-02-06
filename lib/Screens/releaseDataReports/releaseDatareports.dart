import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinayak/Screens/releaseDataReports/controller/releaserepoController.dart';
import 'package:vinayak/core/constants/color_constants.dart';
import 'package:vinayak/core/global_controller/user_controller.dart';
import 'package:vinayak/widget/myappbar.dart';

import '../../core/response/status.dart';
import '../../widget/repoCont.dart';

class ReleaseDataReports extends StatefulWidget {
  const ReleaseDataReports({super.key});

  @override
  State<ReleaseDataReports> createState() => _ReleaseDataReportsState();
}

class _ReleaseDataReportsState extends State<ReleaseDataReports> {
  UserController uc = Get.put(UserController());
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  ReleaseRepoReportController rrc = Get.put(ReleaseRepoReportController());
  ScrollController _scrollController = ScrollController();

  int currentPage = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rrc.getAllReleaseReportData('', 1, false, true);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Load more data when user reaches the end
        currentPage++;
        print('Current page');
        rrc.getAllReleaseReportData('', currentPage, false, false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      // appBar: AppBar(
      //   iconTheme: IconThemeData(color: ColorConstants.midBrown),
      //   title: Text(
      //     'Release data report',
      //     style: TextStyle(
      //         fontWeight: FontWeight.w500, color: ColorConstants.midBrown),
      //   ),
      // ),
      body: RefreshIndicator(
        onRefresh: () async {
          rrc.data.clear();
          rrc.getAllReleaseReportData('', 1, true, false);
        },
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.08,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                child: TextField(
                  controller: rrc.searchCont.value,
                  decoration: InputDecoration(
                    hintText: 'Search ',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                          BorderSide(color: ColorConstants.aqua, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                          BorderSide(color: ColorConstants.aqua, width: 3.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                          BorderSide(color: ColorConstants.aqua, width: 2.0),
                    ),
                  ),
                  style: const TextStyle(height: 1),
                  onChanged: (value) {
                    rrc.getAllReleaseReportData(value, 1, true, true);
                  },
                ),
              ),
            ),
            Obx(() {
              switch (rrc.rxReleaseReportRequestStatus.value) {
                case Status.LOADING:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case Status.ERROR:
                  return Center(
                    child: Text('Something went wrong'),
                  );
                case Status.COMPLETED:
                  if (rrc.data == null || rrc.data.isEmpty) {
                    return Center(
                      child: Text('No reports found'),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      // shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      itemCount: rrc.data.length,
                      itemBuilder: (ctx, index) {
                        Color bgColor = index % 2 == 0
                            ? ColorConstants.back
                            : ColorConstants.aqua;
                        return HoldRepoDetailsWidget(
                          regNo: rrc.data[index].regNo ?? '',
                          id: rrc.data[index].id ?? '',
                          bankName: rrc.data[index].bankName ?? '',
                          custName: rrc.data[index].customerName ?? '',
                          chasisNo: rrc.data[index].chasisNo ?? '',
                          model: 'model',
                          seezerName: rrc.data[index].seezerId?.name ?? '',
                          uploadDate: 'uploadDate',
                          backgroundColor: bgColor,
                        );
                      },
                    ),
                  );
              }
            }),
          ],
        ),
      ),
    );
  }
}
