import 'package:get/get.dart';
import 'package:mobile_ics_flutter/views/dashboard/components/history_content_card.dart';
import 'package:mobile_ics_flutter/views/news_management/news_management_screen.dart';
import 'package:oktoast/oktoast.dart';
import '../../controllers/operator_controllers/operator_controller.dart';
import '../../core/utils/constants.dart';
import 'components/component.dart';
import 'pages/pages.dart';

class OperatorScreen extends GetWidget<OperatorController> {
  const OperatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            opWhite,
          ], // Gradient from https://learnui.design/tools/gradient-generator.html
          tileMode: TileMode.mirror,
        ),
      ),
      //color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: size.height * textButtonHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  iconOperator,
                  width: titleIconSize,
                ),
                const SizedBox(
                  width: padding2,
                ),
                Text(
                  'OP_TITLE'.tr,
                  style: operatorTitle,
                ),
                const SizedBox(
                  width: padding2,
                ),
                ClipRRect(
                  child: InkWell(
                    onTap: () async {
                      // controller.addPlayNewsData();
                    },
                    child: Image.asset(
                      iconAvatar,
                      width: avatarSize,
                    ),
                  ),
                )
              ],
            ),
          ),
          Obx(
            () => CustomContainer(
              height: controller.flag.value ? buttonHeightOn : buttonHeightOff,
              child: Column(
                children: [
                  SizedBox(
                    height: buttonHeightOff,
                    child: CustomTextButton(
                      onpress: () {
                        controller.pressButton();
                      },
                      icon: controller.flag.value
                          ? null
                          : Icons.play_arrow_rounded,
                      text: 'BTL_PLAY_NEWS'.tr,
                    ),
                  ),
                  controller.flag.value
                      ? Column(
                          children: [
                            const SizedBox(
                              height: padding1,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: PlayNews(
                                    icon: iconNews,
                                    height: 28,
                                    content: InkWell(
                                      child: Text(
                                        controller.newsSelected.value == ''
                                            ? 'H_SELECT_NEWS'.tr
                                            : controller.newsSelected.value,
                                        style: textStyle3a,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      onTap: () {
                                        controller.choosingNews = true;
                                        Get.to(
                                          transition: Transition.fade,
                                          curve: Curves.easeInQuad,
                                          duration: Constants.dur500,
                                          () => const NewsManagementScreen(),
                                        );
                                        showToast('Lấy bản tin');
                                        // controller.newsSelected.value =
                                        //     'Bản tin aaaa';
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: PlayNews(
                                    height: 28,
                                    icon: iconDevice,
                                    content: InkWell(
                                      child: Text(
                                        '${'H_SELECT_DEVICE'.tr} (${controller.deviceCounter.value.toString()})',
                                        style: textStyle3a,
                                      ),
                                      onTap: () {
                                        showDeviceSelect(context, controller);
                                      },
                                    ),
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
                                    height: 28,
                                    icon: iconCalender,
                                    content: DropdownButton<String>(
                                      style: TextStyle(
                                        color: opBlack.withOpacity(.6),
                                        fontSize: text3,
                                      ),
                                      isExpanded: true,
                                      //value: null,
                                      onChanged: (value) => {
                                        value == '0'
                                            ? showFixedSchdule(
                                                context, controller)
                                            : controller.chooseTime()
                                      },
                                      hint: Obx(
                                        () => Text(
                                          '${'H_TIME'.tr} (${controller.timeCounter.value.toString()})',
                                          style: textStyle4,
                                        ),
                                      ),
                                      underline:
                                          Container(color: Colors.transparent),
                                      items: const [
                                        DropdownMenuItem(
                                            value: '0',
                                            child: Text('Chọn khung giờ')),
                                        DropdownMenuItem(
                                            value: '1',
                                            child: Text('Thêm khung giờ')),
                                      ],
                                    ),
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
                                    height: 20,
                                    icon: iconRepeat,
                                    content: GetBuilder<OperatorController>(
                                      builder: (_) => DropdownButton<String>(
                                        style: TextStyle(
                                          color: opBlack.withOpacity(.6),
                                          fontSize: text3,
                                        ),
                                        isExpanded: true,
                                        value: _.repeatSelected,
                                        onChanged: (value) =>
                                            _.Select('repeatSelected', value),
                                        hint: Text('H_REPEAT'.tr),
                                        underline: Container(
                                            color: Colors.transparent),
                                        items: controller.repeatList,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: PlayNews(
                                    icon: iconWarning,
                                    content: GetBuilder<OperatorController>(
                                      builder: (_) => DropdownButton<String>(
                                        style: TextStyle(
                                          color: opBlack.withOpacity(.6),
                                          fontSize: text3,
                                        ),
                                        isExpanded: true,
                                        value: _.prioritySelected,
                                        onChanged: (value) =>
                                            _.Select('prioritySelected', value),
                                        hint: Text('H_SELECT_PRIORITY'.tr),
                                        underline: Container(
                                            color: Colors.transparent),
                                        items: controller.priorityList,
                                      ),
                                    ),
                                    //value: '',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: padding2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: defaultPadding),
                                    child: CustomButton1(
                                      padding: padding4,
                                      space: defaultPadding,
                                      icon: Icons.play_arrow_rounded,
                                      text: 'BTL_PLAY'.tr,
                                      onpress: () {
                                        if (controller.checkPlayNews()) {
                                          controller.addPlayNews();
                                          controller.addPlayNewsData();
                                          showToast(
                                              'Thêm thành công "${controller.newsHiveSelected!.name}"');
                                          controller.updateListPlayNewsToday();
                                          //controller.clearSelect();
                                        } else {
                                          showToast('Xin chọn đủ các trường!');
                                        }
                                      },
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
            child: Container(
              //color: Colors.white,
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 30),
              child: CustomContainer(
                  marginHorizontal: 0,
                  marginVertical: 0,
                  paddingHorizontal: defaultPadding * 2 / 3,
                  child: Column(
                    children: [
                      Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                          ),
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                width: 25,
                              ),
                              Text1(text: 'OP_OPERATE_TODAY'.tr),
                              InkWell(
                                onTap: () {
                                  Get.to(
                                    transition: Transition.fade,
                                    curve: Curves.easeInQuad,
                                    duration: Constants.dur500,
                                    () => const NewsList(),
                                  );
                                },
                                child: const Icon(
                                  Icons.more_vert,
                                  size: 25,
                                ),
                              ),
                            ],
                          )),
                      Expanded(
                        child: Obx(
                          () => ListView.builder(
                            itemCount: controller.listPlayNewsToday.length,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () async {
                                controller.showBottomSheet(
                                    context,
                                    MyBottomSheet(
                                      news: controller.getNews(controller
                                          .listPlayNewsToday[index].idNews!),
                                      playNews:
                                          controller.listPlayNewsToday[index],
                                    ));
                              },
                              child: HistoryContentCard(
                                titleName: controller
                                    .getNews(controller
                                        .listPlayNewsToday[index].idNews!)
                                    .name!,
                                titleType:
                                    "Loại: ${controller.getNews(controller.listPlayNewsToday[index].idNews!).type!}",
                                titleTime:
                                    "Thời gian: ${controller.listPlayNewsToday[index].createDate!.toString().substring(0, 16)}",
                                statusCode: controller
                                            .listPlayNewsToday[index].status ==
                                        'Đã phát'
                                    ? 0
                                    : (controller.listPlayNewsToday[index]
                                                .status ==
                                            'Đang phát'
                                        ? 1
                                        : 2),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
