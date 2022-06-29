// import 'package:get/get.dart';
// import 'package:mobile_ics_flutter/controllers/operator_controllers/operator_controller.dart';

// import 'component.dart';

// export 'package:flutter/material.dart';
// export 'o_constants.dart';
// export 'texts.dart';
// export 'bottom_sheet.dart';
// export 'customs.dart';
// export 'play_news.dart';
// export 'volume.dart';

// class TestDropdown extends StatelessWidget {
//   const TestDropdown({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<OperatorController>(
//       builder: (_) => DropdownButtonFormField<String>(
//         decoration: const InputDecoration(
//           icon: ImageIcon(
//             AssetImage("assets/icons/op_news.png"),
//             //color: Colors.red,
//             size: 25,
//           ),
//           contentPadding: EdgeInsets.symmetric(vertical: 0),
//         ),
//         style: TextStyle(
//           color: kBlack.withOpacity(.6),
//           fontSize: text3,
//         ),
//         isExpanded: true,
//         value: _.NewsSelected,
//         onChanged: (value) => _.SelectNews(value),
//         hint: Text('Chọn bản tin'),
//         items: const [
//           DropdownMenuItem(
//               value: '0',
//               child: Text('Bản tin thời sự đài truyền hình Việt Nam')),
//           DropdownMenuItem(value: '1', child: Text('Bản tin dự báo thời tiết')),
//           DropdownMenuItem(
//               value: '2', child: Text('Thông báo tiêm ngừa Covid 19')),
//           DropdownMenuItem(value: '3', child: Text('...')),
//         ],
//       ),
//     );
//   }
// }
