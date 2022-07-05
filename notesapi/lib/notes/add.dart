import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notesapi/custom_text_field.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  TextEditingController titleCont = TextEditingController();
  TextEditingController contentCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
          children: [CustomTextField(hint: 'title', controller: titleCont),
          ]),
    );
  }
}
