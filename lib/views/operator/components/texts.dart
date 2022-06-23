// ignore: camel_case_types
import 'package:flutter/material.dart';
import 'package:mobile_ics_flutter/views/operator/components/o_constants.dart';

import '../../../core/widgets/ktext.dart';

// ignore: camel_case_types
class textStyle1 extends StatelessWidget {
  final String text;
  final Color color;

  const textStyle1({super.key, required this.text, this.color = primaryColor});
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
class textStyle2 extends StatelessWidget {
  final String text;
  final Color color;

  const textStyle2({super.key, required this.text, this.color = primaryColor});
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
