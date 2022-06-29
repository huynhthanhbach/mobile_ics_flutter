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
                                        icon: 'op_news.png',
                                        //full: true,
                                        text: 'Chuyên mục: ',
                                        content: GetBuilder<OperatorController>(
                                          builder: (_) =>
                                              DropdownButton<String>(
                                            isDense: true,
                                            style: TextStyle(
                                              color: kBlack.withOpacity(.6),
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
                                        icon: 'op_clock.png',
                                        //full: true,
                                        text: 'Khung giờ: ',
                                        content: GetBuilder<OperatorController>(
                                          builder: (_) =>
                                              DropdownButton<String>(
                                            isDense: true,
                                            style: TextStyle(
                                              color: kBlack.withOpacity(.6),
                                              fontSize: text3,
                                            ),
                                            isExpanded: true,
                                            value: _.calenderFilter,
                                            onChanged: (value) =>
                                                _.Filt('calenderFilter', value),
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
                                        icon: 'op_calender.png',
                                        //full: true,
                                        text: 'Thời gian phát: ',
                                        content: GetBuilder<OperatorController>(
                                          builder: (_) =>
                                              DropdownButton<String>(
                                            isDense: true,
                                            style: TextStyle(
                                              color: kBlack.withOpacity(.6),
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
                                        icon: 'op_devices.png',
                                        //full: true,
                                        text: 'Thiết bị phát: ',
                                        content: GetBuilder<OperatorController>(
                                          builder: (_) =>
                                              DropdownButton<String>(
                                            isDense: true,
                                            style: TextStyle(
                                              color: kBlack.withOpacity(.6),
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
                      paddingHorizontal: defaultPadding * 2 / 3,
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
