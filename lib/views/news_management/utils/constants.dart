import 'dart:ui';

import 'package:flutter/material.dart';
import 'kcolors.dart';

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

const textStyle11 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: kBlue,
);

// Cỡ chữ 16 màu đen không in đậm
const textStyle2 = TextStyle(fontSize: 16, color: kBlack);

// Mặc định Radius 15

class Constants {
  static final MediaQueryData mediaQueryData =
      MediaQueryData.fromWindow(window);

  static final Size screenSize = mediaQueryData.size;

  static final double screenWidth = screenSize.width;

  static final double screenHeight = screenSize.height;

  static Widget boxPadding({double width = 0, double height = 0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  //default padding
  static const double dkp = 20.0;
  const Constants._();
}
