import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:vinayak/Screens/HomeScreen/controller/homeController.dart';
import 'package:vinayak/Screens/splashSCreen/model/vehicledata_model.dart';
import 'package:vinayak/core/constants/color_constants.dart';
import 'package:vinayak/core/styles/text_styles.dart';
import 'package:vinayak/routes/app_routes.dart';
import 'package:vinayak/widget/myappbar.dart';
import '../../core/constants/helper.dart';
import '../../core/constants/shared_preferences_var.dart';
import '../../core/global_controller/user_controller.dart';
import '../../core/response/status.dart';
import '../../core/sqlite/vehicledb.dart';
import '../searchVehicle/controller/searchController.dart';
import '../splashSCreen/controller/splashscreen_controller.dart';

class HomeSCreen extends StatefulWidget {
  const HomeSCreen({super.key});

  @override
  State<HomeSCreen> createState() => _HomeSCreenState();
}

class _HomeSCreenState extends State<HomeSCreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  HomeController hc = Get.put(HomeController());
  VehicleSearchController sc = Get.put(VehicleSearchController());
  SplashScreenController ssc = Get.put(SplashScreenController());

  TextEditingController last4digit = TextEditingController();
  TextEditingController chasisNoCont = TextEditingController();
  bool showChasisNo = false;
  bool isOnline = true;
  String mode = "Online", lastUpdateDate = "", lastUpdateTime = "";
  bool showlastdata = false;
  bool last4digitHaveFocus = false, chasisNoHaveFocus = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    checkMode();
    hc.getAllDashboardApiData();
    _getCurrentPosition();
    //hc.getGraphWeekApiData("search");
    DateTime today = DateTime.now();
    if (today.hour > 0 && today.hour < 12) {
      hc.selectedGreeting.value = 0;
    } else if (today.hour >= 12 && today.hour < 16) {
      hc.selectedGreeting.value = 1;
    } else {
      hc.selectedGreeting.value = 2;
    }
    //init();
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
    print(sc.offlineData.length);
    setState(() {});
  }

  Future init() async {
    String token =
        await Helper.getStringPreferences(SharedPreferencesVar.token);
    if (token.length > 5) {
      String lastUpdateDate = await Helper.getStringPreferences(
          SharedPreferencesVar.lastUpdateDate);

      if (lastUpdateDate.length > 4) {
        print("in new data");

        ssc.loadPartialData.value = true;
        Timer.periodic(Duration(seconds: 5), (timer) async {
          int currentPage =
              await Helper.getIntPreferences(SharedPreferencesVar.currentPage);
          print('ccccc - $currentPage');
          ssc.getAllDashboardApiDataPeriodically(currentPage);
        });
      } else {
        print("old data");
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
      // appBar: AppBar(
      //   toolbarHeight: 40,
      //   title: const Text('Vinayak Recovery'),
      //   actions: [
      //     Row(
      //       children: [
      //         Text(
      //           mode,
      //           style: TextStyle(
      //               color: ColorConstants.white,
      //               fontSize: 16,
      //               fontWeight: FontWeight.bold),
      //         ),
      //         const SizedBox(
      //           width: 10,
      //         ),
      //         Switch(
      //             value: isOnline,
      //             onChanged: (value) async {
      //               await Helper.setBoolPreferences(
      //                   SharedPreferencesVar.isOnline, value);
      //               setState(() {
      //                 isOnline = value;
      //                 mode = value ? "Online" : "Offline";
      //               });
      //             }),
      //       ],
      //     )
      //   ],
      //   titleTextStyle: TextStyle(
      //     color: ColorConstants.white,
      //     fontSize: 22,
      //     fontWeight: FontWeight.w600,
      //   ),
      //   backgroundColor: ColorConstants.aqua,
      //   leading: IconButton(
      //     onPressed: () {
      //       _scaffoldKey.currentState?.openDrawer();
      //     },
      //     icon: Icon(
      //       Icons.menu,
      //       color: Colors.white,
      //     ),
      //   ),
      // ),
      body: SafeArea(
        child: LayoutBuilder(builder: (ctx, constraints) {
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
                            style:
                                TextStyle(color: ColorConstants.midGreyEAEAEA),
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
                                    fontSize: 18,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: ColorConstants.aqua,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Focus(
                        onFocusChange: (v) {
                          if (v) {
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
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 16.0),
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            if (value.length == 6) {
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
                                showChasisNo = false;
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: ColorConstants.aqua,
                        width: 2,
                      ),
                    ),
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
                          focusNode: _focusNode,
                          autofocus: true,
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
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                              border: InputBorder.none,
                              counterText: ''),
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
                                //showlastdata = false;
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
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case Status.ERROR:
                      return const Center(
                        child: Text('Something went wrong'),
                      );
                    case Status.COMPLETED:
                      if (isOnline) {
                        return Expanded(
                          child: GridView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
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
                                        'officeStaff',
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
                                      sc.searchbyChasisNoModel.value
                                              .data?[index].regNo ??
                                          '',
                                      style: TextStyle(
                                          color: ColorConstants.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ))),
                              );
                            },
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
                                        'officeStaff',
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
                        child: Text('Something went wrong'),
                      );
                    case Status.COMPLETED:
                      if (isOnline) {
                        return Expanded(
                          child: GridView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 8.0,
                                    crossAxisSpacing: 8.0,
                                    childAspectRatio: 5),
                            itemCount: sc.searchbylastModel.value.data!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoutes.searchedVehicleDetails,
                                      arguments: [
                                        sc.searchbylastModel.value.data?[index],
                                        'officeStaff',
                                        isOnline
                                      ]);
                                },
                                child: Container(
                                    height: 0,
                                    width: width * 0,
                                    decoration: BoxDecoration(
                                      color: ColorConstants.aqua,
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: Center(
                                        child: Text(
                                      sc.searchbylastModel.value.data?[index]
                                              .regNo ??
                                          '',
                                      style: TextStyle(
                                          color: ColorConstants.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ))),
                              );
                            },
                          ),
                        );
                      } else {
                        return Expanded(
                          child: GridView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 8.0,
                                    crossAxisSpacing: 8.0,
                                    childAspectRatio: 5),
                            itemCount: sc.offlineDataFiltered.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoutes.searchedVehicleDetails,
                                      arguments: [
                                        sc.offlineDataFiltered[index],
                                        'officeStaff',
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
                      width: width * 0.9,
                      decoration: BoxDecoration(
                          color: ColorConstants.aqua,
                          borderRadius: BorderRadius.circular(18)),
                      child: Center(
                        child: Text(
                          'LAST UPDATE $lastUpdateDate $lastUpdateTime',
                          style: TextStyle(
                              fontSize: 17, color: ColorConstants.white),
                        ),
                      ),
                    ),
                    Obx(() {
                      switch (hc.rxRequestDashboardStatus.value) {
                        case Status.LOADING:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        case Status.ERROR:
                          return const Center(
                            child: Text('Something went wrong'),
                          );
                        case Status.COMPLETED:
                          return Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
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
                                height: 50,
                              ),
                              SizedBox(
                                width: Get.width * 1,
                                height: 170,
                                child: PieChart(PieChartData(sections: [
                                  PieChartSectionData(
                                      badgeWidget: Text('Search'),
                                      badgePositionPercentageOffset: 1.5,
                                      color: ColorConstants.yellowF2C200,
                                      value: hc
                                          .dashboardModel.value.searchCount!
                                          .toDouble()),
                                  PieChartSectionData(
                                      badgeWidget: Text('Release'),
                                      badgePositionPercentageOffset: 1.5,
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
                          );
                      }
                    }),
                  ],
                ),
            ],
          );
        }),
      ),
      //drawer: MyDrawer()
    );
  }
}
