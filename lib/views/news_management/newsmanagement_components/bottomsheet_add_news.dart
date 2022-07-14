// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_icons/awesome_icons.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mobile_ics_flutter/controllers/newsmanagement_controllers/newsmanagement_controller.dart';
import 'package:mobile_ics_flutter/core/widgets/kcolors.dart';
import 'package:mobile_ics_flutter/core/widgets/ktext_style.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';

class BottomSheetAddNews extends StatelessWidget {
  const BottomSheetAddNews({
    Key? key,
    required this.pathDir,
    required this.press,
  }) : super(key: key);
  final String pathDir;

  final Function press;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.mediaQuery.size.height * .9,
      padding: const EdgeInsets.only(
        top: 35,
        left: 35,
        right: 35,
        bottom: 10,
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
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 40, width: 40),
              Text(
                "Upload bản tin",
                style: KTextStyle.textButtonStyle,
              ),
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
            ],
          ),
          const SizedBox(height: 25),
          Expanded(
            child: Column(
              children: [
                GetBuilder<NewsManagementController>(
                  builder: (controller) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (controller.checkPick)
                          ? Text(
                              basename(controller.filePicker!.path.toString()),
                              style: KTextStyle.textDefaultStyle,
                            )
                          : const Text(
                              'name file',
                              style: KTextStyle.textDefaultStyle,
                            ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                GetBuilder<NewsManagementController>(
                  builder: (controller) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (controller.checkPick)
                          ? ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              child: Material(
                                color: const Color(0xFFF6F7FB),
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: IconButton(
                                    onPressed: () {
                                      OpenFile.open(
                                          controller.filePicker!.path);
                                    },
                                    icon: Icon(
                                      Icons.play_arrow,
                                      color: kBackgroundTitle.withOpacity(.8),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              child: Material(
                                color: const Color(0xFFF6F7FB),
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: IconButton(
                                    onPressed: () async {
                                      await controller.pickFiless();
                                    },
                                    icon: Icon(
                                      Icons.upload_file_rounded,
                                      color: kBackgroundTitle.withOpacity(.8),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Chọn khu vực',
                      style: KTextStyle.textRadioButtonStyle,
                    )
                  ],
                ),
                const SizedBox(height: 20),
                GetBuilder<NewsManagementController>(
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
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "Chọn thể loại",
                      style: KTextStyle.textRadioButtonStyle,
                    )
                  ],
                ),
                const SizedBox(height: 20),
                GetBuilder<NewsManagementController>(
                  builder: (_) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
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
                      value: _.valueType,
                      onChanged: (value) => _.onChangeType(value!),
                      items: const [
                        DropdownMenuItem(
                            value: 'sport', child: Text('Thể thao')),
                        DropdownMenuItem(
                            value: 'activity', child: Text('Đời sống')),
                        DropdownMenuItem(
                            value: 'law', child: Text('Pháp luật')),
                        DropdownMenuItem(
                            value: 'warning', child: Text('Cảnh báo')),
                        DropdownMenuItem(
                            value: 'information', child: Text('Thông tin')),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GetBuilder<NewsManagementController>(
                  builder: (controller) => Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          decoration: BoxDecoration(
                            color: (controller.filePicker != null)
                                ? kBackgroundTitle
                                : Colors.black.withOpacity(.5),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextButton(
                            onPressed: (controller.filePicker != null)
                                ? () async {
                                    controller.onAdd(pathDir);
                                    Future.delayed(
                                      const Duration(milliseconds: 200),
                                      (() {
                                        press();
                                      }),
                                    );
                                  }
                                : null,
                            child: Text(
                              "Xác nhận",
                              style: KTextStyle.textButtonStyle1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
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
