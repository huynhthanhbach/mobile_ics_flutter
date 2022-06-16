import 'operator_components.dart';

class MyBottomSheet extends StatelessWidget {
  const MyBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 365,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: const Text(
                  'Bản tin thời sự đài truyền hình Việt Nam',
                  style: TextStyle(fontSize: 18, color: primaryColor),
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
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/op_calender.png',
                      width: 25,
                    ),
                    const SizedBox(
                      width: defaultPadding,
                    ),
                    Text(
                      'Thời gian: ',
                      style: TextStyle(
                          fontSize: 16,
                          color: const Color(0xff4b4b4b).withOpacity(.7)),
                    ),
                    const Text(
                      '17h00 - 01/06/2022',
                      style: TextStyle(fontSize: 16, color: Color(0xff9b9b9b)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/op_clock.png',
                      width: 25,
                    ),
                    const SizedBox(
                      width: defaultPadding,
                    ),
                    Text(
                      'Thời lượng: ',
                      style: TextStyle(
                          fontSize: 16,
                          color: const Color(0xff4b4b4b).withOpacity(.7)),
                    ),
                    const Text(
                      '15 phút',
                      style: TextStyle(fontSize: 16, color: Color(0xff9b9b9b)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/op_status.png',
                      width: 25,
                    ),
                    const SizedBox(
                      width: defaultPadding,
                    ),
                    Text(
                      'Trạng thái: ',
                      style: TextStyle(
                          fontSize: 16,
                          color: const Color(0xff4b4b4b).withOpacity(.7)),
                    ),
                    const Text(
                      'Đang phát',
                      style: TextStyle(fontSize: 16, color: primaryColor),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Image.asset(
                      'assets/icons/op_volume.png',
                      width: 25,
                    ),
                    const SizedBox(
                      width: defaultPadding,
                    ),
                    const Text('50%',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff9b9b9b),
                        )),
                  ],
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/op_news.png',
                      width: 25,
                    ),
                    const SizedBox(
                      width: defaultPadding,
                    ),
                    Text(
                      'Chuyên mục: ',
                      style: TextStyle(
                          fontSize: 16,
                          color: const Color(0xff4b4b4b).withOpacity(.7)),
                    ),
                    const Text(
                      'Đời sống',
                      style: TextStyle(fontSize: 16, color: Color(0xff9b9b9b)),
                    ),
                  ],
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
                  height: defaultPadding - 5,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/op_repeat.png',
                      width: 25,
                    ),
                    const SizedBox(
                      width: defaultPadding,
                    ),
                    Text(
                      'Lặp: ',
                      style: TextStyle(
                          fontSize: 16,
                          color: const Color(0xff4b4b4b).withOpacity(.7)),
                    ),
                    const Text(
                      'Một lần',
                      style: TextStyle(fontSize: 16, color: Color(0xff9b9b9b)),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Image.asset(
                      'assets/icons/op_warning.png',
                      width: 25,
                    ),
                    const SizedBox(
                      width: defaultPadding,
                    ),
                    Text(
                      'Ưu tiên: ',
                      style: TextStyle(
                          fontSize: 16,
                          color: const Color(0xff4b4b4b).withOpacity(.7)),
                    ),
                    const Text(
                      'Cao',
                      style: TextStyle(fontSize: 16, color: Color(0xff9b9b9b)),
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
