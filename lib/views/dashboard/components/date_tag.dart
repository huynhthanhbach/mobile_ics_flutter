import 'package:flutter/material.dart';
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
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: (isNow)
                  ? kBackgroundTitle.withOpacity(.8)
                  : kBorButtonNews.withOpacity(.6),
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            num,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: (isNow) ? kBackgroundTitle : Colors.black,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
