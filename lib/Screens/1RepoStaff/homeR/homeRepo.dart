import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinayak/core/constants/color_constants.dart';
import 'package:vinayak/core/constants/helper.dart';
import 'package:vinayak/core/constants/shared_preferences_var.dart';
import 'package:vinayak/core/global_controller/user_controller.dart';
import 'package:vinayak/core/sqlite/vehicledb.dart';
import 'package:vinayak/core/styles/text_styles.dart';
import 'package:vinayak/routes/app_routes.dart';
import '../../../core/response/status.dart';
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

  bool showlastdata = false;
  bool showChasisNo = false;
  bool isOnline = true;
  String mode = "Online";
  @override
  void initState() {
    super.initState();
    uc.loadUserDetails();
    checkMode();

    DateTime today = DateTime.now();
    if (today.hour > 0 && today.hour < 12) {
      hc.selectedGreeting.value = 0;
    } else if (today.hour >= 12 && today.hour < 16) {
      hc.selectedGreeting.value = 1;
    } else {
      hc.selectedGreeting.value = 2;
    }
    hc.getAllDashboardApiData();
    //init();
  }

  Future checkMode() async {
    isOnline = await Helper.getBoolPreferences(SharedPreferencesVar.isOnline);
    mode = isOnline ? "Online" : "Offline";

    final vehicleDb = VehicleDb();
    sc.offlineData.value = await vehicleDb.fetchAll();
    print(sc.offlineData.length);
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
      } else {
        ssc.loadAllData.value = true;
        int offlinePageNumber = await Helper.getIntPreferences(
            SharedPreferencesVar.offlinePageNumber);
        ssc.getAllDashboardApiData(
            offlinePageNumber > 0 ? offlinePageNumber : 1);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
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
                    const SizedBox(
                      height: 20,
                    ),
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
                    const SizedBox(
                      height: 20,
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
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: ColorConstants.aqua)),
                  child: Center(
                    child: TextFormField(
                      controller: chasisNoCont,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: ColorConstants.aqua,
                        ),
                        hintText: 'Chasis No.',
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 16.0),
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: ColorConstants.aqua),
                      ),
                      onChanged: (value) {
                        if (value.length >= 12) {
                          if (isOnline) {
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
                Container(
                  height: 50,
                  width: width * 0.43,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: ColorConstants.aqua)),
                  child: Center(
                    child: TextFormField(
                      style: TextStyle(color: ColorConstants.aqua),
                      controller: last4digit,
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search_rounded,
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
            const SizedBox(
              height: 20,
            ),
            if (showChasisNo == true && showlastdata == false)
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
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
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
                                    sc.searchbyChasisNoModel.value.data?[index]
                                            .regNo ??
                                        '',
                                    style:
                                        TextStyle(color: ColorConstants.white),
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
                                    style:
                                        TextStyle(color: ColorConstants.white),
                                  ))),
                            );
                          },
                        ),
                      );
                    }
                }
              }),
            if (showlastdata == true && showChasisNo == false)
              Obx(() {
                switch (sc.rxRequestsearchbyLastStatus.value) {
                  case Status.LOADING:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case Status.ERROR:
                    return const Center(
                      child: Text('SOmething went wrong'),
                    );
                  case Status.COMPLETED:
                    if (isOnline) {
                      return Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
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
                                    sc.searchbylastModel.value.data?[index]
                                            .regNo ??
                                        '',
                                    style: TextStyle(
                                        color: ColorConstants.white,
                                        fontWeight: FontWeight.w500),
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
                                    style:
                                        TextStyle(color: ColorConstants.white),
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
                        return const Center();
                      case Status.ERROR:
                        return const Center(
                          child: Text('Something went wrong'),
                        );
                      case Status.COMPLETED:
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
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
                                  Card(
                                    elevation: 10,
                                    child: Container(
                                      height: 130,
                                      width: 130,
                                      decoration: BoxDecoration(
                                          color: ColorConstants.aqua,
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                      child: Center(
                                        child: GestureDetector(
                                          onTap: () async {
                                            DeviceInfoPlugin deviceInfo =
                                                DeviceInfoPlugin();
                                            AndroidDeviceInfo androidInfo =
                                                await deviceInfo.androidInfo;
                                            String deviceId = androidInfo.id;

                                            print(deviceId);
                                          },
                                          child: Text(
                                            'HOLD DATA\n${hc.dashboardModel.value.holdCount}',
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyles.normalheadWhite20DM,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Card(
                                  elevation: 10,
                                  child: Container(
                                    height: 130,
                                    width: 130,
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
                                ),
                                Card(
                                  elevation: 10,
                                  child: Container(
                                    height: 130,
                                    width: 130,
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
    );
  }
}
