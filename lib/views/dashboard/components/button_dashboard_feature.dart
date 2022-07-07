// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:mobile_ics_flutter/core/widgets/widget.dart';

class ButtonDashboardFeature extends StatelessWidget {
  const ButtonDashboardFeature({
    Key? key,
    this.backgroundColorOut = const Color(0xFFE5F7F6),
    this.borderColorOut = const Color(0xFF000000),
    this.backgroundColorIn = const Color(0xFFE5F7F6),
    this.borderColorIn = const Color(0xFFBCBEC3),
    required this.title,
    required this.image,
    required this.onPress,
  }) : super(key: key);

  final Color backgroundColorOut;
  final Color borderColorOut;
  final Color backgroundColorIn;
  final Color borderColorIn;
  final String title;
  final Widget image;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Container(
        height: 90,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Container(
              height: 65,
              width: 65,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: backgroundColorOut.withOpacity(.4),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: borderColorOut.withOpacity(.04),
                ),
              ),
              child: Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  color: backgroundColorIn,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: borderColorIn.withOpacity(.04),
                  ),
                ),
                child: image,
              ),
            ),
            Text(
              title,
              style: KTextStyle.textButtonTitleStyle,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
