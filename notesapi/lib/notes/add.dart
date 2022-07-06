import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:notesapi/component/crud.dart';
import 'package:notesapi/component/link_api.dart';
import 'package:notesapi/custom_text_field.dart';
import 'package:notesapi/main.dart';
import 'package:notesapi/routes/routes.dart';
import 'package:notesapi/validation/validate.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> with crud {
  TextEditingController titleCont = TextEditingController();
  TextEditingController contentCont = TextEditingController();
  GlobalKey<FormState> _formstateKey = GlobalKey();
  add() async {
    var respons = await postRequest(linkAdd, {
      "notes_content": contentCont.text,
      "notes_title": titleCont.text,
      "notes_userid": sharedPref.get('id')
    });

    if (respons['status'] == "success") {
      return respons;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('add notes')),
      body: Container(
        child: Form(
          key: _formstateKey,
          child: ListView(children: [
            CustomTextField(
              key: ValueKey('title'),
              valid: (val) {
               return validInputNoteScreen(titleCont.text.trim());
              },
              hint: 'title',
              controller: titleCont,
            ),
            CustomTextField(
              key: ValueKey('content'),
              valid: (val) {
               return validInputNoteScreen(contentCont.text.trim());
              },
              hint: 'content',
              controller: contentCont,
            ),
            MaterialButton(
              onPressed: () {
                final valid = _formstateKey.currentState?.validate();
                if (valid!) {
                  _formstateKey.currentState?.save();
                  add();

                  Navigator.pushNamedAndRemoveUntil(
                      context, Routes.home, (route) => false);
                }
              },
              child: Icon(Icons.add),
            ),
          ]),
        ),
      ),
    );
  }
}
