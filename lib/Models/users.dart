import 'package:cloud_firestore/cloud_firestore.dart';

class users {
  String? ID;
  String? phoneNo;
  String? email;
  String? username;

  users({this.username, this.ID, this.phoneNo, this.email});

  factory users.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return users(
        username: snapshot['username'],
        ID: snapshot['ID'],
        phoneNo: snapshot['phoneNo'],
        email: snapshot['email']);
  }

  Map<String, dynamic> toJson() =>
      {'username': username, 'ID': ID, 'phoneNo': phoneNo, 'email': email};
}
