import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  // final property - it will not change in the future
  // _ private property - only can be used in this file
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on User (Firebase User)
  CustomUser? _userFromFirebaseUser(User? user) {
    return user != null ? CustomUser(uid: user.uid) : null;
  }

  // auth change user stream object
  // the Stream object will return firebase users whenever there is a hcange in authentication
  Stream<CustomUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // Method: Sign In Anonymous 
  Future signInAnon() async {
    try {
      UserCredential credential = await _auth.signInAnonymously();
      User? user = credential.user;
      return _userFromFirebaseUser(user);
    } 
    catch(e) {
      print(e.toString());
      return null;
    }
  }

  // Method: Sign In Email/Password 
    Future signInWithEmailAndPassword(String email, String password) async {
    try {
      // use the _auth instance to make a request to firebase
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = credential.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // Method: Register Email/Password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      // use the _auth instance to make a request to firebase
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = credential.user;

      // create a new document for the user with the uid
      await DatabaseService(uid: user!.uid).updateUserData('0', 'new user', 100);

      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }


  // Method: Sign Out
  Future signOut() async {
    try {
      return await _auth.signOut(); //built in signout function from the firebase_auth library
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}