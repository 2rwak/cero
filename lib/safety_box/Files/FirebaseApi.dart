import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseApi {
  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  static UploadTask? uploadBytes(String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(data);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  // Future<List> loadFiles() async {
  //   List<Map> files = [];
  //   final ListResult result = await firebaseStorage.ref().listAll();
  //   final List<Reference> allFiles = result.items;
  //   await Future.forEach(allFiles, (Reference file) async {
  //     final String fileURL = await file.getDownloadURL();
  //     files.add({"url": fileURL, "path": file.fullPath});
  //   });
  //   print(files);
  //   return files;
  // }
}
