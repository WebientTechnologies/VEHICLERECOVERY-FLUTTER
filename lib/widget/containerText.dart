import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ContainerWidget extends StatelessWidget {
  final double borderRadius;
  final Color borderColor;
  final double borderWidth;
  final String hintText;
  final String? labelText;
  final double fontSize;
  final double? height;
  final double? width;
  final Color? textColor;
  final Color? backgroundColor;

  ContainerWidget({
    this.borderRadius = 8.0,
    this.borderColor = Colors.cyan,
    this.borderWidth = 2.0,
    required this.hintText,
    this.labelText,
    this.fontSize = 16.0,
    this.height,
    this.width,
    this.textColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: borderColor,
            width: borderWidth,
          ),
        ),
        child: Center(
          child: GestureDetector(
            onLongPress: () async {
              await Clipboard.setData(ClipboardData(text: hintText));
              Fluttertoast.showToast(msg: 'Copied $hintText');
            },
            child: Text(
              hintText,
              style: TextStyle(
                fontSize: fontSize,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
