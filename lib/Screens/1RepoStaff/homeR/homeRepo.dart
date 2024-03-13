import 'dart:async';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:vinayak/core/constants/color_constants.dart';
import 'package:vinayak/core/constants/helper.dart';
import 'package:vinayak/core/constants/shared_preferences_var.dart';
import 'package:vinayak/core/global_controller/user_controller.dart';
import 'package:vinayak/core/sqlite/vehicledb.dart';
import 'package:vinayak/core/styles/text_styles.dart';
import 'package:vinayak/routes/app_routes.dart';
import '../../../core/response/status.dart';
import '../../HomeScreen/controller/homeController.dart';
import '../../searchVehicle/controller/searchController.dart';
import '../../splashSCreen/controller/splashscreen_controller.dart';
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
  SplashScreenController ssc = Get.put(SplashScreenController());
  UserController uc = Get.find<UserController>();
  HomeController hcc = Get.put(HomeController());

  bool showlastdata = false;
  bool showChasisNo = false;
  bool isOnline = true;
  String mode = "Online", lastUpdateDate = "", lastUpdateTime = "";
  bool last4digitHaveFocus = false, chasisNoHaveFocus = false;
  late FocusNode _focusNode;
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    uc.loadUserDetails();
    checkMode();
    _getCurrentPosition();
    DateTime today = DateTime.now();
    if (today.hour > 0 && today.hour < 12) {
      hc.selectedGreeting.value = 0;
    } else if (today.hour >= 12 && today.hour < 16) {
      hc.selectedGreeting.value = 1;
    } else {
      hc.selectedGreeting.value = 2;
    }
    //hcc.getGraphWeekApiData("search");
    hc.getAllDashboardApiData();
    init();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Future checkMode() async {
    ssc.currentPage.value =
        await Helper.getIntPreferences(SharedPreferencesVar.currentPage);
    isOnline = await Helper.getBoolPreferences(SharedPreferencesVar.isOnline);
    lastUpdateDate =
        await Helper.getStringPreferences(SharedPreferencesVar.lastUpdateDate);
    lastUpdateTime =
        await Helper.getStringPreferences(SharedPreferencesVar.lastUpdateTime);
    mode = isOnline ? "Online" : "Offline";

    final vehicleDb = VehicleDb();
    sc.offlineData.value = await vehicleDb.fetchAll();
    sc.offlineDataCount.value = await vehicleDb.getOfflineCount();
    print('offline data count ${sc.offlineData.length}');
    setState(() {});
  }

  Future init() async {
    String token =
        await Helper.getStringPreferences(SharedPreferencesVar.token);
    if (token.length > 5) {
      String lastUpdateDate = await Helper.getStringPreferences(
          SharedPreferencesVar.lastUpdateDate);

      print(lastUpdateDate);

      if (lastUpdateDate.length > 4) {
        ssc.loadPartialData.value = true;
        Timer.periodic(Duration(seconds: 5), (timer) async {
          int currentPage =
              await Helper.getIntPreferences(SharedPreferencesVar.currentPage);
          //print('ccccc - $currentPage');
          ssc.getAllDashboardApiDataPeriodically(currentPage);
        });
      } else {
        ssc.loadAllData.value = true;
        int offlinePageNumber = await Helper.getIntPreferences(
            SharedPreferencesVar.offlinePageNumber);
        ssc.getAllDashboardApiData(
            offlinePageNumber > 0 ? offlinePageNumber : 1);
      }
    }
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await Helper.handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      await Helper.setStringPreferences(
          SharedPreferencesVar.lat, position.latitude.toString());
      await Helper.setStringPreferences(
          SharedPreferencesVar.long, position.longitude.toString());
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(builder: (ctx, constraints) {
        var height = constraints.maxHeight;
        var width = constraints.maxWidth;
        return Column(
          children: [
            Container(
              width: Get.width * 1,
              color: ColorConstants.coalBlack,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GetX(
                      init: UserController(),
                      builder: (cc) {
                        return Text(
                          'Hey ${cc.userDetails['role'] == 'office-staff' ? cc.userDetails['staf']['name'] ?? '' : cc.userDetails['agent']['name'] ?? ''}',
                          style: TextStyle(color: ColorConstants.midGreyEAEAEA),
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() => Text(
                              hc.greeting[hc.selectedGreeting.value],
                              style: TextStyle(
                                  color: ColorConstants.lightGreyF5F5F5,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            )),
                        Row(
                          children: [
                            Text(
                              mode,
                              style: TextStyle(
                                  color: ColorConstants.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Switch(
                                value: isOnline,
                                onChanged: (value) async {
                                  await Helper.setBoolPreferences(
                                      SharedPreferencesVar.isOnline, value);
                                  setState(() {
                                    isOnline = value;
                                    mode = value ? "Online" : "Offline";
                                  });
                                }),
                          ],
                        )
                      ],
                    ),
                    Image.asset('assets/images/logo_t.png')
                  ],
                ),
              ),
            ),
            // Text(
            //   'Vinayak Recovery',
            //   style: TextStyle(
            //       color: ColorConstants.aqua, fontSize: height * 0.03),
            // ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 50,
                  width: width * 0.43,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: ColorConstants.aqua)),
                  child: Center(
                    child: Focus(
                      onFocusChange: (value) {
                        if (value) {
                          chasisNoHaveFocus = true;
                        } else {
                          chasisNoHaveFocus = false;
                        }
                      },
                      child: TextFormField(
                        controller: chasisNoCont,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              chasisNoCont.text = '';
                              setState(() {
                                showChasisNo = false;
                                showlastdata = false;
                              });
                            },
                            icon: const Icon(Icons.close),
                            color: ColorConstants.aqua,
                          ),
                          hintText: 'Chasis No.',
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 16.0),
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: ColorConstants.aqua),
                        ),
                        onChanged: (value) {
                          if (value.length >= 7) {
                            if (isOnline) {
                              sc.getAllSearchByChasisApiData(
                                  chasisNoCont.value.text.substring(0, 6));

                              // if (sc.searchbyChasisNoModel.value.data != null &&
                              //     sc.searchbyChasisNoModel.value.data!
                              //         .isNotEmpty) {
                              setState(() {
                                showChasisNo = true;
                                showlastdata = false;
                              });
                              // } else {
                              //   setState(() {
                              //     showlastdata = false;
                              //   });
                              // }
                              chasisNoCont.text = '';
                            } else {
                              sc.searchOfflineChasisData(value);

                              if (sc.offlineData.isNotEmpty) {
                                setState(() {
                                  showChasisNo = true;
                                  showlastdata = false;
                                });
                              } else {
                                setState(() {
                                  showlastdata = false;
                                });
                              }
                            }
                          } else {
                            setState(() {
                              //showChasisNo = false;
                              showlastdata = false;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: width * 0.43,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: ColorConstants.aqua)),
                  child: Center(
                    child: Focus(
                      onFocusChange: (value) {
                        if (value) {
                          last4digitHaveFocus = true;
                        } else {
                          last4digitHaveFocus = false;
                        }
                      },
                      child: TextFormField(
                        autofocus: true,
                        focusNode: _focusNode,
                        style: TextStyle(color: ColorConstants.aqua),
                        controller: last4digit,
                        maxLength: 4,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              last4digit.text = '';
                              setState(() {
                                showlastdata = false;
                              });
                            },
                            icon: const Icon(Icons.close),
                            color: ColorConstants.aqua,
                          ),
                          hintText: 'Last 4 Digits',
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 16.0),
                          border: InputBorder.none,
                          counterText: '',
                          hintStyle: TextStyle(color: ColorConstants.aqua),
                        ),
                        onChanged: (value) async {
                          if (value.length == 4) {
                            bool isOnline = await Helper.getBoolPreferences(
                                SharedPreferencesVar.isOnline);
                            if (isOnline) {
                              sc.getAllSearchByLastDigitData(
                                  last4digit.value.text);
                              setState(() {
                                showlastdata = true;
                              });
                            } else {
                              sc.searchOfflineLastDigitData(value);
                              setState(() {
                                showlastdata = true;
                              });
                            }
                            last4digit.text = '';
                          } else {
                            setState(() {
                              // showlastdata = false;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            if ((showChasisNo == true || chasisNoHaveFocus) &&
                showlastdata == false)
              Obx(() {
                switch (sc.rxRequestsearchbyChasisNoStatus.value) {
                  case Status.LOADING:
                    if (showChasisNo) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return const SizedBox();
                    }
                  case Status.ERROR:
                    return const Center(
                      child: Text('Something went wrong'),
                    );
                  case Status.COMPLETED:
                    if (isOnline) {
                      return Expanded(
                          child: Row(
                        children: [
                          SizedBox(
                            width: Get.width * 0.5,
                            child: ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              itemCount: sc.firstHalf.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(
                                        AppRoutes.searchedVehicleDetails,
                                        arguments: [
                                          sc.firstHalf[index],
                                          'repoAgent',
                                          isOnline,
                                        ]);
                                  },
                                  child: Container(
                                      height: 40,
                                      width: width * 1,
                                      margin: const EdgeInsets.only(top: 5),
                                      decoration: BoxDecoration(
                                        color: ColorConstants.aqua,
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Center(
                                          child: Text(
                                        sc.firstHalf[index].regNo ?? '',
                                        style: TextStyle(
                                            color: ColorConstants.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ))),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.5,
                            child: ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              itemCount: sc.secondHalf.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(
                                        AppRoutes.searchedVehicleDetails,
                                        arguments: [
                                          sc.secondHalf[index],
                                          'repoAgent',
                                          isOnline,
                                        ]);
                                  },
                                  child: Container(
                                      height: 40,
                                      width: width * 1,
                                      margin: const EdgeInsets.only(top: 5),
                                      decoration: BoxDecoration(
                                        color: ColorConstants.aqua,
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Center(
                                          child: Text(
                                        sc.secondHalf[index].regNo ?? '',
                                        style: TextStyle(
                                            color: ColorConstants.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ))),
                                );
                              },
                            ),
                          ),
                        ],
                      ));
                    } else {
                      return Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16.0,
                                  crossAxisSpacing: 16.0,
                                  childAspectRatio: 5),
                          itemCount: sc.offlineDataFiltered.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.searchedVehicleDetails,
                                    arguments: [
                                      sc.offlineDataFiltered[index],
                                      'repoAgent',
                                      isOnline,
                                    ]);
                              },
                              child: Container(
                                  height: 40,
                                  width: width * 0,
                                  decoration: BoxDecoration(
                                    color: ColorConstants.aqua,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Center(
                                      child: Text(
                                    sc.offlineDataFiltered[index].regNo ?? '',
                                    style: TextStyle(
                                        color: ColorConstants.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ))),
                            );
                          },
                        ),
                      );
                    }
                }
              }),
            if ((showlastdata == true || last4digitHaveFocus) &&
                showChasisNo == false)
              Obx(() {
                switch (sc.rxRequestsearchbyLastStatus.value) {
                  case Status.LOADING:
                    if (showlastdata) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return const SizedBox();
                    }
                  case Status.ERROR:
                    return const Center(
                      child: Text('SOmething went wrong'),
                    );
                  case Status.COMPLETED:
                    if (isOnline) {
                      return Expanded(
                        child: Row(
                          children: [
                            SizedBox(
                              width: Get.width * 0.5,
                              child: ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                itemCount: sc.firstHalf.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(
                                          AppRoutes.searchedVehicleDetails,
                                          arguments: [
                                            sc.firstHalf[index],
                                            'repoAgent',
                                            isOnline
                                          ]);
                                    },
                                    child: Container(
                                        height: 40,
                                        width: width * 1,
                                        margin: const EdgeInsets.only(top: 5),
                                        decoration: BoxDecoration(
                                          color: ColorConstants.aqua,
                                          borderRadius:
                                              BorderRadius.circular(18),
                                        ),
                                        child: Center(
                                            child: Text(
                                          sc.firstHalf[index].regNo ?? '',
                                          style: TextStyle(
                                              color: ColorConstants.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ))),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.5,
                              child: ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                itemCount: sc.secondHalf.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(
                                          AppRoutes.searchedVehicleDetails,
                                          arguments: [
                                            sc.secondHalf[index],
                                            'repoAgent',
                                            isOnline
                                          ]);
                                    },
                                    child: Container(
                                        height: 40,
                                        width: width * 1,
                                        margin: const EdgeInsets.only(top: 5),
                                        decoration: BoxDecoration(
                                          color: ColorConstants.aqua,
                                          borderRadius:
                                              BorderRadius.circular(18),
                                        ),
                                        child: Center(
                                            child: Text(
                                          sc.secondHalf[index].regNo ?? '',
                                          style: TextStyle(
                                              color: ColorConstants.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ))),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16.0,
                                  crossAxisSpacing: 16.0,
                                  childAspectRatio: 5),
                          itemCount: sc.offlineDataFiltered.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.searchedVehicleDetails,
                                    arguments: [
                                      sc.offlineDataFiltered[index],
                                      'repoAgent',
                                      isOnline
                                    ]);
                              },
                              child: Container(
                                  height: 40,
                                  width: width * 0,
                                  decoration: BoxDecoration(
                                    color: ColorConstants.aqua,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Center(
                                      child: Text(
                                    sc.offlineDataFiltered[index].regNo ?? '',
                                    style: TextStyle(
                                        color: ColorConstants.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ))),
                            );
                          },
                        ),
                      );
                    }
                }
              }),
            if (showlastdata == false && showChasisNo == false)
              Column(
                children: [
                  Container(
                    height: 40,
                    width: width * 0.95,
                    decoration: BoxDecoration(
                        color: ColorConstants.aqua,
                        borderRadius: BorderRadius.circular(18)),
                    child: Center(
                      child: Text(
                        'LAST UPDATE $lastUpdateDate  $lastUpdateTime',
                        style: TextStyle(
                            fontSize: 17, color: ColorConstants.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    switch (hc.rxRequestDashboardStatus.value) {
                      case Status.LOADING:
                        return const Center(child: CircularProgressIndicator());
                      case Status.ERROR:
                        return const Center(
                          child: Text('Something went wrong'),
                        );
                      case Status.COMPLETED:
                        return DefaultTabController(
                          length: 4,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        color: ColorConstants.aqua,
                                        borderRadius:
                                            BorderRadius.circular(18)),
                                    child: Center(
                                      child: Text(
                                        'Offline Data \n${sc.offlineDataCount.value}',
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: ColorConstants.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        color: ColorConstants.aqua,
                                        borderRadius:
                                            BorderRadius.circular(18)),
                                    child: Center(
                                      child: Obx(
                                        () => Text(
                                          'Online Data \n${hc.onlineDataCount.value}',
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: ColorConstants.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                width: Get.width * 1,
                                height: 170,
                                child: PieChart(PieChartData(sections: [
                                  PieChartSectionData(
                                      badgeWidget: Text('Release'),
                                      badgePositionPercentageOffset: 1.7,
                                      color: Colors.red,
                                      value: hc
                                          .dashboardModel.value.releaseCount!
                                          .toDouble()),
                                  PieChartSectionData(
                                      badgeWidget: Text('Hold'),
                                      badgePositionPercentageOffset: 1.5,
                                      color: ColorConstants.orangeFC8543,
                                      value: hc.dashboardModel.value.holdCount!
                                          .toDouble()),
                                  PieChartSectionData(
                                      badgeWidget: Text('Repo'),
                                      badgePositionPercentageOffset: 1.5,
                                      value: hc.dashboardModel.value.repoCount!
                                          .toDouble()),
                                ])),
                              )
                            ],
                          ),
                        );
                    }
                  }),
                ],
              ),
          ],
        );
      }),
    );
  }
}
