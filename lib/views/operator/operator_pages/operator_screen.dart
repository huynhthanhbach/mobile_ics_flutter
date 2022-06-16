import 'package:get/get.dart';

import '../../../controllers/operator_controllers/operator_controller.dart';
import '../operator_components/operator_components.dart';
import 'operator_pages.dart';

class OperatorScreen extends StatelessWidget {
  const OperatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var controller = Get.put(OperatorController());
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            primaryColor,
            Color(0xffffffff),
          ], // Gradient from https://learnui.design/tools/gradient-generator.html
          tileMode: TileMode.mirror,
        ),
      ),
      //color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/operator.png',
                  width: defaultIconSize * 2,
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  'Điều hành',
                  style: TextStyle(color: kWhite, fontSize: header1),
                ),
                const SizedBox(
                  width: 20,
                ),
                Image.asset(
                  'assets/icons/avatar.png',
                  width: defaultIconSize * 2,
                )
              ],
            ),
          ),
          GetBuilder<OperatorController>(
            builder: (_) => CustomContainer(
              marginHorizontal: 0,
              marginVertical: 0,
              paddingHorizontal: 0,
              paddingVertical: 0,
              height: _.flag ? 270 : defaultIconSize * 2,
              child: Column(
                children: [
                  SizedBox(
                    height: defaultIconSize * 2,
                    child: CustomTextButton(
                      onpress: () {
                        _.pressButton();
                      },
                      icon: _.flag ? null : Icons.play_arrow_rounded,
                      text: "Phát bản tin",
                    ),
                  ),
                  _.flag
                      ? Column(
                          children: [
                            const SizedBox(
                              height: defaultPadding * 2 / 3,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: PlayNews(
                                    icon: 'op_news.png',
                                    text: DropdownButton<String>(
                                      hint: const Text('Chọn bản tin'),
                                      underline:
                                          Container(color: Colors.transparent),
                                      //value: '0',
                                      items: const [
                                        DropdownMenuItem(
                                          value: '0',
                                          child: PlayNewsCard(
                                            text: 'Bản tin thời sự',
                                            width: 90,
                                          ),
                                        ),
                                      ],
                                      onChanged: (value) {},
                                    ),
                                    value: '',
                                  ),
                                ),
                                Expanded(
                                  child: PlayNews(
                                    icon: 'op_devices.png',
                                    text: DropdownButton<String>(
                                      hint: const Text("Chọn thiết bị"),
                                      underline:
                                          Container(color: Colors.transparent),
                                      //value: '0',
                                      items: [
                                        DropdownMenuItem(
                                          value: '0',
                                          // ignore: avoid_types_as_parameter_names
                                          child: Row(
                                            children: [
                                              Checkbox(
                                                  value: false,
                                                  // ignore: avoid_types_as_parameter_names
                                                  onChanged: (bool) {}),
                                              const PlayNewsCard(
                                                text: 'Loa 1',
                                                isGrey: true,
                                                width: 40,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                      onChanged: (value) {},
                                    ),
                                    value: '',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: PlayNews(
                                    icon: 'op_calender.png',
                                    text: Row(
                                      children: [
                                        DropdownButton<String>(
                                          underline: Container(
                                              color: Colors.transparent),
                                          value: '0',
                                          items: const [
                                            DropdownMenuItem(
                                                value: '0',
                                                child: PlayNewsCard(
                                                  text: 'Khung giờ',
                                                  isGrey: true,
                                                  width: 90,
                                                )),
                                          ],
                                          onChanged: (value) {},
                                        ),
                                      ],
                                    ),
                                    value: '',
                                  ),
                                ),
                                const Expanded(
                                  //color: Colors.amber,
                                  child: Volume(),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: PlayNews(
                                    icon: 'op_repeat.png',
                                    text: DropdownButton<String>(
                                      hint: const Text('Lặp'),
                                      underline:
                                          Container(color: Colors.transparent),
                                      //value: '0',
                                      items: const [
                                        DropdownMenuItem(
                                            value: '0',
                                            child: PlayNewsCard(
                                              text: 'Một lần',
                                              isGrey: true,
                                              width: 55,
                                            )),
                                      ],
                                      onChanged: (value) {},
                                    ),
                                    // text: CustomDropDown(
                                    //   hintText: "Lặp lại",
                                    //   borderRadius: 5,
                                    //   onChanged: (val) {
                                    //     // ignore: avoid_print
                                    //     print(val);
                                    //   },
                                    //   items: const [
                                    //     CustomDropdownMenuItem(
                                    //         value: '0',
                                    //         child: PlayNewsCard(
                                    //           text: 'Một lần',
                                    //           isGrey: true,
                                    //           width: 55,
                                    //         )),
                                    //     CustomDropdownMenuItem(
                                    //         value: '0',
                                    //         child: PlayNewsCard(
                                    //           text: 'Liên tục',
                                    //           isGrey: true,
                                    //           width: 55,
                                    //         )),
                                    //   ],
                                    // ),
                                    value: '',
                                  ),
                                ),
                                Expanded(
                                  child: PlayNews(
                                    icon: 'op_warning.png',
                                    text: Row(
                                      children: [
                                        DropdownButton<String>(
                                          hint: const Text('Độ ưu tiên'),
                                          underline: Container(
                                              color: Colors.transparent),
                                          //value: '-1',
                                          items: const [
                                            DropdownMenuItem(
                                              value: '0',
                                              child: PlayNewsCard(
                                                text: 'Thường',
                                                isGrey: true,
                                                width: 65,
                                              ),
                                            ),
                                            DropdownMenuItem(
                                                value: '1',
                                                child: PlayNewsCard(
                                                  text: 'Khẩn cấp',
                                                  isGrey: true,
                                                  width: 65,
                                                )),
                                            DropdownMenuItem(
                                                value: '2',
                                                child: PlayNewsCard(
                                                  text: 'Ưu tiên',
                                                  isGrey: true,
                                                  width: 65,
                                                )),
                                          ],
                                          onChanged: (value) {},
                                        ),
                                      ],
                                    ),
                                    value: '',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: defaultPadding),
                                    child: const CustomButton1(
                                      padding: defaultPadding * 3,
                                      space: defaultPadding,
                                      icon: Icons.play_arrow_rounded,
                                      text: "Phát",
                                    )),
                              ],
                            )
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
          Expanded(
            child: GetBuilder<OperatorController>(
              builder: (_) => Container(
                //color: Colors.white,
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 30),
                child: CustomContainer(
                    marginHorizontal: 0,
                    marginVertical: 0,
                    child: Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  width: 25,
                                ),
                                const textStyle1(text: "Danh sách phát"),
                                InkWell(
                                  onTap: () {
                                    Get.to(const NewsList());
                                  },
                                  child: const Icon(
                                    Icons.more_vert,
                                    size: 25,
                                  ),
                                ),
                              ],
                            )),
                        Expanded(
                          child: ListView.builder(
                            itemCount: 15,
                            // ignore: avoid_types_as_parameter_names
                            itemBuilder: (context, num) {
                              return InkWell(
                                onTap: () async {
                                  _.showBottomSheet(
                                    context,
                                    const MyBottomSheet(),
                                  );
                                },
                                child: CustomContainer(
                                  height: 60,
                                  marginVertical: 5,
                                  marginHorizontal: defaultPadding,
                                  paddingHorizontal: defaultPadding,
                                  paddingVertical: 7,
                                  child: Row(
                                    children: [
                                      InkWell(
                                        child: SizedBox(
                                          width: 35,
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                  'assets/icons/op_new.png')
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: const [
                                                Expanded(
                                                  child: Text(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    'Bản tin thời sự đài truyền hình Việt Nam',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: const [
                                                Text(
                                                  'Loại: Bản tin thời sự',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: primaryColor,
                                                    //fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: const [
                                                Text(
                                                  'Thời gian: 00:00 - 31/12/2022',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xffd9d9d9),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 80,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: const Color(0xffd9d9d9),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 3,
                                                      horizontal:
                                                          defaultPadding),
                                              child: Text(
                                                'Đã phát',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black
                                                      .withOpacity(.5),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
