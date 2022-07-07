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
          title: const Text(
            newsListPageTille,
            style: TextStyle(
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
              GetBuilder<OperatorController>(
                builder: (_) => CustomContainer(
                  height: _.flag ? buttonHeightOn : buttonHeightOff,

                  //color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(
                        height: buttonHeightOff,
                        child: CustomTextButton(
                          onpress: () {
                            _.pressButton();
                          },
                          icon: _.flag ? null : Icons.filter_list_rounded,
                          text: filtButtonLabel,
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
                                        icon: iconNews,
                                        //full: true,
                                        text: nlCategoriesLabel,
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
                                        text: nlTimeLabel,
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
                                            items: timeList,
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
                                        text: nlCalenderLabel,
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
                                        icon: iconDevice,
                                        //full: true,
                                        text: nlDeviceLabel,
                                        content: GetBuilder<OperatorController>(
                                          builder: (_) =>
                                              DropdownButton<String>(
                                            isDense: true,
                                            style: TextStyle(
                                              color: opBlack.withOpacity(.6),
                                              fontSize: text3,
                                            ),
                                            isExpanded: true,
                                            value: _.deviceFilter,
                                            onChanged: (value) =>
                                                _.Filt('deviceFilter', value),
                                            underline: Container(
                                                color: Colors.transparent),
                                            items: deviceList,
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GetBuilder<OperatorController>(
                                      builder: (_) => Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: defaultPadding),
                                          child: CustomButton1(
                                            padding: padding4,
                                            space: defaultPadding,
                                            icon: Icons.filter_list_rounded,
                                            text: filterButtonLabel,
                                            background: true,
                                            onpress: () {
                                              _.addFilter();
                                              _.pressButton();
                                            },
                                          )),
                                    )
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
                        child: (_.flag)
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
                            children: const [
                              Text1(text: 'Danh sách phát'),
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
            ],
          ),
        ));
  }
}
