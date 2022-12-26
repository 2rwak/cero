import 'package:cloud_firestore/cloud_firestore.dart';

class passwords {
  String? passId;
  String? platform;
  String? username;
  String? password;

  passwords({this.platform, this.username, this.password, this.passId});

  factory passwords.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return passwords(
        platform: snapshot['platform'],
        username: snapshot['username'],
        password: snapshot['password'],
        passId: snapshot['passId']);
  }

  Map<String, dynamic> toJson() => {
        'platform': platform,
        'username': username,
        'password': password,
        'passId': passId
      };
}
