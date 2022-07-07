// ignore_for_file: camel_case_types
import 'component.dart';

class bottomSheetCard extends StatelessWidget {
  final String icon;
  final String name;
  final String value;
  final bool isPlaying;
  final double paddingLeft;
  final double paddingRight;

  const bottomSheetCard(
      {super.key,
      required this.icon,
      required this.name,
      required this.value,
      this.isPlaying = false,
      this.paddingLeft = 0,
      this.paddingRight = 0});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: paddingLeft,
        ),
        Image.asset(
          icon,
          width: defaultIconSize,
        ),
        const SizedBox(
          width: defaultPadding,
        ),
        Text(
          name,
          style: textStyle3a,
        ),
        Text(
          value,
          style: isPlaying ? textStyle3c : textStyle3b,
        ),
        SizedBox(
          width: paddingRight,
        ),
      ],
    );
  }
}
