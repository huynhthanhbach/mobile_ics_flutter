/* 
    - Xây dựng giao diện của các item trên Grid view.
*/

import 'package:flutter/material.dart';
import 'package:mobile_ics_flutter/views/news_management/newsmanagement_components/constants.dart';

// Lớp xây dựng tạo item folder trong gridView với icon, tên và button dấu 3 chấm
// ignore: must_be_immutable
class Folder extends StatelessWidget {
  Folder({
    Key? key,
    required this.press,
    required this.name,
    // required this.datecreate, required this.usercreate, required this.type,
  }) : super(key: key);

  //
  late String datecreate;
  late String usercreate;
  late String type;
  //
  // Hàm xử lí khi nhấn vào dấu 3 chấm
  late  Function press;

  // Tên folder 
  late String name;

  String getName() => name;

  void setName(String newName) => name = newName;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(children: <Widget>[
        Image.asset('assets/icons/nm_folder.png', width: 60, height: 60, fit: BoxFit.fitWidth ),
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
