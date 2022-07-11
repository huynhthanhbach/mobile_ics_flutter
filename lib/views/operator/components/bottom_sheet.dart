import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:mobile_ics_flutter/models/hive_models/hive_model.dart';

import 'component.dart';

class MyBottomSheet extends StatelessWidget {
  const MyBottomSheet({Key? key, required this.news, required this.playNews})
      : super(key: key);
  final NewsHiveModel news;
  final PlayNewsHiveModel playNews;
  List<DropdownMenuItem<String>> dropdown() {
    List<DropdownMenuItem<String>> temp = [];
    temp.add(
      DropdownMenuItem(
          value: '0',
          child: PlayNewsCard(
            text: '${'BSL_DEVICE_SELECTED'.tr} (${playNews.listDevice.length})',
            isGrey: false,
            width: 145,
          )),
    );
    for (var item in playNews.listDevice) {
      temp.add(DropdownMenuItem(
          value: '',
          child: PlayNewsCard(
            text: item.name!,
            isGrey: true,
            width: 145,
          )));
    }
    return temp;
  }

  List<DropdownMenuItem<String>> playTime() {
    List<DropdownMenuItem<String>> temp = [];
    List<String> times = playNews.timeTitle!
        .substring(1, playNews.timeTitle!.length - 1)
        .split(',');

    temp.add(
      DropdownMenuItem(
        value: '0',
        child: PlayNewsCard(
          text: '${'BSL_TIME'.tr}(${times.length})',
          isGrey: false,
          width: 145,
        ),
      ),
    );
    for (var time in times) {
      temp.add(
        DropdownMenuItem(
          value: '',
          child: PlayNewsCard(
            text: time,
            isGrey: false,
            width: 145,
          ),
        ),
      );
    }

    return temp;
  }

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
                vertical: padding1, horizontal: padding3),
            child: Column(
              children: [
                Row(children: [
                  Image.asset(
                    'assets/icons/op_calender.png',
                    width: 25,
                  ),
                  const SizedBox(
                    width: defaultPadding,
                  ),
                  DropdownButton<String>(
                    underline: Container(color: Colors.transparent),
                    value: '0',
                    items: playTime(),
                    onChanged: (value) {},
                  ),
                ]),
                const SizedBox(
                  height: padding1,
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
                      value: playNews.status!,
                      isPlaying: true,
                      paddingRight: padding3,
                    ),
                    bottomSheetCard(
                      icon: iconVolume,
                      name: 'BSL_VOLUME'.tr,
                      value: '${playNews.volume}%',
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
                      items: dropdown(),
                      onChanged: (value) {},
                    ),
                  ],
                ),
                const SizedBox(
                  height: padding1,
                ),
                bottomSheetCard(
                  icon: iconRepeat,
                  name: 'BSL_REPEAT'.tr,
                  value: (playNews.repeatMode!.substring(0, 10) ==
                          playNews.repeatMode!.substring(13, 23)
                      ? playNews.repeatMode!.substring(0, 10)
                      : playNews.repeatMode!),
                  paddingRight: padding3,
                ),
                const SizedBox(
                  height: padding1,
                ),
                bottomSheetCard(
                  icon: iconWarning,
                  name: 'BSL_PRIORITY'.tr,
                  value: playNews.prioritized!,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
