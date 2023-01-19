import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/Models/creditCards.dart';
import 'package:flutter_application_1/Models/labels.dart';
import 'package:flutter_application_1/Models/passwords.dart';
import 'package:flutter_application_1/Models/users.dart';
import 'package:flutter_application_1/safety_box/Files/files.dart';
import 'package:flutter_application_1/Models/filesModel.dart';
import 'package:flutter_application_1/Models/creditCards.dart';
import '../Models/historyModel.dart';

class fireStore_helper {
  static String? currentOne = "";

  static setUID(String uid) {
    currentOne = uid;
  }

  static getUID() {
    return currentOne;
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

  static Future deleteUser() async {
    FirebaseFirestore.instance.collection('users').doc(currentOne).delete();
  }

  static Future updateProfile(users user) async {
    final userInfo =
        FirebaseFirestore.instance.collection('users').doc(user.username);

    final newInfo = users(
      username: user.username,
      ID: user.ID,
      phoneNo: user.phoneNo,
      email: user.email,
    ).toJson();

    try {
      await userInfo.update(newInfo);
    } catch (e) {
      print('error');
    }
  }

  //////FILES
  static Stream<List<filesModel>> readFiles() {
    final filesCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(currentOne)
        .collection('files')
        .orderBy('fileName', descending: false);

    return filesCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => filesModel.fromSnapshot(e)).toList());
  }

  static Future createFile(filesModel file) async {
    final filesCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(currentOne)
        .collection('files');

    final docRef = filesCollection.doc();
    final fid = docRef.id;

    final newFile = filesModel(
      fileName: file.fileName,
      fileId: fid,
    ).toJson();

    await docRef.set(newFile);
  }

/////CREDIT CARDS
  static Stream<List<creditCards>> readCards() {
    final cardsCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(currentOne)
        .collection('creditCards')
        .orderBy('bankName', descending: false);

    return cardsCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => creditCards.fromSnapshot(e)).toList());
  }

  static Future createCards(creditCards creditCard) async {
    final creditCardCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(currentOne)
        .collection('creditCards');

    final docRef = creditCardCollection.doc();
    final cid1 = docRef.id;

    final newCard = creditCards(
      bankName: creditCard.bankName,
      cardNo: creditCard.cardNo,
      ExpiryMonth: creditCard.ExpiryMonth,
      ExpiryYear: creditCard.ExpiryYear,
      CVV: creditCard.CVV,
      Name: creditCard.Name,
      cid: cid1,
    ).toJson();

    await docRef.set(newCard);
  }

  static Future updateCard(creditCards creditCard) async {
    final creditCardCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(currentOne)
        .collection('creditCards');

    final docRef1 = creditCardCollection.doc(creditCard.cid);

    final newCardd = creditCards(
      bankName: creditCard.bankName,
      cardNo: creditCard.cardNo,
      ExpiryMonth: creditCard.ExpiryMonth,
      ExpiryYear: creditCard.ExpiryYear,
      CVV: creditCard.CVV,
      Name: creditCard.Name,
      cid: creditCard.cid,
    ).toJson();

    try {
      await docRef1.update(newCardd);
    } catch (e) {
      print('error');
    }
  }

  static Future deleteCard(creditCards creditCard) async {
    final CardsCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(currentOne)
        .collection('creditCards');

    final docRef = CardsCollection.doc(creditCard.cid).delete();
  }

  //--------------------------------7/1/2023 Reef----------------------
  static Stream<List<historyModel>> readHistory() {
    var historyCollection = FirebaseFirestore.instance
        .collection('users')
        .doc("reefthun")
        .collection('History');

    // for (var queryDocumentSnapshot in historyCollection.docs) {

    // }

    return historyCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => historyModel.fromSnapshot(e)).toList());

    // return historyCollection1;
  }

  //-------------Reef 13/01-------------
  static Future createLabel(labels label) async {
    final LabelsCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(currentOne)
        .collection('Labels');

    final docRef = LabelsCollection.doc();
    final Lid = docRef.id;

    final newLabel = labels(
      labelName: label.labelName,
      LabelColor: label.LabelColor,
      labId: Lid,
    ).toJson();

    await docRef.set(newLabel);
  }

  static Stream<List<labels>> retrieveLabels() {
    final labelsColl = FirebaseFirestore.instance
        .collection('users')
        .doc(currentOne)
        .collection('Labels')
        .orderBy('labelName', descending: false);

    return labelsColl.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => labels.fromSnapshot(e)).toList());
  }

  static Future deleteFile(String fid) async {
    final FileCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(currentOne)
        .collection('files');

    final docRef = FileCollection.doc(fid).delete();
  }
}
