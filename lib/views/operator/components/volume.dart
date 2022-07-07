// import 'component.dart';

// class Volume extends StatefulWidget {
//   const Volume({Key? key}) : super(key: key);

//   @override
//   State<Volume> createState() => _VolumeState();
// }

// class _VolumeState extends State<Volume> {
//   double _currentSliderValue = defaultVolumetValue;

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return SizedBox(
//       child: Row(
//         children: [
//           const SizedBox(
//             width: padding2,
//           ),
//           Image.asset(
//             iconVolume,
//             width: padding3,
//           ),
//           SizedBox(
//             height: padding1,
//             width: size.width * .5 - 100,
//             child: Slider(
//               thumbColor: opLightGreen,
//               activeColor: opLightGreen,
//               inactiveColor: opGray3,
//               value: _currentSliderValue,
//               max: maxVolumetValue,
//               divisions: devisionVolumetValue,
//               //label: _currentSliderValue.round().toString(),
//               onChanged: (double value) {
//                 setState(() {
//                   _currentSliderValue = value;
//                 });
//               },
//             ),
//           ),
//           Text(
//             "${_currentSliderValue.round().toString()}%",
//             style: textStyle3b,
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:get/get.dart';
import 'package:mobile_ics_flutter/controllers/operator_controllers/operator_controller.dart';

import 'component.dart';

class Volume extends StatelessWidget {
  const Volume({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var controller = Get.find<OperatorController>();

    return Obx(() => SizedBox(
          child: Row(
            children: [
              const SizedBox(
                width: padding2,
              ),
              Image.asset(
                iconVolume,
                width: padding3,
              ),
              SizedBox(
                height: padding1,
                width: size.width * .5 - 100,
                child: Slider(
                  thumbColor: opLightGreen,
                  activeColor: opLightGreen,
                  inactiveColor: opGray3,
                  value: controller.volumeSelected.value,
                  max: maxVolumetValue,
                  divisions: devisionVolumetValue,
                  //label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    controller.volumeSelected.value = value;
                  },
                ),
              ),
              Text(
                "${controller.volumeSelected.value.round().toString()}%",
                style: textStyle3b,
              ),
            ],
          ),
        ));
  }
}
