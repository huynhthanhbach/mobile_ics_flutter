import 'package:mobile_ics_flutter/core/services/boxes_service.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/models/hive_models/hive_model.dart';

class HiveCalendar {
  List<CalendarHiveModel> listDefault = [];

  Future<List<CalendarHiveModel>> get() async {
    var box = BoxesService.getCalendar();
    if (!box.isOpen) {
      await BoxesService().openBox();
    }
    await Future.delayed(Constants.dur200);
    var data = box.values.toList();
    List<CalendarHiveModel> list = data.toList();
    for (var calendar in list) {
      if (listDefault.where((element) => element.id == calendar.id).isEmpty) {
        listDefault.add(calendar);
      }
    }
    return list;
  }

  Future<bool> addCalendarToHive(CalendarHiveModel calendarHiveModel) async {
    try {
      var box = BoxesService.getCalendar();
      if (!box.isOpen) {
        await BoxesService().openBox();
      }
      await box.put(calendarHiveModel.id, calendarHiveModel);
    } catch (_) {
      return false;
    }
    return true;
  }

  Future<bool> delete(CalendarHiveModel calendarHiveModel) async {
    try {
      var box = BoxesService.getCalendar();
      if (!box.isOpen) {
        await BoxesService().openBox();
      }
      await box.delete(calendarHiveModel.id);
    } catch (_) {
      return false;
    }

    return true;
  }
}
