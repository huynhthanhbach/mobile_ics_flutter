import 'package:mobile_ics_flutter/core/services/boxes_service.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/models/hive_models/hive_model.dart';

class HiveDevice {
  List<DeviceHiveModel> listDefault = [];

  Future<List<DeviceHiveModel>> get() async {
    var box = BoxesService.getDevice();
    if (!box.isOpen) {
      await BoxesService().openBox();
    }
    await Future.delayed(Constants.dur200);
    var data = box.values.toList();
    List<DeviceHiveModel> list = data.toList();
    for (var device in list) {
      if (listDefault.where((element) => element.id == device.id).isEmpty) {
        listDefault.add(device);
      }
    }
    return list;
  }

  Future<bool> addDeviceToHive(DeviceHiveModel deviceHiveModel) async {
    try {
      var box = BoxesService.getDevice();
      if (!box.isOpen) {
        await BoxesService().openBox();
      }
      await box.put(deviceHiveModel.id, deviceHiveModel);
    } catch (_) {
      return false;
    }
    return true;
  }

  Future<bool> delete(DeviceHiveModel deviceHiveModel) async {
    try {
      var box = BoxesService.getDevice();
      if (!box.isOpen) {
        await BoxesService().openBox();
      }
      await box.delete(deviceHiveModel.id);
    } catch (_) {
      return false;
    }

    return true;
  }
}
