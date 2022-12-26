import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/Models/passwords.dart';
// import 'package:flutter_application_1/Models/users.dart';

class fireStore_helper {
  static String? currentOne = " ";

  static setUID(String uid) {
    currentOne = uid;
  }

  static Stream<List<passwords>> read() {
    final passCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(currentOne)
        .collection('passwordsswallet')
        .orderBy('platform', descending: false);

    return passCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => passwords.fromSnapshot(e)).toList());
  }

  static Future create(passwords password) async {
    final passwordCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(currentOne)
        .collection('passwordsswallet');

    final docRef = passwordCollection.doc();
    final pid = docRef.id;

    final newPassword = passwords(
      platform: password.platform,
      username: password.username,
      password: password.password,
      passId: pid,
    ).toJson();

    await docRef.set(newPassword);
  }

  static Future update(passwords password) async {
    final passwordCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(currentOne)
        .collection('passwordsswallet');

    final docRef = passwordCollection.doc(password.passId);

    final newPassworddd = passwords(
      platform: password.platform,
      username: password.username,
      password: password.password,
      passId: password.passId,
    ).toJson();

    try {
      await docRef.update(newPassworddd);
    } catch (e) {
      print('error');
    }
  }

  static Future delete(passwords password) async {
    final passwordCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(currentOne)
        .collection('passwordsswallet');

    final docRef = passwordCollection.doc(password.passId).delete();
  }

  static Future getSomething(String who) async {
    var currentuser2 =
        FirebaseFirestore.instance.collection('users').doc(who).get();

    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc(who).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;

      // You can then retrieve the value from the Map like this:
      print("outside " + data['ID']);
      return data;
    }
  }
}
