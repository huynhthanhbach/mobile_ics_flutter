// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ics_flutter/controllers/dashboard_controllers/warning_controller.dart';
import 'package:mobile_ics_flutter/core/theme/theme_config.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/core/widgets/widget.dart';
import 'package:mobile_ics_flutter/views/dashboard/components/component.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WarningPage extends StatelessWidget {
  const WarningPage({super.key});

  @override
  Widget build(BuildContext context) {
    final WarningController controller = Get.put(WarningController());
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
                              'WARNING_TITLE'.tr,
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
                        'WARNING_AMOUNT_LEVEL'.tr,
                        style: KTextStyle.textSubTitleStyle,
                        textAlign: TextAlign.center,
                        // tColor: Color(C),
                      ),
                    ],
                  ),
                ),
                Constants.sizedBoxH5,
                Container(
                  height: 300,
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
                              'WARNING_FILTER_BY_LEVEL'.tr,
                              style: KTextStyle.textTitleFilterStyle,
                            ),
                          ],
                        ),
                      ),
                      Obx(
                        () => Expanded(
                          child: SfCircularChart(
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
