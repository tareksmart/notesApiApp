import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final String? Function(String?) valid;
  TextEditingController controller = TextEditingController();
  CustomTextField(
      {Key? key,
      required this.hint,
      required this.controller,
      required this.valid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
      child: TextFormField(
        validator: valid,
        controller: controller,
        decoration: InputDecoration(
            labelText: hint,
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)))),
      ),
    );
  }
}
