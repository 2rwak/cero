import 'package:cloud_firestore/cloud_firestore.dart';

class filesModel {
  String? fileName;
  String? fileId;

  filesModel({this.fileName, this.fileId});

  factory filesModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return filesModel(
        fileName: snapshot['fileName'], fileId: snapshot['fileId']);
  }

  Map<String, dynamic> toJson() => {
        'fileName': fileName,
        'fileId': fileId,
      };
}
