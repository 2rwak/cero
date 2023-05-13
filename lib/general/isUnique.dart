import 'package:cloud_firestore/cloud_firestore.dart';

class isUnique {
  Future<bool> usernameCheck(String username) async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('users', isEqualTo: username)
        .get();

    return result.docs.isEmpty;
  }
}
