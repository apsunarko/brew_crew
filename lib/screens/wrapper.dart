import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/screens/authenticate/authenticate.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    // setup listner using the provider package
    final user = Provider.of<CustomUser?>(context);
    print('User in Wrapper: $user');

    if (user == null) {
      return Authenticate(); // No user, go to Authenticate screen
    } else {
      return Home(); // User is present, go to Home screen
    }
  }
}