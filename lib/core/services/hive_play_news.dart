import 'package:mobile_ics_flutter/core/services/boxes_service.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/models/hive_models/hive_model.dart';

class HivePlayNews {
  List<PlayNewsHiveModel> listDefault = [];

  Future<List<PlayNewsHiveModel>> get() async {
    var box = BoxesService.getPlayNews();
    if (!box.isOpen) {
      await BoxesService().openBox();
    }
    await Future.delayed(Constants.dur200);
    var data = box.values.toList();
    List<PlayNewsHiveModel> list = data.toList();
    for (var play in list) {
      if (listDefault.where((element) => element.id == play.id).isEmpty) {
        listDefault.add(play);
      }
    }
    return list;
  }

  Future<bool> addPlayNewsToHive(PlayNewsHiveModel playNewsHiveModel) async {
    try {
      var box = BoxesService.getPlayNews();
      if (!box.isOpen) {
        await BoxesService().openBox();
      }
      await box.put(playNewsHiveModel.id, playNewsHiveModel);
    } catch (_) {
      return false;
    }
    return true;
  }

  Future<bool> delete(PlayNewsHiveModel playNewsHiveModel) async {
    try {
      var box = BoxesService.getPlayNews();
      if (!box.isOpen) {
        await BoxesService().openBox();
      }
      await box.delete(playNewsHiveModel.id);
    } catch (_) {
      return false;
    }

    return true;
  }
}
