import 'component.dart';
import 'tempdb.dart';

class MyBottomSheet extends StatelessWidget {
  const MyBottomSheet({Key? key}) : super(key: key);

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
                child: const Text(
                  newsTest1,
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
                const bottomSheetCard(
                    icon: iconCalender,
                    name: bsTimeLabel,
                    value: '17h00 - 01/06/2022'),
                const SizedBox(
                  height: defaultPadding,
                ),
                const bottomSheetCard(
                    icon: iconClock, name: bsDurationLabel, value: '15 phút'),
                const SizedBox(
                  height: defaultPadding,
                ),
                Row(
                  children: const [
                    bottomSheetCard(
                      icon: iconStatus,
                      name: bsStatusLabel,
                      value: 'Đang phát',
                      isPlaying: true,
                      paddingRight: padding3,
                    ),
                    bottomSheetCard(
                      icon: iconVolume,
                      name: bsVolumeLabel,
                      value: '50%',
                    ),
                  ],
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                const bottomSheetCard(
                  icon: iconNews,
                  name: bsCategoriesLabel,
                  value: 'Đời sống',
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
                      'Thiết bị phát: ',
                      style: TextStyle(
                          fontSize: 16,
                          color: const Color(0xff4b4b4b).withOpacity(.7)),
                    ),
                    DropdownButton<String>(
                      underline: Container(color: Colors.transparent),
                      value: '0',
                      items: const [
                        DropdownMenuItem(
                            value: '0',
                            child: PlayNewsCard(
                              text: 'Danh sách thiết bị (3)',
                              isGrey: true,
                              width: 145,
                            )),
                        DropdownMenuItem(
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
                  children: const [
                    bottomSheetCard(
                      icon: iconRepeat,
                      name: bsRepeatLabel,
                      value: 'Một lần',
                      paddingRight: padding3,
                    ),
                    bottomSheetCard(
                      icon: iconWarning,
                      name: bsPriority,
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
