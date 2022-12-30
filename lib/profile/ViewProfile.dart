import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/users.dart';
import 'package:flutter_application_1/general/LoginPage.dart';
import 'package:flutter_application_1/navigationBar.dart';
import 'package:flutter_application_1/profile/editProfile.dart';
import 'package:flutter_application_1/profile/loginHistory.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/data_sourse/fireStore_helper.dart';
import 'package:get/route_manager.dart';

class ViewProfile extends StatefulWidget {
  final String who;
  const ViewProfile({Key? key, required this.who}) : super(key: key);

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

openDialogueBox(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Are you sure you want to log out of Cero?'),
          content: SizedBox(
            width: 50,
          ),
          actions: [
            TextButton(
              onPressed: () async {
                submitAction(context);
              },
              child: Text(
                'Log Out',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 195, 7, 7),
                  fontSize: 18,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
                // Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 1, 1, 1),
                  fontSize: 18,
                  fontFamily: 'Inter',
                ),
              ),
            )
          ],
        );
      });
}

submitAction(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const LoginPage(),
    ),
  );
}

class _ViewProfileState extends State<ViewProfile> {
  String ID1 = " ";
  String phoneNo1 = " ";
  String email1 = " ";
  String username1 = " ";

  //-----------------------
  void fetch() async {
    var info = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.who)
        .get();
    setState(() {
      username1 = info.data()!['username'];
      ID1 = info.data()!['ID'];
      phoneNo1 = info.data()!['phoneNo'];
      email1 = info.data()!['email'];
    });
  }

  @override
  void initState() {
    fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.history_outlined,
            color: Color(0xFF8A70BE),
            size: 35,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => loginHistory(username: widget.who)));
          },
        ),
        backgroundColor: Color(0xFF0F0C07),
        centerTitle: false,
        title: Text(
          username1,
          style: TextStyle(
              color: Color(0xFFF8FAFC),
              fontSize: 17,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              openDialogueBox(context);
            },
            child: Icon(
              Icons.logout,
              color: Color(0xFF8A70BE),
              size: 35,
            ),
          ),
          SizedBox(
            width: 15,
            height: 90,
          )
        ],
      ),
      backgroundColor: Color(0xFF141416),
      body: Column(children: [
        SizedBox(
          height: 50,
        ),
        Text(
          'Your Profile',
          textAlign: TextAlign.start,
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: 450,
          height: 410,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Color(0xff1b1b1e),
          ),
          padding: const EdgeInsets.only(
            left: 18,
            right: 32,
            top: 25,
            bottom: 10,
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 14,
                ),
                Text(
                  'UserName',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  username1,
                  style: TextStyle(color: Color(0xFFB0B0B0), fontSize: 15),
                ),
                SizedBox(
                  height: 19,
                ),
                Text(
                  'National ID',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  ID1,
                  style: TextStyle(color: Color(0xFFB0B0B0), fontSize: 15),
                ),
                SizedBox(
                  height: 19,
                ),
                Text(
                  'Phone number',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  phoneNo1,
                  style: TextStyle(color: Color(0xFFB0B0B0), fontSize: 15),
                ),
                SizedBox(
                  height: 19,
                ),
                Text(
                  'Email',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  email1,
                  style: TextStyle(color: Color(0xFFB0B0B0), fontSize: 16),
                ),
                SizedBox(
                  height: 70,
                  width: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 35,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => editProfile(
                                        user: users(
                                      username: username1,
                                      ID: ID1,
                                      phoneNo: phoneNo1,
                                      email: email1,
                                    ))));
                      },
                      child: Container(
                          height: 40,
                          width: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color(0xFF8A70BE),
                          ),
                          child: Center(
                              child: Text(
                            'Edit',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontFamily: 'Inter',
                            ),
                          ))),
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    InkWell(
                      onTap: () {
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
                                    'Delete',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                  content: Text(
                                      'Are you sure you want to delete your profile ? ',
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
                                          fireStore_helper.setUID(widget.who);
                                          fireStore_helper.deleteUser();

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => LoginPage()));
                                        },
                                        child: Text('Delete',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14)))
                                  ],
                                ),
                              );
                            });
                      },
                      child: Container(
                          height: 40,
                          width: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color(0xFFA11E1E),
                          ),
                          child: Center(
                              child: Text(
                            'Delete',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontFamily: 'Inter',
                            ),
                          ))),
                    )
                  ],
                ),
              ]),
        ),
      ]),
    );
  }
}
