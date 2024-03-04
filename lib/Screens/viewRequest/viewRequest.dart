import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinayak/core/constants/color_constants.dart';
import 'package:vinayak/core/response/status.dart';
import 'package:vinayak/routes/app_routes.dart';
import 'package:vinayak/widget/myappbar.dart';

import '../../widget/viewRequestCont.dart';
import 'controller/viewRequestController.dart';

class ViewRequest extends StatefulWidget {
  const ViewRequest({super.key});

  @override
  State<ViewRequest> createState() => _ViewRequestState();
}

class _ViewRequestState extends State<ViewRequest> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ViewRequestByOfficeController vrc = Get.put(ViewRequestByOfficeController());
  ScrollController _scrollController = ScrollController();

  int currentPage = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vrc.getViewRequestData('', 1, false, false);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Load more data when the user reaches the end
        currentPage++;
        vrc.getViewRequestData('', currentPage, false, false);
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
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorConstants.aqua),
        title: Text(
          'View Requests',
          style: TextStyle(
              fontWeight: FontWeight.w500, color: ColorConstants.aqua),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // rrc.data.clear();
          vrc.getViewRequestData('', 1, true, false);
        },
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.08,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                child: TextField(
                  controller: vrc.searchCont.value,
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
                    vrc.getViewRequestData(value, 1, false, true);
                  },
                ),
              ),
            ),
            Obx(() {
              switch (vrc.rxViewReportRequestStatus.value) {
                case Status.LOADING:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case Status.ERROR:
                  return Center(
                    child: Text('Something went wrong'),
                  );
                case Status.COMPLETED:
                  if (vrc.data == null || vrc.data.isEmpty) {
                    return Center(
                      child: Text('No reports found'),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      physics: AlwaysScrollableScrollPhysics(),
                      // shrinkWrap: true,
                      itemCount: vrc.data.length,
                      itemBuilder: (ctx, index) {
                        Color bgColor = index % 2 == 0
                            ? ColorConstants.back
                            : ColorConstants.aqua;
                        return ViewRequestContainer(
                          regNo: vrc.data[index].regNo ?? '',
                          id: vrc.data[index].id ?? '',
                          bankName: vrc.data[index].bankName ?? '',
                          custName: vrc.data[index].customerName ?? '',
                          chasisNo: vrc.data[index].chasisNo ?? '',
                          model: '',
                          seezerName: '',
                          backgroundColor: bgColor,
                          onViewDetailsPressed: () {
                            Get.toNamed(AppRoutes.viewRequestDetails,
                                arguments: [vrc.data[index]]);
                          },
                          onRepoPressed: () {
                            vrc.updateStatus(
                                vrc.data[index].recordId?.id ?? '', 'repo');
                          },
                          onReleasePressed: () {
                            vrc.updateStatus(
                                vrc.data[index].recordId?.id ?? '', 'release');
                          },
                        );
                      },
                    ),
                  );
              }
            }),
          ],
        ),
      ),
      //drawer: MyDrawer(),
    );
  }
}
