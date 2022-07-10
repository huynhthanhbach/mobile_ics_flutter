import 'package:get/get.dart';
import 'package:mobile_ics_flutter/models/hive_models/device_hmodel.dart';
import 'package:mobile_ics_flutter/views/operator/components/component.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../controllers/operator_controllers/operator_controller.dart';
import 'tempdb.dart';

void showFixedSchdule(
    BuildContext context, OperatorController controller) async {
  await showDialog(
    context: context,
    builder: (ctx) {
      return MultiSelectDialog(
        title: Text(
          'H_SELECT_TIMES'.tr,
          style: textStyle1,
        ),
        confirmText: Text(
          'CONFIRM_TEXT'.tr,
          style: textStyle2,
        ),
        cancelText: Text(
          'CANCEL_TEXT'.tr,
          style: textStyle2,
        ),
        items: controller.time_items,
        initialValue: controller.listTimeSelected,
        onConfirm: (List<Time> results) {
          controller.listTimeSelected = results;
          controller.countTime();
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
        searchable: true,
        title: Text(
          'DEVICE_SELECT_TITLE'.tr,
          style: textStyle1,
        ),
        confirmText: Text(
          'CONFIRM_TEXT'.tr,
          style: textStyle2,
        ),
        cancelText: Text(
          'CANCEL_TEXT'.tr,
          style: textStyle2,
        ),
        // items: device_items,
        // initialValue: listDeviceSelected,
        // onConfirm: (List<Device> results) {
        //   listDeviceSelected = results;
        items: controller.deviceItem,
        initialValue: controller.listDeviceSelected,
        onConfirm: (List<DeviceHiveModel> results) {
          controller.listDeviceSelected = results;
          controller.countDevice();
        },
        width: 200,
      );
    },
  );
}
