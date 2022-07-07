// ignore: camel_case_types
import 'package:flutter/material.dart';
import 'package:mobile_ics_flutter/views/operator/components/ktext.dart';
import 'package:mobile_ics_flutter/views/operator/components/op_constant.dart';

// ignore: camel_case_types
class Text1 extends StatelessWidget {
  final String text;
  final Color color;

  const Text1({super.key, required this.text, this.color = primaryColor});
  @override
  Widget build(BuildContext context) {
    return KText(
      text: text,
      isBold: true,
      tColor: color,
      size: header2,
    );
  }
}

// ignore: camel_case_types
class Text2 extends StatelessWidget {
  final String text;
  final Color color;

  const Text2({super.key, required this.text, this.color = primaryColor});
  @override
  Widget build(BuildContext context) {
    return KText(
      text: text,
      isBold: true,
      tColor: color,
      size: text3,
    );
  }
}
