import 'package:brew_crew/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  // final property - it will not change in the future
  // _ private property - only can be used in this file
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on User (Firebase User)
  CustomUser? _userFromFirebaseUser(User? user) {
    return user != null ? CustomUser(uid: user.uid) : null;
  }

  // Method: Sign In Anonymous 
  Future signInAnon() async {
    try {
      UserCredential credential = await _auth.signInAnonymously();
      User? user = credential.user;
      return _userFromFirebaseUser(user);
    } 
    catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Method: Sign In Email/Password 

  // Method: Register Email/Password

  // Method: Sign Out

}