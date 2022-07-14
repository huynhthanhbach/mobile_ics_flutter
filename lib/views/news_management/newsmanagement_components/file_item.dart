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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Column(children: <Widget>[
        InkWell(
          // Nhấn vào folder
          onTap: () {
            OpenFile.open(file.path);
            // controller.showBottomSheet(context, const BottomSheetAddNews());
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
