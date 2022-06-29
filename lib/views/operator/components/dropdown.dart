import 'package:get/get.dart';

import '../../../controllers/operator_controllers/operator_controller.dart';
import 'component.dart';

class Dropdown extends StatelessWidget {
  const Dropdown({Key? key, this.hint, required this.list}) : super(key: key);
  final String? hint;
  final List<DropdownMenuItem<String>> list;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OperatorController>(
      builder: (_) => DropdownButton<String>(
        style: TextStyle(
          color: kBlack.withOpacity(.6),
          fontSize: text3,
        ),
        isExpanded: true,
        value: _.newsSelected,
        onChanged: (value) => _.Select('newsSelected', value),
        hint: Text('$hint'),
        underline: Container(color: Colors.transparent),
        items: list,
      ),
    );
  }
}
