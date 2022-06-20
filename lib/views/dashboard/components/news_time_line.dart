// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/core/widgets/widget.dart';

class NewsTimeLine extends StatelessWidget {
  const NewsTimeLine({
    Key? key,
    this.isNow = false,
    required this.details,
  }) : super(key: key);

  final bool isNow;

  final Map<String, dynamic> details;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.dkp * .5,
      ),
      margin: const EdgeInsets.only(
        bottom: Constants.dkp * .25,
      ),
      decoration: BoxDecoration(
        // color: Colors.white,
        color: (isNow) ? kBackgroundTag : Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          _buildTimeLine(details['tlColor'], isNow: isNow),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KText(
                  text: details['time'],
                  size: 15,
                  fontWeight: Constants.kBold,
                  tColor: kBackgroundTitle,
                ),
                details['title'].isNotEmpty
                    ? _buildCard(
                        details['bgColor'], details['title'], details['slot'],
                        isNow: isNow)
                    : _buildCard(Colors.white, '', '', isNow: isNow),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(Color bgColor, String title, String slot,
      {bool isNow = false}) {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.only(
        left: Constants.dkp * .25,
        right: Constants.dkp * .25,
        top: Constants.dkp * .25,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: Constants.dkp * .25,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              KText(
                text: title,
                size: 15,
                fontWeight: Constants.kBold,
                tColor: kBackgroundTitle,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: Constants.dkp * .25),
              KText(
                text: title,
                size: 15,
                fontWeight: Constants.kRegular,
                tColor: kBackgroundTitle,
                overflow: TextOverflow.ellipsis,
              ),
              Expanded(
                child: SizedBox(
                  width: 230,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      KText(
                        text: slot,
                        tColor: const Color(0xFFA0999B),
                        fontWeight: Constants.kRegular,
                        size: 15,
                        overflow: TextOverflow.ellipsis,
                      ),
                      (isNow)
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset(
                                  'assets/icons/music-playing.png',
                                  width: 30,
                                  color: Colors.blue,
                                ),
                              ],
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeLine(Color color, {bool isNow = false}) {
    return Container(
      decoration: BoxDecoration(
        color: (isNow) ? kBackgroundTag : Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 90,
      width: 20,
      child: TimelineTile(
        alignment: TimelineAlign.manual,
        lineXY: 0,
        isFirst: true,
        indicatorStyle: IndicatorStyle(
          indicatorXY: 0,
          width: 15,
          indicator: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                width: Constants.dkp * .25,
                color: color,
              ),
            ),
          ),
        ),
        afterLineStyle: LineStyle(
          thickness: 2,
          color: color,
        ),
      ),
    );
  }
}
