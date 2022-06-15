import 'package:flutter/material.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/core/widgets/widget.dart';

class DateTag extends StatelessWidget {
  const DateTag({
    Key? key,
    this.text = "Mon",
    this.num = "01",
    this.isNow = false,
  }) : super(key: key);

  final String text;
  final String num;
  final bool isNow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      decoration: BoxDecoration(
        color: (isNow) ? kBackgroundTag : kBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          KText(
            text: text,
            size: 16,
            fontWeight: Constants.kSemiBold,
            tColor: (isNow)
                ? kBackgroundTitle.withOpacity(.8)
                : const Color(0xFFBCBEC3).withOpacity(.6),
            overflow: TextOverflow.ellipsis,
          ),
          KText(
            text: num,
            size: 16,
            fontWeight: Constants.kBold,
            tColor: (isNow) ? kBackgroundTitle : Colors.black,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
