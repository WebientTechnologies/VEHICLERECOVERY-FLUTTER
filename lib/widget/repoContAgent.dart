import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../core/constants/color_constants.dart';

class HoldRepoDetailsWidgetAgent extends StatelessWidget {
  final String regNo, custName, bankName, maker, loadStatus, loadItem;

  final Color backgroundColor;

  HoldRepoDetailsWidgetAgent({
    Key? key,
    required this.regNo,
    required this.custName,
    required this.bankName,
    required this.maker,
    required this.loadStatus,
    required this.loadItem,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 20.0,
            childAspectRatio: 2,
          ),
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {
            return _buildItem(index);
          },
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
        return _buildItemWidget('Maker', maker);
      case 4:
        return _buildItemWidget('Load Status', loadStatus);
      case 5:
        return _buildItemWidget('Load Item', loadItem);

      default:
        return Container();
    }
  }

  Widget _buildItemWidget(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
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
    );
  }
}
