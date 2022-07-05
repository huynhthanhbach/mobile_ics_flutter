// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_icons/awesome_icons.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mobile_ics_flutter/controllers/dashboard_controllers/dashboard_controller.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/core/widgets/widget.dart';

class BottomSheetFilter extends StatelessWidget {
  const BottomSheetFilter({
    Key? key,
    required this.onPress,
  }) : super(key: key);
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    var dashBoardController = Get.find<DashboardController>();
    return Container(
      height: Get.mediaQuery.size.height * .70,
      padding: const EdgeInsets.only(
        top: Constants.padding35,
        left: Constants.padding35,
        right: Constants.padding35,
        bottom: Constants.padding10,
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
          Constants.sizedBoxH15,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        color: kBackgroundTitle.withOpacity(.8),
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                "Lọc",
                style: KTextStyle.textButtonStyle,
              ),
              Tooltip(
                message: "Thiết lập lại",
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Material(
                    color: const Color(0xFFF6F7FB),
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: IconButton(
                        onPressed: () async {
                          // dashBoardController.updateCheckSize();
                        },
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
          Constants.sizedBoxH25,
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Đài truyền thanh",
                      style: KTextStyle.textRadioButtonStyle,
                    )
                  ],
                ),
                Constants.sizedBoxH20,
                GetBuilder<DashboardController>(
                  builder: (_) => CustomRadioButton(
                    elevation: 0,
                    absoluteZeroSpacing: true,
                    height: 30,
                    autoWidth: true,
                    enableShape: true,
                    unSelectedColor: kBackgroundTag2,
                    selectedColor: kBackgroundTitle,
                    unSelectedBorderColor: kBackgroundTag2,
                    selectedBorderColor: kBackgroundTitle,
                    radius: 15,
                    shapeRadius: 15,
                    defaultSelected: _.valueLocation,
                    buttonLables: const [
                      'Cấp Xã',
                      'Cấp Huyện',
                    ],
                    buttonValues: const [
                      "Village",
                      "District",
                    ],
                    buttonTextStyle: ButtonTextStyle(
                      selectedColor: Colors.white,
                      unSelectedColor: Colors.black.withOpacity(.5),
                      textStyle: KTextStyle.textButtonCBXStyle,
                    ),
                    radioButtonValue: (value) {
                      _.onChangeLocation(value.toString());
                    },
                    margin: const EdgeInsets.symmetric(
                        horizontal: Constants.padding20),
                  ),
                ),
                Constants.sizedBoxH20,
                Row(
                  children: [
                    Text(
                      "Khoảng thời gian",
                      style: KTextStyle.textRadioButtonStyle,
                    )
                  ],
                ),
                Constants.sizedBoxH20,
                GetBuilder<DashboardController>(
                  builder: (_) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Constants.padding10,
                      vertical: Constants.padding5,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFE5E8EF),
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.timer,
                          size: 35,
                          color: Color(0xFFBCEBD7),
                        ),
                      ),
                      icon: const Icon(
                        FontAwesomeIcons.angleDown,
                      ),
                      style: KTextStyle.textButtonCBXStyle,
                      isExpanded: true,
                      value: _.valueTime,
                      onChanged: (value) => _.onChangeTime(value!),
                      items: const [
                        DropdownMenuItem(
                            value: 'day ago', child: Text('Một ngày trước')),
                        DropdownMenuItem(
                            value: 'week ago', child: Text('Một tuần trước')),
                        DropdownMenuItem(
                            value: 'month ago', child: Text('Một tháng trước')),
                        DropdownMenuItem(
                            value: 'year ago', child: Text('Một năm trước')),
                      ],
                    ),
                  ),
                ),
                Constants.sizedBoxH20,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: Constants.screenWidth,
                        height: 60,
                        decoration: BoxDecoration(
                          color: kBackgroundTitle,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextButton(
                          onPressed: () {
                            dashBoardController.onFilter();
                            onPress(); // test
                          },
                          child: Text("Xác nhận lọc",
                              style: KTextStyle.textButtonStyle1),
                        ),
                      ),
                      Constants.sizedBoxH25,
                      Container(
                        height: 5,
                        width: 200,
                        decoration: BoxDecoration(
                          color: kBackgroundTitle.withOpacity(.4),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(3),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
