// ignore: file_names
import 'package:get/get.dart';
import 'package:mobile_ics_flutter/views/dashboard/components/history_content_card.dart';
import 'package:mobile_ics_flutter/views/operator/operator_screen.dart';
import '../../../core/utils/constants.dart';
import '../components/component.dart';
import '../components/tempdb.dart';

class NewsGetter extends StatelessWidget {
  const NewsGetter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'CHỌN BẢN TIN PHÁT',
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
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.listNews.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        controller.newsHiveSelected =
                            controller.listNews[index];
                        controller.newsSelected.value =
                            controller.listNews[index].name!;
                        Get.back();
                      },
                      child: HistoryContentCard(
                        titleName: controller.listNews[index].name!,
                        titleType: "Loại: ${controller.listNews[index].type!}",
                        titleTime:
                            "Thời gian: ${controller.listNews[index].createDate!}",
                        statusCode: 0,
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
