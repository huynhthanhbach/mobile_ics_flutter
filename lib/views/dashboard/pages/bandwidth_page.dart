import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ics_flutter/controllers/dashboard_controllers/bandwidth_controller.dart';
import 'package:mobile_ics_flutter/controllers/dashboard_controllers/dashboard_controller.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/core/widgets/widget.dart';
import 'package:mobile_ics_flutter/views/dashboard/components/component.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BandwidthPage extends StatelessWidget {
  const BandwidthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dashBoardController = Get.find<DashboardController>();
    return GetBuilder<BandwidthController>(
      init: BandwidthController(),
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
                                text: "Băng thông",
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
                      children: const [
                        KText(
                          text: "Tốc độ dữ liệu hiện tại",
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
                    child: SfCartesianChart(
                      series: controller.seriesLive,
                      enableAxisAnimation: true,
                      primaryXAxis: NumericAxis(
                        majorGridLines: const MajorGridLines(width: 0),
                        edgeLabelPlacement: EdgeLabelPlacement.shift,
                        interval: 3,
                        labelStyle: const TextStyle(
                          color: kBackgroundTitle,
                          fontSize: 12,
                          fontWeight: Constants.kRegular,
                        ),
                        axisLine: const AxisLine(
                          width: 1,
                          color: kBackgroundTitle,
                        ),
                        title: AxisTitle(
                          text: 'Time (seconds)',
                          textStyle: const TextStyle(
                            color: Color(0xFFA0999B),
                            fontSize: 13,
                            fontWeight: Constants.kRegular,
                          ),
                        ),
                      ),
                      primaryYAxis: NumericAxis(
                        axisLine: const AxisLine(
                          width: 1,
                          color: kBackgroundTitle,
                        ),
                        majorTickLines: const MajorTickLines(
                            size: 0, color: kBackgroundTitle),
                        labelStyle: const TextStyle(
                          color: kBackgroundTitle,
                          fontSize: 12,
                          fontWeight: Constants.kRegular,
                        ),
                        title: AxisTitle(
                          text: 'Internet speed (Mbps)',
                          textStyle: const TextStyle(
                            color: Color(0xFFA0999B),
                            fontSize: 13,
                            fontWeight: Constants.kRegular,
                          ),
                        ),
                      ),
                    ),
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