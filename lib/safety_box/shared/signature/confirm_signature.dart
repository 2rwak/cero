import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flexible_toast/flutter_flexible_toast.dart';
// import 'package:flutter_application_1/safety_box/Files/shared/sharedFiles.dart';
// import 'package:fluttertoast/fluttertoast.dart';

import '../sharedFiles.dart';

class SignaturePreviewPage2 extends StatefulWidget {
  final ByteData byteData;
  final Uint8List imageBytes;
  final String Currentusername;

  const SignaturePreviewPage2(
      {super.key,
      required this.byteData,
      required this.imageBytes,
      required this.Currentusername});

  @override
  _SignaturePreviewPage2State createState() => _SignaturePreviewPage2State();
}

class _SignaturePreviewPage2State extends State<SignaturePreviewPage2> {
  Future<String> storeSignature() async {
    print("In storeSignature");

    final signature = <String, Uint8List>{
      'signature': widget.imageBytes,
    };
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.Currentusername)
        .update(signature);

    return "4";
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color(0xFF141416),
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.cancel_outlined, color: Colors.red),
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Center(
                        child: AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          backgroundColor: Color(0xFF141416),
                          title: Text(
                            'Discard',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          content: Text(
                              'Are you sure you want to discard this signature ? ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                          actions: [
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(0xFF4E5053))),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cancel',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14))),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Color(0xFFEC1F1F),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => sharedFiles(
                                                Currentusername: //               Currentusername:
                                                    widget.Currentusername,
                                              )));
                                },
                                child: Text('Discard',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14)))
                          ],
                        ),
                      );
                    });
              }),
          backgroundColor: (Color(0xFF0F0C07)),
          foregroundColor: (Color(0xFF8A70BE)),
          title: Text(
            'Confirm Signature',
            style: TextStyle(
                color: Color(0xFFF8FAFC),
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.check, color: Colors.green),
              onPressed: () async {
                print("In confirm");
                await storeSignature();
                FlutterFlexibleToast.showToast(
                  icon: ICON.SUCCESS,
                  message: "Signature is added successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  toastGravity: ToastGravity.CENTER,
                  timeInSeconds: 2,
                  backgroundColor: Color(0xFF0F0C07),
                  textColor: Colors.white,
                  fontSize: 14.0,
                );
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => sharedFiles(
                              Currentusername: //               Currentusername:
                                  widget.Currentusername,
                            )));

                // saveSignature.generatePDF(username: widget.Currentusername);
              },
            )
          ],
        ),
        body: Center(
          child: Image.memory(widget.imageBytes),
        ),
      );
}
