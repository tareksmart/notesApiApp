import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
  initState() {
    titleCon.text = widget.notes["notes_title"];
    contentCon.text = widget.notes["notes_content"];
  }

  edite() async {
    var response = await postRequest(linkEdite, {
      "notes_title": titleCon.text,
      "notes_content": contentCon.text,
      "notes_id": widget.notes["notes_id"].toString()
    });
    
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
                    return validInputNoteScreen(titleCon.text.trim());
                  }),
              CustomTextField(
                  controller: contentCon,
                  hint: 'content',
                  valid: (val) {
                    return validInputNoteScreen(contentCon.text.trim());
                  }),
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
