import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/Models/creditCards.dart';
import 'package:flutter_application_1/Models/labels.dart';
import 'package:flutter_application_1/Models/passwords.dart';
import 'package:flutter_application_1/Models/users.dart';
import 'package:flutter_application_1/Models/filesModel.dart';
import '../Models/Pic.dart';
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

    final newFile =
        filesModel(fileName: file.fileName, fileId: fid, fileColor: 0xFF8A70BE)
            .toJson();

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
        .doc(currentOne)
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

    final docRef = FileCollection.doc(fid.substring(69, 82)).delete();
  }

// Arwa 26 / 1
  static Future deleteFileShared(String fid) async {
    final FileCollection = FirebaseFirestore.instance
        .collection('shared_files')
        .doc(currentOne)
        .collection('files');

    final docRef = FileCollection.doc(fid).delete();
  }

  static Future updateFileColor(filesModel update) async {
    final filesCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(currentOne)
        .collection('files');

    final docRef = filesCollection.doc(update.fileId!.substring(69, 82));

    final newFile = filesModel(
            fileName: update.fileName,
            fileColor: update.fileColor,
            fileId: update.fileId)
        .toJson();

    try {
      await docRef.update(newFile);
    } catch (e) {
      print('error');
    }
  }

  static Future<bool> emptylabel() async {
    QuerySnapshot<Map<String, dynamic>> labelsColl = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(currentOne)
        .collection('Labels')
        .get();

    print("${labelsColl.docs.isEmpty}" + "stream");

    if (labelsColl.docs.isEmpty) return true;

    return false;
  }

  static Future updatelabels(labels l) async {
    final creditCardCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(currentOne)
        .collection('Labels');

    final docRef7 = creditCardCollection.doc(l.labId);

    final newlab = labels(
      labelName: l.labelName,
      LabelColor: l.LabelColor,
      labId: l.labId,
    ).toJson();

    try {
      await docRef7.update(newlab);
    } catch (e) {
      print('error');
    }
  }

  static Future uploadPic(Pic p) async {
    final pCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(currentOne)
        .collection('Photos');

    final docRef = pCollection.doc();
    final pid = docRef.id;

    final newP = Pic(pId: pid, pURL: p.pURL, path: p.path, no: p.no).toJson();

    await docRef.set(newP);
  }

  static Stream<List<Pic>> readp() {
    final pColl = FirebaseFirestore.instance
        .collection('users')
        .doc(currentOne)
        .collection('Photos')
        .orderBy("no", descending: true);

    return pColl.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => Pic.fromSnapshot(e)).toList());
  }

  static Future deleteP(String pid) async {
    final pCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(currentOne)
        .collection('Photos');

    final docRef = pCollection.doc(pid).delete();
  }
}
