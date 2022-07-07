import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart';

class FileIcon extends StatelessWidget {
  final FileSystemEntity file;

  const FileIcon({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    File f = File(file.path);
    String _extension = extension(f.path).toLowerCase();
    String mimeType = mime(basename(file.path).toLowerCase()) ?? '';
    String type = mimeType.isEmpty ? '' : mimeType.split('/')[0];
    if (_extension == '.epub' ||
        _extension == '.pdf' ||
        _extension == '.mobi') {
      return const Icon(Icons.document_scanner_rounded, color: Colors.orangeAccent);
    } else {
      switch (type) {
        case 'image':
          return SizedBox(
            width: 50,
            height: 50,
            child: Image(
              errorBuilder: (b, o, c) {
                return const Icon(Icons.image);
              },
              image: ResizeImage(FileImage(File(file.path)),
                  width: 50, height: 50),
            ),
          );
        case 'audio':
          return const Icon(Icons.music_note, color: Colors.blue);
        case 'text':
          return const Icon(Icons.document_scanner_outlined, color: Colors.orangeAccent);
        default:
          return const Icon(Icons.question_mark);
      }
    }
  }
}
