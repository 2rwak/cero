import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class labels {
  String? labId;
  String? labelName;
  String? LabelColor;

  labels({this.labelName, this.LabelColor, this.labId});

  factory labels.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return labels(
      labelName: snapshot['labelName'],
      LabelColor: snapshot['labelColor'],
      labId: snapshot['Lid'],
    );
  }

  Map<String, dynamic> toJson() =>
      {'labelName': labelName, 'labelColor': LabelColor, 'Lid': labId};
}
