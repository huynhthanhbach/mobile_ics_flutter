import 'package:flutter/material.dart';

class NewsManagementScreen extends StatelessWidget {
  const NewsManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
            child: Text(
              'NEWS MANAGEMENT SCREEN ',
            ),
          ),
        ],
      ),
    );
  }
}
