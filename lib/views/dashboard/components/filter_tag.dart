import 'package:flutter/material.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/core/widgets/widget.dart';

class FilterTag extends StatelessWidget {
  const FilterTag({
    Key? key,
    this.name = '',
  }) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.padding10,
        vertical: Constants.padding5,
      ),
      decoration: BoxDecoration(
        color: kBackgroundTitle,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        name,
        style: KTextStyle.textButtonFitterStyle,
      ),
    );
  }
}
