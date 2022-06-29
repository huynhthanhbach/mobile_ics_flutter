/* 
    - Xây dựng giao diện Bottom Sheet khi nhấn vào dấu 3 chấm trên file/folder.
    - Xây dựng chức năng của các tùy chọn trên Bottom Sheet.
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ics_flutter/views/news_management/newsmanagement_components/constants.dart';
import 'package:mobile_ics_flutter/views/news_management/newsmanagement_components/kcolors.dart';

// Lớp xây dựng bottom sheet hiện lên khi nhấn vào dấu 3 chấm trong mỗi file/folder
class BottomSheetActionFolder extends StatelessWidget {
  const BottomSheetActionFolder({
    Key? key,
    required this.foldername,
  }) : super(key: key);

  final String foldername;

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
                Text(foldername, style: textStyle1),
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
          title: Text(foldername, style: textStyle1),
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
                      child: const Text('Xong', style: textStyle11)),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Hủy', style: textStyle11)),
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
          title: Text(foldername, style: textStyle1),
          content: const Text('Bạn có chắc chắn muốn xóa ?', style: textStyle1, textAlign: TextAlign.center),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: const Text('Xóa', style: textStyle11)),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Hủy', style: textStyle11)),
                ],
              ),
            )
          ],
          backgroundColor: kWhite,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
        ),
      );
}
