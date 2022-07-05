import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ics_flutter/controllers/dashboard_controllers/calendar_controller.dart';
import 'package:mobile_ics_flutter/core/theme/theme_config.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/core/widgets/widget.dart';
import 'package:mobile_ics_flutter/views/dashboard/components/component.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CalendarController controller = Get.put(CalendarController());
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(210),
          child: Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(horizontal: Constants.padding15),
            color: kBackground,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  padding: const EdgeInsets.only(
                    left: Constants.padding20,
                    right: Constants.padding20,
                    bottom: Constants.padding20,
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
                              child: KImage.buttonBack,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'CALENDAR_TITLE'.tr,
                              style: KTextStyle.textTitlePageStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(
                      horizontal: Constants.padding10,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.timeBar.length,
                      itemBuilder: (context, index) {
                        final list = controller.timeBar;

                        if (list[index].now) {
                          return Row(
                            children: [
                              const SizedBox(width: Constants.padding5),
                              DateTag(
                                text: list[index].text,
                                num: list[index].num,
                                isNow: true,
                              ),
                              const SizedBox(width: Constants.padding5),
                            ],
                          );
                        } else {
                          return Row(
                            children: [
                              const SizedBox(width: Constants.padding5),
                              DateTag(
                                text: list[index].text,
                                num: list[index].num,
                              ),
                              const SizedBox(width: Constants.padding5),
                            ],
                          );
                        }
                      },
                    ),
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
                        padding: const EdgeInsets.only(top: Constants.padding5),
                        child: Text(
                          'FILTER_TITLE'.tr,
                          style: KTextStyle.textTitleFilterStyle,
                        ),
                      ),
                      Obx(
                        () => FilterTag(name: controller.locationTag.value),
                      ),
                      Obx(
                        () => FilterTag(name: controller.timeTag.value),
                      ),
                      InkWell(
                        child: KImage.imageFilter,
                        onTap: () async {
                          await controller.showBottomSheet(
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
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: Constants.padding10,
              bottom: Constants.padding20,
              left: Constants.padding15,
              right: Constants.padding15,
            ),
            decoration: const BoxDecoration(
              color: kBackgroundSubPage,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'CALENDAR_IN_DAY'.tr,
                        style: KTextStyle.textSubTitleStyle,
                        textAlign: TextAlign.center,
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
                Constants.sizedBoxH5,
                Container(
                  height: 300,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Constants.padding5,
                    vertical: Constants.padding10,
                  ),
                  decoration: BoxDecoration(
                    color: ThemeConfig.lightBG,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: kBlack10,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'TITLE_TIME'.tr,
                                  style: KTextStyle.textAmountSubStyle,
                                ),
                                Text(
                                  'TITLE_CONTENT'.tr,
                                  style: KTextStyle.textAmountSubStyle,
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
                                child: Center(
                                  child: Text(
                                    'CALENDAR_NONE'.tr,
                                    style: KTextStyle.textAmountSubStyle,
                                  ),
                                ),
                              )
                            : ScrollablePositionedList.builder(
                                itemScrollController: controller.itemController,
                                itemCount: controller.listNews!.length,
                                itemPositionsListener: controller.itemListener,
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
                Constants.sizedBoxH10,
                SizedBox(
                  height: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'CALENDAR_AMOUNT_STATUS'.tr,
                        style: KTextStyle.textSubTitleStyle,
                        textAlign: TextAlign.center,
                        // tColor: Color(C),
                      ),
                    ],
                  ),
                ),
                Constants.sizedBoxH5,
                Container(
                  height: 250,
                  width: double.infinity,
                  padding: const EdgeInsets.all(
                    Constants.padding10,
                  ),
                  decoration: BoxDecoration(
                    color: ThemeConfig.lightBG,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: kBlack10,
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
                          children: [
                            Obx(
                              () => Text(
                                controller.timeBar.length.toString(),
                                style: KTextStyle.textAmountStyle,
                              ),
                            ),
                            Text(
                              'CALENDAR_FILTER_BY_STATUS'.tr,
                              style: KTextStyle.textTitleFilterStyle,
                            ),
                          ],
                        ),
                      ),
                      Obx(
                        () => Expanded(
                          child: SfCircularChart(
                            // ignore: invalid_use_of_protected_member
                            series: controller.seriesPie.value,
                            tooltipBehavior: controller.tooltipBehavior,
                            legend: Legend(
                              isVisible: true,
                              overflowMode: LegendItemOverflowMode.wrap,
                              textStyle: KTextStyle.textLegendStyle,
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
    );
  }
}
