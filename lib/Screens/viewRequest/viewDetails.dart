import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:vinayak/Screens/viewRequest/model/viewRequestModel.dart';
import 'package:vinayak/core/constants/color_constants.dart';
import 'package:vinayak/widget/containerText.dart';
import 'package:vinayak/widget/myappbar.dart';

class ViewRequestDetails extends StatefulWidget {
  //ld = last digit search from home page
  const ViewRequestDetails({super.key});

  @override
  State<ViewRequestDetails> createState() => _ViewRequestDetailsState();
}

class _ViewRequestDetailsState extends State<ViewRequestDetails> {
  Requests? data;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    data = Get.arguments[0];
    //print(data?.chasisNo);
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
        iconTheme: IconThemeData(color: ColorConstants.aqua),
        title: Text(
          'View Details',
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
            child: Column(
              children: [
                buildInfoRow('Seezer Name', height, width, 'name'),
                buildInfoRow(
                    'Registeration No', height, width, data?.regNo ?? ''),
                buildInfoRow(
                    'Customer Name', height, width, data?.customerName ?? ''),
                buildInfoRow('Bank Name', height, width, data?.bankName ?? ''),
                buildInfoRow('Branch', height, width, data?.branch ?? ''),
                buildInfoRow('EMI', height, width, ''),
                buildInfoRow('Vehicle Maker', height, width, ''),
                buildInfoRow(
                    'Agreement No', height, width, data?.agreementNo ?? ''),
                buildInfoRow('Chasis No', height, width, data?.chasisNo ?? ''),
                // buildInfoRow('Engine No', height, width, data?.engineNo ?? ''),
                buildInfoRow('Model', height, width, ''),
                // buildInfoRow(
                //     'Call Center 1', height, width, data?.callCenterNo1 ?? ''),
                // buildInfoRow('Call Center No 1', height, width,
                //     data?.callCenterNo1Name ?? ''),
                // buildInfoRow(
                //     'Call Center 2', height, width, data?.callCenterNo2 ?? ''),
                // buildInfoRow('Call Center No 2', height, width,
                //     data?.callCenterNo2Name ?? ''),
                // buildInfoRow('Call Center 2', height, width),
                // buildInfoRow('Call Center No 3', height, width),
                // buildInfoRow('Month', height, width, data?.month ?? ''),
                // buildInfoRow('Last Digit', height, width, data?.lastDigit ?? ''),
                // buildInfoRow('Status', height, width, data?.status ?? ''),
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
      //drawer: MyDrawer(),
    );
  }
}
