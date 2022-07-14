import 'package:flutter/material.dart';
import 'package:mobile_ics_flutter/views/operator/components/op_constant.dart';

class PlayNews extends StatelessWidget {
  const PlayNews(
      {super.key,
      required this.icon,
      required this.content,
      //required String value,
      this.full,
      this.height = padding3,
      this.text = ''});
  final String icon;
  final Widget content;
  final bool? full;
  final double height;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        children: [
          const SizedBox(
            width: padding2,
          ),
          Image.asset(
            icon,
            width: defaultIconSize,
          ),
          const SizedBox(
            width: padding1,
          ),
          (text == '')
              ? const SizedBox(
                  width: 0,
                )
              : Container(
                  padding: const EdgeInsets.only(right: defaultPadding * 1 / 3),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: opBlack.withOpacity(.6),
                      fontSize: text3,
                    ),
                  ),
                ),
          SizedBox(
            width: full == null
                ? MediaQuery.of(context).size.width * .3
                : MediaQuery.of(context).size.width * .65,
            child: content,
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
            color: isGrey ? opGray2 : opBlack.withOpacity(.6), fontSize: text3),
      ),
    );
  }
}
