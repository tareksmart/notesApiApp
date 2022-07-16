import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notesapi/component/crud.dart';
import 'package:notesapi/component/link_api.dart';
import 'package:notesapi/routes/routes.dart';
import 'package:notesapi/validation/validate.dart';

import '../custom_text_field.dart';

class Edite extends StatefulWidget {
  final notes;
  const Edite({Key? key, this.notes}) : super(key: key);

  @override
  State<Edite> createState() => _EditeState();
}

class _EditeState extends State<Edite> with crud {
  TextEditingController titleCon = TextEditingController();
  TextEditingController contentCon = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? myFile;

  initState() {
    titleCon.text = widget.notes["notes_title"];
    contentCon.text = widget.notes["notes_content"];
  }

  edite() async {
    var response;
    if (myFile == null) {
      print('file is null');
      response = await postRequest(linkEdite, {
        "notes_title": titleCon.text,
        "notes_content": contentCon.text,
        "notes_id": widget.notes["notes_id"].toString(),
         "notes_image": widget.notes["notes_image"].toString()
      });
    } else {
       print('file is not null');
      response = await postRequestWithfile(
        myFile!,
        {
          "notes_title": titleCon.text,
          "notes_content": contentCon.text,
          "notes_id": widget.notes["notes_id"].toString(),
          "notes_image": widget.notes["notes_image"].toString()
        },
        linkEdite,
      );
    }

    if (response['status'] == "success") {
      return response;
    } else {
      return Tooltip(
        message: 'no response',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('edit')),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextField(
                  controller: titleCon,
                  hint: 'title',
                  valid: (val) {
                    if (val!.isEmpty)
                      return validInputNoteScreen(titleCon.text.trim());
                  }),
              CustomTextField(
                  controller: contentCon,
                  hint: 'content',
                  valid: (val) {
                    if (val!.isEmpty)
                      return validInputNoteScreen(contentCon.text.trim());
                  }),
              MaterialButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Column(
                          children: [
                            IconButton(
                                onPressed: () async {
                                  XFile? imggalxFile = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                  myFile = File(imggalxFile!.path);
                                  setState(() {}); //refresh for form
                                  Navigator.pop(context);
                                },
                                icon: Text('from gallary')),
                            SizedBox(
                              height: 15,
                            ),
                            IconButton(
                                onPressed: () async {
                                  XFile? imgcamxFile = await ImagePicker()
                                      .pickImage(source: ImageSource.camera);
                                  myFile = File(imgcamxFile!.path);
                                  setState(() {}); //refresh for form
                                  Navigator.pop(context);
                                },
                                icon: Text('from gallary'))
                          ],
                        );
                      });
                },
                child: Text('choose image'),
                color: myFile == null ? Colors.blue : Colors.grey[600],
              ),
              MaterialButton(
                onPressed: () {
                  final valid = _formKey.currentState?.validate();
                  if (valid!) {
                    _formKey.currentState?.save();
                    edite();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(Routes.home, (route) => false);
                  }
                },
                child: Icon(Icons.edit_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
