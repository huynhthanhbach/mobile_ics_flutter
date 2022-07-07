import 'package:hive/hive.dart';
import 'package:mobile_ics_flutter/models/hive_models/hive_model.dart';

class BoxesService {
  static String news = 'news';
  static String warning = 'warning';
  static String device = 'device';

  static Box<NewsHiveModel> getNews() => Hive.box<NewsHiveModel>(news);
  static Box<WarningHiveModel> getWaring() =>
      Hive.box<WarningHiveModel>(warning);
  static Box<DeviceHiveModel> getDevice() => Hive.box<DeviceHiveModel>(device);

  Future<void> openBox() async {
    await Hive.openBox<NewsHiveModel>(news);
    await Hive.openBox<WarningHiveModel>(warning);
    await Hive.openBox<DeviceHiveModel>(device); // mở box
  }

  Future<void> closeHive() async {
    await Hive.close();
  }

  Future<void> closeBox() async {
    await Hive.box<NewsHiveModel>(news).close();
    await Hive.box<WarningHiveModel>(warning).close();
    await Hive.box<DeviceHiveModel>(device).close();
  }
}
