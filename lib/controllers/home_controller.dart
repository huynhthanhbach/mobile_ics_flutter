// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ics_flutter/core/widgets/kcolors.dart';
import 'package:mobile_ics_flutter/views/dashboard/dashboard_screen.dart';
import 'package:mobile_ics_flutter/views/news_management/news_management_screen.dart';
import 'package:mobile_ics_flutter/views/operator/operator_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';

class HomeController extends GetxController {
  late PersistentTabController tabController;
  String rootDirectory = '/storage/emulated/0/';

  @override
  void onInit() async {
    tabController = PersistentTabController(initialIndex: 0);
    rootDirectory = await getRootDirectory();
    print(rootDirectory);

    super.onInit();
  }

  void changeIndex(int index) {
    if (tabController.index != index) {
      tabController.index = index;
      update();
    }
  }

  Future<String> getRootDirectory() async {
    Directory directory;
    String nameDir = 'Mobile_ICS_Flutter';
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = (await getExternalStorageDirectory())!;
          String newPath = '';
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
            print('Directory Parent Created!');
          }
          print(directory.path);
          return directory.path;
        }else{
        exit(0);
        }
      }
    } catch (e) {
      return '/storage/emulated/0/';
    }
    return '/storage/emulated/0/';
  }

  List<PersistentBottomNavBarItem> navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.dashboard_rounded),
        title: 'Dashboard',
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
        activeColorPrimary: kGradientFirst,
        inactiveColorPrimary: kGradientSecond,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.newspaper_rounded),
        title: 'Điều hành phát',
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
        activeColorPrimary: kGradientFirst,
        inactiveColorPrimary: kGradientSecond,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.folder_copy_rounded),
        title: 'Quản lý bản tin',
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
        activeColorPrimary: kGradientFirst,
        inactiveColorPrimary: kGradientSecond,
      ),
    ];
  }

  List<Widget> buildPages() {
    return const [
      DashboardScreen(),
      OperatorScreen(),
      NewsManagementScreen(),
    ];
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
}
