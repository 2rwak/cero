import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/Models/MenuItemss.dart';
import 'package:flutter_application_1/data_sourse/fireStore_helper.dart';
import 'package:flutter_application_1/safety_box/fileviewer.dart';
// import 'package:flutter_application_1/safety_box/shared/addUser.dart';

import 'package:flutter_flexible_toast/flutter_flexible_toast.dart';

import 'package:flutter_application_1/safety_box/shared/signature/use_signature.dart';
import '../../notification/LoadingIndicatorDialog.dart';
import '../fileviewer2.dart';
import '../safetybox.dart';
import 'signature/signing_page.dart';
import 'package:flutter_application_1/email_alert/mailer2.dart' as mailer2;
import 'package:flutter_application_1/notification/notifications.dart';

class sharedFiles extends StatefulWidget {
  final String Currentusername;

  const sharedFiles({Key? key, required this.Currentusername})
      : super(key: key);

  @override
  State<sharedFiles> createState() => _sharedFilesState();
}

class _sharedFilesState extends State<sharedFiles>
    with TickerProviderStateMixin {
  TextEditingController GuestUserNameController = TextEditingController();
  String fileName_being_shared = '';
  String url = "";

  void initState() {
    fireStore_helper.setUID(widget.Currentusername);
    super.initState();
  }

  ///SELECT FILE
  Future selcetFileFromLocal() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = File(result.files.single.path.toString());
    String filePath = path.toString();
    int Last = filePath.lastIndexOf('/');
    String fileSub = filePath.substring(Last + 1);
    String fileN = fileSub.replaceAll("\'", " ");
    var file = path.readAsBytesSync();
    //upload
    var FileExt = FirebaseStorage.instance.ref().child(fileN);
    UploadTask task = FileExt.putData(file);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref.getDownloadURL();
    //upload to firestore

    final docRef = await FirebaseFirestore.instance
        .collection("shared_files")
        .doc(widget.Currentusername)
        .collection("files")
        .doc(fileN);
    await docRef.set({
      'fileName': fileN,
      'fileId': url,
      'status': -1,
      'color': 0xFFFFFFFF,
      'guest_username': "none"
    });
  }

  Future<bool> checkSignatureIsSet() async {
    var info = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.Currentusername)
        .get();
    var bytes = info.data()?['signature'];
    if (bytes == null) return false;
    return true;
  }

  PopupMenuItem<MenuItemss> buildItem(MenuItemss item) =>
      PopupMenuItem<MenuItemss>(
          value: item,
          child: Row(
            children: [
              Icon(
                item.icon,
                color: Color(0xFF8A70BE),
                size: 35,
              ),
              const SizedBox(
                width: 2,
              ),
              Text(
                item.text,
                style: TextStyle(
                    color: Color(0xFF8A70BE),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Color(0xFF8A70BE),
                ),
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => safetybox(
                                Currentusername: widget.Currentusername,
                              )));
                }),
            backgroundColor: Color(0xFF0F0C07),
            centerTitle: false,
            title: Text(
              'Shared Files',
              style: TextStyle(
                  color: Color(0xFFF8FAFC),
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.file_download_outlined,
                  color: Color(0xFF8A70BE),
                  size: 45,
                ),
                onPressed: () async {
                  LoadingIndicatorDialog().show(context);
                  await selcetFileFromLocal();
                  LoadingIndicatorDialog().dismiss();
                },
              ),
              SizedBox(
                width: 40,
                height: 90,
              )
            ]),
        backgroundColor: Color(0xFF141416),
        body: Center(
            child: Column(children: [
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 3,
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("shared_files")
                .doc(widget.Currentusername)
                .collection("files")
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                return Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 9),
                            child: Container(
                              height: 100,
                              width: 110,
                              decoration: BoxDecoration(
                                color: Color(0xff1b1b1e),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.circle,
                                        size: 15,
                                        color: Color(0xFFFFFFFF),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        "Not signed",
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.circle,
                                        size: 15,
                                        color: Color(0xFF8A70BE),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        "Signed",
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.circle,
                                        size: 15,
                                        color: Color(0xFFFE965C),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text("Pending",
                                          style: TextStyle(color: Colors.white))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.circle,
                                        size: 15,
                                        color: Color(0xFF4BF15C),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text("Accepted",
                                          style: TextStyle(color: Colors.white))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.circle,
                                        size: 15,
                                        color: Color(0xFFFF4D4D),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text("Rejected",
                                          style: TextStyle(color: Colors.white))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 148, bottom: 10, top: 4),
                              child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => Sign_page(
                                                  Currentusername: //               Currentusername:
                                                      widget.Currentusername,
                                                )));
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 110,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Color(0xFF0F0C07),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xff1b1b1e),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Icon(
                                          Icons.add_outlined,
                                          size: 20,
                                          color: Color(0xFF8A70BE),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          "signature",
                                          style: TextStyle(
                                              color: Color(0xFF8A70BE),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13),
                                        )
                                      ],
                                    ),
                                  ))),
                        ],
                      ),
                      SizedBox(
                        height: 9,
                      ),
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, i) {
                              QueryDocumentSnapshot files_list =
                                  snapshot.data!.docs[i];

                              return Padding(
                                padding: const EdgeInsets.only(top: 13),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => fileviewer2(
                                                  file_name:
                                                      files_list!["fileName"],
                                                  url_user:
                                                      files_list!["fileId"],
                                                )));
                                  },
                                  child: Container(
                                      width: 100,
                                      height: 125,
                                      // CHANGE hete arwa
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Color(0xff1b1b1e),
                                      ),
                                      padding: const EdgeInsets.only(
                                          left: 12,
                                          right: 1,
                                          top: 1,
                                          bottom: 0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 1, left: 12),
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons
                                                      .insert_drive_file_outlined,
                                                  color: Color(
                                                      files_list['color']),
                                                  size: 30,
                                                ),
                                                onPressed: () {},
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  files_list["fileName"]
                                                  // .toString()
                                                  // .substring(70, 82)
                                                  ,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, top: 10),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Shared with: ${files_list['guest_username']}",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Color(0xFFB7B7B7)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 210.0, top: 0),
                                            child: Row(
                                              children: [
                                                IconButton(
                                                    icon: Icon(
                                                      Icons
                                                          .person_add_alt_outlined,
                                                      color: Color(0xFF8A70BE),
                                                      size: 32,
                                                    ),
                                                    onPressed: () async {
                                                      if (files_list[
                                                              "status"] ==
                                                          0) {
                                                        fileName_being_shared =
                                                            files_list[
                                                                "fileName"];
                                                        openDialog(context);
                                                      } else if (files_list[
                                                              "status"] ==
                                                          1) {
                                                        FlutterFlexibleToast
                                                            .showToast(
                                                          icon: ICON.SUCCESS,
                                                          message:
                                                              "File Inivitation has been sent",
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          toastGravity:
                                                              ToastGravity
                                                                  .CENTER,
                                                          timeInSeconds: 2,
                                                          backgroundColor:
                                                              Color(0xFF0F0C07),
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 14.0,
                                                        );
                                                      } else if (files_list[
                                                              "status"] ==
                                                          -1) {
                                                        FlutterFlexibleToast
                                                            .showToast(
                                                          icon: ICON.CLOSE,
                                                          message:
                                                              "File is not signed",
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          toastGravity:
                                                              ToastGravity
                                                                  .CENTER,
                                                          timeInSeconds: 2,
                                                          backgroundColor:
                                                              Color(0xFF0F0C07),
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 14.0,
                                                        );
                                                      }
                                                    }),

                                                IconButton(
                                                  icon: Icon(
                                                    Icons.brush_outlined,
                                                    color: Color(0xFF8A70BE),
                                                    size: 30,
                                                  ),
                                                  onPressed: () async {
                                                    if (await checkSignatureIsSet()) {
                                                      if (files_list[
                                                              "status"] ==
                                                          -1) {
                                                        LoadingIndicatorDialog()
                                                            .show(context);

                                                        await useSignature.generatePDF(
                                                            username: widget
                                                                .Currentusername,
                                                            pdfUrl: files_list![
                                                                "fileId"],
                                                            pdfName: files_list![
                                                                "fileName"]);
                                                        await LoadingIndicatorDialog()
                                                            .dismiss();

                                                        FlutterFlexibleToast
                                                            .showToast(
                                                          icon: ICON.SUCCESS,
                                                          message: "Signed",
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          toastGravity:
                                                              ToastGravity
                                                                  .CENTER,
                                                          timeInSeconds: 2,
                                                          backgroundColor:
                                                              Color(0xFF0F0C07),
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 14.0,
                                                        );
                                                      } else {
                                                        FlutterFlexibleToast
                                                            .showToast(
                                                          icon: ICON.WARNING,
                                                          message:
                                                              "File is already singed",
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          toastGravity:
                                                              ToastGravity
                                                                  .CENTER,
                                                          timeInSeconds: 2,
                                                          backgroundColor:
                                                              Color(0xFF0F0C07),
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 14.0,
                                                        );
                                                      }
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                              'Signature is not set'),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                                // DELETE new code 4 / 2

                                                IconButton(
                                                    icon: Icon(
                                                      Icons.delete_outlined,
                                                      color: Color(0xFFEC1F1F),
                                                      size: 32,
                                                    ),
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return Center(
                                                              child:
                                                                  AlertDialog(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12.0)),
                                                                backgroundColor:
                                                                    Color(
                                                                        0xFF141416),
                                                                title: Text(
                                                                  'Delete',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          18),
                                                                ),
                                                                content: Text(
                                                                    'Are you sure you want to delete this file ? ',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            16)),
                                                                actions: [
                                                                  ElevatedButton(
                                                                      style: ButtonStyle(
                                                                          backgroundColor: MaterialStateProperty.all(Color(
                                                                              0xFF4E5053))),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: Text(
                                                                          'Cancel',
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 14))),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  ElevatedButton(
                                                                      style:
                                                                          ButtonStyle(
                                                                        backgroundColor:
                                                                            MaterialStateProperty.all(
                                                                          Color(
                                                                              0xFFEC1F1F),
                                                                        ),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        fireStore_helper
                                                                            .setUID(widget.Currentusername);
                                                                        fireStore_helper
                                                                            .deleteFileShared(files_list["fileName"]);

                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: Text(
                                                                          'Delete',
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 14)))
                                                                ],
                                                              ),
                                                            );
                                                          });
                                                    })
                                              ],
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                              );
                            }),
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
                      "You have no shared files yet",
                      style: TextStyle(color: Color(0xFFB7B7B7), fontSize: 20),
                    ),
                  ],
                ),
              );
            },
          )
        ])));
  }

  late BuildContext _context;

  Future<String?> openDialog(BuildContext context) => showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        _context = context;

        return AlertDialog(
          backgroundColor: Color(0xFF141416),
          title: Text('Enter guest username',
              style: TextStyle(
                color: Color(0xFFF8FAFC),
              )),
          content: TextField(
              controller: GuestUserNameController,
              autofocus: true,
              cursorColor: Color(0xFF8A70BE),
              style: TextStyle(
                color: Colors.white,
                overflow: TextOverflow.ellipsis,
                fontSize: 19,
              ),
              decoration: InputDecoration(
                  hintText: 'Guest username',
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF616161),
                    overflow: TextOverflow.ellipsis,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF8A70BE)),
                  ))),
          actions: [
            TextButton(
              child: Text('cancel'),
              onPressed: submit2,
              style: TextButton.styleFrom(
                foregroundColor: Color(0xFF8A70BE),
              ),
            ),
            TextButton(
              child: Text('Send'),
              onPressed: submit,
              style: TextButton.styleFrom(
                foregroundColor: Color(0xFF8A70BE),
              ),
            ),
          ],
        );
      });

  Future<void> submit() async {
    if (GuestUserNameController.text.isEmpty) {
      FlutterFlexibleToast.showToast(
        icon: ICON.CLOSE,
        message: "This field is required",
        toastLength: Toast.LENGTH_SHORT,
        toastGravity: ToastGravity.CENTER,
        timeInSeconds: 2,
        backgroundColor: Color(0xFF0F0C07),
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } else if (GuestUserNameController.text == widget.Currentusername) {
      FlutterFlexibleToast.showToast(
        icon: ICON.CLOSE,
        message: "You cannot invite yourself",
        toastLength: Toast.LENGTH_SHORT,
        toastGravity: ToastGravity.CENTER,
        timeInSeconds: 2,
        backgroundColor: Color(0xFF0F0C07),
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } else if (await usernameCheck(GuestUserNameController.text) == false) {
      LoadingIndicatorDialog().show(context);

      await inviteUser();
      GuestUserNameController.clear();
      await LoadingIndicatorDialog().dismiss();

      Navigator.of(_context).pop(GuestUserNameController.text);
      FlutterFlexibleToast.showToast(
        icon: ICON.SUCCESS,
        message: "Invitation sent",
        toastLength: Toast.LENGTH_SHORT,
        toastGravity: ToastGravity.CENTER,
        timeInSeconds: 2,
        backgroundColor: Color(0xFF0F0C07),
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } else {
      FlutterFlexibleToast.showToast(
        icon: ICON.CLOSE,
        message: "username does not exist",
        toastLength: Toast.LENGTH_SHORT,
        toastGravity: ToastGravity.CENTER,
        timeInSeconds: 2,
        backgroundColor: Color(0xFF0F0C07),
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }

  void submit2() {
    GuestUserNameController.clear();
    Navigator.of(_context).pop();
  }

  Future<bool> usernameCheck(String username) async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .get();

    return result.docs.isEmpty;
  }

  inviteUser() async {
    final docRef = await FirebaseFirestore.instance
        .collection("shared_files")
        .doc(widget.Currentusername)
        .collection("files")
        .doc(fileName_being_shared);
//  var file
    await docRef.update({
      'status': 1,
      'guest_username': GuestUserNameController.text,
      'color': 0xFFFE965C,
    });
    var x = (await docRef.get()).data();
    final user_info = <String, dynamic>{
      'fileName': fileName_being_shared,
      'flag': 0,
      'owner': widget.Currentusername,
      'url': x!["fileId"],
    };
    Random n = new Random(3);

    await FirebaseFirestore.instance
        .collection("users")
        .doc(GuestUserNameController.text)
        .collection("invitations")
        .doc("$fileName_being_shared${widget.Currentusername}")
        .set(user_info);
    await mailer2.notifyGuestShared(widget.Currentusername,
        fileName_being_shared, GuestUserNameController.text);
    await notification.notifyGuestShared(widget.Currentusername,
        fileName_being_shared, GuestUserNameController.text);
  }
}
