import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:mobile_ics_flutter/views/news_management/utils/constants.dart';
import 'package:mobile_ics_flutter/views/news_management/utils/kcolors.dart';
import 'package:mobile_ics_flutter/views/news_management/newsmanagement_components/bottomsheet_itemaction.dart';
import 'package:mobile_ics_flutter/views/news_management/newsmanagement_components/bottomsheet_floatingbuttonaction.dart';
import 'package:mobile_ics_flutter/views/news_management/newsmanagement_components/item.dart';

import 'package:mobile_ics_flutter/controllers/newsmanagement_controllers/newsmanagement_controller.dart';

class NewsManagementScreen extends StatelessWidget {
  const NewsManagementScreen({Key? key}) : super(key: key);
  
  

  @override
  Widget build(BuildContext context) {
    // Bắt đầu từ đây nè
    return GetBuilder<NewsManagementController>(
      init: NewsManagementController(),
      builder: (controller) => Scaffold(
        body: NotificationListener <UserScrollNotification> (
          onNotification: (notification) {
            if(notification.direction == ScrollDirection.forward) {
              if (!controller.isFbVisible) {controller.updateIsFbVisible(true);}
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
                                width: Constants.dkp,
                              ),
                              // Tiêu đề
                              const Text(
                                "Quản lí news",
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
                    
                //     // Container tên folder
                //     child: Stack(
                //       children: <Widget>[
                //         Positioned(
                //           top: 0,
                //           left: 10,
                //           right: 10,
                //           // Đường lai màu xanh
                //           child: Container(
                //               padding: const EdgeInsets.only(top: 20, bottom: 14),
                //               width: double.infinity,
                //               decoration: const BoxDecoration(
                //                 border: Border(
                //                   bottom: BorderSide(width: 1.0, color: kBlue),
                //                 ),
                //               ),
                //               // Container tên folder
                //               child: const Padding(
                //                 padding: EdgeInsets.only(left: 35),
                //                 child: Text(
                //                     //'$foldername',
                //                     'Tất cả',
                //                     style: textStyleTitleNameFolder),
                //               )),
                //         ),
                //         // Container(
                //         //   padding:
                //         //       const EdgeInsets.only(left: 15, right: 15, top: 70),
                //         //   child: GridView.builder(
                //         //     gridDelegate:
                //         //         const SliverGridDelegateWithMaxCrossAxisExtent(
                //         //             maxCrossAxisExtent: 180,
                //         //             childAspectRatio: 3 / 2,
                //         //             crossAxisSpacing: 0,
                //         //             mainAxisSpacing: 0),
                //         //     // Dữ liệu giả
                //         //     itemCount: 100,
                //         //     itemBuilder: (context, foldername) => Item(
                //         //       name: "$foldername",
                //         //       itemAction: () {
                //         //         //Gọi đến BottomSheetFolder để hiện bottom sheet chứa các chức năng Đổi tên, di chuyển, xóa khi nhấn vào dấu 3 chấm
                //         //         controller.showBottomSheet(
                //         //           context,
                //         //           BottomSheetActionFolder(
                //         //             foldername: foldername.toString(),
                //         //           ),
                //         //         );
                //         //       },
                //         //       // datecreate: '06/06/2022',
                //         //       // usercreate: 'Nguyễn Văn A',
                //         //       // type: 'folder'
                //         //     ),
                //         //   ),
                //         // ),
                //       ],
                //     ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Visibility(
          visible: controller.isFbVisible,
          child: bottomSheetFloatingButton(context, controller)
        ),
      ),
    );
  }
}
