import 'dart:io';

import 'package:mobile_ics_flutter/views/news_management/utils/kcolors.dart';
import 'package:mobile_ics_flutter/views/news_management/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ics_flutter/views/news_management/newsmanagement_components/custom_alert.dart';

class CreateFolderDialog extends StatelessWidget {
  final String path;

  CreateFolderDialog({Key? key, required this.path}) : super(key: key);

  final TextEditingController name = TextEditingController();

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
              'Tạo thư mục mới',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                    child: const Text('Hủy', style: textStyle1),
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 130,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (name.text.isNotEmpty) {
                        if (!Directory('$path/${name.text}').existsSync()) {
                          await Directory('$path/${name.text}')
                              .create()
                              .catchError((e) {
                            if (e.toString().contains('Permission denied')) {
                              Dialogs.showToast(
                                  'Cannot write to this Storage  device!');
                            }
                          });
                        } else {
                          Dialogs.showToast('Tên thư mục này đã tồn tại!');
                        }
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
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
                      'Tạo',
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
