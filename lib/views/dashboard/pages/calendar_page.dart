import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ics_flutter/controllers/dashboard_controllers/calendar_controller.dart';
import 'package:mobile_ics_flutter/controllers/dashboard_controllers/dashboard_controller.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/core/widgets/widget.dart';
import 'package:mobile_ics_flutter/views/dashboard/components/component.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dashBoardController = Get.find<DashboardController>();
    return GetBuilder<CalendarPageController>(
      init: CalendarPageController(),
      builder: (controller) => SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(210),
            child: Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: Constants.dkp * .75),
              color: kBackground,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    padding: const EdgeInsets.only(
                      left: Constants.dkp,
                      right: Constants.dkp,
                      bottom: Constants.dkp,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () => Get.back(),
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child:
                                    Image.asset('assets/icons/button-back.png'),
                              ),
                            ),
                            const Expanded(
                              child: KText(
                                text: "Lịch",
                                size: 34,
                                tColor: kBackgroundTitle,
                                isCenter: true,
                                fontWeight: Constants.kRegular,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(
                      horizontal: Constants.dkp * .5,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: dashBoardController.timeBar.length,
                      itemBuilder: (context, index) {
                        final list = dashBoardController.timeBar;

                        if (list[index].now) {
                          return Row(
                            children: [
                              const SizedBox(width: Constants.dkp * .25),
                              DateTag(
                                text: list[index].text,
                                num: list[index].num,
                                isNow: true,
                              ),
                              const SizedBox(width: Constants.dkp * .25),
                            ],
                          );
                        } else {
                          return Row(
                            children: [
                              const SizedBox(width: Constants.dkp * .25),
                              DateTag(
                                text: list[index].text,
                                num: list[index].num,
                              ),
                              const SizedBox(width: Constants.dkp * .25),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          width: 30,
                          padding:
                              const EdgeInsets.only(top: Constants.dkp * .25),
                          child: const KText(
                            text: "Lọc: ",
                            tColor: Color(0xFFBCBEC3),
                            size: 16,
                            fontWeight: Constants.kRegular,
                          ),
                        ),
                        const FilterTag(
                          name: "Cấp huyện",
                        ),
                        const FilterTag(
                          name: "Một tháng trước",
                        ),
                        InkWell(
                          child: Image.asset(
                            'assets/icons/menu.png',
                            color: kBackgroundTitle,
                            width: 30,
                            height: 30,
                            fit: BoxFit.fill,
                          ),
                          onTap: () async {
                            dashBoardController.showBottomSheet(
                              context,
                              BottomSheetFilter(
                                onPress: () {
                                  Get.back();
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: Constants.dkp * .5,
                bottom: Constants.dkp,
                left: Constants.dkp * .75,
                right: Constants.dkp * .75,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFFF5F5F5),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        KText(
                          text: "Bản tin trong ngày",
                          tColor: kSubTitleMainColor,
                          size: 16,
                          fontWeight: Constants.kRegular,
                          isCenter: true,
                          // tColor: Color(C),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: Constants.dkp * .25),
                  Container(
                    height: 300,
                    padding: const EdgeInsets.symmetric(
                      horizontal: Constants.dkp * .5,
                      vertical: Constants.dkp * .5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(4, 4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 35,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  KText(
                                    text: "Thời gian",
                                    size: 20,
                                    fontWeight: Constants.kRegular,
                                    tColor: kBackgroundTitle,
                                  ),
                                  KText(
                                    text: "Nội dung",
                                    size: 20,
                                    fontWeight: Constants.kRegular,
                                    tColor: kBackgroundTitle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: (controller.listNews == null)
                              ? Container(
                                  color: kBackgroundTag,
                                  child: const Center(
                                    child: KText(
                                      text: "Không có lịch phát!",
                                      fontWeight: Constants.kRegular,
                                      tColor: kBackgroundTitle,
                                      size: 20,
                                    ),
                                  ),
                                )
                              : ScrollablePositionedList.builder(
                                  itemScrollController:
                                      controller.itemController,
                                  itemCount: controller.listNews!.length,
                                  itemBuilder: (context, index) {
                                    if (controller.listNews![index]['status'] ==
                                        'Đang phát') {
                                      // WidgetsBinding.instance
                                      //     .addPostFrameCallback((_) {
                                      //   Future.delayed(
                                      //       const Duration(milliseconds: 500),
                                      //       () {
                                      //     controller.scrollToItem(index);
                                      //   });
                                      // });
                                    }
                                    return NewsTimeLine(
                                      details: controller.listNews![index],
                                    );
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () async {
                          controller.changeStatus(3);
                        },
                        child: Image.asset(
                          'assets/icons/music-playing.png',
                          width: 35,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// SliverList(
//                                       delegate: SliverChildBuilderDelegate(
//                                         (context, index) => NewsTimeLine(
//                                           details: controller.listNews![index],
//                                         ),
//                                         childCount: controller.listNews!.length,
//                                       ),
//                                     ),




//  CustomScrollView(
//                                   controller: controller.scrollController,
//                                   slivers: [
//                                     // SliverToBoxAdapter(
//                                     //   child: Column(
//                                     //     children: controller.buildListNews(
//                                     //       controller.listNews!,
//                                     //     ),
//                                     //   ),
//                                     // )
//                                     SliverList(
//                                       delegate: SliverChildBuilderDelegate(
//                                         childCount: controller.listNews!.length,
//                                         (context, index) {
//                                           return NewsTimeLine(
//                                             details:
//                                                 controller.listNews![index],
//                                           );
//                                         },
//                                       ),
//                                     )
//                                   ],
//                                 ),
