import 'package:hive/hive.dart';
import 'package:mobile_ics_flutter/models/hive_models/hive_model.dart';

class BoxesService {
  static String news = 'news';
  static String warning = 'warning';
  static String device = 'device';
  static String bandwidth = 'bandwidth';
  static String calendar = 'calendar';
  static String playNews = 'playNews';

  static Box<NewsHiveModel> getNews() => Hive.box<NewsHiveModel>(news);

  static Box<WarningHiveModel> getWaring() =>
      Hive.box<WarningHiveModel>(warning);

  static Box<DeviceHiveModel> getDevice() => Hive.box<DeviceHiveModel>(device);

  static Box<BandwidthHiveModel> getBandwidth() =>
      Hive.box<BandwidthHiveModel>(bandwidth);

  static Box<CalendarHiveModel> getCalendar() =>
      Hive.box<CalendarHiveModel>(calendar);

  static Box<PlayNewsHiveModel> getPlayNews() =>
      Hive.box<PlayNewsHiveModel>(playNews);

  Future<void> openBox() async {
    await Hive.openBox<NewsHiveModel>(news);
    await Hive.openBox<WarningHiveModel>(warning);
    await Hive.openBox<DeviceHiveModel>(device);
    await Hive.openBox<BandwidthHiveModel>(bandwidth);
    await Hive.openBox<CalendarHiveModel>(calendar);
    await Hive.openBox<PlayNewsHiveModel>(playNews);
  }

  Future<void> closeHive() async {
    await Hive.close();
  }

  Future<void> closeBox() async {
    await Hive.box<NewsHiveModel>(news).close();
    await Hive.box<WarningHiveModel>(warning).close();
    await Hive.box<DeviceHiveModel>(device).close();
    await Hive.box<BandwidthHiveModel>(bandwidth).close();
    await Hive.box<CalendarHiveModel>(calendar).close();
    await Hive.box<PlayNewsHiveModel>(playNews).close();
  }
}
