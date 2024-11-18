import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  
  final Function toggleView;

  SignIn({super.key, required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  // Create an instance of the AuthService class to access the methods
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  // text field state that updates when a user types into the form
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(

      backgroundColor: Colors.brown[100],

      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to Brew Crew'),
        actions: [
          TextButton.icon(
            onPressed: () {
               widget.toggleView(); // remember to access the toggle from the widget level not state
            }, 
            icon: Icon(Icons.person, color: Colors.black,),
            label: Text(
              'Register', 
              style: TextStyle(color: Colors.black),
              ),
            )
        ],
        ),
      
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),

        child: Form(

          key: _formkey,

          child: Column(
            children: [

              SizedBox(height: 20.0,),

              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),

              SizedBox(height: 20.0,),

              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val) => val!.length < 6 ? 'Enter an password 6+ characters long' : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),

              SizedBox(height: 20.0,),

              ElevatedButton(
                onPressed: () async {
                  if(_formkey.currentState!.validate()) {

                    setState(() => loading = true);

                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);

                    if(result == null){
                      setState(() {
                        error = 'Invalid Credentials';
                        loading = false;
                      });
                    } 
                  }
                },  
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[400],
                  foregroundColor: Colors.white,
                ),
                child: Text('Sign in'),
                ),

              SizedBox(height: 12.0,), 

              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),

    );
  }
}