import 'package:flutter/material.dart';

class PCIconButton extends StatelessWidget {
  final String? text;
  final Color? backgroundColor;
  final Color? textColor;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final Function onPressed;
  final IconData? iconcont;
  final IconData? icon;
  final ImageProvider? image;
  final IconData? iconPrefix;
  final IconData? iconSuffix;
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  final double? textSize;
  final double? iconsize;
  final Color? borderColor;

  const PCIconButton({
    Key? key,
    required this.onPressed,
    this.text,
    this.backgroundColor,
    this.textColor,
    this.fontWeight,
    this.fontFamily,
    this.iconcont,
    this.image,
    this.icon,
    this.iconPrefix,
    this.iconSuffix,
    this.width,
    this.height,
    this.borderRadius,
    this.textSize,
    this.borderColor,
    this.iconsize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 55,
      width: width ?? 400,
      child: TextButton(
        onPressed: () => onPressed(),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(15),
              side: BorderSide(color: borderColor ?? Colors.transparent),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (iconPrefix != null) ...[
                Icon(iconPrefix, color: textColor),
                const SizedBox(width: 6),
              ],
              if (iconcont != null) ...[
                Container(
                  height: 28,
                  decoration: BoxDecoration(
                    color: textColor?.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  padding: const EdgeInsets.all(2),
                  child: Icon(iconcont, color: textColor),
                ),
                const SizedBox(width: 2),
              ],
              if (icon != null) ...[
                Icon(icon, color: textColor),
              ],
              if (image != null) ...[
                Image(image: image!, height: 24, width: 24),
                const SizedBox(width: 8),
              ],
              if (text != null) ...[
                Text(
                  text!,
                  style: TextStyle(
                    fontSize: textSize ?? 17,
                    color: textColor,
                    fontWeight: fontWeight,
                    fontFamily: fontFamily,
                  ),
                ),
              ],
              const SizedBox(width: 2),
              if (iconSuffix != null || iconsize != null) ...[
                const SizedBox(width: 4),
                Icon(
                  iconSuffix,
                  color: textColor,
                  size: iconsize ?? 16,
                )
              ],
            ],
          ),
        ),
      ),
    );
  }
}
