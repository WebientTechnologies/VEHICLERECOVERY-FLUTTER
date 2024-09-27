import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../core/constants/color_constants.dart';
import '../../core/response/status.dart';
import '../../core/utils/routes/app_routes.dart';
import 'controller/searchDataController.dart';

class SearchDataReports extends StatefulWidget {
  const SearchDataReports({super.key});

  @override
  State<SearchDataReports> createState() => _SearchDataReportsState();
}

class _SearchDataReportsState extends State<SearchDataReports> {
  SearchDataReportController src = Get.put(SearchDataReportController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _scrollController = ScrollController();
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    src.getAllSearchDataRepoData('', 1, false, true);

    // Add a listener to detect when the user scrolls to the end of the list
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Load more data when the user reaches the end
        currentPage++;
        src.getAllSearchDataRepoData('', currentPage, false, false);
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
      body: RefreshIndicator(
        onRefresh: () async {
          src.data.clear();
          src.getAllSearchDataRepoData('', 1, true, false);
        },
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.08,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                child: TextField(
                  controller: src.searchCont.value,
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
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {
                    src.getAllSearchDataRepoData(value, 1, false, true);
                  },
                  onChanged: (value) {
                    // currentPage = 1;
                  },
                ),
              ),
            ),
            Obx(() {
              switch (src.rxSearchReportRequestStatus.value) {
                case Status.LOADING:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case Status.ERROR:
                  return Center(
                    child: Text('Something went wrong'),
                  );
                case Status.COMPLETED:
                  return Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: src.data.length,
                      physics:
                          AlwaysScrollableScrollPhysics(), // Ensure always scrollable
                      itemBuilder: (ctx, index) {
                        Color bgColor = index % 2 == 0
                            ? ColorConstants.back
                            : ColorConstants.aqua;
                        return GestureDetector(
                            onTap: () {
                              if (src.data[index].vehicleId != null) {
                                Get.toNamed(AppRoutes.searchedVehicleDetails,
                                    arguments: [
                                      src.data[index],
                                      'officeStaff',
                                      false,
                                      'report'
                                    ]);
                              }
                            },
                            child: Container(
                              color: bgColor,
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Bank Name',
                                              style: TextStyle(
                                                color: ColorConstants.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            GestureDetector(
                                              onLongPress: () async {
                                                await Clipboard.setData(
                                                        ClipboardData(
                                                            text: src
                                                                    .data[index]
                                                                    .vehicleId!
                                                                    .bankName ??
                                                                ''))
                                                    .then((v) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          'Copied ${src.data[index].vehicleId!.bankName ?? ''}');
                                                });
                                              },
                                              child: Text(
                                                src.data[index].vehicleId !=
                                                        null
                                                    ? src.data[index].vehicleId!
                                                            .bankName ??
                                                        ''
                                                    : '',
                                                style: TextStyle(
                                                  color: ColorConstants.white,
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Cust Name',
                                              style: TextStyle(
                                                color: ColorConstants.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            GestureDetector(
                                              onLongPress: () async {
                                                await Clipboard.setData(
                                                        ClipboardData(
                                                            text: src
                                                                    .data[index]
                                                                    .vehicleId!
                                                                    .customerName ??
                                                                ''))
                                                    .then((v) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          'Copied ${src.data[index].vehicleId!.customerName ?? ''}');
                                                });
                                              },
                                              child: Text(
                                                src.data[index].vehicleId !=
                                                        null
                                                    ? src.data[index].vehicleId!
                                                            .customerName ??
                                                        ''
                                                    : '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: ColorConstants.white,
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Reg No',
                                              style: TextStyle(
                                                color: ColorConstants.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            GestureDetector(
                                              onLongPress: () async {
                                                await Clipboard.setData(
                                                        ClipboardData(
                                                            text: src
                                                                    .data[index]
                                                                    .vehicleId!
                                                                    .regNo ??
                                                                ''))
                                                    .then((v) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          'Copied ${src.data[index].vehicleId!.regNo ?? ''}');
                                                });
                                              },
                                              child: Text(
                                                src.data[index].vehicleId !=
                                                        null
                                                    ? src.data[index].vehicleId!
                                                            .bankName ??
                                                        ''
                                                    : '',
                                                style: TextStyle(
                                                  color: ColorConstants.white,
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Chasis No',
                                              style: TextStyle(
                                                color: ColorConstants.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            GestureDetector(
                                              onLongPress: () async {
                                                await Clipboard.setData(
                                                        ClipboardData(
                                                            text: src
                                                                    .data[index]
                                                                    .vehicleId!
                                                                    .chasisNo ??
                                                                ''))
                                                    .then((v) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          'Copied ${src.data[index].vehicleId!.chasisNo ?? ''}');
                                                });
                                              },
                                              child: Text(
                                                src.data[index].vehicleId !=
                                                        null
                                                    ? src.data[index].vehicleId!
                                                            .bankName ??
                                                        ''
                                                    : '',
                                                style: TextStyle(
                                                  color: ColorConstants.white,
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Model',
                                              style: TextStyle(
                                                color: ColorConstants.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            Text(
                                              src.data[index].vehicleId != null
                                                  ? src.data[index].vehicleId!
                                                          .model ??
                                                      ''
                                                  : '',
                                              style: TextStyle(
                                                color: ColorConstants.white,
                                                fontSize: 14.0,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Seezer Name',
                                              style: TextStyle(
                                                color: ColorConstants.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            GestureDetector(
                                              onLongPress: () async {
                                                await Clipboard.setData(
                                                        ClipboardData(
                                                            text: src
                                                                    .data[index]
                                                                    .seezerId!
                                                                    .name ??
                                                                ''))
                                                    .then((v) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          'Copied ${src.data[index].seezerId!.name ?? ''}');
                                                });
                                              },
                                              child: Text(
                                                src.data[index].seezerId!
                                                        .name ??
                                                    '',
                                                style: TextStyle(
                                                  color: ColorConstants.white,
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Upload Date',
                                              style: TextStyle(
                                                color: ColorConstants.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            Text(
                                              src.data[index].vehicleId != null
                                                  ? src.data[index].vehicleId!
                                                      .createdAt!
                                                      .substring(0, 10)
                                                  : '',
                                              style: TextStyle(
                                                color: ColorConstants.white,
                                                fontSize: 14.0,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Search Date',
                                              style: TextStyle(
                                                color: ColorConstants.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            Text(
                                              src.data[index].vehicleId != null
                                                  ? src.data[index].createdAt!
                                                      .substring(0, 10)
                                                  : '',
                                              style: TextStyle(
                                                color: ColorConstants.white,
                                                fontSize: 14.0,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Search Time',
                                              style: TextStyle(
                                                color: ColorConstants.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            Text(
                                              src.data[index].createdAt != null
                                                  ? formatTime(src.data[index]
                                                          .createdAt!)
                                                      .substring(13)
                                                  : '',
                                              style: TextStyle(
                                                color: ColorConstants.white,
                                                fontSize: 14.0,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ));
                      },
                    ),
                  );
              }
            }),
          ],
        ),
      ),
      // drawer: MyDrawer(),
    );
  }

  String formatTime(time) {
    DateTime utcTime = DateTime.parse(time).toUtc();

    // Convert UTC to IST (UTC + 5:30)
    DateTime istTime = utcTime.subtract(Duration(hours: 5, minutes: 30));

    // Format the DateTime to the desired output format
    return DateFormat('yyyy-MM-dd – hh:mm aa').format(istTime);
  }
}
