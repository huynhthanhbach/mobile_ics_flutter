import 'package:get/get.dart';
import 'package:mobile_ics_flutter/views/dashboard/components/history_content_card.dart';
import 'package:mobile_ics_flutter/views/operator/components/op_constant.dart';
import 'package:mobile_ics_flutter/views/operator/components/tempdb.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
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
                  width: 40,
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
                  width: 68,
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
                                    height: 20,
                                    icon: 'op_news.png',
                                    content: GetBuilder<OperatorController>(
                                      builder: (_) => DropdownButton<String>(
                                        isDense: true,
                                        style: TextStyle(
                                          color: kBlack.withOpacity(.6),
                                          fontSize: text3,
                                        ),
                                        isExpanded: true,
                                        value: _.newsSelected,
                                        onChanged: (value) =>
                                            _.Select('newsSelected', value),
                                        hint: const Text('Chọn bản tin'),
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
                                    icon: 'op_devices.png',
                                    content: CustomMultiSelectDialogField(
                                      chipDisplay:
                                          MultiSelectChipDisplay.none(),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(40)),
                                        border: Border.all(
                                          color: Colors.blue.withOpacity(0),
                                          width: 2,
                                        ),
                                      ),
                                      buttonIcon: Icon(
                                        Icons.arrow_drop_down_sharp,
                                        color: kBlack.withOpacity(.6),
                                      ),
                                      items: device_items,
                                      title:
                                          const Text("Danh sách thiết bị phát"),
                                      selectedColor: Colors.blue,
                                      buttonText: Text(
                                        "Chọn thiết bị",
                                        style: TextStyle(
                                          color: kBlack.withOpacity(.6),
                                          fontSize: text3,
                                        ),
                                      ),
                                      onConfirm: (results) {
                                        //_selectedAnimals = results;
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
                                    icon: 'op_calender.png',
                                    content: CustomMultiSelectDialogField(
                                      chipDisplay:
                                          MultiSelectChipDisplay.none(),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(40)),
                                        border: Border.all(
                                          color: Colors.blue.withOpacity(0),
                                          width: 2,
                                        ),
                                      ),
                                      buttonIcon: Icon(
                                        Icons.arrow_drop_down_sharp,
                                        color: kBlack.withOpacity(.6),
                                      ),
                                      dialogHeight: 250,
                                      dialogWidth: 200,
                                      items: time_items,
                                      title: const Text("Khung giờ phát"),
                                      selectedColor: Colors.blue,
                                      buttonText: Text(
                                        "Khung giờ",
                                        style: TextStyle(
                                          color: kBlack.withOpacity(.6),
                                          fontSize: text3,
                                        ),
                                      ),
                                      onConfirm: (results) {
                                        //_selectedAnimals = results;
                                      },
                                    ),
                                    //value: '',
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
                                    icon: 'op_repeat.png',
                                    content: GetBuilder<OperatorController>(
                                      builder: (_) => DropdownButton<String>(
                                        style: TextStyle(
                                          color: kBlack.withOpacity(.6),
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
                                    icon: 'op_warning.png',
                                    content: GetBuilder<OperatorController>(
                                      builder: (_) => DropdownButton<String>(
                                        style: TextStyle(
                                          color: kBlack.withOpacity(.6),
                                          fontSize: text3,
                                        ),
                                        isExpanded: true,
                                        value: _.prioritySelected,
                                        onChanged: (value) =>
                                            _.Select('prioritySelected', value),
                                        hint: const Text('Độ ưu tiên'),
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
