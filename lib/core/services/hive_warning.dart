import 'package:mobile_ics_flutter/core/services/boxes_service.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/models/hive_models/hive_model.dart';

class HiveWarning {
  List<WarningHiveModel> listDefault = [];

  Future<List<WarningHiveModel>> get() async {
    var box = BoxesService.getWaring();
    if (!box.isOpen) {
      await BoxesService().openBox();
    }
    await Future.delayed(Constants.dur200);
    var data = box.values.toList();
    List<WarningHiveModel> list = data.toList();
    for (var warning in list) {
      if (listDefault.where((element) => element.id == warning.id).isEmpty) {
        listDefault.add(warning);
      }
    }
    return list;
  }

  Future<bool> addNewsToHive(WarningHiveModel warningHiveModel) async {
    try {
      var box = BoxesService.getWaring();
      if (!box.isOpen) {
        await BoxesService().openBox();
      }
      await box.put(warningHiveModel.id, warningHiveModel);
    } catch (_) {
      return false;
    }
    return true;
  }

  Future<bool> delete(WarningHiveModel warningHiveModel) async {
    try {
      var box = BoxesService.getWaring();
      if (!box.isOpen) {
        await BoxesService().openBox();
      }
      await box.delete(warningHiveModel.id);
    } catch (_) {
      return false;
    }

    return true;
  }
}
