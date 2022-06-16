import 'package:flutter/material.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/core/widgets/widget.dart';

class FilterTag extends StatelessWidget {
  const FilterTag({
    Key? key,
    required this.name,
  }) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.dkp * .5,
        vertical: Constants.dkp * .25,
      ),
      decoration: BoxDecoration(
        color: kBackgroundTitle,
        borderRadius: BorderRadius.circular(15),
      ),
      child: KText(
        text: name,
        size: 16,
        tColor: Colors.white,
        fontWeight: Constants.kSemiBold,
      ),
    );
  }
}
