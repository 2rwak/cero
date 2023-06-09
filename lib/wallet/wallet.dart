import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Models/passwords.dart';
import 'package:flutter_application_1/wallet/addToWallet.dart';
import 'package:flutter_application_1/data_sourse/fireStore_helper.dart';
import 'package:flutter_application_1/wallet/editWallet.dart';

class wallet extends StatefulWidget {
  final String Currentusername;

  const wallet({Key? key, required this.Currentusername}) : super(key: key);

  @override
  State<wallet> createState() => _walletState();
}

class _walletState extends State<wallet> {
  bool flag = true;
  bool isVisible = true;
  String name = "";

  void initState() {
    fireStore_helper.setUID(widget.Currentusername);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode cuurentFocus = FocusScope.of(context);
        if (!cuurentFocus.hasPrimaryFocus) {
          cuurentFocus.unfocus();
        }
      },
      child: Scaffold(
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
            height: 35,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 220, bottom: 19),
            child: Text(
              'Passwords',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: SizedBox(
              width: 360,
              height: 55,
              child: TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.deny(" "),
                ],
                style: TextStyle(color: Colors.white, fontSize: 18),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search_outlined,
                    size: 30,
                    color: Color(0xFF616161),
                  ),
                  hintText: 'Search by platform',
                  hintStyle: TextStyle(fontSize: 16, color: Color(0xFF616161)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Color(0xff616161),
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Color(0xFF8A70BE))),
                ),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          StreamBuilder<List<passwords>>(
              stream: fireStore_helper.read(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  if (flag) {
                    fireStore_helper.setUID(widget.Currentusername);
                    final passdata = snapshot.data;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: passdata!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final singlePass = passdata[index];
                          if (name.isEmpty) {
                            return Container(
                                child: Column(children: [
                              SizedBox(
                                height: 17,
                              ),
                              Container(
                                  width: 360,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Color(0xff1b1b1e),
                                  ),
                                  padding: const EdgeInsets.only(
                                    left: 18,
                                    right: 18,
                                    top: 4,
                                  ),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                    color: Color(0xFF8A70BE))),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 1),
                                              child: IconButton(
                                                  onPressed: () {
                                                    Clipboard.setData(
                                                        ClipboardData(
                                                            text: singlePass
                                                                .password));

                                                    Fluttertoast.showToast(
                                                      msg: "Password copied",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      timeInSecForIosWeb: 2,
                                                      backgroundColor:
                                                          Color(0xFF0F0C07),
                                                      textColor: Colors.white,
                                                      fontSize: 14.0,
                                                    );
                                                  },
                                                  icon: Icon(
                                                    Icons.copy,
                                                    size: 25,
                                                    color: Color(0xFF8A70BE),
                                                  )),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 1,
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
                                              color: Color(0xFFB7B7B7),
                                              fontSize: 13),
                                          textAlign: TextAlign.start,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 0),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Password',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFFDADADA)),
                                                textAlign: TextAlign.left,
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  setState(() {});
                                                  isVisible = !isVisible;
                                                },
                                                icon: Icon(
                                                  isVisible
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  color: Color(0xff616161),
                                                  size: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 0),
                                          child: Row(
                                            children: [
                                              Visibility(
                                                visible: isVisible,
                                                child: Expanded(
                                                  child: Text(
                                                    count(singlePass.password
                                                        .toString()
                                                        .length),
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFFB7B7B7),
                                                        fontSize: 13),
                                                    textAlign: TextAlign.start,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                replacement: Expanded(
                                                  child: Text(
                                                    '${singlePass.password}',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFFB7B7B7),
                                                        fontSize: 13),
                                                    textAlign: TextAlign.start,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),

                                              SizedBox(
                                                width: 70,
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.edit_outlined,
                                                  color: Color.fromARGB(
                                                      255, 143, 146, 151),
                                                  size: 32,
                                                ),
                                                onPressed: () {
                                                  fireStore_helper.setUID(
                                                      widget.Currentusername);
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => editWallet(
                                                              pass: passwords(
                                                                  platform:
                                                                      singlePass
                                                                          .platform,
                                                                  username:
                                                                      singlePass
                                                                          .username,
                                                                  password:
                                                                      singlePass
                                                                          .password,
                                                                  passId:
                                                                      singlePass
                                                                          .passId),
                                                              toEdit: widget
                                                                  .Currentusername)));
                                                },
                                              ),

                                              //delete

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
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                              content: Text(
                                                                  'Are you sure you want to delete this password ? ',
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
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize: 14))),
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
                                                                          .delete(
                                                                              singlePass);

                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                        'Delete',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize: 14)))
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                  }),
                                            ],
                                          ),
                                        ),
                                      ]))
                            ]));
                          } else if (singlePass.platform
                              .toString()
                              .startsWith(name.toLowerCase())) {
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
                                    top: 1,
                                  ),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                    color: Color(0xFF8A70BE))),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 1),
                                              child: IconButton(
                                                  onPressed: () {
                                                    Clipboard.setData(
                                                        ClipboardData(
                                                            text: singlePass
                                                                .password));

                                                    Fluttertoast.showToast(
                                                      msg: "Password copied",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      timeInSecForIosWeb: 2,
                                                      backgroundColor:
                                                          Color(0xFF0F0C07),
                                                      textColor: Colors.white,
                                                      fontSize: 14.0,
                                                    );
                                                  },
                                                  icon: Icon(
                                                    Icons.copy,
                                                    size: 25,
                                                    color: Color(0xFF8A70BE),
                                                  )),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 1,
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
                                              color: Color(0xFFB7B7B7),
                                              fontSize: 13),
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(
                                          height: 9,
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xFFDADADA)),
                                                  textAlign: TextAlign.left,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Visibility(
                                                  visible: isVisible,
                                                  child: Text(
                                                    count(singlePass.password
                                                        .toString()
                                                        .length),
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFFB7B7B7),
                                                        fontSize: 13),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  replacement: Text(
                                                    '${singlePass.password}',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFFB7B7B7),
                                                        fontSize: 13),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                )
                                              ]),

                                          IconButton(
                                            onPressed: () {
                                              setState(() {});
                                              isVisible = !isVisible;
                                            },
                                            icon: Icon(
                                              isVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Color(0xff616161),
                                              size: 20,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 100,
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.edit_outlined,
                                              color: Color.fromARGB(
                                                  255, 143, 146, 151),
                                              size: 32,
                                            ),
                                            onPressed: () {
                                              fireStore_helper.setUID(
                                                  widget.Currentusername);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => editWallet(
                                                          pass: passwords(
                                                              platform:
                                                                  singlePass
                                                                      .platform,
                                                              username:
                                                                  singlePass
                                                                      .username,
                                                              password:
                                                                  singlePass
                                                                      .password,
                                                              passId: singlePass
                                                                  .passId),
                                                          toEdit: widget
                                                              .Currentusername)));
                                            },
                                          ),

                                          //delete
                                          SizedBox(
                                            width: 0.1,
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
                                                              'Are you sure you want to delete this password ? ',
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
                                                                      .delete(
                                                                          singlePass);

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
                                        ]),
                                      ]))
                            ]));
                          }
                          if (!matching(passdata, name) &&
                              name.isNotEmpty &&
                              index == 0) {
                            return Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 100,
                                  ),
                                  Text('No matched platform',
                                      style: TextStyle(
                                          color: Color(0xFFB7B7B7),
                                          fontSize: 20)),
                                ],
                              ),
                            );
                          } else
                          // if (name.isNotEmpty &&
                          //     !matching(passdata, name))
                          {
                            return Center(
                              child: Text(' ',
                                  style: TextStyle(
                                      color: Color(0xFFB7B7B7), fontSize: 20)),
                            );
                          }
                        },
                      ),
                    );
                  }
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
      ),
    );
  }

  String count(int len) {
    String counter = "";

    for (int i = 0; i < len; i++) counter += '*';

    return counter;
  }

  bool matching(List<passwords>? list, String name2) {
    // for (int i = 0; i < list.length; i++) {
    //   if (list[i].platform.toString().startsWith(name2.toLowerCase())) {
    //     isMatch = true;
    //   }
    // }
    int? len = list?.length;
    for (int i = 0; i < len!; i++) {
      if (list![i].platform.toString().startsWith(name2.toLowerCase())) {
        return true;
      }
    }

    return false;
  }
}
