import 'package:get/get.dart';
import 'package:mobile_ics_flutter/views/dashboard/components/history_content_card.dart';

import '../../../controllers/operator_controllers/operator_controller.dart';
import '../components/component.dart';

class NewsList extends StatelessWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Danh sách điều hành phát",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          foregroundColor: Colors.white,
          backgroundColor: primaryColor,
        ),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              GetBuilder<OperatorController>(
                builder: (_) => CustomContainer(
                  marginVertical: 0,
                  marginHorizontal: 0,
                  height: _.flag ? 290 : 50,

                  //color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: CustomTextButton(
                          onpress: () {
                            _.pressButton();
                          },
                          icon: _.flag ? null : Icons.filter_list_rounded,
                          text: "Bộ lọc",
                          background: true,
                        ),
                      ),
                      _.flag
                          ? Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: PlayNews(
                                        icon: 'op_calender.png',
                                        full: true,
                                        text: Row(
                                          children: [
                                            const PlayNewsCard(
                                              text: 'Thời gian phát: ',
                                              width: 110,
                                            ),
                                            DropdownButton<String>(
                                              underline: Container(
                                                  color: Colors.transparent),
                                              value: '0',
                                              items: const [
                                                DropdownMenuItem(
                                                  value: '0',
                                                  child: PlayNewsCard(
                                                    text: 'Tất cả',
                                                    isGrey: true,
                                                    width: 80,
                                                  ),
                                                ),
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
                                  height: defaultPadding,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: PlayNews(
                                        icon: 'op_clock.png',
                                        full: true,
                                        text: Row(
                                          children: [
                                            const PlayNewsCard(
                                              text: 'Khung giờ phát: ',
                                              width: 110,
                                            ),
                                            DropdownButton<String>(
                                              underline: Container(
                                                  color: Colors.transparent),
                                              value: '0',
                                              items: const [
                                                DropdownMenuItem(
                                                  value: '0',
                                                  child: PlayNewsCard(
                                                    text: 'Tất cả',
                                                    isGrey: true,
                                                    width: 80,
                                                  ),
                                                ),
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
                                  height: defaultPadding,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: PlayNews(
                                        icon: 'op_news.png',
                                        full: true,
                                        text: Row(
                                          children: [
                                            const PlayNewsCard(
                                              text: 'Chuyên mục: ',
                                              width: 110,
                                            ),
                                            DropdownButton<String>(
                                              underline: Container(
                                                  color: Colors.transparent),
                                              value: '0',
                                              items: const [
                                                DropdownMenuItem(
                                                  value: '0',
                                                  child: PlayNewsCard(
                                                    text: 'Tất cả',
                                                    isGrey: true,
                                                    width: 80,
                                                  ),
                                                ),
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
                                  height: defaultPadding,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: PlayNews(
                                        icon: 'op_devices.png',
                                        full: true,
                                        text: Row(
                                          children: [
                                            const PlayNewsCard(
                                              text: 'Thiết bị phát: ',
                                              width: 110,
                                            ),
                                            DropdownButton<String>(
                                              underline: Container(
                                                  color: Colors.transparent),
                                              value: '0',
                                              items: const [
                                                DropdownMenuItem(
                                                  value: '0',
                                                  child: PlayNewsCard(
                                                    text: 'Tất cả',
                                                    isGrey: true,
                                                    width: 80,
                                                  ),
                                                ),
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
                                  height: defaultPadding,
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
                                          icon: Icons.filter_list_rounded,
                                          text: "Lọc",
                                          background: true,
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
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: CustomContainer(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                textStyle1(text: 'Danh sách phát'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: 15,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async {
                                    _.showBottomSheet(
                                      context,
                                      const MyBottomSheet(),
                                    );
                                  },
                                  child: const HistoryContentCard(),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}


// CustomContainer(
//                                     height: 60,
//                                     marginVertical: 5,
//                                     marginHorizontal: defaultPadding,
//                                     paddingHorizontal: defaultPadding,
//                                     paddingVertical: 7,
//                                     child: Row(
//                                       children: [
//                                         SizedBox(
//                                           width: 35,
//                                           child: Row(
//                                             children: [
//                                               Image.asset(
//                                                   'assets/icons/op_new.png')
//                                             ],
//                                           ),
//                                         ),
//                                         Expanded(
//                                           child: Column(
//                                             children: [
//                                               Row(
//                                                 children: const [
//                                                   Expanded(
//                                                     child: Text(
//                                                       overflow:
//                                                           TextOverflow.ellipsis,
//                                                       'Bản tin thời sự đài truyền hình Việt Nam',
//                                                       style: TextStyle(
//                                                         fontSize: 12,
//                                                         color: primaryColor,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               Row(
//                                                 children: const [
//                                                   Text(
//                                                     overflow:
//                                                         TextOverflow.ellipsis,
//                                                     'Loại: Bản tin thời sự',
//                                                     style: TextStyle(
//                                                       fontSize: 12,
//                                                       color: primaryColor,
//                                                       //fontWeight: FontWeight.bold,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               Row(
//                                                 children: const [
//                                                   Text(
//                                                     overflow:
//                                                         TextOverflow.ellipsis,
//                                                     'Thời gian: 00:00 - 31/12/2022',
//                                                     style: TextStyle(
//                                                       fontSize: 12,
//                                                       color: Color(0xffd9d9d9),
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           width: 80,
//                                           child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.end,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.end,
//                                             children: [
//                                               Container(
//                                                 decoration: BoxDecoration(
//                                                   color:
//                                                       const Color(0xffd9d9d9),
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                 ),
//                                                 padding:
//                                                     const EdgeInsets.symmetric(
//                                                         vertical: 3,
//                                                         horizontal:
//                                                             defaultPadding),
//                                                 child: Text(
//                                                   'Đã phát',
//                                                   style: TextStyle(
//                                                     fontSize: 12,
//                                                     color: Colors.black
//                                                         .withOpacity(.5),
//                                                   ),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
