// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ics_flutter/controllers/dashboard_controllers/backup_data_controller.dart';
import 'package:mobile_ics_flutter/controllers/dashboard_controllers/dashboard_controller.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/core/widgets/widget.dart';
import 'package:mobile_ics_flutter/views/dashboard/components/component.dart';

class BackupDataPage extends StatelessWidget {
  const BackupDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dashBoardController = Get.find<DashboardController>();
    return GetBuilder<BackupDataController>(
      init: BackupDataController(),
      builder: (controller) => SafeArea(
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
                                child:
                                    Image.asset('assets/icons/button-back.png'),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Backup database",
                                style: KTextStyle.textTitlePageStyle,
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
                      horizontal: Constants.padding10,
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
                                text: list[index].date,
                                num: list[index].day,
                              ),
                              const SizedBox(width: Constants.padding5),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: Constants.padding15,
                vertical: Constants.padding20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  (controller.isLoading)
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: kBackgroundTitle,
                          ),
                        )
                      : const SizedBox(),
                  Constants.sizedBoxH20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await controller.backupDatabase();
                        },
                        child: const Text(
                          "Backup Data",
                        ),
                      ),
                      (Platform.isAndroid)
                          ? ElevatedButton(
                              onPressed: () async {
                                await controller.restoreDatabase();
                              },
                              child: const Text(
                                "Restore Data",
                              ),
                            )
                          : const SizedBox(),
                    ],
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
