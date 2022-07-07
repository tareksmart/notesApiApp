import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notesapi/model/note_model.dart';

class CardNotes extends StatelessWidget {
  void Function()? ontap;
  final note_model noteModel;
  final String title;
  final String content;
  Widget child;
  CardNotes(
      {Key? key, required ontap, required this.child, required this.noteModel,required this.title,
      required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: ontap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          margin: EdgeInsets.all(8),
          elevation: 8,
          child: Row(
            children: [
              Expanded(
                child: Image.asset(
                  'images/note.png',
                  height: 100,
                  width: 50,
                  fit: BoxFit.cover,
                ),
                flex: 1,
              ),
              Expanded(
                child: ListTile(
                  title: Text(noteModel.notesTitle.toString()),
                  subtitle: Text('${noteModel.notesContent}'),
                ),
                flex: 3,
              ),
              child
            ],
          ),
        ),
      ),
    );
  }
}
