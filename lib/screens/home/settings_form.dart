import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // form values
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<CustomUser?>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user!.uid).userData, // access to user data from the wrapper
      builder: (context, snapshot) { // not the same snapshot as firebase

        if(snapshot.hasData){

          UserData? userData = snapshot.data; // we can now reference this data in our form

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                // Text Widget
                Text(
                  'Update your brew settings.',
                  style: TextStyle(fontSize: 18.0),
                ),
          
                SizedBox(height: 20.0),
          
                // Update Name
                TextFormField(
                  initialValue: userData!.name, // userData to match
                  decoration: textInputDecoration,
                  validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
          
                SizedBox(height: 10.0),
          
                // Dropdown Update Sugars
                DropdownButtonFormField(
                  value: _currentSugars ?? userData.sugars, // userData to match
                  decoration: textInputDecoration,
                  items: sugars.map((sugar) { // list of dropdown menu item widgets
                    return DropdownMenuItem(
                      value: sugar, // value of the items in the list
                      child: Text('$sugar sugars'),
                    );
                  }).toList(), // change from iterable to list
                  onChanged: (val) => setState(() => _currentSugars = val! ),
                ),
          
                SizedBox(height: 10.0),
          
                // slider widget
                // playing witht the color effects
                Slider(
                  value: (_currentStrength ?? userData.strength).toDouble(),
                  activeColor: Colors.brown[_currentStrength ?? userData.strength],
                  min: 100,
                  max: 900,
                  divisions: 8,
                  onChanged: (val) => setState(() => _currentStrength = val.round()), // round to change to int
          
                  ),
          
                
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink[400],
                        foregroundColor: Colors.white,
                      ),
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState!.validate()) {
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugars ?? userData.sugars, 
                        _currentName ?? userData.name, 
                        _currentStrength ?? userData.strength);
                      Navigator.pop(context); // Closing the bottom sheet
                    }
                  }
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }

      }
    );
  }
}