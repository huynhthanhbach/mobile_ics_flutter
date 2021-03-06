// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as pathlib;

import 'package:mobile_ics_flutter/controllers/newsmanagement_controllers/newsmanagement_controller.dart';
import 'package:mobile_ics_flutter/views/news_management/newsmanagement_components/custom_alert.dart';
import 'package:mobile_ics_flutter/views/news_management/utils/kcolors.dart';
import 'package:mobile_ics_flutter/views/news_management/utils/utils.dart';

class RenameFileDialog extends StatefulWidget {
  final String path;
  final String type;

  final NewsManagementController controller;

  const RenameFileDialog({
    Key? key,
    required this.path,
    required this.type,
    required this.controller,
  }) : super(key: key);

  @override
  
  State<RenameFileDialog> createState() => _RenameFileDialogState();
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
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: kWhite,
                  border: Border.all(width: 1, color: kShadow),
                  borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                autofocus: true,
                controller: name,
                keyboardType: TextInputType.text,
                cursorColor: Colors.blue,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 40,
                  width: 130,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black12),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Hủy',
                      style: textStyle1
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 130,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (name.text.isNotEmpty) {
                        if (widget.type == 'file') {
                          if (!File('${widget.path.replaceAll(
                                      pathlib.basename(widget.path), '')}${name.text}')
                              .existsSync()) {
                           var nameFile = await File(widget.path)
                                .rename('${widget.path.replaceAll(
                                        pathlib.basename(widget.path), '')}${name.text}')
                                .catchError((e) {
                            });
                            await widget.controller.onUpdateNameFile('file',widget.path,nameFile);

                            // print(nameFile);//code tiep o day
                          } else {
                            Dialogs.showToast('Tên file này bị trùng!');
                          }
                        } else {
                          if (Directory('${widget.path.replaceAll(
                                      pathlib.basename(widget.path), '')}${name.text}')
                              .existsSync()) {
                            Dialogs.showToast('Trùng tên thư mục!');
                          } else {
                           var nameDir= await Directory(widget.path)
                                .rename('${widget.path.replaceAll(
                                        pathlib.basename(widget.path), '')}${name.text}')
                                .catchError((e) {
                            });


                            widget.controller.onUpdateNameDir(nameDir);
                            // print(nameDir);//
                          }
                        }
                       
                     Get.back();
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.blue.shade100),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Xong',
                      style: textStyle1,
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
