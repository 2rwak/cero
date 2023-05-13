import 'package:flutter/material.dart';

import 'package:flutter_flexible_toast/flutter_flexible_toast.dart';

class invitations extends StatefulWidget {
  final String Currentusername;
  const invitations({super.key, required this.Currentusername});

  @override
  State<invitations> createState() => _invitationsState();
}

class _invitationsState extends State<invitations> {
  late final dbCollection;

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
          Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                width: MediaQuery.of(context).size.height,
                height: 65,
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
                          padding: const EdgeInsets.only(top: 9),
                          child: Icon(
                            Icons.insert_drive_file_outlined,
                            color: Color(0xFF8A70BE),
                            size: 30,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "FILE NAME",
                          style:
                              TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12, top: 3),
                          child: Row(
                            children: [
                              Text(
                                "From : ",
                                style: TextStyle(
                                    fontSize: 10, color: Color(0xFFB7B7B7)),
                              ),
                              Text(
                                "[username] ",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 65,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.check,
                            color: Color(0xFF20922B),
                            size: 35,
                          ),
                          onPressed: () {
                            FlutterFlexibleToast.showToast(
                              icon: ICON.SUCCESS,
                              message: "Invitation accepted",
                              toastLength: Toast.LENGTH_SHORT,
                              toastGravity: ToastGravity.CENTER,
                              timeInSeconds: 2,
                              backgroundColor: Color(0xFF0F0C07),
                              textColor: Colors.white,
                              fontSize: 14.0,
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Color(0xFFBD2121),
                            size: 35,
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Center(
                                    child: AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0)),
                                      backgroundColor: Color(0xFF141416),
                                      title: Text(
                                        'Reject',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                      content: Text(
                                          'Are you sure you want to reject this invitation ? ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16)),
                                      actions: [
                                        ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Color(0xFF4E5053))),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Cancel',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14))),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                Color(0xFFEC1F1F),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Yes, sure',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14)))
                                      ],
                                    ),
                                  );
                                });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1,
                    ),
                  ],
                ),
              ))
        ],
      )),
    );
  }
}
