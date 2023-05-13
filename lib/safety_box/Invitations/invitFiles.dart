import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../fileviewer2.dart';
import '../safetybox.dart';

class myRequests extends StatefulWidget {
  final String Currentusername;
  const myRequests({super.key, required this.Currentusername});

  @override
  State<myRequests> createState() => _myRequestsState();
}

class _myRequestsState extends State<myRequests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF141416),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(widget.Currentusername)
                  .collection("requests")
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
                                  child: Container(
                                    width: MediaQuery.of(context).size.height,
                                    height: 78,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Color(0xff1b1b1e),
                                    ),
                                    padding: const EdgeInsets.only(
                                        left: 12, right: 1, top: 8, bottom: 1),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 9),
                                              child: Icon(
                                                Icons.person_outlined,
                                                color: Color(0xFF8A70BE),
                                                size: 30,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "${files_list["owner"]}",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 80,
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Icons.file_open_outlined,
                                                color: Color(0xFF8A70BE),
                                                size: 30,
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            fileviewer2(
                                                              file_name:
                                                                  files_list![
                                                                      "fileName"],
                                                              url_user:
                                                                  files_list![
                                                                      "url"],
                                                            )));
                                              },
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 12, top: 1),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Shared file: ",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Color(0xFFB7B7B7)),
                                              ),
                                              Text(
                                                "${files_list["fileName"]}",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
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
                        "You have no files",
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
}
