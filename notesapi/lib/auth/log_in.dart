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
      print('inside log in');
      
      sharedPref.setString("id", respons['data']['user_id'].toString());
      print(respons['data']['user_id']);
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
                          key: ValueKey('email'),
                          valid:(value){
                            if(value!.isEmpty||value.contains('@')){
                              return 'please enter email';
                            }
                          } ,
                       
                          hint: 'email',
                          controller: email_cont,
                        ),
                        CustomTextField(
                          key: ValueKey('pass'),
                          valid:(value){
                            if(value!.isEmpty){
                              return 'pleae enter pass';

                            }
                          } ,
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
