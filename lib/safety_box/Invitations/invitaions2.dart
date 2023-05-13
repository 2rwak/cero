import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/Models/MenuItemss.dart';
import 'package:flutter_application_1/data_sourse/fireStore_helper.dart';
import 'package:flutter_application_1/safety_box/shared/signature/use_signature_guest.dart';
// import 'package:flutter_application_1/safety_box/shared/addUser.dart';

import 'package:flutter_flexible_toast/flutter_flexible_toast.dart';

import 'package:flutter_application_1/safety_box/shared/signature/use_signature.dart';
import '../../notification/LoadingIndicatorDialog.dart';
import '../fileviewer2.dart';
import 'package:flutter_application_1/email_alert/mailer2.dart' as mailer2;
import 'package:flutter_application_1/notification/notifications.dart';

class invitations2 extends StatefulWidget {
  final String Currentusername;

  const invitations2({Key? key, required this.Currentusername})
      : super(key: key);

  @override
  State<invitations2> createState() => _invitations2State();
}

class _invitations2State extends State<invitations2>
    with TickerProviderStateMixin {
  late final dbCollection;
  String ownerName_being_shared = '';
  String fileName_being_shared = '';
  @override
  Widget build(BuildContext context) {
    var dbCollection = FirebaseFirestore.instance
        .collection("shared_files")
        .doc(widget.Currentusername)
        .collection("files");

    return Scaffold(
      backgroundColor: Color(0xFF141416),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 3,
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(widget.Currentusername)
                  .collection("invitations")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  return Expanded(
                    child: Column(
                      children: [
                        Center(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, i) {
                              QueryDocumentSnapshot files_list =
                                  snapshot.data!.docs[i];
                              return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => fileviewer2(
                                                  file_name:
                                                      files_list!["fileName"],
                                                  url_user: files_list!["url"],
                                                )));
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.height,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Color(0xff1b1b1e),
                                    ),
                                    padding: const EdgeInsets.only(
                                        left: 12, right: 1, top: 4, bottom: 1),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 9),
                                              child: Icon(
                                                Icons
                                                    .insert_drive_file_outlined,
                                                color: Color(0xFF8A70BE),
                                                size: 30,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Expanded(
                                              child: Text(
                                                files_list["fileName"],
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 65,
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Icons.close,
                                                color: Color(0xFFBD2121),
                                                size: 35,
                                              ),
                                              onPressed: () {
                                                fileName_being_shared =
                                                    files_list["fileName"];
                                                ownerName_being_shared =
                                                    files_list["owner"];
                                                showingDialog(context);
                                              },
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Icons.check,
                                                color: Color(0xFF20922B),
                                                size: 35,
                                              ),
                                              onPressed: () async {
                                                await acceptInvitation(
                                                    files_list["fileName"],
                                                    files_list!["url"],
                                                    files_list["owner"]);

                                                FlutterFlexibleToast.showToast(
                                                  icon: ICON.SUCCESS,
                                                  message:
                                                      "Invitation accepted",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  toastGravity:
                                                      ToastGravity.CENTER,
                                                  timeInSeconds: 2,
                                                  backgroundColor:
                                                      Color(0xFF0F0C07),
                                                  textColor: Colors.white,
                                                  fontSize: 14.0,
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 12, top: 3),
                                          child: Row(
                                            children: [
                                              Text(
                                                "From : ",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Color(0xFFB7B7B7)),
                                              ),
                                              Text(
                                                files_list["owner"],
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 120,
                      ),
                      Text(
                        "You have no new inivitations ",
                        style:
                            TextStyle(color: Color(0xFFB7B7B7), fontSize: 20),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> acceptInvitation(
      String fileName, String url, String owner) async {
    print("in acceptInvitation 1");
    LoadingIndicatorDialog().show(context);

    await useSignature2.generatePDF(
        username: owner,
        guest: widget.Currentusername,
        pdfUrl: url,
        pdfName: fileName);
    print("in acceptInvitation 2");

    final docRef = await FirebaseFirestore.instance
        .collection("shared_files")
        .doc(owner)
        .collection("files")
        .doc("$fileName");
//  var file
    print("in acceptInvitation 3");

    await docRef.update({
      'status': 2,
      'color': 0xFF4BF15C,
    });
    print("in acceptInvitation 4");

    await mailer2.notifyOwnerAccept(widget.Currentusername, fileName, owner);
    print("in acceptInvitation 5");

    await notification.notifyOwnerAccept(
        widget.Currentusername, fileName, owner);
    print("in acceptInvitation 6");

    move_to_file(fileName, owner);
    print("in acceptInvitation 6");

    await LoadingIndicatorDialog().dismiss();
  }

  void move_to_file(String fileName, String owner) async {
    print("in move_to_file 1");

    final ref = await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.Currentusername)
        .collection("invitations")
        .doc("$fileName$owner");
    print("in move_to_file 2");

    Map<String, dynamic>? data_map = await (await ref.get()).data();
    print("in move_to_file 3");

    ref.delete();
    print("in move_to_file 4");

    FirebaseFirestore.instance
        .collection("users")
        .doc(widget.Currentusername)
        .collection("requests")
        .doc("$fileName$owner")
        .set(data_map!);
    print("in move_to_file 4");
  }

  Future<void> rejectInvitation(String fileName, String owner) async {
    LoadingIndicatorDialog().show(context);
    final ref = await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.Currentusername)
        .collection("invitations")
        .doc("$fileName$owner")
        .delete();

    final docRef = await FirebaseFirestore.instance
        .collection("shared_files")
        .doc(owner)
        .collection("files")
        .doc("$fileName");
//  var file

    await docRef.update({
      'status': 3,
      'color': 0xFFFF4D4D,
    });
    await mailer2.notifyOwnerReject(widget.Currentusername, fileName, owner);

    await notification.notifyOwnertReject(
        widget.Currentusername, fileName, owner);
    await LoadingIndicatorDialog().dismiss();

    Navigator.of(_context).pop();
  }

  late BuildContext _context;

  void showingDialog(BuildContext context) => showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          _context = context;

          return Center(
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              backgroundColor: Color(0xFF141416),
              title: Text(
                'Reject',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              content: Text(
                  'Are you sure you want to reject this invitation ? ',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              actions: [
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xFF4E5053))),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel',
                        style: TextStyle(color: Colors.white, fontSize: 14))),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color(0xFFEC1F1F),
                      ),
                    ),
                    onPressed: () async {
                      await rejectInvitation(
                        fileName_being_shared,
                        ownerName_being_shared,
                      );

                      FlutterFlexibleToast.showToast(
                        icon: ICON.CLOSE,
                        message: "Rejected",
                        toastLength: Toast.LENGTH_SHORT,
                        toastGravity: ToastGravity.CENTER,
                        timeInSeconds: 2,
                        backgroundColor: Color(0xFF0F0C07),
                        textColor: Colors.white,
                        fontSize: 14.0,
                      );
                    },
                    child: Text('Yes, sure',
                        style: TextStyle(color: Colors.white, fontSize: 14)))
              ],
            ),
          );
        },
      );
}
