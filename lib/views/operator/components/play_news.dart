import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mobile_ics_flutter/views/operator/components/o_constants.dart';

class PlayNews extends StatelessWidget {
  const PlayNews(
      {super.key,
      required this.icon,
      required this.content,
      //required String value,
      this.full,
      this.height = 25.0,
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
            width: defaultPadding * 4 / 3,
          ),
          Image.asset(
            'assets/icons/$icon',
            width: 25,
          ),
          const SizedBox(
            width: defaultPadding,
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
                      color: kBlack.withOpacity(.6),
                      fontSize: text3,
                    ),
                  ),
                ),
          SizedBox(
            width: full == null
                ? MediaQuery.of(context).size.width * .3
                : MediaQuery.of(context).size.width * .55,
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
            color: isGrey ? kGrey : kBlack.withOpacity(.6), fontSize: text3),
      ),
    );
  }
}
