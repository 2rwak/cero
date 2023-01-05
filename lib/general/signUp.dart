import 'dart:collection';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/general/isUnique.dart';

import 'package:flutter_application_1/general/LoginPage.dart';
import 'package:flutter_application_1/profile/ViewProfile.dart';
// import 'package:flutter_application_1/general/localAuth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/navigationBar.dart';

class signUp extends StatefulWidget {
  @override
  State<signUp> createState() => _signUpState();
  const signUp({Key? key}) : super(key: key);
}

class _signUpState extends State<signUp> {
  _signUpState({Key? key});
  final formKey = GlobalKey<FormState>();

  String username = '';
  String email = '';
  String phoneNo = '';
  String ID = '';
  final valid = true;
// Arwa 22/12
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNoController = TextEditingController();
  final IDController = TextEditingController();
  final isUnique isunique = new isUnique();

  // @override
  // void dispose() {
  //   userNameController.dispose();
  //   emailController.dispose();
  //   phoneNoController.dispose();
  //   IDController.dispose();
  //   super.dispose();
  // }

  Future<void> inserting() async {
    final profile = <String, String>{
      'ID': ID,
      'email': email,
      'phoneNo': phoneNo,
      'username': username
    };
    final loginHistory = <String, String>{
      'Device': "",
      'Location': "",
      'Time': "",
    };

    FirebaseFirestore.instance
        .collection('users')
        .doc(username)
        .set(profile)
        .onError((e, _) => print("Error writing document: $e"));

    FirebaseFirestore.instance
        .collection('users')
        .doc(username)
        .collection('History')
        .doc('login')
        .set(loginHistory)
        .onError((e, _) => print("Error writing document: $e"));
  }

// check if user name is used (REEMA)
  Future<bool> usernameCheck(String username) async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .get();
    return result.docs.isEmpty;
  }

// check if national id is used (REEMA)
  Future<bool> nationalIDCheck(String ID) async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('ID', isEqualTo: ID)
        .get();
    return result.docs.isEmpty;
  }

// check if phone number is used (REEMA)
  Future<bool> phoneNoCheck(String phoneNo) async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('phoneNo', isEqualTo: phoneNo)
        .get();
    return result.docs.isEmpty;
  }

  // check if email is used (REEMA)
  Future<bool> emailCheck(String email) async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    return result.docs.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF141416),
      body: Form(
        key: formKey,
        child: Column(children: [
          SizedBox(
            height: 49,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => LoginPage()));
                },
                child: Icon(
                  Icons.keyboard_backspace,
                  color: Colors.white,
                  size: 50,
                ),
              ),
              SizedBox(
                width: 299,
              )
            ],
          ),
          SizedBox(height: 0.0001),
          Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/Icon.png'),
                  width: 70,
                  height: 70,
                ),
                Text('Sign up',
                    style: TextStyle(
                      color: Color(0xfff8fafc),
                      fontSize: 35,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w700,
                    ))
              ]),
          SizedBox(height: 6),
          Container(
            width: 450,
            height: 550,
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
                    height: 3,
                  ),
                  Row(
                    children: [
                      Text(
                        'Username',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Text(' *',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFFEA0707),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Container(
                    width: 350,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color(0xff616161),
                        width: 1.5,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          } else if (value.contains(" ")) {
                            return 'A username should not contain spaces';
                          } else if (value.length < 5) {
                            return 'Username should be at least 5 characters';
                          } else if (value.length > 10) {
                            return 'Username should not exceed 10 characters';
                          } else if (value.contains("@") ||
                              value.contains("%") ||
                              value.contains("-") ||
                              value.contains("/") ||
                              value.contains(")") ||
                              value.contains("(") ||
                              value.contains("}") ||
                              value.contains("{") ||
                              value.contains("]") ||
                              value.contains("[") ||
                              value.contains("*") ||
                              value.contains("&") ||
                              value.contains("^") ||
                              value.contains("\$") ||
                              value.contains("#") ||
                              value.contains("!") ||
                              value.contains("?") ||
                              value.contains(">") ||
                              value.contains("<") ||
                              value.contains("\\") ||
                              value.contains("'") ||
                              value.contains(",") ||
                              value.contains(";") ||
                              value.contains(":") ||
                              value.contains("+") ||
                              value.contains("=")) {
                            return 'Valid special characters _ and . ';
                          } else
                            return "";
                        },
                        controller: userNameController,
                        onChanged: (value) => setState(() => username = value),
                        autofocus: true,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter your username',
                            hintStyle: TextStyle(
                                fontSize: 16, color: Color(0xFF616161))),
                        textAlign: TextAlign.start,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(" "),
                        ],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                        )),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Text(
                        'National ID',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Text(' *',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFFEA0707),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Container(
                    width: 350,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color(0xff616161),
                        width: 1.5,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Required';
                          else if (value.length < 10) {
                            return 'National ID should be at least 10 digits';
                          } else if (value.length > 10) {
                            return 'National ID should not exceed  10 digits';
                          } else
                            return "";
                        },
                        controller: IDController,
                        onChanged: (value) => setState(() => ID = value),
                        autofocus: true,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter your national ID',
                            hintStyle: TextStyle(
                                fontSize: 16, color: Color(0xFF616161))),
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        maxLength: 10,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                        )),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Text(
                        'Phone number',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Text(' *',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFFEA0707),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(children: [
                    Text(
                      '+966',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Container(
                      width: 290,
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Color(0xff616161),
                          width: 1.5,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'Required';
                            else if (value.length < 9) {
                              return 'Phone number should be at least 9 digits';
                            } else if (value.length > 9) {
                              return 'Phone number should not exceed  9 digits';
                            }

                            RegExp phoneNo = RegExp(r'^5?([0-9]{9})$');
                            if (!phoneNo.hasMatch(value)) {
                              return 'Invalid phone number';
                            } else
                              return "";
                          },
                          controller: phoneNoController,
                          onChanged: (value) => setState(() => phoneNo = value),
                          autofocus: true,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '5xxxxxxxx',
                              hintStyle: TextStyle(
                                  fontSize: 16, color: Color(0xFF616161))),
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          maxLength: 9,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                          )),
                    )
                  ]),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Text(' *',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFFEA0707),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Container(
                    width: 350,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color(0xff616161),
                        width: 1.5,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Required';
                          final pattern =
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                          final regExp = RegExp(pattern);

                          if (!regExp.hasMatch(value)) {
                            return 'Invalid email';
                          } else
                            return "";
                        },
                        controller: emailController,
                        onChanged: (value) => setState(() => email = value),
                        autofocus: true,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Example@gmail.com',
                            hintStyle: TextStyle(
                                fontSize: 16, color: Color(0xFF616161))),
                        textAlign: TextAlign.start,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(" "),
                        ],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                        )),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Container(
                  //       height: 50,
                  //       width: 60,
                  //       child: Image(
                  //         image: AssetImage('assets/face.png'),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 18,
                  ),
                  // Center(
                  //   child: Container(
                  //     height: 27,
                  //     width: 219,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(7),
                  //       color: Color(0xFF4E5053),
                  //     ),
                  //     child: Center(
                  //         // child: GestureDetector(
                  //         //   onTap: () async {
                  //         //     bool isAuthenticated =
                  //         //         await LocalAuth.authenticate();
                  //         //     if (isAuthenticated &&
                  //         //         !username.isEmpty &&
                  //         //         !email.isEmpty &&
                  //         //         phoneNo != 0 &&
                  //         //         nationalID != 0) {
                  //         //       Navigator.push(
                  //         //         context,
                  //         //         MaterialPageRoute(
                  //         //             builder: (context) =>
                  //         //                 const navigationBar()),
                  //         //       );
                  //         //     } else {
                  //         //       ScaffoldMessenger.of(context).showSnackBar(
                  //         //         const SnackBar(
                  //         //           content: Text('Authentication failed.'),
                  //         //         ),
                  //         //       );
                  //         //     }
                  //         //   },
                  //         // child: Text(
                  //         //   'Set Up Face Id',
                  //         //   textAlign: TextAlign.center,
                  //         //   style: TextStyle(
                  //         //     color: Colors.white,
                  //         //     fontSize: 14,
                  //         //     fontFamily: 'Inter',
                  //         //   ),
                  //         // ),
                  //         // ),
                  //         ),
                  //   ),
                  // ),

                  Center(
                      child: InkWell(
                    // onTap: () {
                    //   // inserting();
                    //   Navigator.push(context,
                    //       MaterialPageRoute(builder: (_) => navigationBar()));
                    // },
                    child: Container(
                      height: 50,
                      width: 327,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xFF8A70BE),
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () async {
                            // check if user name is used (REEMA)
                            final isValid = formKey.currentState?.validate();
                            print("outside is valid 1");
                            // if (isValid == true) {
                            print("inside is valid 1");
                            bool isUserValid = await usernameCheck(username);
                            bool isIDValid = await nationalIDCheck(ID);
                            bool isPhoneValid = await phoneNoCheck(phoneNo);
                            bool isEmailValid = await emailCheck(email);
                            if (!isUserValid) {
                              print("inside is valid 4");

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Username already exists'),
                                ),
                              );
                            } else if (!isIDValid) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('National ID already exists'),
                                ),
                              );
                            } else if (!isPhoneValid) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Phone number already exists'),
                                ),
                              );
                            } else if (!isEmailValid) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Email already exists'),
                                ),
                              );
                            } else if (isUserValid) {
                              // if (isValid == true)
                              {
                                await inserting();

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => navigationBar(
                                              Currentusername:
                                                  userNameController.text,
                                        
                                            )));
                              }
                            }

                            print("outside is valid 2");

                            ;
                          },
                          child: Text(
                            'Sign Up',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  )),
                ]),
          )
        ]),
      ),
    );
  }
}
