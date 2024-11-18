import 'package:brew_crew/screens/authenticate/register.dart';
import 'package:brew_crew/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  // initiate the condition
  bool showSignIn = true;

  // create the toggle function
  // this function will be passed to the sign_in and register pages
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn; // changes the state of showSignIn to the reverse of current state
    });
  }
  
  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView: toggleView); // remember to 'accept' the widgets using contructors in the pages 
    } else {
      return Register(toggleView: toggleView); // remember to 'accept' the widgets using contructors in the pages
    }
  }
}