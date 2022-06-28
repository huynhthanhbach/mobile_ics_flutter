// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ics_flutter/controllers/dashboard_controllers/dashboard_controller.dart';
import 'package:mobile_ics_flutter/controllers/home_controller.dart';
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
            padding: const EdgeInsets.only(bottom: Constants.dkp),
            decoration: const BoxDecoration(
              color: Colors.white,
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
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 70,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: Constants.dkp * 1.75,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      child: Row(
                                        children: [
                                          InkWell(
                                            child: Image.asset(
                                              'assets/icons/menu.png',
                                              color: Colors.white,
                                              width: 30,
                                              height: 30,
                                              fit: BoxFit.fill,
                                            ),
                                            onTap: () {},
                                          ),
                                          const SizedBox(
                                            width: Constants.dkp,
                                          ),
                                          const KText(
                                            text: "Dashboard",
                                            style: TextStyle(
                                              fontWeight: Constants.kRegular,
                                              fontSize: 34,
                                              color: Colors.white,
                                            ),
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
                                        child: Image.asset(
                                          'assets/icons/avatar.png',
                                          color: Colors.white,
                                          width: 68,
                                          height: 68,
                                          fit: BoxFit.fill,
                                        ),
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
                            horizontal: Constants.dkp * .75,
                          ),
                          padding: const EdgeInsets.symmetric(
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
                                      title: "Bản tin"),
                                  ButtonDashboardFeature(
                                    onPress: () {
                                      Get.to(
                                        transition: Transition.fade,
                                        curve: Curves.easeInQuad,
                                        duration: Constants.dur500,
                                        () => const CalendarPage(),
                                      );
                                    },
                                    title: "Lịch",
                                    backgroundColorOut: const Color(0xFFE2F3FE),
                                    backgroundColorIn: const Color(0xFFE2F3FE),
                                    borderColorIn: const Color(0xFF79C1EF),
                                    image: 'assets/icons/calendar.png',
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
                                    title: "Thiết bị",
                                    backgroundColorOut: const Color(0xFFE7EBFB),
                                    backgroundColorIn: const Color(0xFFE7EBFB),
                                    borderColorIn: const Color(0xFF7991EF),
                                    image: 'assets/icons/device.png',
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
                                    title: "Cảnh báo",
                                    backgroundColorOut: const Color(0xFFF1ECFD),
                                    backgroundColorIn: const Color(0xFFF1ECFD),
                                    borderColorIn: const Color(0xFFA279EF),
                                    image: 'assets/icons/warning.png',
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
                                    title: "Băng thông",
                                    backgroundColorOut: const Color(0xFFFBE0EC),
                                    backgroundColorIn: const Color(0xFFFBE0EC),
                                    borderColorIn: const Color(0xFFEC78AB),
                                    image: 'assets/icons/bandwidth.png',
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
                    horizontal: Constants.dkp * .75,
                    vertical: Constants.dkp * .5,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const KText(
                              text: "Lịch sử phát bản tin",
                              tColor: kSubTitleMainColor,
                              size: 16,
                              fontWeight: Constants.kRegular,
                              isCenter: true,
                              // tColor: Color(C),
                            ),
                            InkWell(
                              onTap: () {
                                Get.find<HomeController>().changeIndex(1);
                              },
                              child: Container(
                                height: 20,
                                width: 80,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: kBackgroundTag,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const KText(
                                  text: "Xem thêm",
                                  size: 13,
                                  fontWeight: Constants.kRegular,
                                  isCenter: true,
                                  tColor: kTextTag,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: Constants.dkp * .25),
                      GetBuilder<DashboardController>(
                        id: 'HISTORY_NEWS',
                        builder: (_) => Container(
                          height: 215,
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
                          child: RefreshIndicator(
                            onRefresh: _.onRefreshNews,
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
                      ),
                      const SizedBox(height: Constants.dkp * .5),
                      SizedBox(
                        height: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const KText(
                              text: "Cảnh báo hệ thống",
                              tColor: kSubTitleMainColor,
                              size: 16,
                              fontWeight: Constants.kRegular,
                              isCenter: true,
                              // tColor: Color(C),
                            ),
                            InkWell(
                              onTap: () async {
                                controller.fillData();
                              },
                              child: Container(
                                height: 20,
                                width: 80,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: kBackgroundTag,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const KText(
                                  text: "Xem thêm",
                                  size: 13,
                                  fontWeight: Constants.kRegular,
                                  isCenter: true,
                                  tColor: kTextTag,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: Constants.dkp * .25),
                      Container(
                        height: 215,
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
                        child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) =>
                              const HistoryContentCard(
                            imageIcon: 'assets/icons/icon-warning.png',
                            titleName: "Tên cảnh báo",
                            titleType: "Nội dung cảnh báo",
                            titleTime:
                                "Loại: Hư thiết bị - Thời gian: 00:00 - 31/12/2022",
                            titleColor: Color(0xFFEBAE08),
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
