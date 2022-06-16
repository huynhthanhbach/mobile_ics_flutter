import 'package:flutter/material.dart';

class KText extends StatelessWidget {
  const KText({
    Key? key,
    required this.text,
    this.tColor,
    this.size = 17,
    this.isBold = false,
    this.isCenter = false,
    this.spacing,
    this.maxLines,
    this.overflow,
    this.style,
    this.fontWeight,
  }) : super(key: key);
  final String text;
  final Color? tColor;
  final double size;
  final bool isBold;
  final bool isCenter;
  final double? spacing;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextStyle? style;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    var fontW = FontWeight.w500;

    if (isBold) {
      fontW = FontWeight.bold;
    }
    return Text(
      text,
      textAlign: isCenter ? TextAlign.center : null,
      overflow: overflow,
      maxLines: maxLines,
      style: style ??
          TextStyle(
            color: tColor,
            fontSize: size,
            fontWeight: fontWeight ?? fontW,
            letterSpacing: spacing,
          ),
    );
  }
}
