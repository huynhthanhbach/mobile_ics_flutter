import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ics_flutter/controllers/dashboard_controllers/dashboard_controller.dart';
import 'package:mobile_ics_flutter/core/theme/theme_config.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/core/widgets/widget.dart';
import 'package:mobile_ics_flutter/views/dashboard/components/component.dart';
import 'package:mobile_ics_flutter/views/dashboard/pages/backup_data_page.dart';
import 'package:mobile_ics_flutter/views/dashboard/pages/page.dart';

class DashboardScreen extends GetWidget<DashboardController> {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: Constants.padding20),
            decoration: const BoxDecoration(
              color: ThemeConfig.lightBG,
            ),
            child: Column(
              children: [
                Container(
                  color: kBackground,
                  height: 330,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 150,
                          decoration: const BoxDecoration(
                            color: kBackgroundTitle,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Constants.radCir30,
                              bottomRight: Constants.radCir30,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 70,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: Constants.padding35,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      child: Row(
                                        children: [
                                          InkWell(
                                            child: KImage.imageMenu,
                                            onTap: () {},
                                          ),
                                          const SizedBox(
                                            width: Constants.padding20,
                                          ),
                                          Text(
                                            'DASH_TITLE'.tr,
                                            style:
                                                KTextStyle.textTitleMainStyle,
                                          ),
                                        ],
                                      ),
                                    ),
                                    CircleAvatar(
                                      backgroundColor: kBackgroundTitle,
                                      radius: 35,
                                      child: InkWell(
                                        onTap: () {
                                          Get.to(
                                            transition: Transition.fade,
                                            curve: Curves.easeInQuad,
                                            duration: Constants.dur500,
                                            () => const BackupDataPage(),
                                          );
                                        },
                                        child: KImage.imageAvt,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          height: 200,
                          margin: const EdgeInsets.symmetric(
                            horizontal: Constants.padding15,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: Constants.padding10,
                          ),
                          decoration: BoxDecoration(
                            color: ThemeConfig.lightBG,
                            borderRadius: Constants.borRadCir15,
                            boxShadow: [
                              BoxShadow(
                                color: kBlack10,
                                offset: const Offset(4, 4),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ButtonDashboardFeature(
                                    onPress: () {
                                      Get.to(
                                        transition: Transition.fade,
                                        curve: Curves.easeInQuad,
                                        duration: Constants.dur500,
                                        () => const NewsPage(),
                                      );
                                    },
                                    title: 'DASH_NEWS_BUTTON'.tr,
                                    backgroundColorOut: kBGButtonNews,
                                    backgroundColorIn: kBGButtonNews,
                                    borderColorIn: kBorButtonNews,
                                    image: KImage.imageNews,
                                  ),
                                  ButtonDashboardFeature(
                                    onPress: () {
                                      Get.to(
                                        transition: Transition.fade,
                                        curve: Curves.easeInQuad,
                                        duration: Constants.dur500,
                                        () => const CalendarPage(),
                                      );
                                    },
                                    title: 'DASH_CAL_BUTTON'.tr,
                                    backgroundColorOut: kBGButtonCal,
                                    backgroundColorIn: kBGButtonCal,
                                    borderColorIn: kBorButtonCal,
                                    image: KImage.imageCalendar,
                                  ),
                                  ButtonDashboardFeature(
                                    onPress: () {
                                      Get.to(
                                        transition: Transition.fade,
                                        curve: Curves.easeInQuad,
                                        duration: Constants.dur500,
                                        () => const DevicePage(),
                                      );
                                    },
                                    title: 'DASH_DEVI_BUTTON'.tr,
                                    backgroundColorOut: kBGButtonDev,
                                    backgroundColorIn: kBGButtonDev,
                                    borderColorIn: kBorButtonDev,
                                    image: KImage.imageDevice,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ButtonDashboardFeature(
                                    onPress: () {
                                      Get.to(
                                        transition: Transition.fade,
                                        curve: Curves.easeInQuad,
                                        duration: Constants.dur500,
                                        () => const WarningPage(),
                                      );
                                    },
                                    title: 'DASH_WARN_BUTTON'.tr,
                                    backgroundColorOut: kBGButtonWar,
                                    backgroundColorIn: kBGButtonWar,
                                    borderColorIn: kBorButtonWar,
                                    image: KImage.imageWarning,
                                  ),
                                  ButtonDashboardFeature(
                                    onPress: () {
                                      Get.to(
                                        transition: Transition.fade,
                                        curve: Curves.easeInQuad,
                                        duration: Constants.dur500,
                                        () => const BandwidthPage(),
                                      );
                                    },
                                    title: 'DASH_BAND_BUTTON'.tr,
                                    backgroundColorOut: kBGButtonBan,
                                    backgroundColorIn: kBGButtonBan,
                                    borderColorIn: kBorButtonBan,
                                    image: KImage.imageBand,
                                  ),
                                  const SizedBox(height: 90, width: 100),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Constants.padding15,
                    vertical: Constants.padding10,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'HIS_NEWS_TITLE'.tr,
                              style: KTextStyle.textSubTitleStyle,
                              textAlign: TextAlign.center,
                            ),
                            InkWell(
                              onTap: () {
                                controller.changIndexPage(1);
                              },
                              child: Container(
                                height: 20,
                                width: 80,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: kBackgroundTag,
                                  borderRadius: Constants.borRadCir10,
                                ),
                                child: Text(
                                  'DASH_VIEW_ALL'.tr,
                                  style: KTextStyle.textSubTagStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Constants.sizedBoxH5,
                      Container(
                        height: 215,
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
                        child: RefreshIndicator(
                          onRefresh: controller.onRefreshNews,
                          color: kBackgroundTitle,
                          child: OverflowBox(
                            child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) =>
                                  const HistoryContentCard(
                                statusCode: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Constants.sizedBoxH10,
                      SizedBox(
                        height: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'HIS_WARN_TITLE'.tr,
                              style: KTextStyle.textSubTitleStyle,
                              textAlign: TextAlign.center,
                              // tColor: Color(C),
                            ),
                            InkWell(
                              onTap: () async {
                                // controller.fillData();
                              },
                              child: Container(
                                height: 20,
                                width: 80,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: kBackgroundTag,
                                  borderRadius: Constants.borRadCir10,
                                ),
                                child: Text(
                                  'DASH_VIEW_ALL'.tr,
                                  style: KTextStyle.textSubTagStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Constants.sizedBoxH5,
                      Container(
                        height: 215,
                        padding: const EdgeInsets.all(
                          Constants.padding10,
                        ),
                        decoration: BoxDecoration(
                          color: ThemeConfig.lightBG,
                          borderRadius: Constants.borRadCir15,
                          boxShadow: [
                            BoxShadow(
                              color: kBlack10,
                              offset: const Offset(4, 4),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) =>
                              const HistoryContentCard(
                            imageIcon: 'assets/icons/icon-warning.png',
                            titleName: "Tên cảnh báo",
                            titleType: "Nội dung cảnh báo",
                            titleTime:
                                "Loại: Hư thiết bị - Thời gian: 00:00 - 31/12/2022",
                            titleColor: kTitleWarningCardColor,
                            isTag: false,
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
