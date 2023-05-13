// New test2 23/1

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_application_1/safety_box/Files/shared/signature/confirm_signature.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as UI;

import 'confirm_signature.dart';

class Sign_page extends StatefulWidget {
  final String Currentusername;

  const Sign_page({super.key, required this.Currentusername});

  @override
  _Sign_pageState createState() => _Sign_pageState();
}

class _Sign_pageState extends State<Sign_page> {
  GlobalKey<SfSignaturePadState> _signaturePadStateKey = GlobalKey();
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Color(0xFF8A70BE),
          ),
          backgroundColor: Color(0xFF0F0C07),
          centerTitle: false,
          title: Text(
            'Add your signature',
            style: TextStyle(
                color: Color(0xFFF8FAFC),
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Container(
              color: Color(0xFF141416),
              child: SfSignaturePad(
                key: _signaturePadStateKey,
                // backgroundColor: Color(0xFF4E5053),
                strokeColor: Color(0xFF8A70BE),
                minimumStrokeWidth: 4,
              ),
              height: 650.0,
              width: 515.0,
            ),
          ],
        ),
        bottomSheet: Container(
          child: buildButtons(context),
          height: 50,
          width: 515.0,
        ),
      );

  buildButtons(BuildContext context) => Container(
      color: Color(0xFF0F0C07),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildClear(context),
          buildCheck(context),
        ],
      ));

  Widget buildCheck(BuildContext context) => IconButton(
        iconSize: 36,
        icon: Icon(Icons.check, color: Colors.green),
        onPressed: () async {
          UI.Image image = await _signaturePadStateKey.currentState!.toImage();
          final byteData =
              await image.toByteData(format: UI.ImageByteFormat.png);

          Uint8List imageBytes = byteData!.buffer
              .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
          Image user_sign_confirm = Image.memory(imageBytes);

          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SignaturePreviewPage2(
                byteData: byteData,
                imageBytes: imageBytes,
                Currentusername: widget.Currentusername),
          ));
        },
      );
  Widget buildClear(BuildContext context) => IconButton(
        iconSize: 36,
        icon: Icon(Icons.clear, color: Colors.red),
        onPressed: () => _signaturePadStateKey.currentState!.clear(),
      );
}
