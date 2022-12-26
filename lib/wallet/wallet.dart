import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/passwords.dart';
import 'package:flutter_application_1/wallet/addToWallet.dart';
import 'package:flutter_application_1/data_sourse/fireStore_helper.dart';
import 'package:flutter_application_1/wallet/editWallet.dart';
import 'package:get/route_manager.dart';

class wallet extends StatefulWidget {
  final String Currentusername;

  const wallet({Key? key, required this.Currentusername}) : super(key: key);

  @override
  State<wallet> createState() => _walletState();
}

class _walletState extends State<wallet> {
  @override
  Widget build(BuildContext context) {
    int count = 0;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF0F0C07),
        centerTitle: false,
        title: Text(
          '   Hello ${widget.Currentusername} !',
          style: TextStyle(
              color: Color(0xFFF8FAFC),
              fontSize: 17,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add_outlined,
              color: Color(0xFF8A70BE),
              size: 50,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => addToWallet(
                            current: widget.Currentusername,
                          )));
            },
          ),
          SizedBox(
            width: 40,
            height: 90,
          )
        ],
      ),
      backgroundColor: Color(0xFF141416),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(
          height: 57,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 170, bottom: 10),
          child: Text(
            '  Your passwords',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.left,
          ),
        ),
        StreamBuilder<List<passwords>>(
            stream: fireStore_helper.read(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                fireStore_helper.setUID(widget.Currentusername);
                final passdata = snapshot.data;
                return Expanded(
                  child: ListView.builder(
                    itemCount: passdata!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final singlePass = passdata[index];
                      return Container(
                          child: Column(children: [
                        SizedBox(
                          height: 17,
                        ),
                        Container(
                            width: 360,
                            height: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Color(0xff1b1b1e),
                            ),
                            padding: const EdgeInsets.only(
                              left: 18,
                              right: 18,
                              top: 12,
                              bottom: 10,
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.vpn_key_outlined,
                                        color: Color(0xFF8A70BE),
                                        size: 22,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text('${singlePass.platform}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF8A70BE)))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    'UserName',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFDADADA)),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    ' ${singlePass.username}',
                                    style: TextStyle(
                                        color: Color(0xFFB7B7B7), fontSize: 13),
                                    textAlign: TextAlign.start,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(children: [
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Password',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFFDADADA)),
                                            textAlign: TextAlign.left,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            '${singlePass.password}',
                                            style: TextStyle(
                                                color: Color(0xFFB7B7B7),
                                                fontSize: 13),
                                            textAlign: TextAlign.start,
                                          )
                                        ])

                                    //here :)
                                    ,
                                    SizedBox(
                                      width: 12,
                                    ),

                                    SizedBox(
                                      width: 95,
                                    ),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          Color(0xFF8A70BE),
                                        ),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12))),
                                      ),
                                      onPressed: () {
                                        fireStore_helper
                                            .setUID(widget.Currentusername);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    editWallet(
                                                        pass: passwords(
                                                            platform: singlePass
                                                                .platform,
                                                            username: singlePass
                                                                .username,
                                                            password: singlePass
                                                                .password,
                                                            passId: singlePass
                                                                .passId),
                                                        toEdit: widget
                                                            .Currentusername)));
                                      },
                                      child: Center(
                                        child: Text(
                                          'Edit',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                          ),
                                        ),
                                      ),
                                    ),

                                    //delete
                                    SizedBox(
                                      width: 6,
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
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0)),
                                                    backgroundColor:
                                                        Color(0xFF141416),
                                                    title: Text(
                                                      'Delete',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18),
                                                    ),
                                                    content: Text(
                                                        'Are you sure you want to delete this password ? ',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16)),
                                                    actions: [
                                                      ElevatedButton(
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty
                                                                      .all(Color(
                                                                          0xFF4E5053))),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text('Cancel',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      14))),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      ElevatedButton(
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(
                                                              Color(0xFFEC1F1F),
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            fireStore_helper
                                                                .setUID(widget
                                                                    .Currentusername);
                                                            fireStore_helper
                                                                .delete(
                                                                    singlePass);

                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text('Delete',
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
                                  ]),
                                ]))
                      ]));
                      //if

                      //else
                      // else {
                      //   return Text(
                      //     'nothing',
                      //     style: TextStyle(fontSize: 60),
                      //   );
                      // }
                    },
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
                    "You have no passwords yet",
                    style: TextStyle(color: Color(0xFFB7B7B7), fontSize: 20),
                  ),
                ],
              ));
            }),
      ]),
    );
  }
}
