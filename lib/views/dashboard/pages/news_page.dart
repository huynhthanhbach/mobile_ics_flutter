import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ics_flutter/controllers/dashboard_controllers/news_page_controller.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/core/widgets/widget.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewsPageController>(
      init: NewsPageController(),
      builder: (controller) => SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(210),
            child: Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: Constants.dkp * .75),
              color: kBackground,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    padding: const EdgeInsets.only(
                      left: Constants.dkp,
                      right: Constants.dkp,
                      bottom: Constants.dkp,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () => Get.back(),
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child:
                                    Image.asset('assets/icons/button-back.png'),
                              ),
                            ),
                            const Expanded(
                              child: KText(
                                text: "Title",
                                size: 34,
                                tColor: kBackgroundTitle,
                                isCenter: true,
                                fontWeight: Constants.kRegular,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(
                      horizontal: Constants.dkp * .5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        _DateTag(
                          dateName: "Sun",
                          dateNum: "29",
                        ),
                        SizedBox(width: Constants.dkp * .5),
                        _DateTag(
                          dateName: "Mon",
                          dateNum: "30",
                        ),
                        SizedBox(width: Constants.dkp * .5),
                        _DateTag(
                          dateName: "Tue",
                          dateNum: "31",
                        ),
                        SizedBox(width: Constants.dkp * .5),
                        _DateNowTag(
                          dateName: "Wed",
                          dateNum: "01",
                        ),
                        SizedBox(width: Constants.dkp * .5),
                        _DateTag(
                          dateName: "Thu",
                          dateNum: "02",
                        ),
                        SizedBox(width: Constants.dkp * .5),
                        _DateTag(
                          dateName: "Fri",
                          dateNum: "03",
                        ),
                        SizedBox(width: Constants.dkp * .5),
                        _DateTag(
                          dateName: "Sat",
                          dateNum: "04",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          width: 60,
                          padding:
                              const EdgeInsets.only(top: Constants.dkp * .25),
                          child: const KText(
                            text: "Sắp xếp: ",
                            tColor: Color(0xFFBCBEC3),
                          ),
                        ),
                        const _FilterTag(
                          name: "Cấp huyện",
                        ),
                        const _FilterTag(
                          name: "Một tháng trước",
                        ),
                        InkWell(
                          child: Image.asset(
                            'assets/icons/menu.png',
                            color: kBackgroundTitle,
                            width: 30,
                            height: 30,
                            fit: BoxFit.fill,
                          ),
                          onTap: () async {
                            controller.showBottomSheet(
                              context,
                              Container(
                                height: Get.mediaQuery.size.height * .70,
                                padding: const EdgeInsets.only(
                                  top: Constants.dkp * .75,
                                  left: Constants.dkp * .75,
                                  right: Constants.dkp * .75,
                                  bottom: Constants.dkp * .5,
                                ),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(35),
                                    topRight: Radius.circular(35),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 5,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: kBackgroundTitle.withOpacity(.4),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(3),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: Constants.dkp * .75),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          child: Material(
                                            color: const Color(0xFFF6F7FB),
                                            child: SizedBox(
                                              height: 40,
                                              width: 40,
                                              child: IconButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                icon: Icon(
                                                  Icons.close_rounded,
                                                  color: kBackgroundTitle
                                                      .withOpacity(.8),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const KText(
                                          text: "Sắp xếp",
                                          size: 22,
                                          fontWeight: Constants.kSemiBold,
                                          tColor: kBackgroundTitle,
                                        ),
                                        Tooltip(
                                          message: "Thiết lập lại",
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                            child: Material(
                                              color: const Color(0xFFF6F7FB),
                                              child: SizedBox(
                                                height: 40,
                                                width: 40,
                                                child: IconButton(
                                                  onPressed: () async {},
                                                  icon: const Icon(
                                                    Icons.change_circle_rounded,
                                                    color: Color(0xFFBCBEC3),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: Constants.dkp),
                                    Expanded(
                                      child: Container(
                                        color: Colors.blue,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: Constants.dkp),
              decoration: const BoxDecoration(
                color: kBackground,
              ),
              child: Column(
                children: [
                  Container(
                    height: 210,
                    color: Colors.yellow,
                  ),
                  Container(
                    height: 2000,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FilterTag extends StatelessWidget {
  const _FilterTag({
    Key? key,
    required this.name,
  }) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.dkp * .5,
        vertical: Constants.dkp * .25,
      ),
      decoration: BoxDecoration(
        color: kBackgroundTitle,
        borderRadius: BorderRadius.circular(15),
      ),
      child: KText(
        text: name,
        size: 16,
        tColor: Colors.white,
        fontWeight: Constants.kSemiBold,
      ),
    );
  }
}

class _DateTag extends StatelessWidget {
  const _DateTag({
    Key? key,
    this.dateName = "Mon",
    this.dateNum = "01",
  }) : super(key: key);

  final String dateName;
  final String dateNum;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      decoration: BoxDecoration(
        color: kBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          KText(
            text: dateName,
            size: 16,
            fontWeight: Constants.kSemiBold,
            tColor: const Color(0xFFBCBEC3).withOpacity(.6),
            overflow: TextOverflow.ellipsis,
          ),
          KText(
            text: dateNum,
            size: 16,
            fontWeight: Constants.kBold,
            tColor: Colors.black,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _DateNowTag extends StatelessWidget {
  const _DateNowTag({
    Key? key,
    this.dateName = "Mon",
    this.dateNum = "01",
  }) : super(key: key);

  final String dateName;
  final String dateNum;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      decoration: BoxDecoration(
        color: kBackgroundTag,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          KText(
            text: dateName,
            size: 16,
            fontWeight: Constants.kSemiBold,
            tColor: kTextTag.withOpacity(.8),
            overflow: TextOverflow.ellipsis,
          ),
          KText(
            text: dateNum,
            size: 16,
            fontWeight: Constants.kBold,
            tColor: kTextTag,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
