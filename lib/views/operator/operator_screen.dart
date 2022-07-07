import 'package:get/get.dart';
import 'package:mobile_ics_flutter/views/dashboard/components/history_content_card.dart';
import 'package:mobile_ics_flutter/views/operator/components/tempdb.dart';
import '../../controllers/operator_controllers/operator_controller.dart';
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
                const Text(
                  operatorTitle,
                  style: TextStyle(color: opWhite, fontSize: header1),
                ),
                const SizedBox(
                  width: padding2,
                ),
                Image.asset(
                  iconAvatar,
                  width: avatarSize,
                )
              ],
            ),
          ),
          GetBuilder<OperatorController>(
            builder: (_) => CustomContainer(
              height: _.flag ? buttonHeightOn : buttonHeightOff,
              child: Column(
                children: [
                  SizedBox(
                    height: buttonHeightOff,
                    child: CustomTextButton(
                      onpress: () {
                        _.pressButton();
                      },
                      icon: _.flag ? null : Icons.play_arrow_rounded,
                      text: playNewsButtonLabel,
                    ),
                  ),
                  _.flag
                      ? Column(
                          children: [
                            const SizedBox(
                              height: padding1,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: PlayNews(
                                    height: padding2,
                                    icon: iconNews,
                                    content: GetBuilder<OperatorController>(
                                      builder: (_) => DropdownButton<String>(
                                        isDense: true,
                                        style: TextStyle(
                                          color: opBlack.withOpacity(.6),
                                          fontSize: text3,
                                        ),
                                        isExpanded: true,
                                        value: _.newsSelected,
                                        onChanged: (value) =>
                                            _.Select('newsSelected', value),
                                        hint: const Text(selectNewsHint),
                                        underline: Container(
                                            color: Colors.transparent),
                                        items: newsList,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: PlayNews(
                                    height: 28,
                                    icon: iconDevice,
                                    content: InkWell(
                                      child: Obx(
                                        () => Text(
                                          'Thiết bị phát (${controller.deviceCounter.value.toString()})',
                                          style: textStyle3a,
                                        ),
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
                                            ? showFixedSchdule(context)
                                            : controller.chooseTime()
                                      },
                                      hint: const Text(selectTimeHint),
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
                                        hint: const Text('Chế độ lặp'),
                                        underline: Container(
                                            color: Colors.transparent),
                                        items: repeatList,
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
                                        hint: const Text(selectPriorityHint),
                                        underline: Container(
                                            color: Colors.transparent),
                                        items: priorityList,
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
                                      text: playButtonLabel,
                                      onpress: () {
                                        controller.printNewsPlayed();
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
            child: GetBuilder<OperatorController>(
              builder: (_) => Container(
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
                                const Text1(text: "Danh sách phát"),
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
                                child: const HistoryContentCard(),
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
