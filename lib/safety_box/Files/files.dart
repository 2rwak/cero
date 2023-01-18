import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/Models/MenuItemss.dart';
import 'package:flutter_application_1/data_sourse/fireStore_helper.dart';
import 'package:flutter_application_1/safety_box/Files/label/AddLAbel.dart';
import 'package:flutter_application_1/safety_box/Files/label/labelMenu.dart';
import 'package:flutter_application_1/safety_box/Files/shared/sharedFiles.dart';
import 'package:path/path.dart';

// Arwa 7/1
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class files extends StatefulWidget {
  final String Currentusername;

  const files({Key? key, required this.Currentusername}) : super(key: key);

  @override
  State<files> createState() => _filesState();
}

class _filesState extends State<files> with TickerProviderStateMixin {
  void initState() {
    fireStore_helper.setUID(widget.Currentusername);

    super.initState();
  }

  File? file;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  String url = "";
  String fileName = '';
  int? number;

  ///SELECT FILE
  Future selectFile() async {
    //random
    number = Random().nextInt(500);

    //pick
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = File(result.files.single.path.toString());
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

    await docRef.set({'fileName': url, 'fileId': fid});
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
  //---------------Reef 13/01--------------------------
  onSelected(BuildContext context, MenuItemss item) {
    switch (item) {
      case labelMenu.itemAdd:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddLabel(current: widget.Currentusername),
        ));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    //------Reef 13/01-------
    TabController tabController = TabController(length: 2, vsync: this);
    return Scaffold(
        appBar: AppBar(
            leading: BackButton(
              color: Color(0xFF8A70BE),
            ),
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
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 5,
            child: Container(
              width: 350,
              height: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xFF0F0C07)),
              child: TabBar(
                indicator: BoxDecoration(

                    //  TextStyle(color: Color(0xFF595961)),
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xFF8A70BE)),
                controller: tabController,
                isScrollable: true,
                labelPadding: EdgeInsets.symmetric(horizontal: 55),
                tabs: [
                  Tab(
                    child: Text(
                      'My Files',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Shared Files',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
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
              if (snapshot.hasData) {
                return Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(left: 260),
                                  //-----------------Reef 13/01--------------------------
                                  child: PopupMenuButton<MenuItemss>(
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
                                      ...labelMenu.itemsSecond
                                          .map(buildItem)
                                          .toList(),
                                    ],
                                  )),
                              IconButton(
                                  onPressed: () {},
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
                                  QueryDocumentSnapshot files_list =
                                      snapshot.data!.docs[i];

                                  return Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Container(
                                        width: 100,
                                        height: 65,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
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
                                                Icons
                                                    .insert_drive_file_outlined,
                                                color: Color(0xFF8A70BE),
                                                size: 30,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                                files_list["fileName"]
                                                    .toString()
                                                    .substring(70, 82),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white)),
                                            SizedBox(
                                              width: 95,
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Icons.sell_outlined,
                                                color: Color(0xFF8A70BE),
                                                size: 30,
                                              ),
                                              onPressed: () {
                                                //here
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
                                                                Color(
                                                                    0xFF141416),
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
                                                                  onPressed:
                                                                      () {
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
                                                                  onPressed:
                                                                      () {
                                                                    fireStore_helper
                                                                        .setUID(
                                                                            widget.Currentusername);
                                                                    fireStore_helper
                                                                        .deleteFile(
                                                                            files_list["fileId"]);

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
                                  );
                                }),
                          ),
                        ],
                      ),
                      sharedFiles()
                      //  Navigator.push(
                      //                           context,
                      //                           MaterialPageRoute(
                      //                               builder: (context) => sharedFiles()));
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
}
