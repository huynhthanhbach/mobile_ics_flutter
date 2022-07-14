import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:mobile_ics_flutter/views/news_management/newsmanagement_components/folder.dart';
import 'package:mobile_ics_flutter/views/news_management/utils/kcolors.dart';

import 'package:mobile_ics_flutter/controllers/newsmanagement_controllers/newsmanagement_controller.dart';

class NewsManagementScreen extends GetWidget<NewsManagementController> {
  const NewsManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.forward) {
            if (!controller.isFbVisible) {
              controller.updateIsFbVisible(true);
            }
          } else if (notification.direction == ScrollDirection.reverse) {
            controller.updateIsFbVisible(false);
          }
          return controller.isFbVisible;
        },
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
                      SizedBox(
                        child: Row(
                          children: [
                            // Icon tiêu đề
                            Image.asset('assets/icons/nm_folder-title.png'),
                            const SizedBox(
                              width: 20,
                            ),
                            // Tiêu đề
                            const Text(
                              "Quản lí",
                              style: TextStyle(
                                fontSize: 34,
                                color: kWhite,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Icon User
                      Image.asset('assets/icons/nm_avatar.png'),
                    ]),
              ),
              // Container nội dung
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 20,
                    bottom: 20 + 8,
                    left: 15,
                    right: 15,
                  ),
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Folder(
                      title: 'Các thư mục và tập tin',
                      path: controller.root,
                      controller: controller,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: Visibility(
      //   visible: controller.isFbVisible,
      //   child: bottomSheetFloatingButton(context, controller)
      // ),
    );
  }
}
