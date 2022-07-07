/* 
    - Xây dựng giao diện và chức năng của các item trên Grid view.
*/

import 'dart:io';

import 'package:mobile_ics_flutter/views/news_management/newsmanagement_components/add_file_dialog.dart';
import 'package:mobile_ics_flutter/views/news_management/newsmanagement_components/category_provider.dart';
import 'package:mobile_ics_flutter/views/news_management/newsmanagement_components/custom_divider.dart';
import 'package:mobile_ics_flutter/views/news_management/newsmanagement_components/dir_item.dart';
import 'package:mobile_ics_flutter/views/news_management/newsmanagement_components/file_item.dart';
import 'package:mobile_ics_flutter/views/news_management/newsmanagement_components/path_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ics_flutter/views/news_management/newsmanagement_components/rename_file_dialog.dart';
import 'package:path/path.dart' as pathlib;
import 'package:mobile_ics_flutter/views/news_management/utils/utils.dart';
import 'package:mobile_ics_flutter/views/news_management/newsmanagement_components/sort_sheet.dart';
import 'package:provider/provider.dart';

// Lớp xây dựng tạo item folder trong gridView với icon, tên và button dấu 3 chấm
// ignore: must_be_immutable

class Item extends StatefulWidget {
  // final String id;
  final String name;
  // final String idParent;
  // final String type;
  // final String dateCreate;
  // final String userCreate;
  final String path;

  Item({
    Key? key,
    required this.itemAction,
    // required this.id,
    required this.name,
    // required this.idParent,
    // required this.type,
    // required this.dateCreate,
    // required this.userCreate,
    required this.path,
  }) : super(key: key);

  // Hàm xử lí khi nhấn vào dấu 3 chấm
  late Function itemAction;

  String getName() => name;

  // void setName(String newName) => name = newName;
  @override
  // ignore: library_private_types_in_public_api
  _ItemState createState() => _ItemState();

  // @override
  // Widget build(BuildContext context) {
  //   if (type == "1") {
  //     return Container(
  //       margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
  //       child: Column(children: <Widget>[
  //         InkWell(
  //           // Nhấn vào folder
  //           onTap: () {
  //             openFolder();
  //           },

  //           // Nhấn giữ folder
  //           onLongPress: () {
  //             openMoreAction();
  //           },
  //           child: Image.asset('assets/icons/nm_folder.png',
  //               width: 60, height: 60, fit: BoxFit.fitWidth),
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             SizedBox(
  //               width: 100,
  //               child: Text(
  //                 name,
  //                 textAlign: TextAlign.center,
  //                 style: textStyle1,
  //                 overflow: TextOverflow.ellipsis,
  //               ),
  //             ),
  //             // Nhấn vào dấu 3 chấm và bottom sheet sẽ hiện lên
  //             InkWell(
  //               onTap: () {
  //                 itemAction(); //Gọi lại hàm press()
  //               },
  //               child: Image.asset('assets/icons/nm_icon-three-dots.png'),
  //             ),
  //           ],
  //         ),
  //       ]),
  //     );
  //   } else {
  //     return Container(
  //       margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
  //       child: Column(children: <Widget>[
  //         InkWell(
  //           // Nhấn vào icon
  //           onTap: () {
  //             playAudioFile();
  //           },

  //           //Nhấn và giữ icon
  //           onLongPress: () {
  //             openMoreAction();
  //           },
  //           child: Image.asset('assets/icons/nm_audio_file.png',
  //               width: 60, height: 60),
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             SizedBox(
  //               width: 100,
  //               child: Text(
  //                 name,
  //                 textAlign: TextAlign.center,
  //                 style: textStyle1,
  //                 overflow: TextOverflow.ellipsis,
  //               ),
  //             ),
  //             // Nhấn vào dấu 3 chấm và bottom sheet sẽ hiện lên
  //             InkWell(
  //               onTap: () {
  //                 itemAction(); //Gọi lại hàm press()
  //               },
  //               child: Image.asset('assets/icons/nm_icon-three-dots.png'),
  //             ),
  //           ],
  //         ),
  //       ]),
  //     );
  //   }
  // }

  // // Hàm chạy phát thử file âm thanh
  // void playAudioFile() {}

  // // Hàm mở folder
  // void openFolder() {}

  // // Hàm nhấn giữ để chọn nhiều file/folder
  // void openMoreAction() {}
}

class _ItemState extends State<Item> with WidgetsBindingObserver {
  late String path;
  List<String> paths = <String>[];

  List<FileSystemEntity> files = <FileSystemEntity>[];
  bool showHidden = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      getFiles();
    }
  }

  getFiles() async {
    try {
      var provider = Provider.of<CategoryProvider>(context, listen: false);
      Directory dir = Directory(path);
      List<FileSystemEntity> dirFiles = dir.listSync();
      files.clear();
      showHidden = provider.showHidden;
      setState(() {});
      for (FileSystemEntity file in dirFiles) {
        if (!showHidden) {
          if (!pathlib.basename(file.path).startsWith('.')) {
            files.add(file);
            setState(() {});
          }
        } else {
          files.add(file);
          setState(() {});
        }
      }

      files = FileUtils.sortList(files, provider.sort);
    } catch (e) {
      // ignore: avoid_print
      print("Loi 1");
    }
  }

  @override
  void initState() {
    super.initState();
    path = widget.path;
    getFiles();
    paths.add(widget.path);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  navigateBack() {
    paths.removeLast();
    path = paths.last;
    setState(() {});
    getFiles();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (paths.length == 1) {
          return true;
        } else {
          paths.removeLast();
          setState(() {
            path = paths.last;
          });
          getFiles();
          return false;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (paths.length == 1) {
                Navigator.pop(context);
              } else {
                navigateBack();
              }
            },
          ),
          elevation: 4,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Nó kêu mình bỏ 2 dấu $ đi
              Text('${widget.name}'),
              Text(
                '$path',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          bottom: PathBar(
            paths: paths,
            icon: Icons.home,
            onChanged: (index) {
              print(paths[index]);
              path = paths[index];
              paths.removeRange(index + 1, paths.length);
              setState(() {});
              getFiles();
            },
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () async {
                await showModalBottomSheet(
                  context: context,
                  builder: (context) => const SortSheet(),
                );
                getFiles();
              },
              tooltip: 'Sort by',
              icon: const Icon(Icons.sort),
            ),
          ],
        ),
        body: Visibility(
          replacement: const Center(child: Text('Thư mục trống')),
          visible: files.isNotEmpty,
          child: ListView.separated(
            padding: const EdgeInsets.only(left: 20),
            itemCount: files.length,
            itemBuilder: (BuildContext context, int index) {
              FileSystemEntity file = files[index];
              if (file.toString().split(':')[0] == 'Directory') {
                return DirectoryItem(
                  popTap: (v) async {
                    if (v == 0) {
                      renameDialog(context, file.path, 'dir');
                    } else if (v == 1) {
                      deleteFile(true, file);
                    }
                  },
                  file: file,
                  tap: () {
                    paths.add(file.path);
                    path = file.path;
                    setState(() {});
                    getFiles();
                  },
                );
              }
              return FileItem(
                file: file,
                popTap: (v) async {
                  if (v == 0) {
                    renameDialog(context, file.path, 'file');
                  } else if (v == 1) {
                    deleteFile(false, file);
                  } else if (v == 2) {
                    // TODO: Implement Share file feature
                    // ignore: avoid_print
                    print('Share');
                  }
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const CustomDivider();
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => addDialog(context, path),
          child: const Icon(Icons.add),
          tooltip: 'Add Folder',
        ),
      ),
    );
  }

  deleteFile(bool directory, var file) async {
    try {
      if (directory) {
        await Directory(file.path).delete(recursive: true);
      } else {
        await File(file.path).delete(recursive: true);
      }
      Dialogs.showToast('Delete Successful');
    } catch (e) {
      print(e.toString());
      if (e.toString().contains('Permission denied')) {
        Dialogs.showToast('Cannot write to this Storage device!');
      }
    }
    getFiles();
  }

  addDialog(BuildContext context, String path) async {
    await showDialog(
      context: context,
      builder: (context) => AddFileDialog(path: path),
    );
    getFiles();
  }

  renameDialog(BuildContext context, String path, String type) async {
    await showDialog(
      context: context,
      builder: (context) => RenameFileDialog(path: path, type: type),
    );
    getFiles();
  }
}
