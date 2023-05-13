import 'package:cloud_firestore/cloud_firestore.dart';

class Pic {
  String? pId;
  String? pURL;
  String? path;
  String? no;

  Pic({this.pId, this.pURL, this.path, this.no});

  factory Pic.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Pic(
        pId: snapshot['pId'],
        pURL: snapshot['pURL'],
        path: snapshot['path'],
        no: snapshot['no']);
  }

  Map<String, dynamic> toJson() =>
      {'pId': pId, 'pURL': pURL, 'path': path, 'no': no};
}
