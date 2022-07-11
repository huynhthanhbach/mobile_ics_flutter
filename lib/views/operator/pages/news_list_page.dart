import 'package:get/get.dart';
import 'package:mobile_ics_flutter/views/dashboard/components/history_content_card.dart';
import '../../../controllers/operator_controllers/operator_controller.dart';
import '../components/component.dart';
import '../components/tempdb.dart';

class NewsList extends StatelessWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'OP_NEWS_PAGE_TITLE'.tr,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          foregroundColor: opWhite,
          backgroundColor: primaryColor,
        ),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Obx(
                () => CustomContainer(
                  height:
                      controller.flag.value ? buttonHeightOn : buttonHeightOff,

                  //color: Colors.white,
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
                              : Icons.filter_list_rounded,
                          text: 'BTL_FILTER'.tr,
                          background: true,
                        ),
                      ),
                      controller.flag.value
                          ? Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: PlayNews(
                                        icon: iconNews,
                                        text: 'NFL_CATEGORY'.tr,
                                        content: GetBuilder<OperatorController>(
                                          builder: (_) =>
                                              DropdownButton<String>(
                                            isDense: true,
                                            style: TextStyle(
                                              color: opBlack.withOpacity(.6),
                                              fontSize: text3,
                                            ),
                                            isExpanded: true,
                                            value: _.categoriesFilter,
                                            onChanged: (value) => _.Filt(
                                                'categoriesFilter', value),
                                            underline: Container(
                                                color: Colors.transparent),
                                            items: categoriesList,
                                          ),
                                        ),
                                        //value: '',
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
                                        icon: iconClock,
                                        //full: true,
                                        text: 'NFL_TIME'.tr,
                                        content: GetBuilder<OperatorController>(
                                          builder: (_) =>
                                              DropdownButton<String>(
                                            isDense: true,
                                            style: TextStyle(
                                              color: opBlack.withOpacity(.6),
                                              fontSize: text3,
                                            ),
                                            isExpanded: true,
                                            value: _.timeFilter,
                                            onChanged: (value) =>
                                                _.Filt('timeFilter', value),
                                            underline: Container(
                                                color: Colors.transparent),
                                            items: controller.timeList,
                                          ),
                                        ),
                                        //value: '',
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
                                        icon: iconCalender,
                                        //full: true,
                                        text: 'NFL_CALENDER'.tr,
                                        content: GetBuilder<OperatorController>(
                                          builder: (_) =>
                                              DropdownButton<String>(
                                            isDense: true,
                                            style: TextStyle(
                                              color: opBlack.withOpacity(.6),
                                              fontSize: text3,
                                            ),
                                            isExpanded: true,
                                            value: _.calenderFilter,
                                            onChanged: (value) =>
                                                _.Filt('calenderFilter', value),
                                            underline: Container(
                                                color: Colors.transparent),
                                            items: calenderList,
                                          ),
                                        ),
                                        //value: '',
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
                                        height: 28,
                                        icon: iconDevice,
                                        content: InkWell(
                                          child: Text(
                                            '${'H_SELECT_DEVICE'.tr} (${controller.filtDeviceCounter.value.toString()})',
                                            style: textStyle3a,
                                          ),
                                          onTap: () {
                                            showFiltDeviceSelect(
                                                context, controller);
                                          },
                                        ),
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
                                        child: CustomButton1(
                                          padding: padding4,
                                          space: defaultPadding,
                                          icon: Icons.filter_list_rounded,
                                          text: 'BTL_FILT'.tr,
                                          background: true,
                                          onpress: () {
                                            controller.addFilter();
                                            controller.pressButton();
                                            controller.checkFilter();
                                            controller.filt();
                                          },
                                        ))
                                  ],
                                )
                              ],
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
              GetBuilder<OperatorController>(
                  builder: (_) => Container(
                        child: (_.flag.value)
                            ? const SizedBox(
                                height: defaultPadding,
                              )
                            : Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: defaultPadding),
                                alignment: Alignment.topLeft,
                                child: const CustomFilterChip(),
                              ),
                      )),
              // const SizedBox(
              //   height: defaultPadding,
              // ),
              Expanded(
                child: GetBuilder<OperatorController>(
                  builder: (_) => CustomContainer(
                    paddingHorizontal: defaultPadding * 2 / 3,
                    child: Column(
                      children: [
                        SizedBox(
                          height: padding5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text1(text: 'OP_OPERATE_HISTORY'.tr),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Obx(
                            () => ListView.builder(
                              itemCount: controller.listPlayNewsFilted.length,
                              itemBuilder: (context, index) => InkWell(
                                onTap: () async {
                                  controller.showBottomSheet(
                                      context,
                                      MyBottomSheet(
                                        news: controller.getNews(controller
                                            .listPlayNewsFilted[index].idNews!),
                                        playNews: controller
                                            .listPlayNewsFilted[index],
                                      ));
                                },
                                child: HistoryContentCard(
                                  titleName: controller
                                      .getNews(controller
                                          .listPlayNews[index].idNews!)
                                      .name!,
                                  titleType:
                                      "Loại: ${controller.getNews(controller.listPlayNewsFilted[index].idNews!).type!}",
                                  titleTime:
                                      "Thời gian: ${controller.listPlayNewsFilted[index].createDate!.toString().substring(0, 16)}",
                                  statusCode: controller
                                              .listPlayNewsFilted[index]
                                              .status ==
                                          'Đã phát'
                                      ? 0
                                      : (controller.listPlayNewsFilted[index]
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
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
