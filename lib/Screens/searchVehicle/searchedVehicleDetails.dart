import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinayak/core/constants/color_constants.dart';
import 'package:vinayak/core/global_controller/user_controller.dart';
import 'package:vinayak/widget/containerText.dart';
import 'package:vinayak/widget/myappbar.dart';
import 'package:vinayak/widget/pciconBtn.dart';
import 'package:url_launcher/url_launcher.dart';

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
  String role = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  UserController uc = Get.put(UserController());
  @override
  void initState() {
    super.initState();
    data = Get.arguments[0];
    role = Get.arguments[1];
    print('lengthhhh ${Get.arguments.length}');
    isOnline = Get.arguments[2];
    if (role == 'officeStaff') {
      isRepoAgent = false;
    } else {
      isRepoAgent = true;
      sc.updateSearchList(isOnline ? data.id : data.id.toString());
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

  Widget buildInfoRow(String label, double height, double width, String value) {
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
            width: width * 0.5,
            height: height * 0.05,
            borderRadius: 18,
            borderColor: ColorConstants.aqua,
            hintText: value,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                      buildInfoRow('Customer Name', height, width,
                          data.customerName ?? ''),
                      buildInfoRow(
                          'Bank Name', height, width, data.bankName ?? ''),
                      buildInfoRow('Vehicle Maker', height, width, ''),
                      buildInfoRow('Load Status', height, width, 'Empty'),
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
                      PCIconButton(
                        onPressed: () {
                          sc.updateVehicleHoldRepo(data.id);
                        },
                        text: 'Hold',
                        height: Get.height * 0.05,
                        textColor: Colors.white,
                        backgroundColor: ColorConstants.aqua,
                      ),
                    ],
                  )
                : Column(
                    children: [
                      buildInfoRow('Seezer Name', height, width, 'name'),
                      buildInfoRow(
                          'Registeration No', height, width, data.regNo ?? ''),
                      buildInfoRow('Customer Name', height, width,
                          data.customerName ?? ''),
                      buildInfoRow(
                          'Bank Name', height, width, data.bankName ?? ''),
                      buildInfoRow('Branch', height, width, data.branch ?? ''),
                      buildInfoRow('EMI', height, width, ''),
                      buildInfoRow('Vehicle Maker', height, width, ''),
                      buildInfoRow('Agreement No', height, width,
                          data.agreementNo ?? ''),
                      buildInfoRow(
                          'Chasis No', height, width, data.chasisNo ?? ''),
                      buildInfoRow(
                          'Engine No', height, width, data.engineNo ?? ''),
                      buildInfoRow('Model', height, width, ''),
                      buildInfoRow('Call Center 1', height, width,
                          data.callCenterNo1 ?? ''),
                      buildInfoRow('Call Center No 1', height, width,
                          data.callCenterNo1Name ?? ''),
                      buildInfoRow('Call Center 2', height, width,
                          data.callCenterNo2 ?? ''),
                      buildInfoRow('Call Center No 2', height, width,
                          data.callCenterNo2Name ?? ''),
                      // buildInfoRow('Call Center 2', height, width),
                      // buildInfoRow('Call Center No 3', height, width),
                      buildInfoRow('Month', height, width, data.month ?? ''),
                      buildInfoRow(
                          'Last Digit', height, width, data.lastDigit ?? ''),
                      buildInfoRow('Status', height, width, data.status ?? ''),
                      buildInfoRow('DL Code', height, width, ''),
                      buildInfoRow('TBR Flag', height, width, ''),
                      buildInfoRow('Executive Name', height, width, ''),
                      buildInfoRow('SEC-17', height, width, ''),
                      buildInfoRow('SEC-09', height, width, ''),
                      buildInfoRow('Seasoning', height, width, ''),
                      buildInfoRow('Upload Date', height, width, ''),
                    ],
                  ),
          ),
        );
      }),
    );
  }
}
