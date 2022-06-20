import 'package:get/get.dart';
import 'package:mobile_ics_flutter/controllers/file_manager.dart';

import 'package:flutter/material.dart';
import 'package:mobile_ics_flutter/views/news_management/constants.dart';
import 'package:mobile_ics_flutter/views/news_management/kcolors.dart';

class NewsManagementScreen extends StatelessWidget {
  const NewsManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FileManagerController>(
      init: FileManagerController(),
      builder: (controller) => Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [kBlue, kWhite],
            )),
            child: Column(
              children: [
                // Tiêu đề AppBar
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40, top: 37),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // Icon tiêu đề
                        Image.asset('assets/icons/nm_folder-title.png'),
                        // Tiêu đề
                        const Text(
                          "Quản lí bản tin",
                          style: TextStyle(
                            fontSize: 34,
                            color: kWhite,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        // Icon User
                        Image.asset('assets/icons/nm_avatar.png'),
                      ]),
                ),
                const SizedBox(height: 20),
                // Container nội dung
                Container(
                  height: 460,
                  width: 380,
                  decoration: BoxDecoration(
                    color: kWhite,
                    border: Border.all(width: 1, color: kShadow),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: kShadow,
                        spreadRadius: 1,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  // Container tên folder
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 10,
                        right: 10,
                        // Đường lai màu xanh
                        child: Container(
                            padding: const EdgeInsets.only(top: 20, bottom: 14),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(width: 1.0, color: kBlue),
                              ),
                            ),
                            // Container tên folder
                            child: const Padding(
                              padding: EdgeInsets.only(left: 35),
                              child: Text(
                                  //'$foldername',
                                  'Tất cả',
                                  style: textStyleTitleNameFolder),
                            )),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.only(left: 15, top: 70, right: 15),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 180,
                                  childAspectRatio: 3 / 2,
                                  crossAxisSpacing: 0,
                                  mainAxisSpacing: 0),
                          itemCount: 100,
                          itemBuilder: (context, foldername) => Folder(
                            name: "$foldername",
                            press: () {
                              //Gọi đến BottomSheetFolder để hiện bottom sheet chứa các chức năng Đổi tên, di chuyển, xóa khi nhấn vào dấu 3 chấm
                              controller.showBottomSheet(
                                context,
                                BottomSheetActionFolder(
                                  foldername: foldername,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: bottomSheetFloatingButton(context, controller),
      ),
    );
  }

  // Widget build floating button dấu +
  Widget bottomSheetFloatingButton(
          BuildContext context, FileManagerController controller) =>
      FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white, size: 35),
        onPressed: () {
          floatingButtonAction(context, controller);
        },
      );

  // Hàm xử lí hiện bottom sheet lên khi tap vào floating button dấu cộng để upload file mp3 hoặc tạo folder mới
  floatingButtonAction(BuildContext context, FileManagerController controller) {
    controller.showBottomSheet(
      context,
      Container(
        height: Get.mediaQuery.size.height * .4,
        padding: const EdgeInsets.only(
          top: Constants.dkp * .75,
          left: Constants.dkp * .75,
          right: Constants.dkp * .75,
          bottom: Constants.dkp * .5,
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
        ]),
      ),
    );
  }
}

// Lớp xây dựng tạo item folder trong gridView với icon, tên và button dấu 3 chấm
class Folder extends StatelessWidget {
  const Folder({
    Key? key,
    required this.press,
    required this.name,
  }) : super(key: key);

  // Hàm xử lí khi nhấn vào dấu 3 chấm
  final Function press;

  // Tên folder
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(children: <Widget>[
        Image.asset('assets/icons/nm_folder.png',
            width: 60, height: 60, fit: BoxFit.fitWidth),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 100,
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: textStyle1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Nhấn vào dấu 3 chấm và bottom sheet sẽ hiện lên
            InkWell(
              onTap: () {
                press(); //Gọi lại hàm press()
              },
              child: Image.asset('assets/icons/nm_icon-three-dots.png'),
            ),
          ],
        ),
      ]),
    );
  }
}

// Lớp xây dựng bottom sheet hiện lên khi nhấn vào dấu 3 chấm trong mỗi file/folder
class BottomSheetActionFolder extends StatelessWidget {
  const BottomSheetActionFolder({
    Key? key,
    required this.foldername,
  }) : super(key: key);

  final int foldername;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.mediaQuery.size.height * .6,
      padding: const EdgeInsets.only(
        top: Constants.dkp * .75,
        left: Constants.dkp * .75,
        right: Constants.dkp * .75,
        bottom: Constants.dkp * .5,
      ),
      decoration: const BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 45, top: 20),
            child: Row(
              children: [
                Text('$foldername', style: textStyle1),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45, top: 8.0),
            child: Row(
              children: const <Widget>[
                Text(
                  'Ngày tạo:',
                  style: textStyle2,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    '06/06/2022',
                    style: textStyle2,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45, top: 8),
            child: Row(
              children: const <Widget>[
                Text(
                  'Người tạo:',
                  style: textStyle2,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 14.0),
                  child: Text(
                    'Nguyễn Văn A',
                    style: textStyle2,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 0),
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: kBlue),
                ),
              ),
            ),
          ),

          // Đổi tên
          InkWell(
            onTap: () {
              openDialogChangeName(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 45, top: 35),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Image.asset('assets/icons/nm_changename.png'),
                  ),
                  const Text('Đổi tên', style: textStyle1),
                ],
              ),
            ),
          ),

          // Di chuyển
          Padding(
            padding: const EdgeInsets.only(left: 45, top: 35),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Image.asset('assets/icons/nm_move.png'),
                ),
                const Text('Di chuyển', style: textStyle1)
              ],
            ),
          ),

          // Xóa
          InkWell(
            onTap: () {
              openDialogDelete(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 45, top: 35),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Image.asset('assets/icons/nm_delete.png'),
                  ),
                  const Text('Xóa', style: textStyle1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Chức năng đổi tên
  Future openDialogChangeName(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('$foldername', style: textStyle1),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(
              icon: Image.asset('assets/icons/nm_changename.png'),
              fillColor: kShadow,
              filled: true,
              hintText: 'Nhập tên mới',
            ),
          ),
          actions: [  
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: const Text('Xong', style: textStyle1)),
                  TextButton(
                      onPressed: () {},
                      child: const Text('Hủy', style: textStyle1)),
                ],
              ),
            )
          ],
          backgroundColor: kWhite,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
        ),
      );

  // Chức năng xóa
  Future openDialogDelete(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('$foldername', style: textStyle1),
          content: const Text('Bạn có chắc chắn muốn xóa ?', style: textStyle1),
          actions: [
            Row(
              children: [
                TextButton(
                    onPressed: () {},
                    child: const Text('Xóa', style: textStyle1)),
                TextButton(
                    onPressed: () {},
                    child: const Text('Hủy', style: textStyle1)),
              ],
            )
          ],
          backgroundColor: kWhite,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
        ),
      );
}
