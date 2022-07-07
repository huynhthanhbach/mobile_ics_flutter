import 'package:mobile_ics_flutter/views/operator/components/component.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../controllers/operator_controllers/operator_controller.dart';
import 'tempdb.dart';

void showFixedSchdule(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (ctx) {
      return MultiSelectDialog(
        title: const Text(selectTimeHint),
        items: time_items,
        initialValue: listTimeSelected,
        onConfirm: (List<Time> results) {
          listTimeSelected = results;
        },
        height: 250,
        width: 200,
      );
    },
  );
  //print(time_selected);
}

void showDeviceSelect(
    BuildContext context, OperatorController controller) async {
  await showDialog(
    context: context,
    builder: (ctx) {
      return MultiSelectDialog(
        title: const Text(selectDeviceHint),
        items: device_items,
        initialValue: listDeviceSelected,
        onConfirm: (List<Device> results) {
          listDeviceSelected = results;
          controller.countDevice();
        },
        height: 250,
        width: 200,
      );
    },
  );
}
