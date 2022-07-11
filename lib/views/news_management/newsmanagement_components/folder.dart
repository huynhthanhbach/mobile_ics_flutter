// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_ics_flutter/views/news_management/newsmanagement_components/bottomsheet_itemaction.dart';
import 'package:path/path.dart' as pathlib;
import 'package:provider/provider.dart';

import 'package:mobile_ics_flutter/controllers/newsmanagement_controllers/newsmanagement_controller.dart';
import 'package:mobile_ics_flutter/views/news_management/newsmanagement_components/category_provider.dart';
import 'package:mobile_ics_flutter/views/news_management/newsmanagement_components/dir_item.dart';
import 'package:mobile_ics_flutter/views/news_management/newsmanagement_components/file_item.dart';
import 'package:mobile_ics_flutter/views/news_management/newsmanagement_components/path_bar.dart';
import 'package:mobile_ics_flutter/views/news_management/newsmanagement_components/rename_file_dialog.dart';
import 'package:mobile_ics_flutter/views/news_management/newsmanagement_components/sort_sheet.dart';
import 'package:mobile_ics_flutter/views/news_management/utils/utils.dart';

class Folder extends StatefulWidget {
  const Folder({
    Key? key,
    required this.title,
    required this.path,
    required this.controller,
  }) : super(key: key);

  final String title;
  final String path;
  final NewsManagementController controller;

  @override
  State<Folder> createState() => _FolderState();
}

class _FolderState extends State<Folder> with WidgetsBindingObserver {
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
      widget.controller.path = dir.path;

      files = FileUtils.sortList(files, provider.sort);
    } catch (e) {
      if (e.toString().contains('Permission denied')) {
        Dialogs.showToast('Permission Denied! cannot access this Directory!');
        navigateBack();
      }
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
            icon: const Icon(Icons.arrow_back, color: Colors.blue,),
            onPressed: () {
              if (paths.length == 1) {
                // Navigator.pop(context);
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
              Text(widget.title),
              Text(
                path,
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
              // ignore: avoid_print
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
              icon: const Icon(Icons.sort, color: Colors.blue),
            ),
          ],
        ),
        body: Visibility(
          replacement: const Center(child: Text('Thư mục này trống')),
          visible: files.isNotEmpty,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3/2,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0
              ),
            itemCount: files.length,
            itemBuilder: (BuildContext context, int index) {
              FileSystemEntity file = files[index];
              if (file.toString().split(':')[0] == 'Directory') {
                return DirectoryItem(
                    file: file,
                    openTab: () {
                      paths.add(file.path);
                      path = file.path;
                      setState(() {});
                      getFiles();
                    },
                    threedotsTab: () => widget.controller.showBottomSheet(context, BottomSheetItemAction(path: path, file: file,),)
                  );
              }
              return FileItem(
                  file: file,
                  threedotsTab: () => widget.controller.showBottomSheet(context, BottomSheetItemAction(path: path, file: file)
                )
              );
            },
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () => addDialog(context, path),
        //   tooltip: 'Add Folder',
        //   child: const Icon(Icons.add),
        // ),
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
      // ignore: avoid_print
      print(e.toString());
      if (e.toString().contains('Permission denied')) {
        Dialogs.showToast('Cannot write to this Storage device!');
      }
    }
    getFiles();
  }

  // addDialog(BuildContext context, String path) async {
  //   await showDialog(
  //     context: context,
  //     builder: (context) => AddFileDialog(path: path),
  //   );
  //   getFiles();
  // }

  renameDialog(BuildContext context, String path, String type) async {
    await showDialog(
      context: context,
      builder: (context) => RenameFileDialog(path: path, type: type),
    );
    getFiles();
  }
}