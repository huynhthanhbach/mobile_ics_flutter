import 'package:mobile_ics_flutter/core/services/boxes_service.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/models/hive_models/hive_model.dart';

class HiveNews {
  List<NewsHiveModel> listDefault = [];

  Future<List<NewsHiveModel>> get() async {
    var box = BoxesService.getNews();
    if (!box.isOpen) {
      await BoxesService().openBox();
    }
    await Future.delayed(Constants.dur200);
    var data = box.values.toList();
    List<NewsHiveModel> list = data.toList();
    for (var news in list) {
      if (listDefault.where((element) => element.id == news.id).isEmpty) {
        listDefault.add(news);
      }
    }
    return list;
  }

  Future<bool> addNewsToHive(NewsHiveModel newsHiveModel) async {
    try {
      var box = BoxesService.getNews();
      if (!box.isOpen) {
        await BoxesService().openBox();
      }
      await box.put(newsHiveModel.id, newsHiveModel);
    } catch (_) {
      return false;
    }
    return true;
  }

  Future<bool> delete(NewsHiveModel newsHiveModel) async {
    try {
      var box = BoxesService.getNews();
      if (!box.isOpen) {
        await BoxesService().openBox();
      }
      await box.delete(newsHiveModel.id);
    } catch (_) {
      return false;
    }

    return true;
  }
}
