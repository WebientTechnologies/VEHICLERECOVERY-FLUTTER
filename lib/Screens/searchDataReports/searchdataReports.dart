import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinayak/widget/myappbar.dart';
import '../../core/constants/color_constants.dart';
import '../../core/response/status.dart';
import '../../widget/repoCont.dart';
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
                  onChanged: (value) {
                    // currentPage = 1;
                    src.getAllSearchDataRepoData(value, 1, false, true);
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
                        return HoldRepoDetailsWidget(
                          regNo: src.data[index].regNo ?? '',
                          id: src.data[index].id ?? '',
                          bankName: src.data[index].bankName ?? '',
                          custName: src.data[index].customerName ?? '',
                          chasisNo: src.data[index].chasisNo ?? '',
                          model: 'model',
                          seezerName: src.data[index].seezerId?.name ?? '',
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
      drawer: MyDrawer(),
    );
  }
}
