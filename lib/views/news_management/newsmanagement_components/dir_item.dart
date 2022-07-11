import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_ics_flutter/views/news_management/utils/utils.dart';
import 'package:path/path.dart';

class DirectoryItem extends StatelessWidget {
  final FileSystemEntity file;
  final Function openTab;
  final Function threedotsTab;

  const DirectoryItem({
    Key? key,
    required this.file,
    required this.openTab,
    required this.threedotsTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return ListTile(
    //   onTap: () => tap(),
    //   contentPadding: EdgeInsets.all(0),
    //   leading: Container(
    //     height: 40,
    //     width: 40,
    //     child: Center(
    //       child: Icon(
    //         Icons.folder,
    //       ),
    //     ),
    //   ),
    //   title: Text(
    //     '${basename(file.path)}',
    //     style: TextStyle(
    //       fontSize: 14,
    //     ),
    //     maxLines: 2,
    //   ),
    //   trailing: popTap == null
    //       ? null
    //       : DirPopup(
    //           path: file.path,
    //           popTap: popTap,
    //         ),
    // );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(children: <Widget>[
        InkWell(
          // Nhấn vào folder
          onTap: () => openTab(),

          // Nhấn giữ folder
          onLongPress: () {
            //  openMoreAction();
          },
          child: Image.asset('assets/icons/nm_folder.png',
              width: 60, height: 60, fit: BoxFit.fitWidth),
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
