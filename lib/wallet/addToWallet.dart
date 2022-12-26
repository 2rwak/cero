import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Models/passwords.dart';
import 'package:flutter_application_1/data_sourse/fireStore_helper.dart';
import 'package:flutter_application_1/navigationBar.dart';
import 'package:flutter_application_1/wallet/wallet.dart';

class addToWallet extends StatefulWidget {
  final String current;

  const addToWallet({super.key, required this.current});

  @override
  State<addToWallet> createState() => _addToWalletState();
}

class _addToWalletState extends State<addToWallet> {
  TextEditingController _platformController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  passwords _pass = passwords();
  _addToWalletState({Key? key});

  final formKeyy = GlobalKey<FormState>();
  bool _obscuretext = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF141416),
        body: Form(
          key: formKeyy,
          child: Center(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Add password',
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
            height: 0.1,
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => navigationBar(
                              Currentusername: widget.current,
                            )));
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
                Navigator.pop(context);
              },
              child: SizedBox(
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
                  onPressed: () {
                    final isValid = formKeyy.currentState?.validate();
                    if (isValid == true) {
                      adding();
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
            )),
          ])
        ]);
    // );
  }

  void adding() async {
    setState(() {});
    _pass.platform = _platformController.text;
    _pass.username = _usernameController.text;
    _pass.password = _passwordController.text;

    fireStore_helper.setUID(widget.current);

    fireStore_helper.create(passwords(
        platform: _pass.platform,
        username: _pass.username,
        password: _pass.password));
    // await FirebaseFirestore.instance
    //     .collection('users')
    //     .doc('Kbayxiiu2qgCHVFVpMud')
    //     .collection('passwordsswallet')
    //     .add(_pass.toJson());

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => navigationBar(
                  Currentusername: widget.current,
                )));
  }
}
