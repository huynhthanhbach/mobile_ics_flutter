// ignore_for_file: avoid_print

/* 
    - Xây dựng Floating Button.
    - Xây dựng giao diện Bottom Sheet khi nhấn vào Floating Button.
    - Xây dựng chức năng của các tùy chọn trên Bottom Sheet.
*/

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile_ics_flutter/controllers/newsmanagement_controllers/newsmanagement_controller.dart';
import 'package:mobile_ics_flutter/views/news_management/newsmanagement_components/add_file_dialog.dart';
import 'package:mobile_ics_flutter/views/news_management/utils/kcolors.dart';
import 'package:mobile_ics_flutter/views/news_management/utils/utils.dart';

//Hàm xây dựng FloatingButton
Widget bottomSheetFloatingButton(
  BuildContext context, NewsManagementController controller) =>
    FloatingActionButton(
      backgroundColor: Colors.blue.withOpacity(.7),
      child: const Icon(Icons.add, color: Colors.white, size: 35),
      onPressed: () {
        floatingButtonAction(context, controller);
      },
    );
    

// Hàm xử lí hiện bottom sheet lên khi tap vào floating button dấu cộng để upload file mp3 hoặc tạo folder mới
floatingButtonAction(BuildContext context, NewsManagementController controller) {
  controller.showBottomSheet(
    context,
    Container(
      height: Get.mediaQuery.size.height * .3,
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
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Tất cả',
                  //'$foldername',
                  style: textStyle1),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 30),
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.0, color: kBlue),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 45, top: 0),
          child: InkWell(
            onTap: () => addDialog(context, controller.path!),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Image.asset('assets/icons/nm_newfolder.png'),
                ),
                const Text('Tạo thư mục mới', style: textStyle1),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 45, top: 20),
          child: InkWell(
            onTap: () {
              pickFiless();
            },
            child: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(Icons.upload, size: 50, color: kBlue),
                ),
                Text('Tải lên', style: textStyle1),
              ],
            ),
          ),
        ),
      ]),
    ),
  );
}

addDialog(BuildContext context, String path) async {
    await showDialog(
      context: context,
      builder: (context) => AddFileDialog(path: path),
    );
    // getFiles();
  }

void pickFiless() async {
  List<PlatformFile>? paths;

  String? extension;
  String? fileName;
  bool userAborted = false;

  try {
    paths = (await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
      onFileLoading: (FilePickerStatus status) => print(status),
      allowedExtensions: (extension?.isNotEmpty ?? false)
          ? extension?.replaceAll(' ', '').split(',')
          : null,
    ))
        ?.files;
  } on PlatformException catch (e) {
    print("Unsupported operation ${e.toString()}");
  } catch (e) {
    print(e.toString());
  }
  fileName = paths != null ? paths.map((e) => e.name).toString() : '...';
  userAborted = paths == null;
}

// Future createNewFolder(BuildContext context) => showDialog(
//   context: context,
//   builder: (context) {
//     final FileManagerController controller = FileManagerController();
//     TextEditingController folderName = TextEditingController();
//     return AlertDialog(
//       title: const Text('Tạo thư mục mới', style: textStyle1),
//       content: TextField(
//         autofocus: true,
//         decoration: InputDecoration(
//           icon: Image.asset('assets/icons/nm_changename.png'),
//           fillColor: kShadow,
//           filled: true,
//           hintText: 'Nhập tên thư mục',
//         ),
//       ),
//       actions: [
//         Padding(
//           padding: const EdgeInsets.only(left: 40, right: 40),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               TextButton(
//                   onPressed: () async {
//                     try {
//                       // Create Folder
//                       await FileManager.createFolder(
//                         controller.getCurrentPath, folderName.text
//                       );
//                       // Open Created Folder
//                       controller.setCurrentPath =
//                           "${controller.getCurrentPath}/${folderName.text}";
//                     } catch (e) {}

//                     // ignore: use_build_context_synchronously
//                     Navigator.pop(context);
//                   },
//                   child: const Text('Tạo', style: textStyle11)),
//               TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text('Hủy', style: textStyle11)),
//             ],
//           ),
//         )
//       ],
//       backgroundColor: kWhite,
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(15.0))),
//     );
//   }
// );
