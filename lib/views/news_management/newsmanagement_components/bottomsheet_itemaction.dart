// ignore_for_file: public_member_api_docs, sort_constructors_first
/* 
    - Xây dựng giao diện Bottom Sheet khi nhấn vào dấu 3 chấm trên file/folder.
    - Xây dựng chức năng của các tùy chọn trên Bottom Sheet.
*/

import 'dart:io';

// import 'package:file_manager/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ics_flutter/controllers/newsmanagement_controllers/newsmanagement_controller.dart';
import 'package:mobile_ics_flutter/views/news_management/newsmanagement_components/rename_file_dialog.dart';
import 'package:mobile_ics_flutter/views/news_management/utils/kcolors.dart';
import 'package:mobile_ics_flutter/views/news_management/utils/utils.dart';
import 'package:path/path.dart';
import 'package:path/path.dart' as pathlib;

// Lớp xây dựng bottom sheet hiện lên khi nhấn vào dấu 3 chấm trong mỗi file/folder
class BottomSheetItemAction extends StatelessWidget {
  // final FileManagerController controller = FileManagerController();
  // final TextEditingController name = TextEditingController();
  final String path;
  final FileSystemEntity file;
  final String type;
  final Function press;

  const BottomSheetItemAction({
    Key? key,
    required this.path,
    required this.file,
    required this.type,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NewsManagementController controller = Get.find<NewsManagementController>();
    return Container(
      height: Get.mediaQuery.size.height * .5,
      padding: const EdgeInsets.only(
        top: 15,
        left: 15,
        right: 15,
        bottom: 10,
      ),
      decoration: const BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 45, top: 20),
            child: Row(
              children: [
                Text(basename(file.path), style: textStyle1),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 45, top: 8),
            child: Row(
              children: const <Widget>[
                Text(
                  'Người tạo:',
                  style: textStyle2,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 14.0),
                  child: Text(
                    'Nguyễn Văn A',
                    style: textStyle2,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 0),
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: kBlue),
                ),
              ),
            ),
          ),

          // Đổi tên
          InkWell(
            onTap: () {
              
              if (type == 'file') {
                renameDialog(context, file.path, 'file', press,controller);
                
              } else {
                renameDialog(context, file.path, 'dir',press,controller);
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 45, top: 35),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Image.asset('assets/icons/nm_changename.png'),
                  ),
                  const Text('Đổi tên', style: textStyle1),
                ],
              ),
            ),
          ),

          // Di chuyển
          Padding(
            padding: const EdgeInsets.only(left: 45, top: 35),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Image.asset('assets/icons/nm_move.png'),
                ),
                const Text('Di chuyển', style: textStyle1)
              ],
            ),
          ),

          // Xóa
          InkWell(
            onTap: () {

               if (type == 'file') {
               deleteFile(false, file, press,controller);
                
              } else {
                deleteFile(true, file, press,controller);
              }
              
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 45, top: 35),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Image.asset('assets/icons/nm_delete.png'),
                  ),
                  const Text('Xóa', style: textStyle1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Chức năng đổi tên
  renameDialog(BuildContext context, String path, String type, Function press,NewsManagementController controller) async {
    await showDialog(
      context: context,
      builder: (context) => RenameFileDialog(path: path, type: type,controller: controller,),
    );
    Get.back();
    press();
  }

  // Chức năng xóa
  deleteFile(bool directory, var file, Function press, NewsManagementController controller) async {
    try {
      if (directory) {
        await controller.onDeleteFileAndModel(directory,file);
        await Directory(file.path).delete(recursive: true);
      } else {
        await controller.onDeleteFileAndModel(directory,file);
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
    press();
    Get.back();
  }
}
