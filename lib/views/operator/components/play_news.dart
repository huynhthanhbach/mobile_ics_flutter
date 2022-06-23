import 'package:flutter/material.dart';
import 'package:mobile_ics_flutter/views/operator/components/o_constants.dart';

class PlayNews extends StatelessWidget {
  const PlayNews(
      {super.key,
      required this.icon,
      required this.text,
      required String value,
      this.full});
  final String icon;
  final Widget text;
  final bool? full;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: defaultPadding * 2,
      child: Row(
        children: [
          const SizedBox(
            width: defaultPadding * 4 / 3,
          ),
          Image.asset(
            'assets/icons/$icon',
            width: 25,
          ),
          const SizedBox(
            width: defaultPadding,
          ),
          SizedBox(
            width: full == null
                ? MediaQuery.of(context).size.width * .3
                : MediaQuery.of(context).size.width * .55,
            child: text,
          )
        ],
      ),
    );
  }
}

class PlayNewsCard extends StatelessWidget {
  final double width;
  final String text;
  final bool isGrey;

  const PlayNewsCard({
    super.key,
    this.width = 200,
    required this.text,
    this.isGrey = false,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: isGrey ? kGrey : kBlack.withOpacity(.6), fontSize: text3),
      ),
    );
  }
}
