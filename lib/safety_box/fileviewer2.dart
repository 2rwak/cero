import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class fileviewer2 extends StatefulWidget {
  final String url_user;
  final String file_name;

  const fileviewer2({Key? key, required this.url_user, required this.file_name})
      : super(key: key);

  @override
  State<fileviewer2> createState() => _files2State();
}

void initState() {}

class _files2State extends State<fileviewer2> with TickerProviderStateMixin {
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
                  '${widget.file_name}',
                  style: TextStyle(
                      color: Color(0xFFF8FAFC),
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                )),
            backgroundColor: Color(0xFF0F0C07),
            body: SfPdfViewer.network(widget.url_user)));
  }
}
