import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ics_flutter/controllers/dashboard_controllers/dashboard_controller.dart';
import 'package:mobile_ics_flutter/controllers/dashboard_controllers/device_controller.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/core/widgets/widget.dart';
import 'package:mobile_ics_flutter/views/dashboard/components/component.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:syncfusion_flutter_charts/charts.dart';

class DevicePage extends StatelessWidget {
  const DevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dashBoardController = Get.find<DashboardController>();
    return GetBuilder<DeviceController>(
      init: DeviceController(),
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
                                text: "Thiết bị",
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
                                  controller.changList();
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
                          text: "Số lượng thiết bị phân theo loại",
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
                    height: 270,
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
                                text: "Thiết bị phân theo loại",
                                size: 16,
                                fontWeight: Constants.kRegular,
                                tColor: Color(0xFFBCBEC3),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: charts.BarChart(
                            controller.series,
                            animate: true,
                            animationDuration: Constants.dur500,
                            defaultRenderer: charts.BarRendererConfig(
                              maxBarWidthPx: 40,
                              barRendererDecorator:
                                  charts.BarLabelDecorator<String>(
                                insideLabelStyleSpec:
                                    const charts.TextStyleSpec(
                                  color: charts.Color.white,
                                  fontSize: 13,
                                  fontWeight: 'w500',
                                  fontFamily: 'SourceSansPro',
                                ),
                                outsideLabelStyleSpec:
                                    const charts.TextStyleSpec(
                                  color: charts.Color.black,
                                  fontSize: 13,
                                  fontWeight: 'w500',
                                  fontFamily: 'SourceSansPro',
                                ),
                              ),
                            ),
                            domainAxis: charts.OrdinalAxisSpec(
                              renderSpec: charts.SmallTickRendererSpec(
                                // Tick and Label styling here.
                                labelStyle: charts.TextStyleSpec(
                                  fontSize: 13, // size in Pts.
                                  color: charts.ColorUtil.fromDartColor(
                                    const Color(0xFFBCBEC3),
                                  ),
                                ),

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
                                labelStyle: charts.TextStyleSpec(
                                  fontSize: 13, // size in Pts.
                                  color: charts.ColorUtil.fromDartColor(
                                    kBackgroundTitle,
                                  ),
                                ),

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
                          text: "Số lượng thiết bị phân theo trạng thái",
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
                                text: "Thiết bị phân theo trạng thái",
                                size: 16,
                                fontWeight: Constants.kRegular,
                                tColor: Color(0xFFBCBEC3),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: Constants.dkp),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 200,
                                width: Constants.screenWidth * .43,
                                alignment: Alignment.center,
                                child: SfCircularChart(
                                  series: controller.seriesPie,
                                  tooltipBehavior: controller.tooltipBehavior1,
                                  legend: Legend(
                                    isVisible: true,
                                    position: LegendPosition.bottom,
                                    overflowMode: LegendItemOverflowMode.wrap,
                                    textStyle: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: Constants.kRegular,
                                      color: Color(0xFFBCBEC3),
                                    ),
                                    height: '40%',
                                    alignment: ChartAlignment.center,
                                  ),
                                ),
                              ),
                              Container(
                                height: 200,
                                width: Constants.screenWidth * .43,
                                alignment: Alignment.center,
                                child: SfCircularChart(
                                  series: controller.seriesPie,
                                  tooltipBehavior: controller.tooltipBehavior2,
                                  legend: Legend(
                                    isVisible: true,
                                    position: LegendPosition.bottom,
                                    overflowMode: LegendItemOverflowMode.wrap,
                                    textStyle: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: Constants.kRegular,
                                      color: Color(0xFFBCBEC3),
                                    ),
                                    alignment: ChartAlignment.center,
                                    height: '40%',
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
      ),
    );
  }
}
