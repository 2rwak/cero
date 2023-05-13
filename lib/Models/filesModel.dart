import 'package:cloud_firestore/cloud_firestore.dart';

class filesModel {
  String? fileName;
  String? fileId;
  int? fileColor;

  filesModel({this.fileName, this.fileId, this.fileColor});

  factory filesModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return filesModel(
        fileName: snapshot['fileName'],
        fileId: snapshot['fileId'],
        fileColor: snapshot['fileColor']);
  }

  Map<String, dynamic> toJson() =>
      {'fileName': fileName, 'fileId': fileId, 'fileColor': fileColor};
}
