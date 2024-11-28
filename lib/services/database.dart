import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  // when an instance of DatabseService is activated, a uid will be passed
  final String uid;
  DatabaseService({ required this.uid });

  // collection reference
  // if by the time this code runs, and the colelction doesn't exist
  // Firestore will create the colection
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    // reference to the document with the uid passed to DatabaseService
    // if document doesn't exist, one will be created
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
     return snapshot.docs.map((doc){
       return Brew(
         name: doc.get('name'),
         sugars: doc.get('sugars'),
         strength: doc.get('strength'),
       );
     }).toList(); // need to convert to list because the return is a iterable
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.get('name'),
      sugars: snapshot.get('sugars'),
      strength: snapshot.get('strength'),
    );
  }

  // get brews stream
  // Insert the List Brew to the Stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots()
      .map(_brewListFromSnapshot);
  }

  // get the user doc stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots()
      .map(_userDataFromSnapshot);
  }

}

