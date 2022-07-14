// ignore_for_file: avoid_print
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ics_flutter/controllers/home_controller.dart';
import 'package:mobile_ics_flutter/controllers/operator_controllers/operator_controller.dart';
import 'package:mobile_ics_flutter/core/services/boxes_service.dart';
import 'package:mobile_ics_flutter/core/services/hive_news.dart';
import 'package:mobile_ics_flutter/core/utils/extension.dart';
import 'package:mobile_ics_flutter/models/hive_models/hive_model.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as pathlib;

class NewsManagementController extends GetxController {
  var opController = Get.find<OperatorController>();
  HiveNews hiveNews = HiveNews();
  bool isFbVisible = false;

  late String root;
  late String valueType = 'sport';
  late String valueLocation = 'Village';

  PlatformFile? filePicker;

  bool checkPick = false;

  String? path;
  String? areaFilter;
  String? getUrlUpload;

  var areaTag = ''.obs;
  var typeTag = ''.obs;

  List<NewsHiveModel> listNews = <NewsHiveModel>[];

  @override
  void onInit() async {
    root = Get.find<HomeController>().rootDirectory;
    areaFilter = _changeArea();
    update();
    super.onInit();
  }

  @override
  void onReady() {
    typeTag.value = _changeType();
    areaTag.value = _changeLocation();
    super.onReady();
  }

  void updateIsFbVisible(bool check) {
    isFbVisible = check;
    update();
  }

  void onChangeLocation(String value) {
    valueLocation = value;
  }

  void onChangeType(String value) {
    valueType = value;
  }

  String _changeType() {
    switch (valueType) {
      case 'activity':
        return 'Đời sống';
      case 'law':
        return 'Pháp luật';
      case 'warning':
        return 'Cảnh báo';
      case 'information':
        return 'Thông tin';
      default:
        return 'Thể thao';
    }
  }

  String _changeLocation() {
    switch (valueLocation) {
      case 'District':
        return 'FILTER_AREA_DISTRICT'.tr;
      default:
        return 'FILTER_AREA_VILLAGE'.tr;
    }
  }

  String _changeArea() {
    switch (valueLocation) {
      case 'District':
        return 'AREA_CHANGE_DISTRICT'.tr;
      default:
        return 'AREA_CHANGE_VILLAGE'.tr;
    }
  }

  Future onAdd(String path) async {
    typeTag.value = _changeType();
    areaTag.value = _changeLocation();
    areaFilter = _changeArea();

    var flag = await _copyFile(filePicker!, path);
    if (flag) {
      const uid = Uuid();
      final news = NewsHiveModel(
        id: uid.v1(),
        name: 'name',
        type: typeTag.value,
        author: 'Mobile ICS',
        content: typeTag.value,
        createDate: DateTime.now(),
        duration: 'duration',
        status: 'Chưa phát',
        area: areaFilter,
        url: getUrlUpload,
      );
      print(news);
      var upL = await hiveNews.addNewsToHive(news);
      if (upL) {
        'Thành công'.toast();
        Get.back();
      } else {
        'Thất bại'.toast();
      }
    } else {
      print('copy that bai');
    }
  }

  Future onDeleteFileAndModel(bool directory, var file) async {
    List<NewsHiveModel> listNews = await hiveNews.get();
    if (listNews.isNotEmpty) {
      if (directory) {
        List<File> list = await _getAllDirectoryFiles(Directory(file.path));
        if (list.isNotEmpty) {
          for (var news in listNews) {
            for (var file in list) {
              if (news.url == file.path) {
                hiveNews.delete(news);
              }
            }
          }
        }
      } else {
        for (var item in listNews) {
          if (item.url == file.path) {
            hiveNews.delete(item);
          }
        }
      }
    }
  }

  Future onUpdateNameFile(String type, String oldPath, File newFile) async {
    List<NewsHiveModel> listNews = await hiveNews.get();
    final boxes = BoxesService.getNews();
    if (listNews.isNotEmpty) {
      if (type == 'file') {
        final oldName = pathlib.basename(File(oldPath).path);

        final newName = pathlib.basename(newFile.path);
        var newsPathDir =
            newFile.path.replaceAll(pathlib.basename(newFile.path), '');

        for (var item in listNews) {
          final oldNameList = pathlib.basename(File(item.url!).path);
          if (oldNameList == oldName) {
            var newUrl = '$newsPathDir$newName';
            // item.url = newUrl;
            // item.save();

            final newsModel = item;
            newsModel.url = newUrl;

            boxes.put(newsModel.id, newsModel);
          }
        }
      } else {}
    }
  }

  Future onUpdateNameDir(Directory newDir) async {
    List<NewsHiveModel> listNews = await hiveNews.get();
    final boxes = BoxesService.getNews();
    if (listNews.isNotEmpty) {
      List<File> list = await _getAllDirectoryFiles(newDir);
      if (list.isNotEmpty) {
        for (var news in listNews) {
          final oldNameList = pathlib.basename(File(news.url!).path);
          for (var file in list) {
            final nameFileList = pathlib.basename(file.path);
            if (oldNameList == nameFileList) {
              final newsModel = news;
              newsModel.url = '${newDir.path}/$nameFileList';

              boxes.put(newsModel.id, newsModel);
            }
          }
        }
      }
    }
  }

  getNewsList() async {
    List<NewsHiveModel> listN = await hiveNews.get();
    if (listN.isNotEmpty) {
      listNews = listN.toList();
    }
  }

  Future showBottomSheet(BuildContext context, Widget child) async {
    Future<void> future = Get.bottomSheet(
      child,
      isScrollControlled: true,
      ignoreSafeArea: true,
      barrierColor: Colors.black26,
    );
    future.then((void value) => _closeModal(value));
  }

  void _closeModal(void value) {
    checkPick = false;
    filePicker = null;
    getUrlUpload = null;
    update();
  }

  Future pickFiless() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );
    if (result == null) {
      return;
    }
    final file = result.files.first;
    if (pathlib.extension(file.path!) == '.mp3' ||
        pathlib.extension(file.path!) == '.txt' ||
        pathlib.extension(file.path!) == '.pdf') {
      filePicker = file;
      checkPick = true;
      update();

      print(file);
    } else {
      'Vui lòng chọn file *mp3, *txt, *pdf'.toast();
    }
  }

  Future<bool> _copyFile(PlatformFile file, String folder) async {
    final path = File(file.path!);
    final basename = pathlib.basename(path.path);
    print(folder);
    try {
      List<File> list = await _getAllDirectoryFiles(Directory(folder));
      if (list.isNotEmpty) {
        for (var file in list) {
          String nameFile = pathlib.basename(file.path);
          if (nameFile == basename) {
            return false;
          } else {
            path.copy('$folder/$basename');
            getUrlUpload = '$folder/$basename';
            update();
            return true;
          }
        }
      } else {
        path.copy('$folder/$basename');
        getUrlUpload = '$folder/$basename';
        update();
        print(basename);
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
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
              frameworkFilePaths.add(file);
            }
          });
        })
        .asFuture()
        .then((_) {
          return frameworkFilePaths;
        });
  }

  @override
  void onClose() {
    filePicker = null;
    getUrlUpload = null;
    super.onClose();
  }
}
