// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter_application_1/data_sourse/fireStore_helper.dart';

class useSignature2 {
  static Future<void> generatePDF({
    required String username,
    required String guest,
    required String pdfUrl,
    required String pdfName,
  }) async {
    // await merge(username, pdfUrl);
    await downloadFileExample(username, guest, pdfUrl, pdfName);
  }

  static Future<void> downloadFileExample(
    String username,
    String guest,
    String pdfUrl,
    String pdfName,
  ) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();

    String fileName_merge = '${appDocDir.path}/downloaded-pdf.pdf';

    File downloadToFile_merge = File(fileName_merge);
    String fileToDownload_merge = '$pdfName';

    await FirebaseStorage.instance
        .ref(fileToDownload_merge)
        .writeToFile(downloadToFile_merge);
    print("START 10 fileName_merge $fileName_merge");

    PdfDocument document =
        PdfDocument(inputBytes: File('$fileName_merge').readAsBytesSync());

    Map<String, dynamic> user_data = await retrive_user_data(guest);
    List<int> imageSignature = user_data['signature'];

    final PdfPage page = document.pages[0];
    page.graphics.drawString("${user_data['username']}",
        PdfStandardFont(PdfFontFamily.helvetica, 12, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(400, 550, 200, 50),
        brush: PdfBrushes.white,
        // pen: PdfPens.blue,
        format: PdfStringFormat(alignment: PdfTextAlignment.left));

    page.graphics.drawString("${user_data['ID']}",
        PdfStandardFont(PdfFontFamily.helvetica, 12, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(400, 565, 200, 50),
        brush: PdfBrushes.white,
        // pen: PdfPens.blue,
        format: PdfStringFormat(alignment: PdfTextAlignment.left));

    page.graphics.drawString("${user_data['email']}",
        PdfStandardFont(PdfFontFamily.helvetica, 12, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(400, 585, 200, 50),
        brush: PdfBrushes.white,
        // pen: PdfPens.blue,
        format: PdfStringFormat(alignment: PdfTextAlignment.left));

    final PdfBitmap image = PdfBitmap(imageSignature);
    page.graphics.drawImage(image, Rect.fromLTWH(400, 595, 100, 100));

    File(fileName_merge).writeAsBytes(document.saveSync());

    Uint8List path = await File(fileName_merge).readAsBytes();

    // document.dispose();
    await save_signed_file(path, username, pdfName);
    OpenFile.open(fileName_merge);
    // await fireStore_helper.deleteFileShared(pdfName);

    return;
  }

  static Future save_signed_file(
      Uint8List path, String username, String fileName_merge) async {
    //upload
    var FileExt = FirebaseStorage.instance.ref().child(fileName_merge);
    UploadTask task = FileExt.putData(path);
    TaskSnapshot snapshot = await task;
    String url = await snapshot.ref.getDownloadURL();

    //upload to firestore
    final filesCollection = FirebaseFirestore.instance
        .collection("shared_files")
        .doc(username)
        .collection("files");
    final docRef = filesCollection.doc('${fileName_merge}');
//  var file
    await docRef.update({
      'fileName': '${fileName_merge}',
      'fileId': url,
      'status': 2,
      'color': 0xFF4BF15C,
      'guest_username': "none",
    });
  }

  static Future<Map<String, dynamic>> retrive_user_data(String username) async {
    // var ID, email, phoneNo, username, byte;
    var info = await FirebaseFirestore.instance
        .collection('users')
        .doc(username)
        .get();

    var username1 = info.data()!['username'];
    var ID = info.data()!['ID'];
    var email = info.data()!['email'];
    var phoneNo = info.data()!['phoneNo'];

    var bytes = info.data()!['signature'].cast<int>();

    final profile = <String, dynamic>{
      'ID': ID,
      'email': email,
      'phoneNo': phoneNo,
      'username': username,
      'signature': bytes,
    };
    return profile;
  }
}
