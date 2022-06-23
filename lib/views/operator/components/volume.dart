// import 'package:flutter/material.dart';
// import 'package:mobile_ics_flutter/views/operator/operator_components/contrant.dart';

// class Volume extends StatefulWidget {
//   const Volume({Key? key}) : super(key: key);

//   @override
//   State<Volume> createState() => _VolumeState();
// }

// class _VolumeState extends State<Volume> {
//   double _currentSliderValue = 70;

//   @override
//   Widget build(BuildContext context) {
//     //var size = MediaQuery.of(context).size;
//     return Row(
//       children: [
//         SizedBox(
//           //color: Colors.amber,
//           height: 10,
//           //width: size.width * .68,
//           child: Slider(
//             thumbColor: const Color(0xff51dea3),
//             activeColor: const Color(0xff51dea3),
//             inactiveColor: const Color(0xffd9d9d9),
//             value: _currentSliderValue,
//             max: 100,
//             divisions: 100,
//             //label: _currentSliderValue.round().toString(),
//             onChanged: (double value) {
//               setState(() {
//                 _currentSliderValue = value;
//               });
//             },
//           ),
//         ),
//         Text(
//           "${_currentSliderValue.round().toString()}%",
//           style: const TextStyle(color: kGrey, fontSize: 16),
//         ),
//       ],
//     );
//   }
// }
import 'component.dart';

class Volume extends StatefulWidget {
  const Volume({Key? key}) : super(key: key);

  @override
  State<Volume> createState() => _VolumeState();
}

class _VolumeState extends State<Volume> {
  double _currentSliderValue = 70;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      child: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          Image.asset(
            "assets/icons/op_volume.png",
            width: 25,
          ),
          SizedBox(
            height: 10,
            width: size.width * .5 - 100,
            child: Slider(
              thumbColor: const Color(0xff51dea3),
              activeColor: const Color(0xff51dea3),
              inactiveColor: const Color(0xffd9d9d9),
              value: _currentSliderValue,
              max: 100,
              divisions: 100,
              //label: _currentSliderValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                });
              },
            ),
          ),
          Text(
            "${_currentSliderValue.round().toString()}%",
            style: const TextStyle(color: kGrey, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
