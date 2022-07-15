import 'package:flutter/material.dart';
import 'package:notesapi/component/crud.dart';
import 'package:notesapi/component/link_api.dart';

import 'package:notesapi/custom_text_field.dart';
import 'package:notesapi/routes/routes.dart';

import '../validation/validate.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
  
    crud cru = crud();
    GlobalKey<FormState> formState = GlobalKey();
    TextEditingController email_cont = new TextEditingController();
    TextEditingController pass_cont = new TextEditingController();
    TextEditingController userName_cont = new TextEditingController();
    bool isloading = false;
    
    signup() async {
       
      isloading = true;
      
      setState(() {});
      print('before respo');
      var response = await cru.postRequest(linkSignUp, {
        'user_name': userName_cont.text,
        'email': email_cont.text,
        'password': pass_cont.text
      });
      print('afterrrrrrrrrrrrrrrr respo' + "${response}");

      if (response['status'] == "success") {
        print('insid if respo' + "${response["status"]}");
        isloading = false;
        setState(() {});
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.home, (route) => false);
      } else
        print('sign fail');
    }

    return Scaffold(
      body: isloading
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
                          width: 200,
                          height: 200,
                        ),
                        CustomTextField(
                          valid: validInputNoteScreen(email_cont.text),
                          hint: 'email',
                          controller: email_cont,
                        ),
                        CustomTextField(
                          valid: validInputNoteScreen(userName_cont.text),
                          hint: 'user name',
                          controller: userName_cont,
                        ),
                        CustomTextField(
                          valid: validInputNoteScreen(pass_cont.text),
                          hint: 'password',
                          controller: pass_cont,
                        ),
                        MaterialButton(
                          onPressed: () async {
                            await signup();
                          },
                          child: Text('signUp'),
                          color: Colors.blueGrey[600],
                          textColor: Colors.white,
                        ),
                        InkWell(
                          child: Text('logIn'),
                          onTap: () => Navigator.pushReplacementNamed(
                              context, Routes.login),
                        )
                      ],
                    ))
              ],
            ),
    );
  }
}
