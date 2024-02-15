import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinayak/Screens/HomeScreen/controller/homeController.dart';
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
  String mode = "Online", lastUpdateDate = "";
  bool showlastdata = false;
  @override
  void initState() {
    super.initState();
    checkMode();
    hc.getGraphWeekApiData("search");
    hc.getAllDashboardApiData();
    DateTime today = DateTime.now();
    if (today.hour > 0 && today.hour < 12) {
      hc.selectedGreeting.value = 0;
    } else if (today.hour >= 12 && today.hour < 16) {
      hc.selectedGreeting.value = 1;
    } else {
      hc.selectedGreeting.value = 2;
    }
    init();
  }

  Future checkMode() async {
    isOnline = await Helper.getBoolPreferences(SharedPreferencesVar.isOnline);
    lastUpdateDate =
        await Helper.getStringPreferences(SharedPreferencesVar.lastUpdateDate);
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
            const SizedBox(
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
                        if (value.length >= 7) {
                          sc.getAllSearchByChasisApiData(
                              chasisNoCont.value.text.substring(0, 6));

                          if (sc.searchbyChasisNoModel.value.data != null &&
                              sc.searchbyChasisNoModel.value.data!.isNotEmpty) {
                            setState(() {
                              showChasisNo = true;
                              showlastdata = false;
                            });
                          } else {
                            setState(() {
                              showlastdata = false;
                            });
                          }
                          chasisNoCont.text = '';
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
                      child: Text('SOmething went wrong'),
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
                                        fontWeight: FontWeight.bold),
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
                                        fontWeight: FontWeight.bold),
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
                        'LAST UPDATE $lastUpdateDate',
                        style: TextStyles.normalheadWhite20DM,
                      ),
                    ),
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
                        return DefaultTabController(
                          length: 5,
                          child: Column(
                            children: [
                              TabBar(
                                  onTap: (i) {
                                    switch (i) {
                                      case 0:
                                        //hc.getGraphWeekApiData("search");
                                        break;
                                      case 1:
                                        hc.getGraphWeekApiData("search");
                                        break;
                                      case 2:
                                        hc.getGraphWeekApiData("release");
                                        break;
                                      case 3:
                                        hc.getGraphWeekApiData("hold");
                                        break;
                                      case 4:
                                        hc.getGraphWeekApiData("repo");
                                        break;
                                    }
                                  },
                                  tabs: const [
                                    Tab(
                                      text: 'Dashboard',
                                    ),
                                    Tab(
                                      text: 'Search',
                                    ),
                                    Tab(
                                      text: 'Release',
                                    ),
                                    Tab(
                                      text: 'Hold',
                                    ),
                                    Tab(
                                      text: 'Repo',
                                    ),
                                  ]),
                              SizedBox(
                                width: Get.width * 0.95,
                                height: 250,
                                child: TabBarView(children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                            color: ColorConstants.aqua,
                                            borderRadius:
                                                BorderRadius.circular(18)),
                                        child: Center(
                                          child: Text(
                                            'Offline Data \n${sc.offlineDataCount.value}',
                                            style:
                                                TextStyles.normalheadWhite20DM,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                            color: ColorConstants.aqua,
                                            borderRadius:
                                                BorderRadius.circular(18)),
                                        child: Center(
                                          child: Obx(
                                            () => Text(
                                              'Online Data \n${hc.onlineDataCount.value}',
                                              style: TextStyles
                                                  .normalheadWhite20DM,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 60),
                                        width: Get.width * 1,
                                        height: 190,
                                        child: LineChart(LineChartData(
                                            maxX: 7,
                                            clipData: const FlClipData.all(),
                                            borderData: FlBorderData(
                                                border: const Border(
                                                    bottom: BorderSide(),
                                                    left: BorderSide())),
                                            backgroundColor:
                                                ColorConstants.coalBlack,
                                            titlesData: FlTitlesData(
                                                bottomTitles: AxisTitles(
                                                    sideTitles: SideTitles(
                                                        showTitles: true,
                                                        getTitlesWidget:
                                                            (value, meta) {
                                                          String text = '';
                                                          switch (
                                                              value.toInt()) {
                                                            case 0:
                                                              text = 'Sun';
                                                              break;
                                                            case 1:
                                                              text = 'Mon';
                                                              break;
                                                            case 2:
                                                              text = 'Tue';
                                                              break;
                                                            case 3:
                                                              text = 'Wed';
                                                              break;
                                                            case 4:
                                                              text = 'Thu';
                                                              break;
                                                            case 5:
                                                              text = 'Fri';
                                                              break;
                                                            case 6:
                                                              text = 'Sat';
                                                              break;
                                                            case 7:
                                                              text = 'Sun';
                                                              break;
                                                          }

                                                          return Text(text);
                                                        })),
                                                topTitles: AxisTitles(
                                                    sideTitles: SideTitles(
                                                        showTitles: false,
                                                        getTitlesWidget:
                                                            (value, meta) {
                                                          String text = '';
                                                          switch (
                                                              value.toInt()) {
                                                            case 0:
                                                              text = 'Sun';
                                                              break;
                                                            case 1:
                                                              text = 'Mon';
                                                              break;
                                                            case 2:
                                                              text = 'Tue';
                                                              break;
                                                            case 3:
                                                              text = 'Wed';
                                                              break;
                                                            case 4:
                                                              text = 'Thu';
                                                              break;
                                                            case 5:
                                                              text = 'Fri';
                                                              break;
                                                            case 6:
                                                              text = 'Sat';
                                                              break;
                                                            case 7:
                                                              text = 'Sun';
                                                              break;
                                                          }

                                                          return Text(text);
                                                        })),
                                                rightTitles: const AxisTitles(
                                                    sideTitles: SideTitles(
                                                        showTitles: false))),
                                            lineBarsData: [
                                              LineChartBarData(
                                                  belowBarData: BarAreaData(
                                                      show: true,
                                                      gradient: LinearGradient(
                                                          transform:
                                                              const GradientRotation(
                                                                  90),
                                                          colors: [
                                                            ColorConstants.aqua,
                                                            ColorConstants
                                                                .coalBlack,
                                                          ])),
                                                  shadow: Shadow(
                                                      color:
                                                          ColorConstants.aqua),
                                                  isCurved: true,
                                                  spots: hc.weekData
                                                      .map((e) => FlSpot(
                                                          e.count!.toDouble(),
                                                          e.totalVehicle!
                                                              .toDouble()))
                                                      .toList())
                                            ])),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 60),
                                        width: Get.width * 1,
                                        height: 190,
                                        child: LineChart(LineChartData(
                                            maxX: 7,
                                            clipData: const FlClipData.all(),
                                            borderData: FlBorderData(
                                                border: const Border(
                                                    bottom: BorderSide(),
                                                    left: BorderSide())),
                                            backgroundColor:
                                                ColorConstants.coalBlack,
                                            titlesData: FlTitlesData(
                                                bottomTitles: AxisTitles(
                                                    sideTitles: SideTitles(
                                                        showTitles: true,
                                                        getTitlesWidget:
                                                            (value, meta) {
                                                          String text = '';
                                                          switch (
                                                              value.toInt()) {
                                                            case 0:
                                                              text = 'Sun';
                                                              break;
                                                            case 1:
                                                              text = 'Mon';
                                                              break;
                                                            case 2:
                                                              text = 'Tue';
                                                              break;
                                                            case 3:
                                                              text = 'Wed';
                                                              break;
                                                            case 4:
                                                              text = 'Thu';
                                                              break;
                                                            case 5:
                                                              text = 'Fri';
                                                              break;
                                                            case 6:
                                                              text = 'Sat';
                                                              break;
                                                            case 7:
                                                              text = 'Sun';
                                                              break;
                                                          }

                                                          return Text(text);
                                                        })),
                                                topTitles: AxisTitles(
                                                    sideTitles: SideTitles(
                                                        showTitles: false,
                                                        getTitlesWidget:
                                                            (value, meta) {
                                                          String text = '';
                                                          switch (
                                                              value.toInt()) {
                                                            case 0:
                                                              text = 'Sun';
                                                              break;
                                                            case 1:
                                                              text = 'Mon';
                                                              break;
                                                            case 2:
                                                              text = 'Tue';
                                                              break;
                                                            case 3:
                                                              text = 'Wed';
                                                              break;
                                                            case 4:
                                                              text = 'Thu';
                                                              break;
                                                            case 5:
                                                              text = 'Fri';
                                                              break;
                                                            case 6:
                                                              text = 'Sat';
                                                              break;
                                                            case 7:
                                                              text = 'Sun';
                                                              break;
                                                          }

                                                          return Text(text);
                                                        })),
                                                rightTitles: const AxisTitles(
                                                    sideTitles: SideTitles(
                                                        showTitles: false))),
                                            lineBarsData: [
                                              LineChartBarData(
                                                  belowBarData: BarAreaData(
                                                      show: true,
                                                      gradient: LinearGradient(
                                                          transform:
                                                              const GradientRotation(
                                                                  90),
                                                          colors: [
                                                            ColorConstants.aqua,
                                                            ColorConstants
                                                                .coalBlack,
                                                          ])),
                                                  shadow: Shadow(
                                                      color:
                                                          ColorConstants.aqua),
                                                  isCurved: true,
                                                  spots: hc.weekData
                                                      .map((e) => FlSpot(
                                                          e.count!.toDouble(),
                                                          e.totalVehicle!
                                                              .toDouble()))
                                                      .toList())
                                            ])),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 60),
                                        width: Get.width * 1,
                                        height: 190,
                                        child: LineChart(LineChartData(
                                            maxX: 7,
                                            clipData: const FlClipData.all(),
                                            borderData: FlBorderData(
                                                border: const Border(
                                                    bottom: BorderSide(),
                                                    left: BorderSide())),
                                            backgroundColor:
                                                ColorConstants.coalBlack,
                                            titlesData: FlTitlesData(
                                                bottomTitles: AxisTitles(
                                                    sideTitles: SideTitles(
                                                        showTitles: true,
                                                        getTitlesWidget:
                                                            (value, meta) {
                                                          String text = '';
                                                          switch (
                                                              value.toInt()) {
                                                            case 0:
                                                              text = 'Sun';
                                                              break;
                                                            case 1:
                                                              text = 'Mon';
                                                              break;
                                                            case 2:
                                                              text = 'Tue';
                                                              break;
                                                            case 3:
                                                              text = 'Wed';
                                                              break;
                                                            case 4:
                                                              text = 'Thu';
                                                              break;
                                                            case 5:
                                                              text = 'Fri';
                                                              break;
                                                            case 6:
                                                              text = 'Sat';
                                                              break;
                                                            case 7:
                                                              text = 'Sun';
                                                              break;
                                                          }

                                                          return Text(text);
                                                        })),
                                                topTitles: AxisTitles(
                                                    sideTitles: SideTitles(
                                                        showTitles: false,
                                                        getTitlesWidget:
                                                            (value, meta) {
                                                          String text = '';
                                                          switch (
                                                              value.toInt()) {
                                                            case 0:
                                                              text = 'Sun';
                                                              break;
                                                            case 1:
                                                              text = 'Mon';
                                                              break;
                                                            case 2:
                                                              text = 'Tue';
                                                              break;
                                                            case 3:
                                                              text = 'Wed';
                                                              break;
                                                            case 4:
                                                              text = 'Thu';
                                                              break;
                                                            case 5:
                                                              text = 'Fri';
                                                              break;
                                                            case 6:
                                                              text = 'Sat';
                                                              break;
                                                            case 7:
                                                              text = 'Sun';
                                                              break;
                                                          }

                                                          return Text(text);
                                                        })),
                                                rightTitles: const AxisTitles(
                                                    sideTitles: SideTitles(
                                                        showTitles: false))),
                                            lineBarsData: [
                                              LineChartBarData(
                                                  belowBarData: BarAreaData(
                                                      show: true,
                                                      gradient: LinearGradient(
                                                          transform:
                                                              const GradientRotation(
                                                                  90),
                                                          colors: [
                                                            ColorConstants.aqua,
                                                            ColorConstants
                                                                .coalBlack,
                                                          ])),
                                                  shadow: Shadow(
                                                      color:
                                                          ColorConstants.aqua),
                                                  isCurved: true,
                                                  spots: hc.weekData
                                                      .map((e) => FlSpot(
                                                          e.count!.toDouble(),
                                                          e.totalVehicle!
                                                              .toDouble()))
                                                      .toList())
                                            ])),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 60),
                                        width: Get.width * 1,
                                        height: 190,
                                        child: LineChart(LineChartData(
                                            maxX: 7,
                                            clipData: const FlClipData.all(),
                                            borderData: FlBorderData(
                                                border: const Border(
                                                    bottom: BorderSide(),
                                                    left: BorderSide())),
                                            backgroundColor:
                                                ColorConstants.coalBlack,
                                            titlesData: FlTitlesData(
                                                bottomTitles: AxisTitles(
                                                    sideTitles: SideTitles(
                                                        showTitles: true,
                                                        getTitlesWidget:
                                                            (value, meta) {
                                                          String text = '';
                                                          switch (
                                                              value.toInt()) {
                                                            case 0:
                                                              text = 'Sun';
                                                              break;
                                                            case 1:
                                                              text = 'Mon';
                                                              break;
                                                            case 2:
                                                              text = 'Tue';
                                                              break;
                                                            case 3:
                                                              text = 'Wed';
                                                              break;
                                                            case 4:
                                                              text = 'Thu';
                                                              break;
                                                            case 5:
                                                              text = 'Fri';
                                                              break;
                                                            case 6:
                                                              text = 'Sat';
                                                              break;
                                                            case 7:
                                                              text = 'Sun';
                                                              break;
                                                          }

                                                          return Text(text);
                                                        })),
                                                topTitles: AxisTitles(
                                                    sideTitles: SideTitles(
                                                        showTitles: false,
                                                        getTitlesWidget:
                                                            (value, meta) {
                                                          String text = '';
                                                          switch (
                                                              value.toInt()) {
                                                            case 0:
                                                              text = 'Sun';
                                                              break;
                                                            case 1:
                                                              text = 'Mon';
                                                              break;
                                                            case 2:
                                                              text = 'Tue';
                                                              break;
                                                            case 3:
                                                              text = 'Wed';
                                                              break;
                                                            case 4:
                                                              text = 'Thu';
                                                              break;
                                                            case 5:
                                                              text = 'Fri';
                                                              break;
                                                            case 6:
                                                              text = 'Sat';
                                                              break;
                                                            case 7:
                                                              text = 'Sun';
                                                              break;
                                                          }

                                                          return Text(text);
                                                        })),
                                                rightTitles: const AxisTitles(
                                                    sideTitles: SideTitles(
                                                        showTitles: false))),
                                            lineBarsData: [
                                              LineChartBarData(
                                                  belowBarData: BarAreaData(
                                                      show: true,
                                                      gradient: LinearGradient(
                                                          transform:
                                                              const GradientRotation(
                                                                  90),
                                                          colors: [
                                                            ColorConstants.aqua,
                                                            ColorConstants
                                                                .coalBlack,
                                                          ])),
                                                  shadow: Shadow(
                                                      color:
                                                          ColorConstants.aqua),
                                                  isCurved: true,
                                                  spots: hc.weekData
                                                      .map((e) => FlSpot(
                                                          e.count!.toDouble(),
                                                          e.totalVehicle!
                                                              .toDouble()))
                                                      .toList())
                                            ])),
                                      ),
                                    ],
                                  ),
                                ]),
                              ),
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
      //drawer: MyDrawer()
    );
  }
}
