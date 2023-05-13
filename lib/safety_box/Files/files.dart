import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/Models/MenuItemss.dart';
import 'package:flutter_application_1/Models/filesModel.dart';
import 'package:flutter_application_1/Models/labels.dart';
import 'package:flutter_application_1/data_sourse/fireStore_helper.dart';
import 'package:flutter_application_1/safety_box/Files/label/AddLabel.dart';
import '../fileviewer2.dart';
import '../safetybox.dart';
import 'label/EditLabel.dart';

class files extends StatefulWidget {
  final String Currentusername;

  const files({Key? key, required this.Currentusername}) : super(key: key);

  @override
  State<files> createState() => _filesState();
}

class _filesState extends State<files> with TickerProviderStateMixin {
  initState() {
    fireStore_helper.setUID(widget.Currentusername);

    super.initState();
  }

  bool isDescending = false;
  File? file;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  String url = "";
  String fileName = '';
  int? number;
  var selectedLabel;

  QueryDocumentSnapshot? files_list;

  ///SELECT FILE
  Future selectFile() async {
    //random
    number = Random().nextInt(500);

    //pick
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = File(result.files.single.path.toString());
    String filePath = path.toString();
    int Last = filePath.lastIndexOf('/');
    String fileSub = filePath.substring(Last + 1);
    String fileN = fileSub.replaceAll("\'", " ");
    var file = path.readAsBytesSync();
    String name = DateTime.now().millisecondsSinceEpoch.toString();

    // setState(() => file = File(path));
    // uploadFile();

    //upload
    var FileExt = FirebaseStorage.instance.ref().child(name);
    UploadTask task = FileExt.putData(file);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref.getDownloadURL();

    //upload to firestore
    final filesCollection = FirebaseFirestore.instance
        .collection("users")
        .doc(widget.Currentusername)
        .collection("files");
    print(widget.Currentusername);
    final docRef = filesCollection.doc(name);
    final fid = docRef.id;
//  var file
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.Currentusername)
        .collection('files')
        .get();

    for (var queryDocumentSnapshot in data.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      var file = data['fileName'];
    }

    await docRef
        .set({'fileName': fileN, 'fileId': url, 'fileColor': 0xFF8A70BE});
  }

  ///UPLOAD FILE
  // Future uploadFile() async {
  //   if (file == null) return;

  //   final fileName = basename(file!.path);
  //   final destination = 'files/$fileName';

  //   task = FirebaseApi.uploadFile(destination, file!);

  //   if (task == null) return;

  //   final snapshot = await task!.whenComplete(() {});
  //   final urlDownload = await snapshot.ref.getDownloadURL();

  //   print('Download-Link: $urlDownload');
  // }

  Future getFiles() async {
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.Currentusername)
        .collection('files')
        .get();
    String fid = '';
    for (var queryDocumentSnapshot in data.docs) {
      Map<String, dynamic> data2 = queryDocumentSnapshot.data();
      fid = data2['fileId'];
      print('fid' + fid);
    }
  }

  //----------------------Reef 13/01-------------------------
  PopupMenuItem<MenuItemss> buildItem(MenuItemss item) =>
      PopupMenuItem<MenuItemss>(
          value: item,
          child: Row(
            children: [
              Icon(
                item.icon,
                color: Color(item.color),
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

  PopupMenuItem<MenuItemss> buildItem2(MenuItemss item) =>
      PopupMenuItem<MenuItemss>(
        value: item,
        child: Row(children: [
          Icon(Icons.circle, color: Color(item.color), size: 30),
          SizedBox(
            width: 2,
          ),
          Text(
            item.text,
            style: TextStyle(color: Colors.white, fontSize: 16),
          )
        ]),
      );
  //---------------Reef 13/01--------------------------
  onSelected(BuildContext context, MenuItemss item) {
    if (item.text.startsWith(" ")) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddLabel(
          current: widget.Currentusername,
          lname: item.text,
          lcolor: item.color,
          lid: item.lID,
        ),
      ));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EditLabel(
          current: widget.Currentusername,
          lname: item.text,
          lcolor: item.color,
          lid: item.lID,
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (true) {
      addinglabelss();
      print("inside if");
    }
    //------Reef 13/01-------

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
              'Files',
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
                onPressed: () {
                  selectFile();
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
                .collection("users")
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
                            padding: const EdgeInsets.only(left: 260),
                            child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(widget.Currentusername)
                                    .collection('Labels')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  var labelcolorr;

                                  if (!snapshot.hasData) {
                                    return Text(
                                      "Loading...",
                                      style: TextStyle(color: Colors.white),
                                    );
                                  } else {
                                    List<MenuItemss> labelList = [];
                                    for (int i = 0;
                                        i < snapshot.data!.docs.length;
                                        i++) {
                                      DocumentSnapshot snapl =
                                          snapshot.data!.docs[i];
                                      var lname = snapl['labelName'];
                                      labelcolorr = snapl['labelColor'];
                                      var labelid = snapl['Lid'];
                                      labelList.add(MenuItemss(
                                          text: lname,
                                          icon: Icons.circle,
                                          color: labelcolorr,
                                          lID: labelid));
                                    }
                                    return PopupMenuButton<MenuItemss>(
                                      onSelected: (item) =>
                                          onSelected(context, item),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0))),
                                      icon: Icon(
                                        Icons.style_outlined,
                                        size: 38,
                                        color: Color(0xFF8A70BE),
                                      ),
                                      color: Color(0xFF0F0C07),
                                      itemBuilder: (context) => [
                                        ...labelList.map(buildItem2).toList(),
                                        // PopupMenuDivider(),
                                        // ...labelMenu.itemsSecond
                                        //     .map(buildItem)
                                        //     .toList(),
                                      ],
                                    );
                                  }
                                }),
                            //-----------------Reef 13/01--------------------------
                          ),
                          IconButton(
                              onPressed: () =>
                                  setState(() => isDescending = !isDescending),
                              icon: Icon(
                                Icons.sort_outlined,
                                color: Color(0xFF8A70BE),
                                size: 40,
                              )),
                        ],
                      ),
                      Center(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, i) {
                              // final sortedDocs = snapshot.data!.docs
                              //   ..sort((doc1, doc2) => isDescending
                              //       ? doc2['fileName']
                              //           .compareTo(doc1['fileName'])
                              //       : doc1['fileName']
                              //           .compareTo(doc2['fileName']));
                              // final singleFile = sortedDocs[i];
                              final files_list = snapshot.data!.docs[i];

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
                                                  url_user:
                                                      files_list!["fileId"],
                                                )));
                                  },
                                  child: Container(
                                      width: 100,
                                      height: 65,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Color(0xff1b1b1e),
                                      ),
                                      padding: const EdgeInsets.only(
                                          left: 12,
                                          right: 1,
                                          top: 1,
                                          bottom: 1),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 1, left: 8),
                                            child: Icon(
                                              Icons.insert_drive_file_outlined,
                                              color: Color(
                                                  files_list["fileColor"]),
                                              size: 30,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(
                                              files_list["fileName"],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          // IconButton(
                                          //   icon: Icon(
                                          //     Icons.sell_outlined,
                                          //     color: Color(0xFF8A70BE),
                                          //     size: 30,
                                          //   ),
                                          //   onPressed: () {

                                          //   },
                                          // ),
                                          StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(widget.Currentusername)
                                                .collection('Labels')
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              var lc;
                                              if (!snapshot.hasData) {
                                                return Text("Loading...");
                                              } else {
                                                List<DropdownMenuItem> labels =
                                                    [];

                                                for (int i = 0;
                                                    i <
                                                        snapshot
                                                            .data!.docs.length;
                                                    i++) {
                                                  DocumentSnapshot snap =
                                                      snapshot.data!.docs[i];
                                                  var ln = snap['labelName'];
                                                  lc = snap['labelColor'];
                                                  if (!snap['labelName']
                                                      .toString()
                                                      .startsWith(" ")) {
                                                    if (files_list[
                                                                "fileColor"] !=
                                                            0xFF8A70BE &&
                                                        i == 0) {
                                                      labels
                                                          .add(DropdownMenuItem(
                                                        value: 0xFF8A70BE,
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "Unassign",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFF8A70BE),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ));
                                                    }
                                                    labels.add(DropdownMenuItem(
                                                      value: snap['labelColor']
                                                          as int,
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.circle,
                                                            color: Color(lc),
                                                            size: 20,
                                                          ),
                                                          SizedBox(
                                                            width: 3,
                                                          ),
                                                          Text(
                                                            ln,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16),
                                                          ),
                                                        ],
                                                      ),
                                                    ));
                                                  }
                                                }
                                                return SizedBox(
                                                  height: 50,
                                                  width: 90,
                                                  child:
                                                      DropdownButtonHideUnderline(
                                                    child: DropdownButton(
                                                      menuMaxHeight: 250,
                                                      dropdownColor:
                                                          Color(0xFF141416),
                                                      isExpanded: true,
                                                      iconSize: 28,
                                                      value: selectedLabel,
                                                      icon: Icon(
                                                        Icons.sell_outlined,
                                                        color:
                                                            Color(0xFF8A70BE),
                                                        size: 30,
                                                      ),
                                                      items: labels,
                                                      onChanged: (chosenlabel) {
                                                        setState(() {
                                                          // selectedLabel =
                                                          //     chosenlabel;

                                                          fireStore_helper
                                                              .setUID(widget
                                                                  .Currentusername);
                                                          fireStore_helper.updateFileColor(filesModel(
                                                              fileName:
                                                                  files_list[
                                                                      "fileName"],
                                                              fileId:
                                                                  files_list[
                                                                      "fileId"],
                                                              fileColor:
                                                                  chosenlabel));
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
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
                                                        child: AlertDialog(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0)),
                                                          backgroundColor:
                                                              Color(0xFF141416),
                                                          title: Text(
                                                            'Delete',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 18),
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
                                                                    backgroundColor:
                                                                        MaterialStateProperty.all(Color(
                                                                            0xFF4E5053))),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text(
                                                                    'Cancel',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            14))),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            ElevatedButton(
                                                                style:
                                                                    ButtonStyle(
                                                                  backgroundColor:
                                                                      MaterialStateProperty
                                                                          .all(
                                                                    Color(
                                                                        0xFFEC1F1F),
                                                                  ),
                                                                ),
                                                                onPressed: () {
                                                                  fireStore_helper
                                                                      .setUID(widget
                                                                          .Currentusername);
                                                                  fireStore_helper
                                                                      .deleteFile(
                                                                          files_list[
                                                                              "fileId"]);

                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text(
                                                                    'Delete',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            14)))
                                                          ],
                                                        ),
                                                      );
                                                    });
                                              })
                                        ],
                                      )),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),

                  //Navigator.push(
                  //context,
                  //MaterialPageRoute(
                  // builder: (context) => sharedFiles()));
                );
              }
              return Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 120,
                    ),
                    Text(
                      "You have no files yet",
                      style: TextStyle(color: Color(0xFFB7B7B7), fontSize: 20),
                    ),
                  ],
                ),
              );
            },
          )
        ])));
  }

  addinglabelss() async {
    List<Color> c = [
      Color(0xFFFF4D4D),
      Color(0xFFFE965C),
      Color(0xFFFFF066),
      Color(0xFF4BF15C),
      Color(0xFF3E67CF),
      Color(0xFF8700F1),
      Color(0xFFFFFFFF),
      Color(0xFF898989),
      Color(0xFF69E4EC)
    ];
    QuerySnapshot<Map<String, dynamic>> labelsColl = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(widget.Currentusername)
        .collection('Labels')
        .get();

    if (labelsColl.docs.isEmpty) {
      for (int i = 0; i < c.length; i++) {
        fireStore_helper.createLabel(labels(
          labelName: " ",
          LabelColor: c[i].value,
        ));
      }
    }
  }

  checking() {}
}
