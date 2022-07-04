import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notesapi/component/card_note.dart';
import 'package:notesapi/component/crud.dart';
import 'package:notesapi/component/link_api.dart';
import 'package:notesapi/main.dart';
import 'package:notesapi/routes/routes.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with crud {

getNotes()async{
var respons=postRequest(linkView, {
  "notes_userid":sharedPref.getString('id')
});
if(respons['status']=="sucess")
return respons;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
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
      body: ListView(children: [
        FutureBuilder(
          future: getNotes(),
          builder: ( (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting)
            {
              return Center(child: CircularProgressIndicator(),);
            }
            if(snapshot.hasData)
            {
              return ListView.builder<snapshot.data>(
                itemCount: snapshot.data['data'].lenght,
                itemBuilder: itemBuilder)
            }
            
          }))
      
      ]),
    );
  }
}
