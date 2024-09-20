import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vinayak/core/constants/color_constants.dart';
import 'package:vinayak/core/global_controller/user_controller.dart';
import 'package:vinayak/core/response/status.dart';
import 'package:vinayak/widget/containerText.dart';
import 'package:vinayak/widget/pciconBtn.dart';

import 'controller/searchController.dart';

class SearchLDVehicleDetails extends StatefulWidget {
  //ld = last digit search from home page
  const SearchLDVehicleDetails({super.key});

  @override
  State<SearchLDVehicleDetails> createState() => _SearchLDVehicleDetailsState();
}

class _SearchLDVehicleDetailsState extends State<SearchLDVehicleDetails> {
  VehicleSearchController sc = Get.put(VehicleSearchController());
  dynamic data;
  bool isRepoAgent = false, isOnline = false;

  String role = '', from = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  UserController uc = Get.put(UserController());
  @override
  void initState() {
    super.initState();
    data = Get.arguments[0];
    role = Get.arguments[1];
    print('lengthhhh ${Get.arguments.length}');
    isOnline = Get.arguments[2];
    from = Get.arguments[3];
    sc.getAllSeezerData();
    if (role == 'officeStaff') {
      isRepoAgent = false;
    } else {
      isRepoAgent = true;
      sc.updateSearchList(isOnline ? data.id : data.dataId.toString());
    }
    //print(data.chasisNo);

    //print(data.id);
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri phoneCallUri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunch(phoneCallUri.toString())) {
      await launch(phoneCallUri.toString());
    } else {
      throw 'Could not launch $phoneCallUri';
    }
  }

  Widget _buildClickableContainer(double height, String phoneNumber) {
    return GestureDetector(
      onTap: () => _launchPhoneDialer(phoneNumber),
      child: ContainerWidget(
        height: height * 0.06,
        borderRadius: 18,
        borderColor: ColorConstants.aqua,
        hintText: phoneNumber,
      ),
    );
  }

  void _launchPhoneDialer(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (phoneNumber != null && await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  Widget buildInfoRow(String label, double height, double width, String value,
      {bool enableIcon = false, String text = ''}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style:
                TextStyle(fontSize: height * 0.023, color: ColorConstants.aqua),
          ),
          ContainerWidget(
            width: width * 0.6,
            height: 40,
            borderRadius: 18,
            borderColor: ColorConstants.aqua,
            hintText: value,
            enableIcon: enableIcon,
            text: text,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Vehicle Data',
          style: TextStyle(
              fontWeight: FontWeight.w500, color: ColorConstants.aqua),
        ),
      ),
      body: LayoutBuilder(builder: (ctx, constraints) {
        var height = constraints.maxHeight;
        var width = constraints.maxWidth;
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: isRepoAgent == true
                ? Column(
                    children: [
                      buildInfoRow(
                          'Registeration No', height, width, data.regNo ?? ''),
                      buildInfoRow(
                          'Customer Name',
                          height,
                          width,
                          from == 'home' || from == 'homee'
                              ? data.customerName ?? ''
                              : data.vehicleId.customerName ?? ''),
                      buildInfoRow(
                          'Bank Name',
                          height,
                          width,
                          from == 'home' || from == 'homee'
                              ? data.bankName
                              : data.vehicleId.bankName),
                      buildInfoRow('Vehicle Maker', height, width, ''),
                      const SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Load Status',
                            style: TextStyle(
                                fontSize: height * 0.023,
                                color: ColorConstants.aqua),
                          ),
                          Container(
                            width: Get.width * 0.6,
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: ColorConstants.aqua, width: 2),
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: Obx(
                                () => Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: DropdownButton(
                                      underline: const SizedBox(),
                                      isExpanded: true,
                                      items: sc.loadStatus,
                                      value: sc.selectedLoadStatus.value,
                                      onChanged: (value) {
                                        sc.selectedLoadStatus.value = value!;
                                        print(value!);
                                      }),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => Visibility(
                          visible: sc.selectedLoadStatus.value
                              .toLowerCase()
                              .contains('g'),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Load Item',
                                style: TextStyle(
                                    fontSize: height * 0.023,
                                    color: ColorConstants.aqua),
                              ),
                              Container(
                                  width: Get.width * 0.6,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: ColorConstants.aqua, width: 2),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                          hintText: 'Load Item',
                                          border: InputBorder.none),
                                      controller: sc.loadItemCont.value,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      PCIconButton(
                        onPressed: () {},
                        text: 'Confirm Numbers',
                        height: Get.height * 0.05,
                        textColor: Colors.white,
                        backgroundColor: ColorConstants.aqua,
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      _buildClickableContainer(height, '+919416319283'),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      _buildClickableContainer(height, '+917027817555'),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      _buildClickableContainer(height, '+917027818555'),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      _buildClickableContainer(height, '+917027819555'),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      _buildClickableContainer(height, '+917027820555'),
                      SizedBox(
                        height: height * 0.15,
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Seezer Name',
                            style: TextStyle(
                                fontSize: height * 0.023,
                                color: ColorConstants.aqua),
                          ),
                          Container(
                            width: Get.width * 0.6,
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: ColorConstants.aqua, width: 2),
                                borderRadius: BorderRadius.circular(50)),
                            child: from == 'home'
                                ? Center(
                                    child: Obx(() {
                                      switch (sc.rxSeezerListStatus.value) {
                                        case Status.LOADING:
                                          return Center(
                                            child: SizedBox(
                                                width: 20,
                                                height: 20,
                                                child:
                                                    CircularProgressIndicator()),
                                          );

                                        case Status.ERROR:
                                          return Text('Error');
                                        case Status.COMPLETED:
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: DropdownButton(
                                                underline: const SizedBox(),
                                                isExpanded: true,
                                                items: sc
                                                    .seezerModel.value.agents!
                                                    .map((e) =>
                                                        DropdownMenuItem(
                                                          child: Text(e.name!),
                                                          value: e.sId,
                                                        ))
                                                    .toList(),
                                                value: sc.selectedSeezer.value,
                                                onChanged: (value) {
                                                  sc.selectedSeezer.value =
                                                      value!;
                                                }),
                                          );
                                      }
                                    }),
                                  )
                                : Center(child: Text(data.seezerId!.name)),
                          )
                        ],
                      ),
                      buildInfoRow(
                          'Bank Name',
                          height,
                          width,
                          from == 'home' || from == 'homee'
                              ? data.bankName != null
                                  ? data.bankName
                                  : ''
                              : data.vehicleId!.bankName != null
                                  ? data.vehicleId!.bankName
                                  : ''),
                      buildInfoRow(
                          'Branch',
                          height,
                          width,
                          from == 'home' || from == 'homee'
                              ? data.branch != null
                                  ? data.branch
                                  : ''
                              : data.vehicleId!.branch != null
                                  ? data.vehicleId!.branch
                                  : ''),
                      buildInfoRow(
                          'Registeration No',
                          height,
                          width,
                          from == 'home' || from == 'homee'
                              ? data.regNo != null
                                  ? data.regNo
                                  : ''
                              : data.vehicleId!.regNo != null
                                  ? data.vehicleId!.regNo
                                  : ''),
                      buildInfoRow(
                          'Loan No',
                          height,
                          width,
                          from == 'home' || from == 'homee'
                              ? data.loanNo != null
                                  ? data.loanNo
                                  : ''
                              : data.vehicleId!.loanNo != null
                                  ? data.vehicleId!.loanNo
                                  : ''),
                      buildInfoRow(
                          'Customer Name',
                          height,
                          width,
                          from == 'home' || from == 'homee'
                              ? data.customerName != null
                                  ? data.customerName
                                  : ''
                              : data.vehicleId!.customerName != null
                                  ? data.vehicleId!.customerName
                                  : ''),
                      buildInfoRow(
                          'Model',
                          height,
                          width,
                          from == 'home' || from == 'homee'
                              ? data.model != null
                                  ? data.model
                                  : ''
                              : data.vehicleId!.model != null
                                  ? data.vehicleId!.model
                                  : ''),
                      buildInfoRow(
                          'Make',
                          height,
                          width,
                          from == 'home' || from == 'homee'
                              ? data.maker != null
                                  ? data.maker
                                  : ''
                              : data.vehicleId!.maker != null
                                  ? data.vehicleId!.maker
                                  : ''),
                      buildInfoRow(
                          'Chasis No',
                          height,
                          width,
                          from == 'home' || from == 'homee'
                              ? data.chasisNo != null
                                  ? data.chasisNo
                                  : ''
                              : data.vehicleId!.chasisNo != null
                                  ? data.vehicleId!.chasisNo
                                  : ''),
                      buildInfoRow(
                          'Engine No',
                          height,
                          width,
                          from == 'home' || from == 'homee'
                              ? data.engineNo != null
                                  ? data.engineNo
                                  : ''
                              : data.vehicleId!.engineNo != null
                                  ? data.vehicleId!.engineNo
                                  : ''),
                      buildInfoRow(
                          'EMI',
                          height,
                          width,
                          from == 'home' || from == 'homee'
                              ? data.emi != null
                                  ? data.emi
                                  : ''
                              : data.vehicleId!.emi != null
                                  ? data.vehicleId!.emi
                                  : ''),
                      buildInfoRow(
                          'Bucket',
                          height,
                          width,
                          from == 'home' || from == 'homee'
                              ? data.bucket != null
                                  ? data.bucket
                                  : ''
                              : data.vehicleId!.bucket != null
                                  ? data.vehicleId!.bucket
                                  : ''),
                      buildInfoRow(
                          'POS',
                          height,
                          width,
                          from == 'home' || from == 'homee'
                              ? data.pos != null
                                  ? data.pos
                                  : ''
                              : data.vehicleId!.pos != null
                                  ? data.vehicleId!.pos
                                  : ''),
                      buildInfoRow(
                          'TOS',
                          height,
                          width,
                          from == 'home' || from == 'homee'
                              ? data.tos != null
                                  ? data.tos
                                  : ''
                              : data.vehicleId!.tos != null
                                  ? data.vehicleId!.tos
                                  : ''),
                      buildInfoRow(
                          'Allocation',
                          height,
                          width,
                          from == 'home' || from == 'homee'
                              ? data.allocation != null
                                  ? data.allocation
                                  : ''
                              : data.vehicleId!.allocation != null
                                  ? data.vehicleId!.allocation
                                  : ''),
                      buildInfoRow(
                          'Call Center 1',
                          height,
                          width,
                          from == 'home' || from == 'homee'
                              ? data.callCenterNo1Name != null
                                  ? data.callCenterNo1Name
                                  : ''
                              : data.vehicleId!.callCenterNo1Name != null
                                  ? data.vehicleId!.callCenterNo1Name
                                  : ''),
                      buildInfoRow(
                          'Call Center No 1',
                          height,
                          width,
                          enableIcon: true,
                          from == 'home' || from == 'homee'
                              ? data.callCenterNo1 != null
                                  ? data.callCenterNo1
                                  : ''
                              : data.vehicleId!.callCenterNo1 != null
                                  ? data.vehicleId!.callCenterNo1
                                  : '',
                          text:
                              '''Respected Sir\n\nThis Vehicle Has Been Traced Out By Our Ground Team. Detail Of Customer And Their Vehicle Is Given Below.\n\nBank:${data.bankName}\nCustomer Name:${data.customerName}\nRegistration:${data.regNo}\nChasis No:${data.chasisNo}\nMaker:maker\nModel:\nAllocated Name:\nAllocated Dpd Bucket:\nOpning Od Bucket:\nOpning Od Amount:\nList Upload Date:\nVehicle Location:\nLoad Status:${sc.selectedLoadStatus.value}\nLoad Item:${sc.loadItemCont.value.text}\nList upload date:${data.createdAt.substring(0, 10)}\n\nPlease confirm This Vehicle On Urgent Basis Either Repo Or Release It.\n\nConfirmation Department\n*VINAYAK ASSOCIATES*
'''),
                      buildInfoRow(
                          'Call Center Email 1',
                          height,
                          Get.width * 0.9,
                          enableIcon: true,
                          from == 'home' || from == 'homee'
                              ? data.callCenterNo1Email != null
                                  ? data.callCenterNo1Email
                                  : ''
                              : data.vehicleId!.callCenterNo1Email != null
                                  ? data.vehicleId!.callCenterNo1Email
                                  : ''),
                      buildInfoRow(
                          'Call Center 2',
                          height,
                          width,
                          from == 'home' || from == 'homee'
                              ? data.callCenterNo2Name != null
                                  ? data.callCenterNo2Name
                                  : ''
                              : data.vehicleId!.callCenterNo2Name != null
                                  ? data.vehicleId!.callCenterNo2Name
                                  : ''),
                      buildInfoRow(
                          'Call Center No 2',
                          height,
                          width,
                          enableIcon: true,
                          from == 'home' || from == 'homee'
                              ? data.callCenterNo2 != null
                                  ? data.callCenterNo2
                                  : ''
                              : data.vehicleId!.callCenterNo2 != null
                                  ? data.vehicleId!.callCenterNo2
                                  : '',
                          text:
                              '''Respected Sir\n\nThis Vehicle Has Been Traced Out By Our Ground Team. Detail Of Customer And Their Vehicle Is Given Below.\n\nBank:${data.bankName}\nCustomer Name:${data.customerName}\nRegistration:${data.regNo}\nChasis No:${data.chasisNo}\nMaker:maker\nModel:\nAllocated Name:\nAllocated Dpd Bucket:\nOpning Od Bucket:\nOpning Od Amount:\nList Upload Date:\nVehicle Location:\nLoad Status:${sc.selectedLoadStatus.value}\nLoad Item:${sc.loadItemCont.value.text}\nList upload date:${data.createdAt.substring(0, 10)}\n\nPlease confirm This Vehicle On Urgent Basis Either Repo Or Release It.\n\nConfirmation Department\n*VINAYAK ASSOCIATES*
'''),
                      buildInfoRow(
                          'Call Center Email 2',
                          height,
                          Get.width * 0.9,
                          enableIcon: true,
                          from == 'home' || from == 'homee'
                              ? data.callCenterNo2Email != null
                                  ? data.callCenterNo2Email
                                  : ''
                              : data.vehicleId!.callCenterNo2Email != null
                                  ? data.vehicleId!.callCenterNo2Email
                                  : ''),
                      buildInfoRow(
                          'Call Center 3',
                          height,
                          width,
                          from == 'home' || from == 'homee'
                              ? data.callCenterNo3Name != null
                                  ? data.callCenterNo3Name
                                  : ''
                              : data.vehicleId!.callCenterNo3Name != null
                                  ? data.vehicleId!.callCenterNo3Name
                                  : ''),
                      buildInfoRow(
                          'Call Center No 3',
                          height,
                          width,
                          enableIcon: true,
                          from == 'home' || from == 'homee'
                              ? data.callCenterNo3 != null
                                  ? data.callCenterNo3
                                  : ''
                              : data.vehicleId!.callCenterNo3 != null
                                  ? data.vehicleId!.callCenterNo3
                                  : '',
                          text:
                              '''Respected Sir\n\nThis Vehicle Has Been Traced Out By Our Ground Team. Detail Of Customer And Their Vehicle Is Given Below.\n\nBank:${data.bankName}\nCustomer Name:${data.customerName}\nRegistration:${data.regNo}\nChasis No:${data.chasisNo}\nMaker:maker\nModel:\nAllocated Name:\nAllocated Dpd Bucket:\nOpning Od Bucket:\nOpning Od Amount:\nList Upload Date:\nVehicle Location:\nLoad Status:${sc.selectedLoadStatus.value}\nLoad Item:${sc.loadItemCont.value.text}\nList upload date:${data.createdAt.substring(0, 10)}\n\nPlease confirm This Vehicle On Urgent Basis Either Repo Or Release It.\n\nConfirmation Department\n*VINAYAK ASSOCIATES*
'''),
                      buildInfoRow(
                          'Call Center Email 3',
                          height,
                          Get.width * 0.9,
                          enableIcon: true,
                          from == 'home' || from == 'homee'
                              ? data.callCenterNo3Email != null
                                  ? data.callCenterNo3Email
                                  : ''
                              : data.vehicleId!.callCenterNo3Email != null
                                  ? data.vehicleId!.callCenterNo3Email
                                  : ''),
                      buildInfoRow(
                          'Address',
                          height,
                          width,
                          from == 'home' || from == 'homee'
                              ? data.address != null
                                  ? data.address
                                  : ''
                              : data.vehicleId!.address != null
                                  ? data.vehicleId!.address
                                  : ''),
                      buildInfoRow(
                          'SEC - 17',
                          height,
                          width,
                          from == 'home' || from == 'homee'
                              ? data.sec17 != null
                                  ? data.sec17
                                  : ''
                              : data.vehicleId!.sec17 != null
                                  ? data.vehicleId!.sec17
                                  : ''),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Load Status',
                            style: TextStyle(
                                fontSize: height * 0.023,
                                color: ColorConstants.aqua),
                          ),
                          Container(
                            width: Get.width * 0.6,
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: ColorConstants.aqua, width: 2),
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: Obx(
                                () => Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: DropdownButton(
                                      underline: const SizedBox(),
                                      isExpanded: true,
                                      items: sc.loadStatus,
                                      value: sc.selectedLoadStatus.value,
                                      onChanged: (value) {
                                        sc.selectedLoadStatus.value = value!;
                                      }),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => Visibility(
                          visible: sc.selectedLoadStatus.value
                              .toLowerCase()
                              .contains('g'),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Load Item',
                                style: TextStyle(
                                    fontSize: height * 0.023,
                                    color: ColorConstants.aqua),
                              ),
                              Container(
                                  width: Get.width * 0.6,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: ColorConstants.aqua, width: 2),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                          hintText: 'Load Item',
                                          border: InputBorder.none),
                                      controller: sc.loadItemCont.value,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        );
      }),
      bottomNavigationBar: from == 'home'
          ? Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PCIconButton(
                    onPressed: () {
                      sc.updateVehicleHoldRepo(context, data.id, isRepoAgent);
                    },
                    text: 'Hold',
                    width: Get.width * 0.8,
                    height: Get.height * 0.05,
                    textColor: Colors.white,
                    backgroundColor: ColorConstants.aqua,
                  ),
                  IconButton(
                      onPressed: () async {
                        String msg =
                            '''Respected Sir\n\nThis Vehicle Has Been Traced Out By Our Ground Team. Detail Of Customer And Their Vehicle Is Given Below.\n\nBank:${data.bankName}\nCustomer Name:${data.customerName}\nRegistration:${data.regNo}\nChasis No:${data.chasisNo}\nMaker:maker\nModel:\nAllocated Name:\nAllocated Dpd Bucket:\nOpning Od Bucket:\nOpning Od Amount:\nList Upload Date:\nVehicle Location:\nLoad Status:${sc.selectedLoadStatus.value}\nLoad Item:${sc.loadItemCont.value.text}\nList upload date:${data.createdAt.substring(0, 10)}\n\nPlease confirm This Vehicle On Urgent Basis Either Repo Or Release It.\n\nConfirmation Department\n*VINAYAK ASSOCIATES*
''';
                        print(msg);
                        Share.share(msg);
//                   final url = "https://wa.me?text=$msg";

//                   if (await canLaunchUrl(Uri.parse(url))) {
//                     await launchUrl(Uri.parse(url));
//                   } else {
//                     Fluttertoast.showToast(msg: 'Something went wrong');
//                   }
//                   if (!await launchUrl(Uri.parse(url)))
//                     throw 'Could not launch $url';
                      },
                      icon: Icon(
                        Icons.message,
                        color: ColorConstants.aqua,
                        size: 40,
                      ))
                ],
              ),
            )
          : const SizedBox(),
    );
  }
}
