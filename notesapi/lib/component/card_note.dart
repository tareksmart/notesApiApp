import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CardNotes extends StatelessWidget {
  void Function()? ontap;
  final String title;
  final String content;
  CardNotes({Key? key, required this.title, required this.content,required ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: ontap,
        child: Card(
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
                  title: Text('$title'),
                  subtitle: Text('$content'),
                ),
                flex: 3,
              ),
           
            ],
          ),
        ),
      ),
    );
  }
}
