import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinayak/Screens/HomeScreen/controller/homeController.dart';
import 'package:vinayak/core/constants/color_constants.dart';
import 'package:vinayak/core/styles/text_styles.dart';
import 'package:vinayak/routes/app_routes.dart';
import 'package:vinayak/widget/myappbar.dart';
import 'package:vinayak/widget/textfield.dart';
import '../../core/constants/helper.dart';
import '../../core/constants/shared_preferences_var.dart';
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
  String mode = "Online";
  bool showlastdata = false;
  @override
  void initState() {
    super.initState();
    hc.getAllDashboardApiData();
    checkMode();
    //init();
  }

  Future checkMode() async {
    isOnline = await Helper.getBoolPreferences(SharedPreferencesVar.isOnline);

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
        appBar: AppBar(
          toolbarHeight: 40,
          title: const Text('Vinayak Recovery'),
          actions: [
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
          titleTextStyle: TextStyle(
            color: ColorConstants.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
          backgroundColor: ColorConstants.aqua,
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
        ),
        body: LayoutBuilder(builder: (ctx, constraints) {
          var height = constraints.maxHeight;
          var width = constraints.maxWidth;
          return Column(
            children: [
              Center(
                child: Container(
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
                        maxLength: 4,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
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
                                      'officeStaff',
                                      isOnline
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
                      if (isOnline) {
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
                                        'officeStaff',
                                        isOnline
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
                                        isOnline
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
                                      sc.offlineDataFiltered[index].regNo ?? '',
                                      style:
                                          TextStyle(color: ColorConstants.aqua),
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
                                    Container(
                                      height: Get.height * 0.1,
                                      width: width * 0.43,
                                      decoration: BoxDecoration(
                                          color: ColorConstants.aqua,
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                      child: Center(
                                        child: Text(
                                          'SEARCH DATA\n${hc.dashboardModel.value.searchCount}',
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
                                        child: GestureDetector(
                                          onTap: () async {
                                            final vehicleDb = VehicleDb();

                                            // await vehicleDb.insertVehicle(
                                            //     'dataId',
                                            //     'loadStatus',
                                            //     'bankName',
                                            //     'branch',
                                            //     'agreementNo',
                                            //     'customerName',
                                            //     'regNo',
                                            //     'mychasisnoooooo',
                                            //     'engineNo',
                                            //     'callCenterNo1',
                                            //     'callCenterNo1Name',
                                            //     'callCenterNo2',
                                            //     'callCenterNo2Name',
                                            //     'lastDigit',
                                            //     'month',
                                            //     'status',
                                            //     'fileName',
                                            //     'createdAt',
                                            //     'updatedAt');

                                            await vehicleDb.fetchAll();
                                          },
                                          child: Text(
                                            'HOLD DATA\n${hc.dashboardModel.value.holdCount}',
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyles.normalheadWhite20DM,
                                          ),
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
        drawer: MyDrawer());
  }
}
