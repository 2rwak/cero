import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class PdfViewerPage extends StatefulWidget {
  final String fileID;
  final String Currentusername;

  const PdfViewerPage(
      {Key? key, required this.fileID, required this.Currentusername})
      : super(key: key);

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  late File Pfile;
  bool isLoading = false;
  Future<void> loadNetwork() async {
    setState(() {
      isLoading = true;
    });

    var fileName;
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.Currentusername)
        .collection('files')
        .doc(widget.fileID)
        .get();

    var data2 = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.Currentusername)
        .collection('files')
        .where('fileId', isEqualTo: widget.fileID)
        .snapshots();

    fileName = data2.elementAt(0);
    var url = fileName;
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();
    var file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    setState(() {
      Pfile = file;
    });

    print(Pfile);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    loadNetwork();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flutter PDF Viewer",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: Center(
                child: PDFView(
                  filePath: Pfile.path,
                ),
              ),
            ),
    );
  }
}
