import 'dart:io';

import 'package:mobile_ics_flutter/views/news_management/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ics_flutter/views/news_management/newsmanagement_components/custom_alert.dart';

class AddFileDialog extends StatelessWidget {
  final String path;

  AddFileDialog({Key? key, required this.path}) : super(key: key);

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
              'Add New Folder',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                Container(
                  height: 40,
                  width: 130,
                  child: OutlinedButton(
                    child: Text(
                      'Cancel',
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
                    child: const Text(
                      'Create',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (name.text.isNotEmpty) {
                        if (!Directory(path + '/${name.text}').existsSync()) {
                          await Directory(path + '/${name.text}')
                              .create()
                              .catchError((e) {
                            print(e.toString());
                            if (e.toString().contains('Permission denied')) {
                              Dialogs.showToast(
                                  'Cannot write to this Storage  device!');
                            }
                          });
                        } else {
                          Dialogs.showToast(
                              'A Folder with that name already exists!');
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
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
