import 'dart:io';

import 'package:mobile_ics_flutter/views/news_management/newsmanagement_components/file_icon.dart';
import 'package:mobile_ics_flutter/views/news_management/newsmanagement_components/file_popup.dart';
import 'package:mobile_ics_flutter/views/news_management/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';

class FileItem extends StatelessWidget {
  final FileSystemEntity file;
  final Function? popTap;

  const FileItem({
    Key? key,
    required this.file,
    this.popTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => OpenFile.open(file.path),
      contentPadding: const EdgeInsets.all(0),
      leading: FileIcon(file: file),
      title: Text(
        '${basename(file.path)}',
        style: const TextStyle(fontSize: 14),
        maxLines: 2,
      ),
      subtitle: Text(
        '${FileUtils.formatBytes(File(file.path).lengthSync(), 2)},'
        ' ${FileUtils.formatTime(File(file.path).lastModifiedSync().toIso8601String())}',
      ),
      trailing:
          popTap == null ? null : FilePopup(path: file.path, popTap: popTap!),
    );
  }
}
