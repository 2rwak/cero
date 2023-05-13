import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/data_sourse/fireStore_helper.dart';
import 'package:flutter_application_1/safety_box/Photos/pView.dart';
import '../../Models/Pic.dart';
import '../safetybox.dart';
import 'package:image_picker/image_picker.dart';
import 'addphoto.dart';

class photos extends StatefulWidget {
  final String currentusername;
  const photos({super.key, required this.currentusername});

  @override
  State<photos> createState() => _photosState();
}

class _photosState extends State<photos> {
  String imageURL = "";
  String uniqueName = "";
  Pic p = Pic();
  initState() {
    fireStore_helper.setUID(widget.currentusername);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: Color(0xFF8A70BE),
                ),
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => safetybox(
                                Currentusername: widget.currentusername,
                              )));
                }),
            backgroundColor: Color(0xFF0F0C07),
            centerTitle: false,
            title: Text(
              'Photos',
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => addphoto(
                                currentusername: widget.currentusername,
                              )));
                },
              ),
              SizedBox(
                width: 40,
                height: 90,
              )
            ]),
        backgroundColor: Color(0xFF141416),
        body: Center(
            child: StreamBuilder(
          stream: fireStore_helper.readp(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              final pdata = snapshot.data;
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: pdata!.length,
                  itemBuilder: (context, index) {
                    final singleP = pdata[index];
                    File pf = File(singleP.path!);
                    return InkWell(
                      onTap: () {
                        if (singleP.pURL!.isNotEmpty)
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => pView(
                                        url: singleP.pURL!,
                                        title: singleP.no!.substring(0, 16),
                                        pid: singleP.pId!,
                                        currentusername: widget.currentusername,
                                      )));
                      },
                      child: Container(
                        margin: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                image: FileImage(pf), fit: BoxFit.cover)),
                      ),
                    );
                  });
            }
            return Center(
                child: Column(
              children: [
                SizedBox(
                  height: 120,
                ),
                Text(
                  "You have no photos yet",
                  style: TextStyle(color: Color(0xFFB7B7B7), fontSize: 20),
                ),
              ],
            ));
          },
        )));
  }
}
