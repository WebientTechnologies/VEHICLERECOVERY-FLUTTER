import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinayak/widget/textfield.dart';

import '../../core/constants/color_constants.dart';
import '../../core/global_controller/user_controller.dart';
import '../../core/response/status.dart';
import '../../widget/myappbar.dart';
import '../../widget/repoCont.dart';
import 'controller/repodataController.dart';

class RepoDataReports extends StatefulWidget {
  const RepoDataReports({super.key});

  @override
  State<RepoDataReports> createState() => _RepoDataReportsState();
}

class _RepoDataReportsState extends State<RepoDataReports> {
  UserController uc = Get.put(UserController());
  int currentPage = 1;
  RepoDataReportController rrc = Get.put(RepoDataReportController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    rrc.getRepoReportData('', 1, false, false);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Load more data when user reaches the end
        currentPage++;
        print('Current page');
        rrc.getRepoReportData(
            rrc.searchCont.value.text, currentPage, false, false);
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
      key: _scaffoldKey,
      // appBar: AppBar(
      //   iconTheme: IconThemeData(color: ColorConstants.midBrown),
      //   title: Text(
      //     'Repo data report',
      //     style: TextStyle(
      //         fontWeight: FontWeight.w500, color: ColorConstants.midBrown),
      //   ),
      // ),
      body: RefreshIndicator(
        onRefresh: () async {
          rrc.data.clear();
          rrc.getRepoReportData('', 1, true, false);
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
                      borderSide: BorderSide(
                          color: ColorConstants.coalBlack, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                          color: ColorConstants.coalBlack, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                          color: ColorConstants.coalBlack, width: 1.0),
                    ),
                  ),
                  style: TextStyle(height: 1),
                  onChanged: (value) {
                    rrc.getRepoReportData(value, currentPage, false, true);
                  },
                ),
              ),
            ),
            Obx(() {
              switch (rrc.rxRepoRequestStatus.value) {
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
                      // physics: NeverScrollableScrollPhysics(),
                      // shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: rrc.data.length,
                      itemBuilder: (ctx, index) {
                        Color bgColor = index % 2 == 0
                            ? Colors.brown[400]!
                            : ColorConstants.midBrown;
                        print(rrc.data[index].seezerId?.name);
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

                default:
                  return Container();
              }
            }),
          ],
        ),
      ),
    );
  }
}
