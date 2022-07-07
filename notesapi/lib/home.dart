import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:notesapi/component/card_note.dart';
import 'package:notesapi/component/crud.dart';
import 'package:notesapi/component/link_api.dart';
import 'package:notesapi/main.dart';
import 'package:notesapi/model/note_model.dart';
import 'package:notesapi/notes/delete.dart';
import 'package:notesapi/notes/edite.dart';
import 'package:notesapi/routes/routes.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with crud {
  late int _noteId = 0;
  getNotes() async {
    var respons = await postRequest(
        linkView, {"notes_userid": sharedPref.getString('id')});
    print(respons);
    if (respons['status'] == "success") return respons;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(Routes.add);
        },
      ),
      appBar: AppBar(
        title: Text('home'),
        actions: [
          IconButton(
              onPressed: () {
                sharedPref.clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(Routes.login, (route) => false);
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(children: [
          FutureBuilder(
              future: getNotes(),
              builder: ((context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data['status'] == 'no success')
                    return Center(
                      child: Text('no notes found'),
                    );

                  return ListView.builder(
                    itemCount: snapshot.data['data']?.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: ((context, index) {
                      _noteId = snapshot.data['data'][index]['notes_id'];

                      print(' index ${index}');
                      return InkWell(
                        onTap: () => Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx) {
                          return Edite(notes: snapshot.data['data'][index]);
                        })),
                        child: CardNotes(
                          noteModel:
                              note_model.fromJson(snapshot.data['data'][index]),
                          ontap: () {
                            print('tapppppppppppped');
                          },
                          title:
                              "${snapshot.data['data'][index]['notes_title']}",
                          content:
                              "${snapshot.data['data'][index]['notes_content']}",
                          child: Delete(
                              noteId: snapshot.data['data'][index]['notes_id']),
                        ),
                      );
                    }),
                  );
                  // ignore: dead_code
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Text('loading'));
                  }
                }
                return Center(child: Text('loading'));
              })),
        ]),
      ),
    );
  }
}
