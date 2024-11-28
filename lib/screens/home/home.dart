import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({super.key});

  // create an instance of the AuthService for signOut()
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    // Bottom Sheet Function
    void showSettingsPanel() {
      showModalBottomSheet(
        context: context, 
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: SettingsForm(),
          );
        }); //builder returns a widget tree that sits inside the bottom sheet
    }

    return StreamProvider<List<Brew>?>.value(

      //use this stream for the rest of the widget
      value: DatabaseService(uid: '').brews,
      initialData: [],

      // All widgets inside the Scaffold is wrapped with the provider above

      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: [

            // Logout Button 
            TextButton.icon(
              icon: Icon(Icons.person),
              onPressed: () async {
                await _auth.signOut();
              }, 
              label: Text('logout'),
              ),

            // Bottom Sheet
            // TextButton.icon(
            //   icon: Icon(Icons.settings),
            //   label: Text('settings'),
            //   onPressed: () => showSettingsPanel(), 
            //   ),
          ],
        ),

        // BrewList Widget
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
              )
          ),
          child: BrewList()),
        
        // Bottom nav bar
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Container(height: 50.0),
        ),

        // bottom sheet via showSettingsPanel function
        floatingActionButton: FloatingActionButton(
            onPressed: () => showSettingsPanel(),
            tooltip: 'Increment Counter',
            child: const Icon(Icons.coffee),
          ),
        // button position
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      
      ),
    );
  }
}