import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/Models/passwords.dart';
import 'package:flutter_application_1/data_sourse/fireStore_helper.dart';
import 'package:flutter_application_1/navigationBar.dart';
import 'package:flutter_application_1/wallet/wallet.dart';

class editWallet extends StatefulWidget {
  final String toEdit;
  final passwords pass;
  const editWallet({Key? key, required this.pass, required this.toEdit})
      : super(key: key);

  @override
  State<editWallet> createState() => _editWalletState();
}

class _editWalletState extends State<editWallet> {
  TextEditingController? _platformController;
  TextEditingController? _usernameController;
  TextEditingController? _passwordController;

  void initState() {
    _platformController = TextEditingController(text: widget.pass.platform);
    _usernameController = TextEditingController(text: widget.pass.username);
    _passwordController = TextEditingController(text: widget.pass.password);

    super.initState();
  }

  final formKeyyy = GlobalKey<FormState>();
  bool _obscuretext = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF141416),
        body: Form(
          key: formKeyyy,
          child: Center(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Edit password',
                      style: TextStyle(
                        color: Color(0xfff8fafc),
                        fontSize: 26,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w700,
                      )),
                  SizedBox(height: 12),
                  Container(
                      width: 450,
                      height: 400,
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
                      child: _buildQuestionForm()),
                ]),
          ),
        ));
  }

  Widget _buildQuestionForm() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 3,
          ),
          Row(
            children: [
              Text(
                '   Platform',
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
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: SizedBox(
              width: 360,
              height: 55,
              child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'This field is required';
                  },
                  controller: _platformController,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(" "),
                  ],
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  decoration: InputDecoration(
                    // errorBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                    //   borderSide: BorderSide(
                    //     color: Colors.redAccent,
                    //     width: 1.5,
                    //   ),
                    // ) ,
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
                  )),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Text(
                '   UserName',
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
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: SizedBox(
              width: 360,
              height: 55,
              child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'This field is required';
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(" "),
                  ],
                  controller: _usernameController,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Color(0xff616161),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xFF8A70BE))))),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Text(
                '   Password',
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
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: SizedBox(
              width: 360,
              height: 55,
              child: TextFormField(
                  obscureText: _obscuretext,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'This field is required';
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(" "),
                  ],
                  controller: _passwordController,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {});
                          _obscuretext = !_obscuretext;
                        },
                        child: Icon(
                          _obscuretext
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Color(0xff616161),
                          size: 20,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Color(0xff616161),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xFF8A70BE))))),
            ),
          ),
          SizedBox(
            height: 36,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Center(
                child: InkWell(
              onTap: () {
                Navigator.pop(
                  context,
                );
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
            )),
            SizedBox(
              width: 80,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  final isValid = formKeyyy.currentState?.validate();
                  if (isValid == true) {
                    edit();
                  }
                },
                // child: SizedBox(
                //   height: 41,
                //   width: 94,
                child: Container(
                  height: 41,
                  width: 94,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xFF8A70BE),
                  ),

                  // onPressed: () {
                  //   final isValid = formKeyyy.currentState?.validate();
                  //   if (isValid == true) {
                  //     // fireStore_helper.update(passwords(
                  //     //     platform: _platformController!.text,
                  //     //     username: _usernameController!.text,
                  //     //     password: _passwordController!.text,
                  //     //     passId: widget.pass.passId));

                  //     // Navigator.pop(context);
                  //   }
                  // },
                  child: Center(
                    child: Text(
                      'Save',
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
            ),
            // )),
          ])
        ]);
  }

  void edit() async {
    fireStore_helper.update(passwords(
        platform: _platformController!.text,
        username: _usernameController!.text,
        password: _passwordController!.text,
        passId: widget.pass.passId));

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => wallet(
                  Currentusername: widget.toEdit,
                )));
  }
}
