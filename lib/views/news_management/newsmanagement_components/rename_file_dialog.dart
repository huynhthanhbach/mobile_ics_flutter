import 'dart:io';

import 'package:mobile_ics_flutter/views/news_management/newsmanagement_components/custom_alert.dart';
import 'package:mobile_ics_flutter/views/news_management/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as pathlib;

class RenameFileDialog extends StatefulWidget {
  final String path;
  final String type;

  const RenameFileDialog({required this.path, required this.type});

  @override
  _RenameFileDialogState createState() => _RenameFileDialogState();
}

class _RenameFileDialogState extends State<RenameFileDialog> {
  final TextEditingController name = TextEditingController();

  @override
  void initState() {
    super.initState();
    name.text = pathlib.basename(widget.path);
  }

  @override
  Widget build(BuildContext context) {
    return CustomAlert(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 15),
            const Text(
              'Đổi tên',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 25),
            TextField(
              controller: name,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 40,
                  width: 130,
                  child: OutlinedButton(
                    child: Text(
                      'Hủy',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      side: MaterialStateProperty.all(
                        BorderSide(color: Theme.of(context).accentColor),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: 130,
                  child: ElevatedButton(
                    child: Text(
                      'Xong',
                      style: const TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (name.text.isNotEmpty) {
                        if (widget.type == 'file') {
                          if (!File(widget.path.replaceAll(
                                      pathlib.basename(widget.path), '') +
                                  '${name.text}')
                              .existsSync()) {
                            await File(widget.path)
                                .rename(widget.path.replaceAll(
                                        pathlib.basename(widget.path), '') +
                                    '${name.text}')
                                .catchError((e) {
                              print("Lỗi 2");
                            });
                          } else {
                            Dialogs.showToast('Trùng tên file!');
                          }
                        } else {
                          if (Directory(widget.path.replaceAll(
                                      pathlib.basename(widget.path), '') +
                                  '${name.text}')
                              .existsSync()) {
                            Dialogs.showToast('Trùng tên thư mục!');
                          } else {
                            await Directory(widget.path)
                                .rename(widget.path.replaceAll(
                                        pathlib.basename(widget.path), '') +
                                    '${name.text}')
                                .catchError((e) {
                              print("Lỗi 3");
                            });
                          }
                        }
                        Navigator.pop(context);
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).accentColor),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
