import 'package:flutter/material.dart';

import 'package:notesapi/custom_text_field.dart';
import 'package:notesapi/routes/routes.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formState = GlobalKey();
    TextEditingController email_cont = new TextEditingController();
    TextEditingController pass_cont = new TextEditingController();
    return Scaffold(
      body: ListView(
        children: [
          Form(
              key: formState,
              child: Column(
                children: [
                  Image.asset(
                    'images/log.png',
                    width: 200,
                    height: 200,
                  ),
                  CustomTextField(
                    hint: 'email',
                    controller: email_cont,
                  ),
                  CustomTextField(
                    hint: 'password',
                    controller: pass_cont,
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.home);
                    },
                    child: Text('login'),
                    color: Colors.blueGrey[600],
                    textColor: Colors.white,
                  ),
                  InkWell(
                    child: Text('signup'),
                    onTap: () => Navigator.of(context).pushNamed(Routes.signUp),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
