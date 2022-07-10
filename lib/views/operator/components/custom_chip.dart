import 'package:get/get.dart';
import 'package:mobile_ics_flutter/views/operator/components/component.dart';

import '../../../controllers/operator_controllers/operator_controller.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final double verticalMargin;
  final double horizontalMargin;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isBold;

  const CustomChip({
    super.key,
    required this.label,
    this.verticalMargin = 5,
    this.horizontalMargin = 5,
    this.backgroundColor,
    this.textColor,
    this.isBold = false,
  });
  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(
          color: textColor ?? primaryColor,
          fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      backgroundColor: backgroundColor ?? primaryColor.withOpacity(.2),
    );
  }
}

class CustomFilterChip extends StatelessWidget {
  const CustomFilterChip({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OperatorController>(
        builder: (_) => _.checkFiler.value
            ? Wrap(
                spacing: 7,
                runSpacing: 5,
                children: [
                  const Text(
                    'Bộ lọc: ',
                    style: textStyle3a,
                  ),
                  (_.filter[0] != 'Tất cả')
                      ? CustomChip(label: _.filter[0])
                      : const SizedBox(),
                  (_.filter[1] != 'Tất cả')
                      ? CustomChip(label: _.filter[1])
                      : const SizedBox(),
                  (_.filter[2] != 'Tất cả')
                      ? CustomChip(label: _.filter[2])
                      : const SizedBox(),
                  (_.filter[3] != 'Tất cả')
                      ? CustomChip(label: _.filter[3])
                      : const SizedBox(),
                  InkWell(
                    child: CustomChip(
                      label: 'Xoá bộ lọc',
                      backgroundColor: Colors.red.withOpacity(.0),
                      textColor: Colors.red,
                      isBold: true,
                    ),
                    onTap: () {
                      _.deleteFilter();
                      _.checkFilter();
                    },
                  ),
                ],
              )
            : const SizedBox());
  }
}
