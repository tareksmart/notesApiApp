import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      appBar: AppBar(
        title: Text('home'),
      ),
      body: ListView(children: [
        Card(
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
                  title: Text('note title'),
                  subtitle: Text('note details'),
                ),
                flex: 3,
              ),
              InkWell(
                highlightColor: Colors.blue,
                child: Icon(Icons.edit),
                onTap: () {},
              ),
            ],
          ),
        )
      ]),
    );
  }
}
