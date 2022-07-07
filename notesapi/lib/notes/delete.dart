import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notesapi/component/crud.dart';
import 'package:notesapi/component/link_api.dart';
import 'package:notesapi/routes/routes.dart';

class Delete extends StatelessWidget with crud {
  final int noteId;
  delete() async {
    var response = await postRequest(linkDelete, {
      "notes_id": this.noteId.toString()}
      );

    if (response['status'] == "success") {
      return response;
    } else {
      return Tooltip(
        message: 'no response',
      );
    }
  }

  const Delete({Key? key, required this.noteId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        delete();
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Routes.home, (route) => false);
      },
      child: Icon(Icons.delete),
    );
  }
}
