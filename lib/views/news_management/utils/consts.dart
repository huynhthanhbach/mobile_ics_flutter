import 'dart:html';

import 'package:flutter/material.dart';

class Constants {
  static List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  static List categories = [
    {'title': 'Videos', 'icon': Icons.play_circle, 'path': '', 'color': Colors.red},
    {
      'title': 'Audio',
      'icon': Icons.music_note,
      'path': '',
      'color': Colors.teal
    },
    {
      'title': 'Documents & Others',
      'icon': Icons.book,
      'path': '',
      'color': Colors.pink
    },
  ];

  static List sortList = [
    'File name (A to Z)',
    'File name (Z to A)',
    'Date (oldest first)',
    'Date (newest first)',
  ];
}
