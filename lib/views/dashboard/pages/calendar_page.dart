import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ics_flutter/controllers/dashboard_controllers/calendar_controller.dart';
import 'package:mobile_ics_flutter/controllers/dashboard_controllers/dashboard_controller.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/core/widgets/widget.dart';
import 'package:mobile_ics_flutter/views/dashboard/components/component.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
                  GetBuilder<DashboardController>(
                    builder: (_) => SizedBox(
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
                          FilterTag(
                            name: _.locationTag!,
                          ),
                          FilterTag(
                            name: _.timeTag!,
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
                              _.showBottomSheet(
                                context,
                                BottomSheetFilter(
                                  onPress: () {
                                    controller.changList();
                                    Get.back();
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const KText(
                          text: "Bản tin trong ngày",
                          tColor: kSubTitleMainColor,
                          size: 16,
                          fontWeight: Constants.kRegular,
                          isCenter: true,
                          // tColor: Color(C),
                        ),
                        InkWell(
                          onTap: () {
                            controller.jumpNewsPlaying();
                          },
                          child: Container(
                            height: 20,
                            width: 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: kBackgroundTag,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.asset(
                              'assets/icons/music-playing.png',
                              width: 35,
                              fit: BoxFit.fitWidth,
                              color: kTextTag,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: Constants.dkp * .25),
                  Container(
                    height: 300,
                    padding: const EdgeInsets.symmetric(
                      horizontal: Constants.dkp * .25,
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
                                  itemPositionsListener:
                                      controller.itemListener,
                                  itemBuilder: (context, index) {
                                    if (controller.listNews![index]['status'] ==
                                        'Đang phát') {
                                      return NewsTimeLine(
                                        details: controller.listNews![index],
                                        isNow: true,
                                      );
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
                  const SizedBox(height: Constants.dkp * .5),
                  SizedBox(
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        KText(
                          text:
                              "Số lượng lịch phát bản tin phân theo trạng thái",
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
                    height: 250,
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
                          height: 60,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              KText(
                                text: "1000",
                                size: 30,
                                fontWeight: Constants.kRegular,
                                tColor: kBackgroundTitle,
                              ),
                              KText(
                                text: "Bản tin phân theo trạng thái",
                                size: 16,
                                fontWeight: Constants.kRegular,
                                tColor: Color(0xFFBCBEC3),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SfCircularChart(
                            series: controller.seriesPie,
                            tooltipBehavior: controller.tooltipBehavior,
                            legend: Legend(
                              isVisible: true,
                              overflowMode: LegendItemOverflowMode.wrap,
                              textStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: Constants.kRegular,
                                color: Color(0xFFBCBEC3),
                              ),
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
        ),
      ),
    );
  }
}
