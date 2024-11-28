class CustomUser {
  final String uid;

  CustomUser({ required this.uid });
}

// create a user model separate from the brew model
// this allows for future extension of one model independent of the other
// brew model does not include uid
class UserData {

  final String uid;
  final String name;
  final String sugars;
  final int strength;

  UserData({ required this.uid, required this.sugars, required this.strength, required this.name });

}