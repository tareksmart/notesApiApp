import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notesapi/component/crud.dart';
import 'package:notesapi/component/link_api.dart';

import 'package:notesapi/custom_text_field.dart';
import 'package:notesapi/main.dart';
import 'package:notesapi/routes/routes.dart';
import 'package:notesapi/validation/validate.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController email_cont = new TextEditingController();
  TextEditingController pass_cont = new TextEditingController();
  crud cru = crud();
  bool isloading = false;
  login() async {
    isloading = true;
    setState(() {});
    var respons = await cru.postRequest(
        linkLogIn, {"email": email_cont.text, "password": pass_cont.text});
    if (respons['status'] == "success") {
      sharedPref.setString("id", respons['data']['id'].toString());
      sharedPref.setString("user_name", respons['data']['user_name'].toString());
      sharedPref.setString("email", respons['data']['email'].toString());
      Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
      isloading = false;
      setState(() {});
    } else {
      isloading = false;
      setState(() {});
      AwesomeDialog(
              context: context,
              title: 'تنبيه',
              dialogType: DialogType.INFO,
              body: Text('wrong data'))
          .show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Form(
                    key: formState,
                    child: Column(
                      children: [
                        Image.asset(
                          'images/log.png',
                          width: 150,
                          height: 150,
                        ),
                        CustomTextField(
                          valid:validInputNoteScreen(email_cont.text) ,
                       
                          hint: 'email',
                          controller: email_cont,
                        ),
                        CustomTextField(
                          valid:validInputNoteScreen(pass_cont.text) ,
                          hint: 'password',
                          controller: pass_cont,
                        ),
                        MaterialButton(
                          onPressed: () async {
                            await login();
                          },
                          child: Text('login'),
                          color: Colors.blueGrey[600],
                          textColor: Colors.white,
                        ),
                        InkWell(
                          child: Text('signup'),
                          onTap: () =>
                              Navigator.of(context).pushNamed(Routes.signUp),
                        )
                      ],
                    ))
              ],
            ),
    );
  }
}
