import 'package:cloud_firestore/cloud_firestore.dart';

class historyModel {
  String? device;
  String? location;
  String? time;

  historyModel({this.device, this.location, this.time});

  factory historyModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return historyModel(
        device: snapshot['Device'],
        location: snapshot['Location'],
        time: snapshot['Time']);
  }

  Map<String, dynamic> toJson() =>
      {'Device': device, 'Location': location, 'Time': time};
}
