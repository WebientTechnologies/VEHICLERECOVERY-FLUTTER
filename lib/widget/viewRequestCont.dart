import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../core/constants/color_constants.dart';

class ViewRequestContainer extends StatelessWidget {
  final String regNo, id, bankName, custName, chasisNo, model, seezerName;
  final Color backgroundColor;

  final VoidCallback onViewDetailsPressed;
  final VoidCallback onRepoPressed;
  final VoidCallback onReleasePressed;

  ViewRequestContainer({
    Key? key,
    required this.regNo,
    required this.id,
    required this.bankName,
    required this.custName,
    required this.chasisNo,
    required this.model,
    required this.seezerName,
    required this.backgroundColor,
    required this.onViewDetailsPressed,
    required this.onRepoPressed,
    required this.onReleasePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 0.0,
                childAspectRatio: 2,
              ),
              itemCount: 6,
              itemBuilder: (BuildContext context, int index) {
                return _buildItem(index);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildItemWidget('Seezer Name', seezerName),
                _buildButtons()
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItem(int index) {
    switch (index) {
      case 0:
        return _buildItemWidget('ID', id);
      case 1:
        return _buildItemWidget('Bank Name', bankName);
      case 2:
        return _buildItemWidget('Cust. Name', custName);
      case 3:
        return _buildItemWidget('Reg. No', regNo);
      case 4:
        return _buildItemWidget('Chasis No', chasisNo);
      case 5:
        return _buildItemWidget('Model', model);
      case 6:
        return _buildItemWidget('Seezer Name', seezerName);

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
              await Clipboard.setData(ClipboardData(text: value)).then((value) {
                Fluttertoast.showToast(msg: 'Copied to Clipboard');
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

  Widget _buildButtons() {
    return Row(
      children: [
        _buildButton('View Details', onViewDetailsPressed),
        SizedBox(width: 4),
        _buildButton('Repo', onRepoPressed),
        SizedBox(width: 4),
        _buildButton('Release', onReleasePressed),
      ],
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return Container(
      width: Get.width * 0.22,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(),
          primary: ColorConstants.green,
        ),
      ),
    );
  }
}
