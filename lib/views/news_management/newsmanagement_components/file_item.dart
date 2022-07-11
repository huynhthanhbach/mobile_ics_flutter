// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';

import 'package:mobile_ics_flutter/views/news_management/newsmanagement_components/file_icon.dart';
import 'package:mobile_ics_flutter/views/news_management/utils/utils.dart';

class FileItem extends StatelessWidget {
  final FileSystemEntity file;
  final Function threedotsTab;
  const FileItem({
    Key? key,
    required this.file,
    required this.threedotsTab,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // return ListTile(
    //   onTap: () => OpenFile.open(file.path),
    //   contentPadding: const EdgeInsets.all(0),
    //   leading: FileIcon(file: file),
    //   title: Text(
    //     '${basename(file.path)}',
    //     style: const TextStyle(fontSize: 14),
    //     maxLines: 2,
    //   ),
    //   subtitle: Text(
    //     '${FileUtils.formatBytes(File(file.path).lengthSync(), 2)},'
    //     ' ${FileUtils.formatTime(File(file.path).lastModifiedSync().toIso8601String())}',
    //   ),
    //   trailing:
    //       popTap == null ? null : FilePopup(path: file.path, popTap: popTap!),
    // );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(children: <Widget>[
        InkWell(
          // Nhấn vào folder
          onTap: () {
            OpenFile.open(file.path);
          },

          // Nhấn giữ folder
          onLongPress: () {
            // openMoreAction();
          },
          child: FileIcon(file: file),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 100,
              child: Text(
                basename(file.path),
                textAlign: TextAlign.center,
                style: textStyle1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Nhấn vào dấu 3 chấm và bottom sheet sẽ hiện lên
            InkWell(
              onTap: () => threedotsTab(),
              // {
              //   controller.showBottomSheet(context, BottomSheetItemAction(path: file.path)); 
              // },
              child: Image.asset('assets/icons/nm_icon-three-dots.png'),
            ),
          ],
        ),
      ]),
    );
  }
}
