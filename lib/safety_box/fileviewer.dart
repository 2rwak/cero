import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class fileviewtry extends StatefulWidget {
  @override
  State<fileviewtry> createState() => _fileviewrtryState();
}

var file;
Future<Uint8List?> loadFile() async {
  final gsReference = FirebaseStorage.instance
      .refFromURL("gs://cero-5bfd9.appspot.com/cero_signature_first_page.pdf");
  const oneMegabyte = 1024 * 1024;
  file = await gsReference.getData(oneMegabyte);

  return file;
}

class _fileviewrtryState extends State<fileviewtry>
    with TickerProviderStateMixin {
  Future<void> initState() async {
    await loadFile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                leading: BackButton(
                  color: Color(0xFF8A70BE),
                ),
                backgroundColor: Color(0xFF0F0C07),
                centerTitle: false,
                title: Text(
                  'test',
                  style: TextStyle(
                      color: Color(0xFFF8FAFC),
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                )),
            backgroundColor: Color(0xFF0F0C07),
            body: SfPdfViewer.memory(file)));
  }
}
