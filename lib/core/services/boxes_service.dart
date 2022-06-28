import 'package:hive/hive.dart';
import 'package:mobile_ics_flutter/models/hive_models/hive_model.dart';

class BoxesService {
  static String news = 'news';

  static Box<NewsHiveModel> getNews() => Hive.box<NewsHiveModel>(news);

  Future<void> openBox() async {
    await Hive.openBox<NewsHiveModel>(news); // mở box
  }

  Future<void> closeHive() async {
    await Hive.close();
  }

  Future<void> closeBox() async {
    await Hive.box<NewsHiveModel>(news).close();
  }
}
