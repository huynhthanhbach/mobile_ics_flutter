import 'package:get/get.dart';
import 'package:mobile_ics_flutter/models/hive_models/hive_model.dart';

import 'component.dart';

class MyBottomSheet extends StatelessWidget {
  const MyBottomSheet({Key? key, required this.news}) : super(key: key);
  final NewsHiveModel news;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: bottomSheetHeight,
      decoration: const BoxDecoration(
          color: opWhite,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadius1),
              topRight: Radius.circular(borderRadius1))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: padding2),
                child: Text(
                  news.name!,
                  style: textStyle2,
                ),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: primaryColor,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                vertical: padding2, horizontal: padding3),
            child: Column(
              children: [
                bottomSheetCard(
                    icon: iconCalender,
                    name: 'BSL_TIME'.tr,
                    value: news.createDate.toString()),
                const SizedBox(
                  height: defaultPadding,
                ),
                bottomSheetCard(
                    icon: iconClock,
                    name: 'BSL_DURATION'.tr,
                    value: news.duration!),
                const SizedBox(
                  height: defaultPadding,
                ),
                Row(
                  children: [
                    bottomSheetCard(
                      icon: iconStatus,
                      name: 'BSL_STATUS'.tr,
                      value: 'Đang phát',
                      isPlaying: true,
                      paddingRight: padding3,
                    ),
                    bottomSheetCard(
                      icon: iconVolume,
                      name: 'BSL_VOLUME'.tr,
                      value: '50%',
                    ),
                  ],
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                bottomSheetCard(
                  icon: iconNews,
                  name: 'BSL_CATEGORY'.tr,
                  value: news.type!,
                ),
                const SizedBox(
                  height: defaultPadding - 5,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/op_devices.png',
                      width: 25,
                    ),
                    const SizedBox(
                      width: defaultPadding,
                    ),
                    Text(
                      'BSL_DEVICE'.tr,
                      style: TextStyle(
                          fontSize: 16,
                          color: const Color(0xff4b4b4b).withOpacity(.7)),
                    ),
                    DropdownButton<String>(
                      underline: Container(color: Colors.transparent),
                      value: '0',
                      items: [
                        DropdownMenuItem(
                            value: '0',
                            child: PlayNewsCard(
                              text: '${'BSL_DEVICE_SELECTED'.tr} (3)',
                              isGrey: true,
                              width: 145,
                            )),
                        const DropdownMenuItem(
                            value: '1',
                            child: PlayNewsCard(
                              text: 'Loa 1',
                              isGrey: true,
                              width: 145,
                            )),
                      ],
                      onChanged: (value) {},
                    ),
                  ],
                ),
                const SizedBox(
                  height: padding1,
                ),
                Row(
                  children: [
                    bottomSheetCard(
                      icon: iconRepeat,
                      name: 'BSL_REPEAT'.tr,
                      value: 'Một lần',
                      paddingRight: padding3,
                    ),
                    bottomSheetCard(
                      icon: iconWarning,
                      name: 'BSL_PRIORITY'.tr,
                      value: 'Cao',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
