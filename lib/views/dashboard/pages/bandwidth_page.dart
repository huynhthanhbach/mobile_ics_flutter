// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ics_flutter/controllers/dashboard_controllers/bandwidth_controller.dart';
import 'package:mobile_ics_flutter/core/theme/theme_config.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/core/widgets/widget.dart';
import 'package:mobile_ics_flutter/views/dashboard/components/component.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BandwidthPage extends StatelessWidget {
  const BandwidthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final BandwidthController controller = Get.put(BandwidthController());
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
                              'BANDWIDTH_TITLE'.tr,
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
                                text: list[index].date,
                                num: list[index].day,
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
                                text: list[index].day,
                                num: list[index].day,
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
                        'BANDWIDTH_SPEED'.tr,
                        style: KTextStyle.textSubTitleStyle,
                        textAlign: TextAlign.center,
                        // tColor: Color(C),
                      ),
                    ],
                  ),
                ),
                Constants.sizedBoxH5,
                Container(
                  height: 360,
                  padding: const EdgeInsets.all(Constants.padding10),
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
                    children: [
                      Expanded(
                        child: Obx(
                          () => SfCartesianChart(
                            series: controller.seriesLive.value,
                            enableAxisAnimation: true,
                            primaryXAxis: NumericAxis(
                              majorGridLines: const MajorGridLines(width: 0),
                              edgeLabelPlacement: EdgeLabelPlacement.shift,
                              interval: 2,
                              labelStyle: KTextStyle.textPieLabelBandStyle,
                              axisLine: const AxisLine(
                                width: 1,
                                color: kBackgroundTitle,
                              ),
                              title: AxisTitle(
                                text: 'BANDWIDTH_TIME'.tr,
                                textStyle:
                                    KTextStyle.textPieLabelBandTitleStyle,
                              ),
                            ),
                            primaryYAxis: NumericAxis(
                              axisLine: const AxisLine(
                                width: 1,
                                color: kBackgroundTitle,
                              ),
                              majorTickLines: const MajorTickLines(
                                  size: 0, color: kBackgroundTitle),
                              labelStyle: KTextStyle.textPieLabelBandStyle,
                              title: AxisTitle(
                                text: 'BANDWIDTH_INTER_SPEED'.tr,
                                textStyle:
                                    KTextStyle.textPieLabelBandTitleStyle,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'BANDWIDTH_NOW'.tr,
                                        style: KTextStyle.textDefaultStyle,
                                      ),
                                      Obx(
                                        () => Text(
                                          ': ${controller.nowDataValue.value.toStringAsFixed(3)} (Mbps) ',
                                          style: KTextStyle.textDefaultStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'BANDWIDTH_NOW_TOTAL'.tr,
                                        style: KTextStyle.textDefaultStyle,
                                      ),
                                      Obx(
                                        () => Text(
                                          ': ${controller.totalDataValue.value.toStringAsFixed(3)} (Mbps) ',
                                          style: KTextStyle.textDefaultStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
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
                        'BANDWIDTH_TOTAL'.tr,
                        style: KTextStyle.textSubTitleStyle,
                        textAlign: TextAlign.center,
                        // tColor: Color(C),
                      ),
                    ],
                  ),
                ),
                Constants.sizedBoxH5,
                Container(
                  height: 330,
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
                        height: 30,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'BANDWIDTH_USED'.tr,
                                  style: KTextStyle.textAmountSubStyle,
                                ),
                                Obx(
                                  () => Text(
                                    ' (${controller.timeStart.value} - ${controller.timeEnd.value}) ',
                                    style: KTextStyle.textAmountSubStyle,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Obx(
                        () => Expanded(
                          child: (controller.listBandwidth.isNotEmpty)
                              ? charts.BarChart(
                                  controller.seriesBarChart.value,
                                  animate: true,
                                  animationDuration: Constants.dur500,
                                  barRendererDecorator:
                                      charts.BarLabelDecorator<String>(
                                    insideLabelStyleSpec:
                                        KTextStyle.textInsideLabelStyleSpec,
                                    outsideLabelStyleSpec:
                                        KTextStyle.textOutsideLabelStyleSpec,
                                  ),
                                  domainAxis: charts.OrdinalAxisSpec(
                                    renderSpec: charts.SmallTickRendererSpec(
                                      // Tick and Label styling here.
                                      labelStyle:
                                          KTextStyle.textChartsLabelStyle,

                                      // Change the line colors to match text color.
                                      lineStyle: charts.LineStyleSpec(
                                        color: charts.ColorUtil.fromDartColor(
                                          kBackgroundTitle,
                                        ),
                                      ),
                                    ),
                                  ),
                                  primaryMeasureAxis: charts.NumericAxisSpec(
                                    renderSpec: charts.GridlineRendererSpec(
                                      // Tick and Label styling here.
                                      labelStyle:
                                          KTextStyle.textChartsLabelStyle1,

                                      // Change the line colors to match text color.
                                      lineStyle: charts.LineStyleSpec(
                                        color: charts.ColorUtil.fromDartColor(
                                          kBackgroundTitle.withOpacity(.3),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    'NONE_DATA'.tr,
                                    style: KTextStyle.textAmountSubStyle,
                                  ),
                                ),
                        ),
                      ),
                      Constants.sizedBoxH10,
                      SizedBox(
                        height: 35,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'BANDWIDTH_USED_MBS'.tr,
                                        style: KTextStyle.textDefaultStyle,
                                      ),
                                      Obx(
                                        () => Text(
                                          ': ${controller.totalDataUsed.value.toStringAsFixed(2)} (MB/s) ',
                                          style: KTextStyle.textDefaultStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
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
