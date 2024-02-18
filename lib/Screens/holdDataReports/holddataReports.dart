import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinayak/core/constants/color_constants.dart';
import 'package:vinayak/core/global_controller/user_controller.dart';
import 'package:vinayak/widget/myappbar.dart';

import '../../core/response/status.dart';
import '../../widget/repoCont.dart';
import 'controller/holdDataController.dart';

class HoldDataReports extends StatefulWidget {
  const HoldDataReports({Key? key}) : super(key: key);

  @override
  State<HoldDataReports> createState() => _HoldDataReportsState();
}

class _HoldDataReportsState extends State<HoldDataReports> {
  HoldDataController hdc = Get.put(HoldDataController());
  UserController uc = Get.put(UserController());
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  int currentPage = 1;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    hdc.getHoldRepoData('', 1, false, true);

    // Add a listener to detect when user scrolls to the end of the list
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Load more data when user reaches the end
        currentPage++;
        hdc.getHoldRepoData(
            hdc.searchCont.value.text, currentPage, false, false);
      }
    });
  }

  @override
  void dispose() {
    // Dispose the scroll controller when the widget is disposed
    _scrollController.dispose();
    super.dispose();
  }

  Future _refreshData() async {
    print("Refreshing data...");
    hdc.data.clear();
    hdc.getHoldRepoData('', 1, true, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      // appBar: AppBar(
      //   iconTheme: IconThemeData(color: ColorConstants.midBrown),
      //   title: Text(
      //     'Hold data report',
      //     style: TextStyle(
      //         fontWeight: FontWeight.w500, color: ColorConstants.midBrown),
      //   ),
      // ),
      body: LayoutBuilder(builder: (ctx, constraints) {
        return RefreshIndicator(
          onRefresh: _refreshData,
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.08,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                  child: TextField(
                    controller: hdc.searchCont.value,
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
                    style: TextStyle(height: 1),
                    onChanged: (value) {
                      hdc.getHoldRepoData(value, currentPage, false, true);
                    },
                  ),
                ),
              ),
              Obx(() {
                switch (hdc.rxRequestHoldRepoStatus.value) {
                  case Status.LOADING:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  case Status.ERROR:
                    return Center(
                      child: Text('Something went wrong'),
                    );
                  case Status.COMPLETED:
                    if (hdc.data == null || hdc.data.isEmpty) {
                      return Center(
                        child: Text('No reports found'),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        controller: _scrollController,
                        itemCount: hdc.data.length,
                        itemBuilder: (ctx, index) {
                          Color bgColor = index % 2 == 0
                              ? ColorConstants.back
                              : ColorConstants.aqua;
                          return HoldRepoDetailsWidget(
                            bankName: hdc.data[index].bankName ?? '',
                            chasisNo: hdc.data[index].chasisNo ?? '',
                            id: hdc.data[index].id ?? '',
                            custName: hdc.data[index].customerName ?? '',
                            model: 'model',
                            regNo: hdc.data[index].regNo ?? '',
                            seezerName: 'seezerName',
                            backgroundColor: bgColor,
                            uploadDate: '',
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
        );
      }),
    );
  }
}
