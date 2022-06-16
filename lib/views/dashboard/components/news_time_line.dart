// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/core/widgets/widget.dart';
import 'package:timeline_tile/timeline_tile.dart';

class NewsTimeLine extends StatelessWidget {
  const NewsTimeLine({
    Key? key,
    required this.details,
  }) : super(key: key);

  final Map<String, dynamic> details;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.dkp * .25,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          _buildTimeLine(details['tlColor']),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KText(
                  text: details['time'],
                ),
                details['title'].isNotEmpty
                    ? _buildCard(
                        details['bgColor'], details['title'], details['slot'])
                    : _buildCard(Colors.white, '', ''),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(Color bgColor, String title, String slot) {
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
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.dkp * .25,
        vertical: Constants.dkp * .25,
      ),
      margin: const EdgeInsets.symmetric(vertical: Constants.dkp * .25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KText(text: title),
          const SizedBox(height: 10),
          KText(
            text: slot,
            tColor: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildTimeLine(Color color) {
    return Container(
      color: Colors.white,
      height: 80,
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
                border: Border.all(width: 5, color: color)),
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
