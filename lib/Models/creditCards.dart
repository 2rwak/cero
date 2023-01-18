import 'package:cloud_firestore/cloud_firestore.dart';

class creditCards {
  String? bankName;
  String? cardNo;
  int? ExpiryMonth;
  int? ExpiryYear;
  String? CVV;
  String? Name;
  String? cid;

  creditCards(
      {this.bankName,
      this.cardNo,
      this.ExpiryMonth,
      this.ExpiryYear,
      this.CVV,
      this.Name,
      this.cid});

  factory creditCards.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return creditCards(
        bankName: snapshot['bankName'],
        cardNo: snapshot['cardNo'],
        ExpiryMonth: snapshot['ExpiryMonth'],
        ExpiryYear: snapshot['ExpiryYear'],
        CVV: snapshot['CVV'],
        Name: snapshot['Name'],
        cid: snapshot['cid']);
  }

  Map<String, dynamic> toJson() => {
        'bankName': bankName,
        'cardNo': cardNo,
        'ExpiryMonth': ExpiryMonth,
        'ExpiryYear': ExpiryYear,
        'CVV': CVV,
        'Name': Name,
        'cid': cid
      };
}
