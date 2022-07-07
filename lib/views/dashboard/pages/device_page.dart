import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ics_flutter/controllers/dashboard_controllers/device_controller.dart';
import 'package:mobile_ics_flutter/core/theme/theme_config.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/core/widgets/widget.dart';
import 'package:mobile_ics_flutter/views/dashboard/components/component.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:syncfusion_flutter_charts/charts.dart';

class DevicePage extends StatelessWidget {
  const DevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final DeviceController controller = Get.put(DeviceController());
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
                              'DEVICE_TITLE'.tr,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'DEVICE_AMOUNT_TYPE'.tr,
                        style: KTextStyle.textSubTitleStyle,
                        textAlign: TextAlign.center,
                        // tColor: Color(C),
                      ),
                    ],
                  ),
                ),
                Constants.sizedBoxH5,
                Container(
                  height: 270,
                  width: double.infinity,
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
                              'DEVICE_FILTER_BY_TYPE'.tr,
                              style: KTextStyle.textTitleFilterStyle,
                            ),
                          ],
                        ),
                      ),
                      Obx(
                        () => Expanded(
                          child: charts.BarChart(
                            // ignore: invalid_use_of_protected_member
                            controller.series.value,
                            animate: true,
                            animationDuration: Constants.dur500,
                            defaultRenderer: charts.BarRendererConfig(
                              maxBarWidthPx: 40,
                              barRendererDecorator:
                                  charts.BarLabelDecorator<String>(
                                insideLabelStyleSpec:
                                    KTextStyle.textInsideLabelStyleSpec,
                                outsideLabelStyleSpec:
                                    KTextStyle.textOutsideLabelStyleSpec,
                              ),
                            ),
                            domainAxis: charts.OrdinalAxisSpec(
                              renderSpec: charts.SmallTickRendererSpec(
                                // Tick and Label styling here.
                                labelStyle: KTextStyle.textChartsLabelStyle,

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
                                labelStyle: KTextStyle.textChartsLabelStyle1,

                                // Change the line colors to match text color.
                                lineStyle: charts.LineStyleSpec(
                                  color: charts.ColorUtil.fromDartColor(
                                    kBackgroundTitle.withOpacity(.3),
                                  ),
                                ),
                              ),
                            ),
                          ),
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
                        'DEVICE_AMOUNT_STATUS'.tr,
                        style: KTextStyle.textSubTitleStyle,
                        textAlign: TextAlign.center,
                        // tColor: Color(C),
                      ),
                    ],
                  ),
                ),
                Constants.sizedBoxH5,
                Container(
                  height: 340,
                  width: double.infinity,
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
                              'DEVICE_FILTER_BY_STATUS'.tr,
                              style: KTextStyle.textTitleFilterStyle,
                            ),
                          ],
                        ),
                      ),
                      Constants.sizedBoxH5,
                      SizedBox(
                        height: 35,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'NEWS_LOCAL'.tr,
                                  style: KTextStyle.textAmountSubStyle,
                                ),
                                Text(
                                  'NEWS_ONLINE'.tr,
                                  style: KTextStyle.textAmountSubStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Constants.sizedBoxH20,
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => Container(
                                height: 200,
                                width: Constants.screenWidth * .43,
                                alignment: Alignment.center,
                                child: SfCircularChart(
                                  // ignore: invalid_use_of_protected_member
                                  series: controller.seriesPie.value,
                                  tooltipBehavior: controller.tooltipBehavior1,
                                  legend: Legend(
                                    isVisible: true,
                                    position: LegendPosition.bottom,
                                    overflowMode: LegendItemOverflowMode.wrap,
                                    textStyle: KTextStyle.textLegendStyle,
                                    height: '40%',
                                    alignment: ChartAlignment.center,
                                  ),
                                ),
                              ),
                            ),
                            Obx(
                              () => Container(
                                height: 200,
                                width: Constants.screenWidth * .43,
                                alignment: Alignment.center,
                                child: SfCircularChart(
                                  // ignore: invalid_use_of_protected_member
                                  series: controller.seriesPie.value,
                                  tooltipBehavior: controller.tooltipBehavior2,
                                  legend: Legend(
                                    isVisible: true,
                                    position: LegendPosition.bottom,
                                    overflowMode: LegendItemOverflowMode.wrap,
                                    textStyle: KTextStyle.textLegendStyle,
                                    alignment: ChartAlignment.center,
                                    height: '40%',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
