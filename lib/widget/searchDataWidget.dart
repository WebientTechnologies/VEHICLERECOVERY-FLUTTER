import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../core/constants/color_constants.dart';

class SearchDataWidget extends StatelessWidget {
  final String regNo,
      id,
      bankName,
      custName,
      chasisNo,
      model,
      seezerName,
      uploadDate,
      searchDate,
      searchTime;
  final Color backgroundColor;

  SearchDataWidget({
    Key? key,
    required this.regNo,
    required this.id,
    required this.bankName,
    required this.custName,
    required this.chasisNo,
    required this.model,
    required this.seezerName,
    required this.uploadDate,
    required this.searchDate,
    required this.searchTime,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 20.0,
              childAspectRatio: 2,
            ),
            itemCount: 9,
            itemBuilder: (BuildContext context, int index) {
              return _buildItem(index);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildItem(int index) {
    switch (index) {
      // case 0:
      //   return _buildItemWidget('ID', id);
      case 0:
        return _buildItemWidget('Bank Name', bankName);
      case 1:
        return _buildItemWidget('Cust. Name', custName);
      case 2:
        return _buildItemWidget('Reg. No', regNo);
      case 3:
        return _buildItemWidget('Chasis No', chasisNo);
      case 4:
        return _buildItemWidget('Model', model);
      case 5:
        return _buildItemWidget('Seezer Name', seezerName);
      case 6:
        return _buildItemWidget('Upload Date', uploadDate);
      case 7:
        return _buildItemWidget('Search Date', searchDate);
      case 8:
        return _buildItemWidget('Search Time', searchTime);
      default:
        return Container();
    }
  }

  Widget _buildItemWidget(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 10),
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: ColorConstants.white,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
            GestureDetector(
              onLongPress: () async {
                await Clipboard.setData(ClipboardData(text: value)).then((v) {
                  Fluttertoast.showToast(msg: 'Copied $value');
                });
              },
              child: Text(
                value,
                style: TextStyle(
                  color: ColorConstants.white,
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
