import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data_sourse/fireStore_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_flexible_toast/flutter_flexible_toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../Models/Pic.dart';
import '../../notification/LoadingIndicatorDialog.dart';

class addphoto extends StatefulWidget {
  final String currentusername;
  const addphoto({super.key, required this.currentusername});

  @override
  State<addphoto> createState() => _ADDphotosState();
}

class _ADDphotosState extends State<addphoto> {
  var path = "";
  var no;
  late final String userid = fireStore_helper.getUID();

  CollectionReference _reference =
      FirebaseFirestore.instance.collection('photos');
  String imageUrl = '';
  String uniqueFileName = '';
  Pic p = Pic();
  File? _image;
  initState() {
    super.initState();
  }

  Future getImage() async {
    LoadingIndicatorDialog().show(context);
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    await LoadingIndicatorDialog().dismiss();
    if (image == null) return;
    final imageTemporry = File(image.path);
    setState(() {
      this._image = imageTemporry;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: BackButton(color: Color(0xFF8A70BE)),
        backgroundColor: Color(0xFF0F0C07),
        centerTitle: false,
        title: Text(
          'Upload Photo',
          style: TextStyle(
              color: Color(0xFFF8FAFC),
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Color(0xFF141416),
      body: Center(
        child: Column(children: [
          SizedBox(
            height: 100,
            width: 300,
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: _image != null
                ? Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: Image.file(
                      _image!,
                      width: 300,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  )
                : InkWell(
                    onTap: () {
                      getImage();
                    },
                    child: Image(
                      image: AssetImage('assets/Add.png'),
                      width: 300,
                      height: 300,
                    ),
                  ),
          ),
          SizedBox(
            height: 50,
            width: 100,
          ),

          InkWell(
            onTap: () {
              getImage();
            },
            child: Container(
                height: 40,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: Color(0xFF8A70BE),
                ),
                child: Center(
                    child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Icon(
                        Icons.ios_share_outlined,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      'Upload photo',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ))),
          ),

          //-------------------------------------------//
          SizedBox(
            height: 36,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            InkWell(
              onTap: () {
                if (_image != null) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Center(
                          child: AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            backgroundColor: Color(0xFF141416),
                            title: Text(
                              'Cancel',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            content: Text(
                                'Are you sure you don\'t want to upload this photo ? ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                            actions: [
                              ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Color(0xFF4E5053))),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('No',
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
                                    Navigator.pop(context);
                                    r2();
                                  },
                                  child: Text('Yes, cancel',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14)))
                            ],
                          ),
                        );
                      });
                } else
                  Navigator.pop(context);
              },
              child: Container(
                height: 41,
                width: 94,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xFF4E5053),
                ),
                child: Center(
                  child: Text(
                    'Cancel',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 40,
            ),
            SizedBox(
              height: 41,
              width: 94,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color(0xFF8A70BE),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
                onPressed: () async {
                  if (_image == null) {
                    FlutterFlexibleToast.showToast(
                      icon: ICON.ERROR,
                      message: "Please choose photo to upload",
                      toastLength: Toast.LENGTH_SHORT,
                      toastGravity: ToastGravity.CENTER,
                      timeInSeconds: 4,
                      backgroundColor: Color(0xFF0F0C07),
                      textColor: Colors.white,
                      fontSize: 14.0,
                    );
                    return;
                  } else {
                    //Import dart:core
                    uniqueFileName = DateTime.now().toString();
                    no = uniqueFileName;
                    /*Step 2: Upload to Firebase storage*/
                    //Install firebase_storage
                    //Import the library

                    //Get a reference to storage root
                    Reference referenceRoot = FirebaseStorage.instance.ref();
                    Reference referenceDirImages =
                        referenceRoot.child('images');

                    //Create a reference for the image to be stored
                    Reference referenceImageToUpload =
                        referenceDirImages.child(uniqueFileName);
                    //Handle errors/success
                    try {
                      //Store the file
                      LoadingIndicatorDialog().show(context);
                      await referenceImageToUpload.putFile(File(_image!.path));
                      await LoadingIndicatorDialog().dismiss();
                      //Success: get the download URL
                      imageUrl = await referenceImageToUpload.getDownloadURL();
                      path = _image!.path;
                    } catch (error) {
                      //Some error occurred
                    }

                    // if (_image == null) {
                    //   FlutterFlexibleToast.showToast(
                    //     icon: ICON.ERROR,
                    //     message: "Please choose photo to upload",
                    //     toastLength: Toast.LENGTH_SHORT,
                    //     toastGravity: ToastGravity.CENTER,
                    //     timeInSeconds: 4,
                    //     backgroundColor: Color(0xFF0F0C07),
                    //     textColor: Colors.white,
                    //     fontSize: 14.0,
                    //   );
                    // }

                    //Create a Map of data
                    Map<String, String> dataToSend = {
                      'image': imageUrl,
                    };

                    //Add a new item
                    _reference.add(dataToSend);
                    addingP();

                    Navigator.pop(context);
                  }
                },
                child: Center(
                  child: Text(
                    'Add',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
            ),
          ])
        ]),
      ),
    );
  }

  void addingP() async {
    setState(() {});
    p.pId = uniqueFileName;
    p.pURL = imageUrl;
    p.path = path;
    p.no = no;

    fireStore_helper.setUID(widget.currentusername);
    fireStore_helper
        .uploadPic(new Pic(pId: p.pId, pURL: p.pURL, path: p.path, no: p.no));
  }

  void r2() {
    Navigator.pop(context);
  }
}
