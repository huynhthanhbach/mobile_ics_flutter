import 'package:get/get.dart';
import 'package:mobile_ics_flutter/core/widgets/widget.dart';
import 'package:mobile_ics_flutter/models/bandwidth_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BandwidthController extends GetxController {
  List<BandwidthModel> dataBandwidth = [
    BandwidthModel(time: 0, value: 42),
    BandwidthModel(time: 01, value: 47),
    BandwidthModel(time: 02, value: 43),
    BandwidthModel(time: 03, value: 49),
    BandwidthModel(time: 04, value: 54),
    BandwidthModel(time: 05, value: 41),
    BandwidthModel(time: 06, value: 58),
    BandwidthModel(time: 07, value: 51),
    BandwidthModel(time: 08, value: 98),
    BandwidthModel(time: 09, value: 41),
    BandwidthModel(time: 10, value: 53),
    BandwidthModel(time: 11, value: 72),
    BandwidthModel(time: 12, value: 86),
    BandwidthModel(time: 13, value: 52),
    BandwidthModel(time: 14, value: 94),
    BandwidthModel(time: 15, value: 92),
    BandwidthModel(time: 16, value: 86),
    BandwidthModel(time: 17, value: 72),
    BandwidthModel(time: 18, value: 94),
  ];

  List<LineSeries<BandwidthModel, int>> seriesLive = [];

  @override
  void onInit() {
    seriesLive = [
      LineSeries(
        dataSource: dataBandwidth,
        // color: const Color.fromRGBO(192, 108, 132, 1),
        color: kBackgroundTitle,
        xValueMapper: (BandwidthModel live, _) => live.time,
        yValueMapper: (BandwidthModel live, _) => live.value,
      ),
    ];
    super.onInit();
  }
}
