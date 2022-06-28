// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_ics_flutter/controllers/dashboard_controllers/dashboard_controller.dart';
import 'package:mobile_ics_flutter/core/services/boxes_service.dart';
import 'package:mobile_ics_flutter/core/services/hive_news.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/models/hive_models/hive_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

class BackupDataController extends GetxController {
  late Directory directory;

  HiveNews hiveNews = HiveNews();

  bool isLoading = false;

  List<File> listFileBackup = [];
  List<File> listFileRestore = [];

  @override
  void onInit() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    directory = Directory('${appDocDir.path}/mobile_ics_db');
    List<File> list = await _getAllDirectoryFiles(directory);
    if (list.isNotEmpty) {
      listFileBackup = list.toList();
      update();
    }
    super.onInit();
  }

  Future<List<File>> _getAllDirectoryFiles(Directory directory) {
    List<File> frameworkFilePaths = [];

    // Grab all paths in directory
    return Directory(directory.path)
        .list(recursive: true, followLinks: false)
        .listen((FileSystemEntity entity) {
          // For each path, if the path leads to a file, then add to array list
          File file = File(entity.path);
          file.exists().then((exists) {
            if (exists) {
              if (p.extension(file.path) == '.hive') {
                frameworkFilePaths.add(file);
              }
            }
          });
        })
        .asFuture()
        .then((_) {
          return frameworkFilePaths;
        });
  }

  Future<void> _backupHiveBox(Directory directory) async {
    String formatDate =
        DateFormat('yyyy-MM-dd – kk-mm-ss').format(DateTime.now());
    Directory dir;
    await BoxesService().closeBox();

    try {
      dir = Directory('${directory.path}/$formatDate');
      update();
      var flag = await dir.exists();
      if (!flag) {
        await dir.create();
        print('Directory child created!');
      }
      print(dir);

      for (var file in listFileBackup) {
        String basename = p.basename(file.path);
        File(file.path).copy('${dir.path}/$basename');
      }
    } catch (e) {
      print(e.toString());
      'Backup process failed'.toast();
      await BoxesService().openBox();
    } finally {
      await BoxesService().openBox();
    }

    update();
  }

  Future<void> _restoreHiveBox() async {
    await BoxesService().closeBox();

    try {
      for (var fileRestore in listFileRestore) {
        for (var fileBackup in listFileBackup) {
          if (p.basename(fileRestore.path) == p.basename(fileBackup.path)) {
            File(fileRestore.path).copy(fileBackup.path);
          }
        }
      }
    } catch (e) {
      print(e.toString());
      'Restore process failed'.toast();
      await BoxesService().openBox();
    } finally {
      await BoxesService().openBox();
    }
  }

  Future<bool> _getDirectoryAndBackup() async {
    Directory directory;

    String nameDir = 'Mobile_ICS_Flutter';
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = (await getExternalStorageDirectory())!;
          String newPath = '';
          // /storage/emulated/0/Android/data/com.example.mobile_ics_flutter/files
          List<String> folders = directory.path.split('/');
          for (var i = 1; i < folders.length; i++) {
            String folder = folders[i];
            if (folder != 'Android') {
              newPath += "/$folder";
            } else {
              break;
            }
          }
          newPath = '$newPath/$nameDir';
          directory = Directory(newPath);
          var flag = await directory.exists();
          if (!flag) {
            await directory.create();
            print('Directory parent created!');
          }
          print(directory.path);
          await _backupHiveBox(directory)
              .catchError((onError) => print(onError));
          return true;
        } else {
          return false;
        }
      } else if (Platform.isWindows) {
        final appDocDir = await getApplicationDocumentsDirectory();
        directory = Directory('${appDocDir.path}/$nameDir');
        var flag = await directory.exists();
        if (!flag) {
          await directory.create();
          print('Directory parent created!');
        }
        print(directory.path);
        await _backupHiveBox(directory).catchError((onError) => print(onError));
        return true;
      } else {
        'Chưa hỗ trợ backup trên nền tảng này'.toast();
      }
    } catch (e) {
      print(e);
      return false;
    }
    return false;
  }

  Future<bool> _pickerDirectoryAndRestore() async {
    try {
      listFileRestore.clear();
      String? path = await FilePicker.platform.getDirectoryPath();
      if (path != null) {
        directory = Directory(path);
        List<File> list = await _getAllDirectoryFiles(directory);
        if (list.isNotEmpty) {
          listFileRestore = list.toList();
          update();
          return true;
        }
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<void> backupDatabase() async {
    try {
      isLoading = true;
      update();
      var flag = await _getDirectoryAndBackup();
      if (flag) {
        Future.delayed(
          Constants.dur1000,
          (() {
            isLoading = false;
            update();
            print('Backup successful!');
            'Backup successful!'.toast();
          }),
        );
      } else {
        Future.delayed(
          Constants.dur1000,
          (() {
            isLoading = false;
            update();
            print('Backup failed!');
            'Backup failed!'.toast();
          }),
        );
      }
    } catch (e) {
      return;
    }
  }

  Future<void> restoreDatabase() async {
    try {
      isLoading = true;
      update();
      var flag = await _pickerDirectoryAndRestore();
      if (flag) {
        await _restoreHiveBox().catchError((onError) => print(onError));
        Future.delayed(
          Constants.dur1000,
          (() {
            isLoading = false;
            update();
            print('Restore successful!');
            'Restore successful!'.toast();
          }),
        );
      } else {
        Future.delayed(
          Constants.dur1000,
          (() {
            isLoading = false;
            update();
            print('Restore failed!');
            'Restore failed!'.toast();
          }),
        );
      }
    } catch (e) {
      return;
    } finally {
      Get.find<DashboardController>().onRefreshNews();
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var per = await permission.request();
      if (per == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  String getRandomString(int length) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    Random rnd = Random();

    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(
          rnd.nextInt(chars.length),
        ),
      ),
    );
  }

  Future<void> addDataFakeToHive() async {
    const uid = Uuid();
    var id = "";
    var name = "";
    for (var i = 0; i < 10; i++) {
      if (id == "") {
        id = uid.v1();
        name = getRandomString(2);

        final newsHiveModel = NewsHiveModel(
          id: id,
          name: 'Bản tin thông tin đài $name',
          type: 'Thông tin',
          author: 'Huỳnh Thanh Bách',
          content: 'Mô tả tóm tắt bản tin',
          createDate: DateTime.now(),
          duration: '10 minute',
          status: 'Đã phát',
          area: 'Đài truyền thanh cấp xã',
          url: null,
        );
        // var flag = await hiveNews.addNewsToHive(newsHiveModel);
        // if (flag) {
        //   print('${newsHiveModel.id} -- Success');
        // } else {
        //   print('${newsHiveModel.id} -- Failed');
        // }

        print(newsHiveModel.id);

        print(newsHiveModel.name);
        print(newsHiveModel.type);
        print(newsHiveModel.status);
        print(newsHiveModel.area);
      }
      id = "";
      name = "";
    }
    Get.find<DashboardController>().onRefreshNews();
  }

  Future<void> clearAllNewsData() async {
    try {
      final box = BoxesService.getNews();
      box.clear();
    } finally {
      Get.find<DashboardController>().onRefreshNews();
      print("Clear all data!");
      'Thành công'.toast();
    }
  }

  @override
  void onClose() {
    listFileBackup.clear();
    super.onClose();
  }
}
