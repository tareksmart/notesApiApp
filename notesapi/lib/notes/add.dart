import 'dart:io';
import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
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
  File? myFile;
  TextEditingController titleCont = TextEditingController();
  TextEditingController contentCont = TextEditingController();
  GlobalKey<FormState> _formstateKey = GlobalKey();

  add() async {
    if (myFile == null)
      return AwesomeDialog(
              context: context, title: 'message', body: Text('take pic first'))
          .show();

    var respons = await postRequestWithfile(
        myFile!,
        {
          "notes_content": contentCont.text,
          "notes_title": titleCont.text,
          "notes_userid": sharedPref.get("id")
        },
        linkAdd);

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
                if (val!.isEmpty)
                  return validInputNoteScreen(contentCont.text.trim());
              },
              hint: 'title',
              controller: titleCont,
            ),
            CustomTextField(
              key: ValueKey('content'),
              valid: (val) {
                if (val!.isEmpty)
                  return validInputNoteScreen(contentCont.text.trim());
              },
              hint: 'content',
              controller: contentCont,
            ),
            MaterialButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () async {
                                  XFile? xfile = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                  myFile = File(xfile!.path);
                                  setState(() {});
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'take pic from gallary',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () async {
                                  XFile? xcamFile = await ImagePicker()
                                      .pickImage(source: ImageSource.camera);
                                  myFile = File(xcamFile!.path);
                                  setState(() {});
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'take pic from cam',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: Text('choose image'),
              color: myFile == null ? Colors.blue : Colors.green,
            ),
            MaterialButton(
              onPressed: () async{
                final valid = _formstateKey.currentState?.validate();
                if (valid!) {
                  _formstateKey.currentState?.save();
                await add();

                  Navigator.pushReplacementNamed(
                      context, Routes.home);
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
