
import 'package:flutter/material.dart';
import 'package:notesapi/auth/log_in.dart';
import 'package:notesapi/home.dart';
import 'package:notesapi/notes/add.dart';
import 'package:notesapi/routes/routes.dart';

import '../auth/signup.dart';

class SpecialRouter{
  static Route<dynamic> generateRoute(RouteSettings settings)
  {
    switch (settings.name) {
      case Routes.login:
      return MaterialPageRoute(builder: (_)=>LogIn());
      case Routes.signUp:
      return MaterialPageRoute(builder: (_)=>SignUp());
      case Routes.home:
      return MaterialPageRoute(builder: (_)=>Home());
      case Routes.add:
      return MaterialPageRoute(builder: (_)=>Add());
        
      default:
      return MaterialPageRoute(builder: (_)=>LogIn());
    }
  }
}