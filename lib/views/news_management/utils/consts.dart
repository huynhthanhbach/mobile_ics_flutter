import 'package:flutter/material.dart';
import 'package:mobile_ics_flutter/views/news_management/utils/kcolors.dart';

// Kiểu chữ tiêu đề
const textTitle = TextStyle(
  fontSize: 34,
  color: kWhite,
);

// Kiểu chữ hiển thị tên folder trên đầu
const textStyleTitleNameFolder = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 20,
  color: kBlack,
);

// Cỡ chữ 16 in đậm màu đen
const textStyle1 = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 16,
  color: kBlack,
);
const textStyle1gray = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 16,
  color: Color.fromARGB(255, 217, 217, 217),
);

const textStyle11 = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 16,
  color: kBlue,
);

// Cỡ chữ 16 màu đen không in đậm
const textStyle2 = TextStyle(fontSize: 16, color: kBlack);

class Constants {
  static List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  static List sortList = [
    'File name (A to Z)',
    'File name (Z to A)',
    'Date (oldest first)',
    'Date (newest first)',
  ];
}
