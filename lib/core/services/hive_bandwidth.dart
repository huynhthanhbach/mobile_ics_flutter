import 'package:mobile_ics_flutter/core/services/boxes_service.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/models/hive_models/hive_model.dart';

class HiveBandwidth {
  List<BandwidthHiveModel> listDefault = [];

  Future<List<BandwidthHiveModel>> get() async {
    var box = BoxesService.getBandwidth();
    if (!box.isOpen) {
      await BoxesService().openBox();
    }
    await Future.delayed(Constants.dur200);
    var data = box.values.toList();
    List<BandwidthHiveModel> list = data.toList();
    for (var bandwidth in list) {
      if (listDefault.where((element) => element.id == bandwidth.id).isEmpty) {
        listDefault.add(bandwidth);
      }
    }
    return list;
  }

  Future<bool> addBandwidthToHive(BandwidthHiveModel bandwidthHiveModel) async {
    try {
      var box = BoxesService.getBandwidth();
      if (!box.isOpen) {
        await BoxesService().openBox();
      }
      await box.put(bandwidthHiveModel.id, bandwidthHiveModel);
    } catch (_) {
      return false;
    }
    return true;
  }

  Future<bool> delete(BandwidthHiveModel bandwidthHiveModel) async {
    try {
      var box = BoxesService.getBandwidth();
      if (!box.isOpen) {
        await BoxesService().openBox();
      }
      await box.delete(bandwidthHiveModel.id);
    } catch (_) {
      return false;
    }

    return true;
  }
}
