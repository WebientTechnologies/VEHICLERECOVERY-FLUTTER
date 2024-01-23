import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinayak/Screens/HomeScreen/controller/homeController.dart';
import 'package:vinayak/core/constants/color_constants.dart';
import 'package:vinayak/core/styles/text_styles.dart';
import 'package:vinayak/routes/app_routes.dart';
import 'package:vinayak/widget/myappbar.dart';
import '../../../core/response/status.dart';
import '../../searchVehicle/controller/searchController.dart';
import 'controller/repoHomeController.dart';

class HomeScreenRepoStaff extends StatefulWidget {
  const HomeScreenRepoStaff({super.key});

  @override
  State<HomeScreenRepoStaff> createState() => _HomeScreenRepoStaffState();
}

class _HomeScreenRepoStaffState extends State<HomeScreenRepoStaff> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  HomeRepoAgentController hc = Get.put(HomeRepoAgentController());
  VehicleSearchController sc = Get.put(VehicleSearchController());
  TextEditingController last4digit = TextEditingController();
  TextEditingController chasisNoCont = TextEditingController();

  bool showlastdata = false;
  bool showChasisNo = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hc.getAllDashboardApiData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: ColorConstants.back,
        appBar: MyAppBar(),
        body: LayoutBuilder(builder: (ctx, constraints) {
          var height = constraints.maxHeight;
          var width = constraints.maxWidth;
          return Column(
            children: [
              Center(
                child: Container(
                  width: width * 0.33,
                  height: height * 0.15,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo.jpg'),
                      fit: BoxFit.cover,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                ),
              ),
              Text(
                'Vinayak Recovery',
                style: TextStyle(
                    color: ColorConstants.aqua, fontSize: height * 0.03),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 50,
                    width: width * 0.43,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: ColorConstants.aqua,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: TextFormField(
                        controller: chasisNoCont,
                        decoration: InputDecoration(
                          hintText: 'Chasis No.',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 16.0),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          if (value.length >= 12) {
                            sc.getAllSearchByChasisApiData(
                                chasisNoCont.value.text);

                            if (sc.searchbyChasisNoModel.value.data != null &&
                                sc.searchbyChasisNoModel.value.data!
                                    .isNotEmpty) {
                              setState(() {
                                showChasisNo = true;
                                showlastdata = false;
                              });
                            } else {
                              setState(() {
                                showlastdata = false;
                              });
                            }
                          } else {
                            setState(() {
                              showChasisNo = false;
                              showlastdata = false;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: width * 0.43,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: ColorConstants.aqua,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: TextFormField(
                        controller: last4digit,
                        decoration: InputDecoration(
                          hintText: 'Last 4 Digits',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 16.0),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          if (value.length == 4) {
                            sc.getAllSearchByLastDigitData(
                                last4digit.value.text);
                            setState(() {
                              showlastdata = true;
                            });
                          } else {
                            setState(() {
                              showlastdata = false;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              if (showChasisNo == true && showlastdata == false)
                Obx(() {
                  switch (sc.rxRequestsearchbyChasisNoStatus.value) {
                    case Status.LOADING:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    case Status.ERROR:
                      return Center(
                        child: Text('SOmething went wrong'),
                      );
                    case Status.COMPLETED:
                      return Expanded(
                        child: GridView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16.0,
                                  crossAxisSpacing: 16.0,
                                  childAspectRatio: 5),
                          itemCount:
                              sc.searchbyChasisNoModel.value.data!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.searchedVehicleDetails,
                                    arguments: [
                                      sc.searchbyChasisNoModel.value
                                          .data?[index],
                                      'repoAgent'
                                    ]);
                              },
                              child: Container(
                                  height: 40,
                                  width: width * 0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Center(
                                      child: Text(
                                    sc.searchbyChasisNoModel.value.data?[index]
                                            .regNo ??
                                        '',
                                    style:
                                        TextStyle(color: ColorConstants.aqua),
                                  ))),
                            );
                          },
                        ),
                      );
                  }
                }),
              if (showlastdata == true && showChasisNo == false)
                Obx(() {
                  switch (sc.rxRequestsearchbyLastStatus.value) {
                    case Status.LOADING:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    case Status.ERROR:
                      return Center(
                        child: Text('SOmething went wrong'),
                      );
                    case Status.COMPLETED:
                      return Expanded(
                        child: GridView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16.0,
                                  crossAxisSpacing: 16.0,
                                  childAspectRatio: 5),
                          itemCount: sc.searchbylastModel.value.data!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.searchedVehicleDetails,
                                    arguments: [
                                      sc.searchbylastModel.value.data?[index],
                                      'repoAgent'
                                    ]);
                              },
                              child: Container(
                                  height: 40,
                                  width: width * 0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Center(
                                      child: Text(
                                    sc.searchbylastModel.value.data?[index]
                                            .regNo ??
                                        '',
                                    style:
                                        TextStyle(color: ColorConstants.aqua),
                                  ))),
                            );
                          },
                        ),
                      );
                  }
                }),
              if (showlastdata == false && showChasisNo == false)
                Column(
                  children: [
                    Container(
                      height: 50,
                      width: width * 0.95,
                      decoration: BoxDecoration(
                          color: ColorConstants.aqua,
                          borderRadius: BorderRadius.circular(18)),
                      child: Center(
                        child: Text(
                          'LAST UPDATE',
                          style: TextStyles.normalheadWhite20DM,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Obx(() {
                      switch (hc.rxRequestDashboardStatus.value) {
                        case Status.LOADING:
                          return Center();
                        case Status.ERROR:
                          return Center(
                            child: Text('SOmething went wrong'),
                          );
                        case Status.COMPLETED:
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Container(
                                    //   height: height * 0.1,
                                    //   width: width * 0.43,
                                    //   decoration: BoxDecoration(
                                    //       color: ColorConstants.aqua,
                                    //       borderRadius:
                                    //           BorderRadius.circular(18)),
                                    //   child: Center(
                                    //     child: Text(
                                    //       'SEARCH DATA\n${hc.dashboardModel.value.searchCount}',
                                    //       textAlign: TextAlign.center,
                                    //       style: TextStyles.normalheadWhite20DM,
                                    //     ),
                                    //   ),
                                    // ),
                                    Container(
                                      height: Get.height * 0.1,
                                      width: width * 0.43,
                                      decoration: BoxDecoration(
                                          color: ColorConstants.aqua,
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                      child: Center(
                                        child: Text(
                                          'HOLD DATA\n${hc.dashboardModel.value.holdCount}',
                                          textAlign: TextAlign.center,
                                          style: TextStyles.normalheadWhite20DM,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: Get.height * 0.1,
                                    width: width * 0.43,
                                    decoration: BoxDecoration(
                                        color: ColorConstants.aqua,
                                        borderRadius:
                                            BorderRadius.circular(18)),
                                    child: Center(
                                      child: Text(
                                        'REPO DATA\n${hc.dashboardModel.value.repoCount}',
                                        textAlign: TextAlign.center,
                                        style: TextStyles.normalheadWhite20DM,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: Get.height * 0.1,
                                    width: width * 0.43,
                                    decoration: BoxDecoration(
                                        color: ColorConstants.aqua,
                                        borderRadius:
                                            BorderRadius.circular(18)),
                                    child: Center(
                                      child: Text(
                                        'RELEASE DATA\n${hc.dashboardModel.value.releaseCount}',
                                        textAlign: TextAlign.center,
                                        style: TextStyles.normalheadWhite20DM,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          );
                      }
                    }),
                  ],
                ),
            ],
          );
        }),
        drawer: MyRepoAgentDrawer());
  }
}
