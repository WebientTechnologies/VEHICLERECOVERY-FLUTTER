import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
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
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? maxLength; // New parameter for maximum character length

  TextFieldWidget({
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
    this.controller,
    this.validator,
    this.keyboardType,
    this.maxLength, // Added maxLength parameter
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLength: maxLength, // Use the provided maxLength
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          contentPadding:
              EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          fillColor: backgroundColor,
          filled: backgroundColor != null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor, width: borderWidth),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor, width: borderWidth),
          ),
          counterText: "", // Set counterText to an empty string
          counterStyle:
              TextStyle(fontSize: 0), // Set counterStyle to hide the counter
        ),
        style: TextStyle(
          fontSize: fontSize,
          color: textColor,
        ),
        validator: validator,
      ),
    );
  }
}
