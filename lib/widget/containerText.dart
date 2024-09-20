import 'package:direct_caller_sim_choice/direct_caller_sim_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vinayak/core/constants/image_constants.dart';

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
  final bool enableIcon;
  final String? text;

  ContainerWidget(
      {this.borderRadius = 8.0,
      this.borderColor = Colors.cyan,
      this.borderWidth = 2.0,
      required this.hintText,
      this.labelText,
      this.fontSize = 16.0,
      this.height,
      this.width,
      this.textColor,
      this.backgroundColor,
      this.enableIcon = false,
      this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 50),
      width: width,
      padding: const EdgeInsets.only(left: 5),
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
          child: Row(
            mainAxisAlignment: !enableIcon
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () async {
                  if (hintText.length == 10) {
                    await Permission.phone.request().then((v) {
                      if (v.isGranted) {
                        final DirectCaller directCaller = DirectCaller();
                        directCaller.makePhoneCall(hintText);
                      } else {
                        launchUrl(Uri.parse('tel:$hintText'));
                      }
                    });
                  }
                },
                child: enableIcon
                    ? Text(
                        hintText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: fontSize,
                          color: textColor,
                        ),
                      )
                    : SizedBox(
                        width: Get.width * 0.6 * 0.95,
                        child: Text(
                          hintText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: fontSize,
                            color: textColor,
                          ),
                        ),
                      ),
              ),
              if (enableIcon && hintText.isNotEmpty)
                GestureDetector(
                  onTap: () async {
                    await launchUrl(
                        Uri.parse('https://wa.me/$hintText?text=$text'));
                  },
                  child: Image.asset(
                    ImageConstants.whatsapp,
                    width: 35,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
